# Script: image2gnf.ps1
# Purpose: Compress all JPEGs (test1_*.jpg) in the input directory into a single GNF file as a 2DArray

# Configuration
$image2gnfPath = "YOUR_PATH_TO_SDK_WHICH_IS_NEEDED\image2gnf.exe"
$inputDir = "YOUR_PATH_TO_SDK_WHICH_IS_NEEDED\jpg_input"
$outputDir = "YOUR_PATH_TO_SDK_WHICH_IS_NEEDED\gnf_output"
$outputFile = "$outputDir\textures.gnf"

# Start logging
Start-Transcript -Path "$outputDir\gnf_conversion_log.txt"

# Create output directory
New-Item -ItemType Directory -Path $outputDir -Force | Out-Null

# Generate list of input files (test1_*.jpg)
$inputFiles = Get-ChildItem -Path $inputDir -Filter "test1_*.jpg" | Sort-Object { [int]($_.BaseName -replace 'test1_', '') } | Select-Object -ExpandProperty FullName

# Check if files exist
if ($inputFiles.Count -eq 0) {
    Write-Error "No input files found in $inputDir matching test1_*.jpg"
    Stop-Transcript
    exit 1
}

# Warn if slice count is not power-of-2
$sliceCount = $inputFiles.Count
$powerOf2 = [math]::Log($sliceCount, 2)
if ($powerOf2 -ne [math]::Floor($powerOf2)) {
    Write-Warning "Number of slices ($sliceCount) is not a power-of-2. This may affect GPU performance."
}

# Prepare image2gnf arguments with individual -i flags
$gnfArgs = @("-i")
$gnfArgs += $inputFiles
$gnfArgs += @("-o", $outputFile, "-t", "2DArray", "-f", "Bc7UNorm", "-g", "1", "-x", "M", "-e", "-w", "-b", "0.8", "-z", "30", "-m", "4", "-l", "4KB")

# Run image2gnf
Write-Host "Compressing $sliceCount JPEGs into $outputFile as a 2DArray..."
& $image2gnfPath $gnfArgs
if ($LASTEXITCODE -ne 0) {
    Write-Warning "Failed to create $outputFile. Check error messages above and log at $outputDir\gnf_conversion_log.txt."
} else {
    Write-Host "Successfully created $outputFile with $sliceCount textures"
}

# Stop logging
Stop-Transcript