$i = Get-Content(".\input.txt")
$wordsthatmatch = 0

Measure-Command {
    $i | ForEach-Object {
        $lowestcharacterCount = ($_ -split ('-'))[0]
        $highestcharacterCount = ($_ -split ('-') -split (' '))[1]
        $charactertofind = ($_ -split (' ') -split(':'))[1]
        $password = ($_ -split (': '))[1]

        $storedString = @{}

        $password -split('') | ForEach-Object {
            if ($storedString.ContainsKey($_)) {
                $count = $storedString.Item($_)
                $count++
                $storedString.Set_Item($_, $count)
            } else {
                $storedString.Add($_, 1)
            }
        }

        $storedString

        if ($storedString.Item($charactertofind) -ge $lowestcharacterCount -and $storedString.Item($charactertofind) -le $highestcharacterCount){
            $wordsthatmatch++
        }

    }
}

Write-Host "Found words: $($wordsthatmatch)"


$i = Get-Content(".\input.txt")
$wordsthatmatch = 0

Measure-Command {
    $i | ForEach-Object {
        $lowestcharacterCount = ($_ -split ('-'))[0]
        $highestcharacterCount = ($_ -split ('-') -split (' '))[1]
        $charactertofind = ($_ -split (' ') -split(':'))[1]
        $password = ($_ -split (': '))[1]

        Write-Host " $charactertofind"
        Write-Host "letter at position $($lowestcharacterCount)  $($password[$lowestcharacterCount - 1])"
        Write-Host "letter at position $($highestcharacterCount)  $($password[$highestcharacterCount - 1])"

        if (($password[$lowestcharacterCount - 1] -match $charactertofind -ne $password[$highestcharacterCount - 1] -match $charactertofind) -or ($password[$highestcharacterCount - 1] -match $charactertofind -ne $password[$lowestcharacterCount - 1] -match $charactertofind)){
            Write-Host "yes"
            $wordsthatmatch++
        } else {
            Write-Host "no"
        }

    }
}

Write-Host "Found words: $($wordsthatmatch)"