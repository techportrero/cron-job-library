# daily-commit.ps1

# Set the path to your repository
$REPO_PATH = "C:\Development\Source\cron-job-library"

# Set log file path
$LOG_PATH = "C:\Development\Source\cron-job-library\Daily Commit\daily-commit.log"

# Create log directory if it doesn't exist
$LOG_DIR = Split-Path -Path $LOG_PATH -Parent
if (-not (Test-Path -Path $LOG_DIR)) {
    New-Item -ItemType Directory -Path $LOG_DIR -Force
}

# Navigate to repository
Set-Location -Path $REPO_PATH

# Get current date for the commit message
$DATE = Get-Date -Format "yyyy-MM-dd"

# Pull latest changes to avoid conflicts
git pull origin main

# Add all changes
git add -A

# Check if there are any changes to commit
$status = git status --porcelain
if ($status) {
    # Changes exist, proceed with commit
    git commit -m "Daily update: $DATE"
    
    # Push changes to remote repository
    git push origin main
    
    # Log the success
    Add-Content -Path $LOG_PATH -Value "Daily commit completed for $DATE - Changes were pushed"
} else {
    # No changes to commit
    Add-Content -Path $LOG_PATH -Value "Daily commit skipped for $DATE - No changes detected"
}