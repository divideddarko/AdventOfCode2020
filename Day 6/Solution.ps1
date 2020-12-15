function setgroupValues {
    [CmdletBinding()]
    param (
        [Parameter()]
        [string]$letter,
        [ValidateSet('Setup', 'Add', 'Clear')]
        [string]$action
    )


    switch ($action) {
        'Setup' {
            $groupsValues.Add($letter, 0)
            return
         }
        'Add' {
            $currentValue = $groupsValues.Item($letter)
            $groupsValues.Set_Item($letter, ($currentValue += 1))
            break
         }
        'Clear' {
            $groupsValues.Clear()
            return
         }
    }
}


$content = Get-Content(".\input.txt")

$runningTotal, $newTotal, $row, $count, $aTotal, $newnum = 0
$q = 1
$script:groupsValues = @{}
$groupNumbers = @{}

$content | ForEach-Object {
    if ($_ -ne ''){
        $count++
    }

    if ($_ -eq ''){
        $row++
        $groupNumbers.Set_Item($row, $count)
        $count = 0
    }
}


$content | ForEach-Object {
    $word = $_

    if ($_ -ne '') {
        for ($i = 0; $i -lt $word.Length; $i++) {
            setgroupValues -letter "$($word[$i])" -action 'Add'
        }
    }
    if ($_ -eq '') {
        $groupsValues

        $groupsValues.GetEnumerator() | Select-Object Key, Value | ForEach-Object {
            if ($_.Value -eq $($groupNumbers.Item($q))){
                $newnum++
            }
        }

        $q++
        $runningTotal += $($groupsValues.Count)
        $groupsValues.Clear()
    }
}

Write-Host "Running Total: $newnum"