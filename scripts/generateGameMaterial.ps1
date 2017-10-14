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

$doc = [System.Xml.Linq.XDocument]::Load("$PSCommandPath\..\..\docs\requestcards.html")
$body = $doc.Root.Elements() | select -Skip 1 -First 1
$colors = "black", "red", "blue", "green", "yellow", "cyan", "purple", "orange", "lightgrey"
$playerNames = ("A", "B", "C", "D", "E", "F", "G", "H", "I", "J").GetEnumerator()
$playerTemplate = '<svg width="120" height="110" xmlns="http://www.w3.org/2000/svg">                        
    <path d="M 4 10 L 4 100 L 94 100 Z" stroke="{0}" stroke-width="10" fill="none" />
    <text x="10" y="90" text-anchor="start" font-family="sans-serif" 
                        font-size="50px" font-weight="bold" font-stretch="normal">
                        {1}
                    </text>
    <path d="M 4 10 L 4 100 L 94 100 Z" stroke="{0}" stroke-width="10" fill="none" transform="rotate(180, 55,50)" />
    <text x="10" y="90" text-anchor="start" font-family="sans-serif" 
                        font-size="50px" font-weight="bold" font-stretch="normal" transform="rotate(180, 55,50)">
                        {1}
                    </text>
                   </svg>'

$timeTemplate = '<svg width="90" height="90" xmlns="http://www.w3.org/2000/svg" transform="scale(2)"> 
                    <rect x="5" y="5" width="80" height="80" fill="white" stroke="{0}" stroke-width="10" />                    
                    <text x="50" y="60" text-anchor="middle" font-family="sans-serif" 
                        font-size="50px" font-weight="bold" font-stretch="normal">
                        {1}
                    </text> 
        </svg>'

# player markers
$players = $colors | foreach{
    $playerNames.MoveNext() | Out-Null
    $color = $_
    $baked = $playerTemplate -f $color, $playerNames.Current
    for($i = 0; $i -lt 3;$i++){
        [System.Xml.Linq.XElement]::Parse($baked)
    }    
}
$players | foreach {
    $body.Add($_)
}

$currColors = $colors.GetEnumerator()
# Time markers
$times = "1", "2", "3", "6.", "12", "24", "48", "96" | foreach{
    $value = $_
    $currColors.MoveNext() | Out-Null
    $color = $currColors.Current
    for($i = 0;$i -lt 18;$i++){
        [System.Xml.Linq.XElement]::Parse(($timeTemplate -f $color, $value))
    }    
}

$times | foreach {
    $body.Add($_)
}
$doc.Save("$PSCommandPath\..\..\docs\requestcards.html")

# sample
[System.Xml.Linq.XDocument]$sample = [System.Xml.Linq.XDocument]::Load("$PSCommandPath\..\harness.html")
$sample.Root[0].Add([System.Xml.Linq.XElement]::Parse($requestCards[6].OuterXml))
$sample.Root[0].Add($players[0])
$sample.Root[0].Add($players[6])
$sample.Root[0].Add($times[0])
$sample.Root[0].Add($times[50])
$sample.Save("$PSCommandPath\..\..\docs\sample.html")
