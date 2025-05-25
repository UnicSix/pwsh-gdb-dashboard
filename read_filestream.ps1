$filepath = ".\.tmp"

$previous_content = Get-Content $filepath -Raw
Write-Output $previous_content

while(Test-Path -Path $filepath) {
  $current_content = Get-Content $filepath -Raw
  if($current_content -ne $previous_content) {
    # Clear-Host
    Write-Output $current_content
    $previous_content = $current_content
  }
  Start-Sleep -Milliseconds 500
}
