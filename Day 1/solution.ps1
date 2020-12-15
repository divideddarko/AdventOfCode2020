$input = Get-Content(".\input.txt")

foreach ($one in $input)
{
    foreach ($two in $input)
    {
        if ($two -ne $one)
        {
            $counted = [int]$two + [int]$one
            if ($counted -eq "2020")
            {
                $results = [int]$i * [int]$one
                Write-Host "results: $results"
            }
        }
    }
}



$input = Get-Content(".\input.txt")

foreach ($item in $input)
{
    foreach ($i in $input)
    {
        foreach ($p in $input)
        {
            if ($i -ne $item -and $p -ne $input -and $p -ne $i)
            {
                $q = [int]$i + [int]$item + [int]$p
                if ($q -eq "2020")
                {
                    $results = [int]$i * [int]$item * [int]$p
                    Write-Host "results: $results"
                    return
                }
            }
        }
    }
}
