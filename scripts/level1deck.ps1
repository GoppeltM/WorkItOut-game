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

function New-HtmlCards{
	param($stamp, $savePath)
	[xml]$harness = Get-Content -Path $PSCommandPath\..\harness.html
	$body = $harness.ChildNodes[0].ChildNodes[1]
	$deck | foreach {
		$card = $_
		$copy = $stamp.Clone()
		$copy.tr.td | where {$_.id -eq "gain"} | foreach{$_.'#text' = $card.gain.ToString()}
		$copy.tr.td | where {$_.id -eq "aging"} | foreach{$_.'#text' = $card.agingCost.ToString()}
		$cancelCost = [int]($card.effort / 5)
		$copy.tr.td | where {$_.id -eq "cancelCost"} | foreach{$_.'#text' = $cancelCost.ToString()}
		$copy.tr.td | where {$_.id -eq "effort"} | foreach{$_.'#text' = $card.effort.ToString()}
		$copy.tr.td | where {$_.id -ne $null} | foreach{$_.RemoveAttribute('id')}

		$imported = $harness.ImportNode($copy, $true)
		$body.AppendChild($imported) | Out-Null
	}
	$harness.Save($savePath)
}
[xml]$template = Get-Content -Path $PSCommandPath\..\l1template-german.html
New-HtmlCards -stamp $template.table -savePath "$PSCommandPath\..\..\docs\level1cards-german.html"
[xml]$template = Get-Content -Path $PSCommandPath\..\l1template-english.html
New-HtmlCards -stamp $template.table -savePath "$PSCommandPath\..\..\docs\level1cards-english.html"
