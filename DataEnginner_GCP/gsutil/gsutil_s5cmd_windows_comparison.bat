# Using n2-standard-4
# Using Windows Server version 1809 Datacenter Core for Containers, built on 20200813

powershell

# Create local SSD file system and mount
Get-Disk
Get-Disk | Where-Object PartitionStyle –Eq 'RAW' | Initialize-Disk
# For NVMe:
#New-Partition –DiskNumber 0 -AssignDriveLetter –UseMaximumSize
# For SCSI:
#New-Partition –DiskNumber 1 -AssignDriveLetter –UseMaximumSize
Format-Volume -DriveLetter D
cd D:\

##### Testing with gsutil #####

# Download empty 30 GB file created on Linux machine
gsutil cp gs://doit-speed-test-bucket/temp_30GB_file .

# Test upload from local SSD
Measure-Command {gsutil cp temp_30GB_file gs://doit-speed-test-bucket/}
# NVMe: 3m50.064s, 133.53 MB/s
# SCSI: 4m7.256s, 124.24 MB/s

Measure-Command {gsutil -m cp temp_30GB_file gs://doit-speed-test-bucket/}
# NVMe: 3m59.462s, 128.29 MB/s
# SCSI: 3m34.013s, 143.54 MB/s

Measure-Command {gsutil -o GSUtil:parallel_composite_upload_threshold=150M cp temp_30GB_file gs://doit-speed-test-bucket/}
# NVMe: 5m54.046s, 86.77 MB/s
# SCSI: 6m13.929s, 82.15 MB/s

Measure-Command {gsutil -m -o GSUtil:parallel_composite_upload_threshold=150M cp temp_30GB_file gs://doit-speed-test-bucket/}
# NVMe: 5m55.751s, 86.40 MB/s
# SCSI: 5m58.078s, 85.79 MB/s

# Test download to local SSD
Measure-Command {gsutil cp gs://doit-speed-test-bucket/temp_30GB_file .}
## Note: Seems to get around 68-69 MB/s, but takes 1-2 minutes to begin downloading and sometimes hangs mid-download
# NVMe 1st attempt: 11m39.426s, 43.92 MB/s
# NVMe 2nd attempt: 9m1.857s, 56.69 MB/s
# SCSI 1st attempt: 8m54.462s, 57.48 MB/s
# SCSI 2nd attempt: 10m1.023s, 51.05 MB/s

Measure-Command {gsutil -m cp gs://doit-speed-test-bucket/temp_30GB_file .}
## Note: Seems to get around 70-71 MB/s, but takes 1-2 minutes to begin downloading and sometimes hangs mid-download
# NVMe 1st attempt: 8m52.537s, 57.69 MB/s
# NVMe 2nd attempt: 22m4.824s, 23.19 MB/s
# NVMe 3rd attempt: 8m50.202s, 57.94 MB/s
# SCSI 1st attempt: 7m29.502s, 68.34 MB/s
# SCSI 2nd attempt: 9m9.652s, 55.89 MB/s



##### Testing with s5cmd #####
# Install go
param(
	[string]$w='',
	[string]$v='1.15'
)

# installer file
$file = 'go' + $v + '.windows-amd64.msi'

# set defaults
$workDir = 'Documents\go'
$url = 'https://storage.googleapis.com/golang/' + $file
$dest = Join-Path $Home "Downloads"
$dest = Join-Path $dest $file

# if $w wasn't passed; use the default
if ($w -eq "") {
    $gopath = Join-Path $Home $workDir
} else {
    $gopath = $w
}

# Setup the Go workspace; if it doesn't exist.
If (!(Test-Path $gopath)) {
    New-Item -path $gopath -type directory
}

# Create GOPATH and set PATH to use $GOPATH\bin
$gopathbin = Join-Path $gopath "bin"

# set the $GOPATH
[Environment]::SetEnvironmentVariable( "GOPATH", $gopath, [System.EnvironmentVariableTarget]::User )

# see the $GOBIN
[Environment]::SetEnvironmentVariable( "GOBIN", $gopathbin, [System.EnvironmentVariableTarget]::User )

Write-Output "downloading $url"
# Create client, set its info, and download
$wc = New-Object System.Net.WebClient
$wc.UseDefaultCredentials = $true
$wc.Headers.Add("X-FORMS_BASED_AUTH_ACCEPTED", "f")
$wc.DownloadFile($url, $dest)

Write-Output "$url downloaded as $dest"
Write-Output "installing $v..."
# Run the msi
Start-Process $dest

Write-Output "done"


# Install AWS CLI
$url = "https://awscli.amazonaws.com/AWSCLIV2.msi"
$tmp = "AWSCLIV2.msi"
Invoke-WebRequest -Uri $url -OutFile $tmp
Start-Process $tmp -ArgumentList '/quiet' -Wait
Remove-Item -path $tmp


# Install Git
$url = "https://github.com/git-for-windows/git/releases/download/v2.28.0.windows.1/Git-2.28.0-64-bit.exe"
$tmp = "Git-2.28.0-64-bit.exe"
Invoke-WebRequest -Uri $url -OutFile $tmp
Start-Process $tmp -ArgumentList '/quiet' -Wait
Remove-Item -path $tmp


# Refresh path
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

# Set up access & secret access keys provided for a service account from S3 Interoperability
aws configure

# Install s5cmd
C:\Go\bin\go.exe get github.com/peak/s5cmd


# Test upload from local SSD
Measure-Command {s5cmd --endpoint-url https://storage.googleapis.com cp -c=1 -p=1000000 temp_30GB_file s3://doit-speed-test-bucket/}
# NVMe: 6m21.780s, 80.46 MB/s
# SCSI: 7m14.162s, 70.76 MB/s

Measure-Command {s5cmd --endpoint-url https://storage.googleapis.com cp -p=1000000 temp_30GB_file s3://doit-speed-test-bucket/}
# NVMe: 12m56.066s, 39.58 MB/s
# SCSI: 8m12.255s, 62.41 MB/s

# Test download to local SSD
Measure-Command {s5cmd --endpoint-url https://storage.googleapis.com cp -c=1 -p=1000000 s3://doit-speed-test-bucket/temp_30GB_file .}
# NVMe 1st attempt: 2m17.954s, 222.68 MB/s
# NVMe 2nd attempt: 1m44.718s, 293.36 MB/s
# SCSI 1st attempt: 3m9.581s, 162.04 MB/s
# SCSI 2nd attempt: 1m52.500s, 273.07 MB/s

Measure-Command {s5cmd --endpoint-url https://storage.googleapis.com cp -c=1 s3://doit-speed-test-bucket/temp_30GB_file .}
# NVMe 1st attempt: 3m18.006s, 155.15 MB/s
# NVMe 2nd attempt: 4m2.792s, 126.53 MB/s
# SCSI 1st attempt: 3m37.126s, 141.48 MB/s
# SCSI 2nd attempt: 4m9.657s, 123.05 MB/s

Measure-Command {s5cmd --endpoint-url https://storage.googleapis.com cp -p=1000000 s3://doit-speed-test-bucket/temp_30GB_file .}
# NVMe 1st attempt: 2m17.151s, 223.99 MB/s
# NVMe 2nd attempt: 1m47.217s, 286.52 MB/s
# SCSI 1st attempt: 4m39.120s, 110.06 MB/s
# SCSI 2nd attempt: 1m42.159s, 300.71 MB/s

Measure-Command {s5cmd --endpoint-url https://storage.googleapis.com cp s3://doit-speed-test-bucket/temp_30GB_file .}
# NVMe 1st attempt: 2m48.714s, 182.08 MB/s
# NVMe 2nd attempt: 2m41.174s, 190.60 MB/s
# SCSI 1st attempt: 2m35.480s, 197.58 MB/s
# SCSI 2nd attempt: 2m40.483s, 191.42 MB/s


# Find average speed of a download or upload
# Function courtesy of: https://gist.github.com/jpoehls/2206444
function Measure-CommandAvg ([ScriptBlock]$Expression, [int]$Samples = 20, [Switch]$Silent, [Switch]$Long) {
<#
.SYNOPSIS
  Runs the given script block and returns the execution duration.
  Discovered on StackOverflow. http://stackoverflow.com/questions/3513650/timing-a-commands-execution-in-powershell
  
.EXAMPLE
  Measure-Command2 { ping -n 1 google.com }
#>
  $timings = @()
  do {
    $sw = New-Object Diagnostics.Stopwatch
    if ($Silent) {
      $sw.Start()
      $null = & $Expression
      $sw.Stop()
      Write-Host "." -NoNewLine
    }
    else {
      $sw.Start()
      & $Expression
      $sw.Stop()
    }
    $timings += $sw.Elapsed
    
    $Samples--
  }
  while ($Samples -gt 0)
  
  Write-Host
  
  $stats = $timings | Measure-Object -Average -Minimum -Maximum -Property Ticks
  
  # Print the full timespan if the $Long switch was given.
  if ($Long) {  
    Write-Host "Avg: $((New-Object System.TimeSpan $stats.Average).ToString())"
    Write-Host "Min: $((New-Object System.TimeSpan $stats.Minimum).ToString())"
    Write-Host "Max: $((New-Object System.TimeSpan $stats.Maximum).ToString())"
  }
  else {
    # Otherwise just print the milliseconds which is easier to read.
    Write-Host "Avg: $((New-Object System.TimeSpan $stats.Average).TotalMilliseconds)ms"
    Write-Host "Min: $((New-Object System.TimeSpan $stats.Minimum).TotalMilliseconds)ms"
    Write-Host "Max: $((New-Object System.TimeSpan $stats.Maximum).TotalMilliseconds)ms"
  }
}


# Find average download speed with ideal command and arguments
Measure-CommandAvg {s5cmd --endpoint-url https://storage.googleapis.com cp -c=1 -p=1000000 s3://doit-speed-test-bucket/temp_30GB_file .}
### With 20 sample downloads
# NVMe:
# Avg: 1m48.014s, 284.41 MB/s
# Min: 1m23.411s, 368.30 MB/s
# Max: 3m10.989s, 160.85 MB/s
# SCSI: 
# Avg: 1m47.737s, 285.14 MB/s
# Min: 1m24.784s, 362.33 MB/s
# Max: 4m44.807s, 107.86 MB/s

Measure-CommandAvg {s5cmd --endpoint-url https://storage.googleapis.com cp -p=1000000 s3://doit-speed-test-bucket/temp_30GB_file .}
### With 20 sample downloads
# NVMe:
# Avg: 3m3.770s, 167.17 MB/s
# Min: 1m34.901s, 323.70 MB/s
# Max: 10m34.575s, 48.41 MB/s
# SCSI: 
# Avg: 2m20.131s, 219.22 MB/s
# Min: 1m31.585s, 335.43 MB/s
# Max: 3m43.215s, 137.63 MB/s


# Find average upload speed with ideal command and arguments
Measure-CommandAvg {gsutil cp temp_30GB_file gs://doit-speed-test-bucket/}
# NVMe:
# Avg: 3m23.216s, 151.17 MB/s
# Min: 2m31.169s, 203.22 MB/s
# Max: 4m13.943s, 121.42 MB/s
# SCSI: 
# Avg: 5m1.570s, 101.87 MB/s
# Min: 3m2.649s, 168.19 MB/s
# Max: 35m3.276s, 14.61 MB/s



##### Testing s5cmd download with many small files #####

Measure-CommandAvg {s5cmd --endpoint-url https://storage.googleapis.com cp s3://doit-speed-test-bucket/smallparts/* parts/}
# NVMe:
# Avg: 2m39.540s, 192.55 MB/s
# Min: 2m35.323s, 197.78 MB/s
# Max: 2m44.260s, 187.02 MB/s
# SCSI: 
# Avg: 2m45.431s, 185.70 MB/s
# Min: 2m40.785s, 191.06 MB/s
# Max: 2m50.930s, 179.72 MB/s



##### Testing gsutil upload with many small files #####

Measure-CommandAvg {gsutil -q -m cp -r parts gs://doit-speed-test-bucket/smallparts/}
# NVMe:
# Avg: 16m36.562s, 30.83 MB/s
# Min: 16m22.914s, 31.25 MB/s
# Max: 17m0.299s, 30.11 MB/s
# SCSI: 
# Avg: 17m29.591s, 29.27 MB/s
# Min: 17m5.236s, 29.96 MB/s
# Max: 18m3.469s, 28.35 MB/s