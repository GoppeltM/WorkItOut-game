  # {
  #  "gain": 20,
  #  "effort": 10,
  #  "agingCost": 1
  # }

  $ruleFile = "$PSCommandPath\..\..\data\rules.json"

[int]$timePot = 10

function Update-TimePot
{
    [CmdletBinding()]
    param(        
        [int[]]$playerStones,
        [Parameter(ValueFromPipeline=$true)][hashtable]$request
    )

    $req = $request.Clone()
    if($req.effort -le 0){ 
        $req.effort = 0        
        $timePot = $timePot + $req.gain
        $req.gain = 0
        return
    }
    $workTodo = $playerStones | Measure -Sum | Select -ExpandProperty Sum
    $global:timePot = $timePot - $workTodo
    if($timePot -lt 0){
        throw "Broke! workload $workTodo greater than timepot $timePot"
    }
    $rules = Get-Content -Path $ruleFile | ConvertFrom-Json
    $req.effort = $req.effort + $req.agingCost
    $commCost = $playerStones.Count * $rules.communicationCost
    $req.effort = $req.effort + $commCost    
    $req.effort = $req.effort - $workDone
    
    $req
}

@{"gain" = 20;"effort"=10;"agingCost"=1} | Update-TimePot -playerStones 5,5 | Update-TimePot -playerStones 5
