. $PSScriptRoot\level1deck.ps1

$avgGain = $deck | measure -Property gain -Average | select -ExpandProperty Average
$avgRejection = $avgGain / 5
"Average gain: $avgGain"
"Average rejection cost: $avgRejection"
$avgEffort = $deck | measure -Property effort -Average | select -ExpandProperty Average
"Average effort: $avgEffort"
$deck | measure -Property agingCost -Average | select -ExpandProperty Average | foreach{ "Average aging: $_"}

"On avg 2 cards accepted (avg request completion time) per round : 50"
"Optimum team size: 4 per active card = 8 team members total"
$rejectedCards = 50 * (3/8)
"Chance of reject: 3 out of 8: $rejectedCards cards"
"Total rejection costs: $($rejectedCards * $avgRejection)"
$finishedCards = 50 - (50 * (3/8))
"Finished cards: $finishedCards cards"
"Total gain: $($finishedCards * $avgGain)"
"Total finished effort: $($finishedCards * $avgEffort)"
"Hiring costs: $(15 * 8)"
"Estimated optimal surplus (gain - effort - rejects - hiring): " + ` 
    + "$($finishedCards * $avgGain - $finishedCards * $avgEffort - $rejectedCards * $avgRejection - 15 * 8)"