function ConvertFrom-UnixTime {
    [CmdletBinding(DefaultParameterSetName = "Seconds")]
    param (
        [Parameter(Position = 0, 
            ValueFromPipeline = $true, 
            Mandatory = $true,
            ParameterSetName = "Seconds")]
        [int]
        $Seconds,

        [Parameter(Position = 0, 
            ValueFromPipeline = $true, 
            Mandatory = $true, ParameterSetName = "Miliseconds")]
        [bigint]
        $Miliseconds
    )
    Begin {
        $date = (Get-Date "1970-01-01 00:00:00.000Z")
    }
    Process {
        switch ($PSCmdlet.ParameterSetName) {
            "Miliseconds" {
                $date = $date.AddMilliseconds($Miliseconds)
            }
            Default {
                $date = $date.AddSeconds($Seconds);
            }
        }
    }
    End {
        $date
    }
}
Set-Alias -Name epoch -Value ConvertFrom-UnixTime

1633694244| epoch
1633694244565 | epoch
