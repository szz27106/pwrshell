function Rename-Files {
    param (
        [string]$extension
    )

    # Get all files with the specified extension in the current directory
    # change it to modification time
    $files = Get-ChildItem -Path . -Filter *.$extension | Sort-Object LastWriteTime -Descending

    # Initialize the counter
    $counter = 1

    # Loop through each file and rename it
    foreach ($file in $files) {
        # Format the new file name with 3 digits
        $newName = "{0:D3}.$extension" -f $counter

        # Rename the file
        Rename-Item -Path $file.FullName -NewName $newName

        # Increment the counter
        $counter++ 
    }
}
