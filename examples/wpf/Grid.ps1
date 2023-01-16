# https://wpf-tutorial.com/panels/grid-rows-and-columns/

[xml]$XAML = @'
<Window Name="Window1"
   xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
   xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
   Width="700" Height="500"
   Title="Movie Player" Topmost="True">
    <Grid>
        <Grid.ColumnDefinitions>
            <ColumnDefinition Width="2*" />
            <ColumnDefinition Width="1*" />
            <ColumnDefinition Width="1*" />
        </Grid.ColumnDefinitions>
        <Grid.RowDefinitions>
            <RowDefinition Height="2*" />
            <RowDefinition Height="1*" />
            <RowDefinition Height="1*" />
        </Grid.RowDefinitions>
        <Button Name="Btn1">Button 1</Button>
        <Button Grid.Column="1" Content="Btn 2"/>
        <Button Grid.Column="2">Button 3</Button>
        <Button Grid.Row="1">Button 4</Button>
        <Button Grid.Column="1" Grid.Row="1">Button 5</Button>
        <Button Grid.Column="2" Grid.Row="1">Button 6</Button>
        <Button Grid.Row="2">Button 7</Button>
        <Button Grid.Column="1" Grid.Row="2">Button 8</Button>
        <Button Grid.Column="2" Grid.Row="2">Button 9</Button>
    </Grid>
</Window>
'@

Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName System.ComponentModel

$XAMLReader=(New-Object System.Xml.XmlNodeReader $XAML)
$window=[Windows.Markup.XamlReader]::Load( $XAMLReader )

$Btn1 = $window.FindName("Btn1")
$Btn1.Content = "Btn 1"
$window.ShowDialog()

