
# ==========================================
# PREPARATION AUTOMATIQUE DE POSTE WINDOWS
# ==========================================

Write-Host "====================================" -ForegroundColor Cyan
Write-Host "   PREPARATION DU POSTE INFORMATIQUE" -ForegroundColor Cyan
Write-Host "====================================" -ForegroundColor Cyan

# 1. Vérification des droits administrateur
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $isAdmin) {
    Write-Host "Merci de lancer PowerShell en administrateur." -ForegroundColor Red
    exit
}

# 2. Installation de Chocolatey si absent
if (!(Get-Command choco -ErrorAction SilentlyContinue)) {
    Write-Host "Installation de Chocolatey..." -ForegroundColor Yellow

    Set-ExecutionPolicy Bypass -Scope Process -Force
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072

    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
}

# 3. Mise à jour de Chocolatey
Write-Host "Mise à jour de Chocolatey..." -ForegroundColor Yellow
choco upgrade chocolatey -y

# 4. Installation des logiciels
Write-Host "Installation des logiciels..." -ForegroundColor Yellow

$logiciels = @(
    "googlechrome",
    "firefox",
    "anydesk",
    "7zip",
    "winrar",
    "onedrive"
)

foreach ($logiciel in $logiciels) {
    Write-Host "Installation : $logiciel" -ForegroundColor Cyan
    choco install $logiciel -y
}

# 5. Mise à jour des logiciels
Write-Host "Mise à jour des logiciels..." -ForegroundColor Yellow
choco upgrade all -y

# 6. Fin de préparation
Write-Host "====================================" -ForegroundColor Green
Write-Host "   PREPARATION TERMINEE !" -ForegroundColor Green
Write-Host "====================================" -ForegroundColor Green

Read-Host "Appuyez sur Entree pour fermer"
