. $PSScriptRoot\level1deck.ps1

$avgGain = $deck | measure -Property gain -Average | select -ExpandProperty Average
$avgRejection = $avgGain / 5
"Average gain: $avgGain"
"Average rejection cost: $avgRejection"
$avgEffort = $deck | measure -Property effort -Average | select -ExpandProperty Average
"Average effort: $avgEffort"
$deck | measure -Property agingCost -Average | select -ExpandProperty Average | foreach{ "Average aging: $_"}

"On avg 2 cards accepted (avg request completion time) per round : 50"
$teamMembers = 4 * 2
"Optimum team size: 4 per active card = $teamMembers team members total"

$rejectedCards = 50 * (3/8)
"Chance of reject: 3 out of 8: $rejectedCards cards"
"Total rejection costs: $($rejectedCards * $avgRejection)"
$finishedCards = 50 - (50 * (3/8))
"Finished cards: $finishedCards cards"
"Total gain: $($finishedCards * $avgGain)"
"Total finished effort: $($finishedCards * $avgEffort)"
"Hiring costs: $(15 * $teamMembers)"
$coopBonus = ($teamMembers - 1) * 25
"Cooperation bonus: $coopBonus"
"Estimated optimal surplus (gain + coop - effort - rejects - hiring): " + ` 
    + "$($finishedCards * $avgGain + $coopBonus - $finishedCards * $avgEffort - $rejectedCards * $avgRejection - 15 * 8)"

""
"Normalized goals:"
"1 point per 25 surplus (10p for 250)"
"1 point per 100 gain (10p for 1000)"
"1 point per team member (10p for 10)"
"25 points. -1 Point per reject (10p for 15)"
"1 point per 2 finished card (10p for 20)"
"2 points per team member that gained control (10p for 5)"

"24 goal chips would allow a maximum of 12 players => 4*6 chip sets"