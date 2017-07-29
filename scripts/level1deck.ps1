$requests = Get-content "$PSCommandPath\..\..\data\requests.json" | ConvertFrom-Json
$rules = Get-Content -Path "$PSCommandPath\..\..\data\rules.json" | ConvertFrom-Json

$deck = $requests + $requests
# make the set a little more benign
$deck += $requests[0], $requests[1], $requests[2]
$deck += $requests[0], $requests[1], $requests[2]
# add a few more small cards, to make bigger jobs (and losses) less frequent
$deck += $requests[0], $requests[3], $requests[6], $requests[9], $requests[12], $requests[15], $requests[18], $requests[21]
$deck += $requests[0], $requests[3], $requests[6], $requests[9], $requests[12], $requests[15], $requests[18], $requests[21]
# add middle jobs, to make heavy jobs more rare
$deck += $requests[1], $requests[4], $requests[7], $requests[10], $requests[13], $requests[16], $requests[19], $requests[22]