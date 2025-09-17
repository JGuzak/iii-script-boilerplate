if (-not (Get-Command python -ErrorAction SilentlyContinue)) {
    Write-Host "❌ Python not found. Please install Python 3.11 before continuing."
    exit 1
}

$pyVersion = python -c "import sys; print(f'{sys.version_info.major}.{sys.version_info.minor}')"
if ($pyVersion -ne "3.11") {
    Write-Host "❌ Python version mismatch. Found $pyVersion, but 3.11 is required."
    exit 1
}

if (Test-Path ".venv") {
    try {
        $venvVersion = .\.venv\Scripts\python.exe -c "import sys; print(f'{sys.version_info.major}.{sys.version_info.minor}')" 
    } catch {
        $venvVersion = "none"
    }
    if ($venvVersion -ne "3.11") {
        Write-Host "⚠️  Existing .venv uses $venvVersion. Recreating..."
        Remove-Item -Recurse -Force ".venv"
    }
}

python -m venv .venv
.\.venv\Scripts\Activate.ps1

pip install --upgrade pip
pip install -r requirements.txt

Write-Host "✅ Setup complete!"
Write-Host "➡️ To activate: .\.venv\Scripts\Activate.ps1"
