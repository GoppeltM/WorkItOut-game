$requests = Get-content "$PSCommandPath\..\..\data\requests.json" | ConvertFrom-Json
$rules = Get-Content -Path "$PSCommandPath\..\..\data\rules.json" | ConvertFrom-Json

Class Profile{
    $Name
    $Values
}
$profiles = @(
            [Profile]@{
                Name="Full power"
                Values = @(5,5,5,5,5,5,5,5),@(5,5,5,5,5,5,5,5),@(5,5,5,5,5,5,5,5),@(5,5,5,5,5,5,5,5),@(5,5,5,5,5,5,5,5), `
                         @(5,5,5,5,5,5,5,5),@(5,5,5,5,5,5,5,5),@(5,5,5,5,5,5,5,5),@(5,5,5,5,5,5,5,5),@(5,5,5,5,5,5,5,5)
            },
            [Profile]@{
                Name="One man show"
                Values = @(5),@(5),@(5),@(5),@(5),@(5),@(5),@(5),@(5),@(5)
            },
            [Profile]@{
                Name="Medium effort"
                Values = @(3,3,3 ),@(3,3,3 ),@(3,3,3 ),@(3,3,3 ),@(3,3,3 ),@(3,3,3 ),@(3,3,3 ),@(3,3,3 ),@(3,3,3 ),@(3,3,3 )
            },
            [Profile]@{
                Name="Adding manpower"
                Values = @(5),@(5,5 ),@(5,5,5 ),@(5,5,5,5 ),@(5,5,5,5,5 ),@(5,5,5,5,5,5 ),@(5,5,5,5,5,5,5 ),@(5,5,5,5,5,5,5,5),@(5,5,5,5,5,5,5,5,5),@(5,5,5,5,5,5,5,5,5,5)
            },
            [Profile]@{
                Name="Reducing manpower"
                Values = @(5,5,5,5,5,5 ), @(5,5,5,5,5 ),@(5,5,5,5 ),@(5,5,5 ),@(5,5 ),@(5)
            },
            [Profile]@{
                Name="Fooling around"
                Values = @(1,1,1,1),@(1,1,1,1),@(1,1,1,1),@(1,1,1,1),@(1,1,1,1),@(1,1,1,1),@(1,1,1,1),@(1,1,1,1),@(1,1,1,1),@(1,1,1,1)
            }

        )

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
    $workTodo = $playerStones | Measure -Sum | Select -ExpandProperty Sum
    $workTodo = $workTodo * $rules.workPerStone
    if($req.gain -eq 0){
        $req
        return
    }
    $global:timePot = $timePot - $workTodo
    if($timePot -lt 0){
        throw " Broke! workload $workTodo greater than timepot $timePot"
    }
    
    $req.effort = $req.effort + $req.agingCost
    $commCost = [math]::Floor(($playerStones.Count - 1) * ($playerStones.Count - 1) * $rules.communicationCost)
    $req.effort = $req.effort + $commCost    
    $req.effort = $req.effort - $workTodo
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
