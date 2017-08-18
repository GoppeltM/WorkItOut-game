$ErrorActionPreference = 'Stop'
. $PSScriptRoot\level1deck.ps1
Add-Type -AssemblyName 'System.Xml.Linq'

function New-HtmlCards{
	param($stamp, $deck)	
	$deck | foreach {
		$card = $_
		$copy = $stamp.Clone()
		$copy.tr.td | where {$_.id -eq "gain"} | foreach{$_.'#text' = $card.gain.ToString()}
		$copy.tr.td | where {$_.id -eq "aging"} | foreach{$_.'#text' = $card.agingCost.ToString()}
		$cancelCost = [int]($card.effort / 5)
		$copy.tr.td | where {$_.id -eq "cancelCost"} | foreach{$_.'#text' = $cancelCost.ToString()}
		$copy.tr.td.div | where {$_.id -eq "effort"} | foreach{$_.'#text' = $card.effort.ToString()}
		$copy.tr.td | where {$_.id -ne $null} | foreach{$_.RemoveAttribute('id')}
        $copy.tr.td.div | where {$_.id -ne $null} | foreach{$_.RemoveAttribute('id')}
        $copy
	}	
}
# request cards
[xml]$template = Get-Content -Path $PSCommandPath\..\cardTemplate-icon.html
[xml]$harness = Get-Content -Path $PSCommandPath\..\harness.html
$body = $harness.ChildNodes[0].ChildNodes[1]
$requestCards = New-HtmlCards -stamp $template.table -deck $deck
$requestCards | foreach{
		$imported = $harness.ImportNode($_, $true)
		$body.AppendChild($imported) | Out-Null
}
$harness.Save("$PSCommandPath\..\..\docs\requestcards.html")

$colors = "black", "red", "blue", "green", "yellow", "cyan", "purple", "orange", "lightgrey"
$playerTemplate = '<svg width="120" height="110" xmlns="http://www.w3.org/2000/svg">                        
                    <path d ="M 4 10 L 4 100 L 94 100 Z" stroke ="{0}" stroke-width="10" fill="none"/> 
                    <path d ="M 20 4 L 110 94 L 110 4 Z" stroke ="{0}" stroke-width="10" fill="none"/> 
                   </svg>'

$timeTemplate = '<svg width="60" height="60" xmlns="http://www.w3.org/2000/svg"> 
                    <rect x="5" y="5" width="50" height="50" fill="white" stroke="{0}" stroke-width="10" />                    
                    <text x="33" y="40" text-anchor="middle" font-family="sans-serif" 
                        font-size="30px" font-weight="bold" font-stretch="normal">
                        {1}
                    </text> 
        </svg>'

# player markers
$players = $colors | foreach{
    $color = $_
    $playerTemplate -f $color
    $playerTemplate -f $color
    $playerTemplate -f $color
}
[xml]$node = "<html><body>" + ($players -join "") + "</body></html>"
$node.Save("$PSCommandPath\..\..\docs\level1playermarkers.html")

$currColors = $colors.GetEnumerator()
# Time markers
$times = "1", "2", "3", "6.", "12", "24", "48", "96" | foreach{
    $value = $_
    $currColors.MoveNext() | Out-Null
    $color = $currColors.Current
    for($i = 0;$i -lt 18;$i++){
        $timeTemplate -f $color, $value
    }    
}

[xml]$node = "<html><body>" + ($times -join "") + "</body></html>"
$node.Save("$PSCommandPath\..\..\docs\timemarkers.html")

# sample
[System.Xml.Linq.XDocument]$sample = [System.Xml.Linq.XDocument]::Load("$PSCommandPath\..\harness.html")
$sample.Root[0].Add([System.Xml.Linq.XElement]::Parse($requestCards[6].OuterXml))
$sample.Root[0].Add([System.Xml.Linq.XElement]::Parse($players[0]))
$sample.Root[0].Add([System.Xml.Linq.XElement]::Parse($players[6]))
$sample.Root[0].Add([System.Xml.Linq.XElement]::Parse($times[0]))
$sample.Root[0].Add([System.Xml.Linq.XElement]::Parse($times[50]))
$sample.Save("$PSCommandPath\..\..\docs\sample.html")
