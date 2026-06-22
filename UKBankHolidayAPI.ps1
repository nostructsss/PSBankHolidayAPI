function Get-UKBankHoliday
{
    param (
        [ValidateSet('england-and-wales', 'scotland', 'northern-ireland')]
        [string]$Region = 'england-and-wales'
    )

    $url = "https://www.gov.uk/bank-holidays.json"
    
    try 
    {
        $response = Invoke-RestMethod -Uri $url -Method Get
        
        $events = $response.$Region.events

        $CurrentDate = Get-Date -Format "yyyy-MM-dd"

        foreach ($i in $events)
        {
            if ($i.date -gt $CurrentDate)
            {
                $NextBankHolidayDate = $i.date
                $NextBankHolidayTitle = $i.title
                break
            }
        }
        
        Write-Host "The Next Bank Holiday is: $NextBankHolidayTitle at $NextBankHolidayDate"
    }
    catch 
    {
        Write-Error "Failed to retrieve bank holidays: $_"
    }
}