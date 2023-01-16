# https://stackoverflow.com/questions/8097354/how-do-i-capture-the-output-into-a-variable-from-an-external-process-in-powershe
Function GetProgramOutput([string]$exe, [string]$arguments)
{
    $process = New-Object -TypeName System.Diagnostics.Process
    $process.StartInfo.FileName = $exe
    $process.StartInfo.Arguments = $arguments
    
    $process.StartInfo.UseShellExecute = $false
    $process.StartInfo.RedirectStandardOutput = $true
    $process.StartInfo.RedirectStandardError = $true
    $process.Start()
    
    $output = $process.StandardOutput.ReadToEnd()   
    $err = $process.StandardError.ReadToEnd()
    
    $process.WaitForExit()
    
    $output
    $err
}
    
$exe = "C:\Program Files\7-Zip\7z.exe"
$arguments = "i"
    
$runResult = (GetProgramOutput $exe $arguments)
$stdout = $runResult[-2]
$stderr = $runResult[-1]
    
[System.Console]::WriteLine("Standard out: " + $stdout)
[System.Console]::WriteLine("Standard error: " + $stderr)

$cmdOutput = & $exe $arguments 2>&1 | ForEach-Object {
    if ($_ -is [System.Management.Automation.ErrorRecord]) {
      Write-Error $_
    } else {
      $_
    }
  }

$cmdOutput 