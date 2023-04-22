## Define variables ####
$launcherRun = "D:\J\PC\Minecraft Java\BV\TL.exe"
$mmtRun = "D:\P\MMT\MultiMonitorTool.exe"
$mmtDisplay = 2
$processLauncher = "java"
$windowTitleLauncher1 = "TL ::"
$windowTitleLauncher2 = "Legacy"
$processMC = "javaw"
$windowTitleMC = "Minecraft"

# Start Launcher
Start-Process $launcherRun

# Wait for Launcher to start
while (!(Get-Process $processLauncher -ErrorAction SilentlyContinue | Where-Object {$_.MainWindowTitle -like ("*" + $windowTitleLauncher1 + "*")})) { }

# Move Launcher to defined monitor
Start-Process $mmtRun "/MoveWindow $mmtDisplay Title $windowTitleLauncher1"

# Wait for Launcher to start
while (!(Get-Process $processLauncher -ErrorAction SilentlyContinue | Where-Object {$_.MainWindowTitle -like ("*" + $windowTitleLauncher2 + "*")})) { }

# Move Launcher to defined monitor
Start-Process $mmtRun "/MoveWindow $mmtDisplay Title $windowTitleLauncher2"

# Wait for Minecraft to start
while (!($proc))
{
    $proc = Get-Process $processMC -ErrorAction SilentlyContinue | Where-Object {$_.MainWindowTitle -like ($windowTitleMC + "*")}
}

# Move Minecraft to defined monitor
Start-Process $mmtRun "/MoveWindow $mmtDisplay Title $windowTitleMC"

# Wait for Minecraft to close so PlayNite does not appear
if ($proc -ne $null) {
    $proc.WaitForExit()
    $proc.Dispose()
}
