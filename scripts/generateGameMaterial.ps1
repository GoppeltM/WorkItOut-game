. $PSScriptRoot\level1deck.ps1

function New-HtmlCards{
	param($stamp, $deck)
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
$requestCards = New-HtmlCards -stamp $template.table -deck $deck
$requestCards.Save("$PSCommandPath\..\..\docs\level1cards-german.html")
[xml]$template = Get-Content -Path $PSCommandPath\..\l1template-english.html
$requestCards = New-HtmlCards -stamp $template.table -deck $deck
$requestCards.Save("$PSCommandPath\..\..\docs\level1cards-english.html")

$colors = "black", "red", "blue", "green", "yellow", "cyan", "purple", "orange", "lightgrey", "brown"
$playerTemplate = '<svg width="120" height="110" xmlns="http://www.w3.org/2000/svg">                        
                    <path d ="M 4 10 L 4 100 L 94 100 Z" stroke ="{0}" stroke-width="10" fill="none"/> 
                    <path d ="M 20 4 L 110 94 L 110 4 Z" stroke ="{0}" stroke-width="10" fill="none"/> 
                   </svg>'

$timeTemplate = '<svg width="60" height="60" xmlns="http://www.w3.org/2000/svg"> 
                    <rect width="60" height="60" fill="white" stroke="{0}" stroke-width="20" />                    
                    <text x="33" y="40" text-anchor="middle" font-family="sans-serif" 
                        font-size="30px" font-weight="bold" font-stretch="{2}">
                        {1}
                    </text> 
        </svg>'

# player markers
$players = $colors | foreach{
    $color = $_
    $playerTemplate -f $color
    $playerTemplate -f $color
    '<svg width="120" height="110" xmlns="http://www.w3.org/2000/svg">                        
                    <path d ="M 4 10 L 4 100 L 94 100 Z" stroke ="{0}" stroke-width="10" fill="none"/> 
                   </svg>' -f $color
}
[xml]$node = "<html><body>" + ($players -join "") + "</body></html>"
$node.Save("$PSCommandPath\..\..\docs\level1playermarkers.html")

$currColors = $colors.GetEnumerator()
# Time markers
$times = "1", "2", "3", "6", "12", "24", "48", "96" | foreach{
    $value = $_
    $currColors.MoveNext() | Out-Null
    $color = $currColors.Current
    for($i = 0;$i -lt 15;$i++){
        $timeTemplate -f $color, $value, "normal"
    }    
}
$times += "192", "384" | foreach{
    $value = $_
    $currColors.MoveNext() | Out-Null
    $color = $currColors.Current
    for($i = 0;$i -lt 15;$i++){
        $timeTemplate -f $color, $value, "condensed"
    }    
}

[xml]$node = "<html><body>" + ($times -join "") + "</body></html>"
$node.Save("$PSCommandPath\..\..\docs\timemarkers.html")

# sample
[xml]$sample = '<html><head><link rel="stylesheet" href="cardstyle.css" /></head><body>' `
     + ($requestCards.html.body.table[0].OuterXml, $players[0], $players[6], $times[0], $times[50]  -join "") + "</body></html>"
$sample.Save("$PSCommandPath\..\..\docs\sample.html")
