$requests = Get-content "$PSCommandPath\..\..\data\requests.json" | ConvertFrom-Json
$rules = Get-Content -Path "$PSCommandPath\..\..\data\rules.json" | ConvertFrom-Json

Class Profile{
    $Name
    $Values
}
$s = $rules.stonesPerMember
$profiles = @(
            [Profile]@{
                Name="Full power"
                Values = @($s,$s,$s,$s),@($s,$s,$s,$s),@($s,$s,$s,$s),@($s,$s,$s,$s),@($s,$s,$s,$s), `
                         @($s,$s,$s,$s),@($s,$s,$s,$s),@($s,$s,$s,$s),@($s,$s,$s,$s),@($s,$s,$s,$s)
            },
            [Profile]@{
                Name="One man show"
                Values = @($s),@($s),@($s),@($s),@($s),@($s),@($s),@($s),@($s),@($s)
            },
            [Profile]@{
                Name="Medium effort"
                Values = @(3,3,3 ),@(3,3,3 ),@(3,3,3 ),@(3,3,3 ),@(3,3,3 ),@(3,3,3 ),@(3,3,3 ),@(3,3,3 ),@(3,3,3 ),@(3,3,3 )
            },
            [Profile]@{
                Name="Adding manpower"
                Values = @($s),@($s,$s ),@($s,$s,$s ),@($s,$s,$s,$s ),@($s,$s,$s,$s,$s ),@($s,$s,$s,$s,$s,$s ),@($s,$s,$s,$s,$s,$s,$s ),@($s,$s,$s,$s,$s,$s,$s,$s),@($s,$s,$s,$s,$s,$s,$s,$s,$s),@($s,$s,$s,$s,$s,$s,$s,$s,$s,$s)
            },
            [Profile]@{
                Name="Reducing manpower"
                Values = @($s,$s,$s,$s,$s,$s ), @($s,$s,$s,$s,$s ),@($s,$s,$s,$s ),@($s,$s,$s ),@($s,$s ),@($s)
            },
            [Profile]@{
                Name="Fooling around"
                Values = @(1,1,1,1),@(1,1,1,1),@(1,1,1,1),@(1,1,1,1),@(1,1,1,1),@(1,1,1,1),@(1,1,1,1),@(1,1,1,1),@(1,1,1,1),@(1,1,1,1)
            }

        )

function Out-Workforce{
    [CmdletBinding()]
    param(        
        [Parameter(ValueFromPipeline=$true)][int[]]$playerStones    
    )
    $workTodo = $playerStones | Measure -Sum | Select -ExpandProperty Sum
    $workTodo = $workTodo * $rules.workPerStone
    $workTodo
}

function Out-CommunicationCost{
    [CmdletBinding()]
    param(        
        [Parameter(ValueFromPipeline=$true)][int]$playerCount
    )

    process{
        $commCost = 0
        while($playerCount -gt 0)
        {
            $playerCount = $playerCount - 1
            $commCost = $commCost + $playerCount                
        }
        $commCost
    }    
}

function Get-GlobalStats{
    [CmdletBinding()]
    param()

    $playerStones = ,$rules.stonesPerMember
    for($i=1;$i -le 11;$i++){
        $workload = Out-Workforce -playerStones $playerStones
        $commCost = Out-CommunicationCost -playerCount $i
        "Max workload ($i player): $workload, net: $($workload - $commCost), loss: $commCost ($($commCost / $workload * 100)%)"
        $playerStones += ($rules.stonesPerMember)
    }    
}

function Update-TimePot
{
    [CmdletBinding()]
    param(        
        [int[]]$playerStones,
        [Parameter(ValueFromPipeline=$true)][hashtable]$request,
        [PSCustomObject]$rules
    )

    $req = $request.Clone()   
    "Timepot: $timePot Effort: $($req.effort) gain: $($req.gain)" | Write-Debug
    
    if($req.gain -eq 0){
        $req
        return
    }
    $workLoad = Out-Workforce -playerStones $playerStones
    $global:timePot = $timePot - $workLoad
    if($timePot -lt 0){
        throw " Broke! workload $workTodo greater than timepot $timePot"
    }
    
    $req.effort = $req.effort + $req.agingCost    
    $req.effort = $req.effort + (Out-CommunicationCost -playerCount $playerStones.Count)
    $req.effort = $req.effort - $workLoad
    "Timepot: $timePot Effort: $($req.effort) AgingCost: $($req.agingCost) CommCost: $commCost" | Write-Debug
    if($req.effort -le 0 -and $req.gain -ne 0){ 
        $req.effort = 0        
        $global:timePot = $timePot + $req.gain
        $req.gain = 0        
    }
    $req
}



function Do-AllRequests{
    [CmdletBinding()]
    param(
        $requests = $requests,
        $profiles = $profiles,
        $rules = $rules
    )
    

    $requests | foreach {
        "----------------------" | Write-Verbose
        "Title: $($_.title)" | Write-Verbose
        "        " | Write-Verbose

        foreach ($profile in $profiles){
            $request = @{
                "effort" = $_.effort
                "agingCost" = $_.agingCost
                "gain" = $_.gain
            }
            $profile.Name | Write-Verbose
            $global:timePot = 1000
            $current = 0
            $won = $false
            $winningRound = 0
            try{
                foreach ($team in $profile.Values){
                    $current = $current + 1
                    $request = $request | Update-TimePot -playerStones $team -rules $rules
                    if($request.gain -eq 0 -and $won -ne $true){
                        $won = $true
                        $winningRound = $current              
                    }
                }
                if($won){
                    " Won after $winningRound rounds" | Write-Verbose
                }                
                " final time pot: $global:timePot" | Write-Verbose
            }
            catch{
                $_.Exception.Message | Write-Verbose
            }
        }               
    }
}
