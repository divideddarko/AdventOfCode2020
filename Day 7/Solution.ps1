# The rules

# light red bags contain 1 bright white bag, 2 muted yellow bags.
# dark orange bags contain 3 bright white bags, 4 muted yellow bags.
# bright white bags contain 1 shiny gold bag.
# muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
# shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
# dark olive bags contain 3 faded blue bags, 4 dotted black bags.
# vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
# faded blue bags contain no other bags.
# dotted black bags contain no other bags.


# find the shiny gold
# see if there is a bag at the start of the array of bags in the list
# check to see if this bag is held within another bag.

function checkBagStatus {
    [CmdletBinding()]
    param (
        [Parameter()]
        [string]$bagColour
    )

    Write-Host "Status: $bagColour"
}

$filecontent = Get-Content(".\input.txt")
$shinyBagCount = 0

$filecontent | ForEach-Object {
    if ($_ -match 'shiny gold') {
        $shinyBagCount++
        $eachBag = $_ -split (',')

        $eachBag | ForEach-Object {
            if ($_ -notmatch 'shiny gold bags') {
                checkBagStatus -bagColour $_
            }
        }
    }
}

Write-Host "There are: $shinyBagCount shiny gold bags"
3


# Count all different bag types

$bagsCounted = @{ }

$filecontent = Get-Content(".\testinput.txt")

$filecontent | ForEach-Object {
    $_ -split (',') | ForEach-Object {
        Write-Host "Working on $_"
        if ($_ -match '[0-9]') {
            $bagCount = $($_ -split('[aA-zZ]')).trim()
            $bagDetails = $_ -split('[0-9] ')

            Write-Host "bag Count: $bagCount `nbag details: $bagDetails"


            if ($bagsCounted.Item($bagDetails)) {
                $currentBagCount = $bagsCounted.Item($bagDetails)
                $newBagCount = $currentBagCount + $bagCount
                $bagsCounted.Set_Item($bagDetails, $newBagCount)
            } else {
                $bagsCounted.Add($bagDetails, $bagCount)
            }
        } else {

            if (!$bagsCounted.Item($bagDetails)) {
                $bagsCounted.Add($bagDetails, 0)
            }
        }
    }
}

$bagsCounted