Add-Type -AssemblyName System.Windows.Forms 

$VideoBrowser = New-Object System.Windows.Forms.OpenFileDialog -Property @{ 
    InitialDirectory = $PSCommandPath
    Filter = 'Video file (*.mp4)|*.mp4|All files (*.*)|*.*'
    Title = 'Choose video file'
}
$null = $VideoBrowser.ShowDialog()
if (!($VideoBrowser.FileName))
{
    return
}

$AudioBrowser = New-Object System.Windows.Forms.OpenFileDialog -Property @{ 
    Filter = 'Video file (*.m4a)|*.m4a|All files (*.*)|*.*'
    Title = 'Choose audio file'
    #RestoreDirectory = $true
}
$null = $AudioBrowser.ShowDialog()
if (!($AudioBrowser.FileName))
{
    return
}

$NewVideoBrowser = New-Object System.Windows.Forms.SaveFileDialog -Property @{ 
    Filter = 'Video file (*.mp4)|*.mp4|All files (*.*)|*.*'
    Title = 'Save new video file as'
    #RestoreDirectory = $true
}
$null = $NewVideoBrowser.ShowDialog()
if (!($NewVideoBrowser.FileName))
{
    return
}
