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
	$harness
}
[xml]$template = Get-Content -Path $PSCommandPath\..\l1template-german.html
$requestCards = New-HtmlCards -stamp $template.table
$requestCards.Save("$PSCommandPath\..\..\docs\level1cards-german.html")
[xml]$template = Get-Content -Path $PSCommandPath\..\l1template-english.html
$requestCards = New-HtmlCards -stamp $template.table -savePath "$PSCommandPath\..\..\docs\level1cards-english.html"
$requestCards.Save("$PSCommandPath\..\..\docs\level1cards-german.html")

$colors = "black", "red", "blue", "green", "yellow", "cyan", "purple", "orange", "lightgrey", "brown"
$playerTemplate = '<svg width="120" height="110" xmlns="http://www.w3.org/2000/svg">                        
                    <path d ="M 0 5 L 0 95 L 90 95 L 0 5" stroke ="{0}" stroke-width="10" fill="none"/> 
                    <path d ="M 20 0 L 110 90 L 110 0 L 20 0" stroke ="{0}" stroke-width="10" fill="none"/> 
                   </svg>'

$timeTemplate = '<svg width="60" height="60" xmlns="http://www.w3.org/2000/svg"> 
                    <rect width="60" height="60" fill="white" stroke="{0}" stroke-width="20" />                    
                    <text x="33" y="40" text-anchor="middle" font-family="sans-serif" font-size="20px" font-weight="bold">
                        {1}
                    </text> 
        </svg>'

# player markers
$players = $colors | foreach{
    $color = $_
    $playerTemplate -f $color
    $playerTemplate -f $color
    '<svg width="120" height="110" xmlns="http://www.w3.org/2000/svg">                        
                    <path d ="M 0 5 L 0 95 L 90 95 L 0 5" stroke ="{0}" stroke-width="10" fill="none"/>                     
                   </svg>' -f $color
}
[xml]$node = "<html><body>" + ($players -join "") + "</body></html>"
$node.Save("$PSCommandPath\..\..\docs\level1playermarkers.html")

$currColors = $colors.GetEnumerator()
# Time markers
$times = "1", "2", "3", "6", "12", "24", "48", "96", "192", "384" | foreach{
    $value = $_
    $currColors.MoveNext() | Out-Null
    $color = $currColors.Current
    for($i = 0;$i -lt 15;$i++){
        $timeTemplate -f $color, $value
    }    
}
[xml]$node = "<html><body>" + ($times -join "") + "</body></html>"
$node.Save("$PSCommandPath\..\..\docs\timemarkers.html")

# sample
[xml]$sample = '<html><head><link rel="stylesheet" href="cardstyle.css" /></head><body>' `
     + ($requestCards.html.body.table[0].OuterXml, $players[0], $players[6], $times[0], $times[50]  -join "") + "</body></html>"
$sample.Save("$PSCommandPath\..\..\docs\sample.html")
