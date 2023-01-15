[xml]$XAML = @'
<Window Name="Window1"
   xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
   xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
   Width="700" Height="500"
   Title="Movie Player" Topmost="True">
    <Grid>
        <Grid.RowDefinitions>
            <RowDefinition Height="*"/>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="Auto"/>
        </Grid.RowDefinitions>
            <MediaElement Margin="10" Grid.Row="0" Name="VideoPlayer" LoadedBehavior="Manual" UnloadedBehavior="Stop" HorizontalAlignment="Stretch" VerticalAlignment="Stretch" />
            <Label Name="Status" Grid.Row="1" Content="Not playing..." HorizontalContentAlignment="Center" Margin="5" />
            <ProgressBar Name="Progress" Grid.Row="2" HorizontalAlignment="Stretch" Value="0" Height="20" Margin="5"></ProgressBar>
            <StackPanel Orientation="Horizontal" HorizontalAlignment="Center" Grid.Row="3">
                <Button Content="Pause" Name="PauseButton" IsEnabled="True" HorizontalAlignment="Left" VerticalAlignment="Top" Width="75"/>
                <Button Content="Play" Name="PlayButton" IsEnabled="False" HorizontalAlignment="Left" VerticalAlignment="Top" Width="75"/>
            </StackPanel>
         
    </Grid>
</Window>
'@

Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName System.ComponentModel

[uri]$VideoSource = "S:\stage\cv\1106-12.004.mp4"

$XAMLReader=(New-Object System.Xml.XmlNodeReader $XAML)
$window=[Windows.Markup.XamlReader]::Load( $XAMLReader )
$VideoPlayer = $window.FindName("VideoPlayer")
$PauseButton = $window.FindName("PauseButton")
$PlayButton = $window.FindName("PlayButton")
$Status = $window.FindName("Status")
$Progress = $window.FindName("Progress")

$VideoPlayer.Volume = 100
$VideoPlayer.Source = $VideoSource
$VideoPlayer.Play()
$PauseButton.IsEnabled = $true
$PlayButton.IsEnabled = $false
$Status.Content = "Playing"
$Progress.Value = 10

$PlayButton.Add_Click{
    $VideoPlayer.Play()
    $PauseButton.IsEnabled = $true
    $PlayButton.IsEnabled = $false
}

$PauseButton.Add_Click{
    $VideoPlayer.Pause()
    $PauseButton.IsEnabled = $false
    $PlayButton.IsEnabled = $true
}

$window.ShowDialog()
$VideoPlayer.Close()