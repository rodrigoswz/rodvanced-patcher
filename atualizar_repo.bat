@echo off
echo --- ATUALIZANDO SEU REPO ---

:: 1. Garante que voce esta na branch principal
git checkout main

:: 2. Adiciona o upstream (se ja existir, ele ignora o erro)
git remote add upstream https://github.com/E85Addict/revanced-magisk-module.git 2>NUL

:: 3. Baixa as novidades
echo.
echo Baixando atualizacoes do E85Addict...
git fetch upstream

:: 4. Mescla (Tenta automatico, se der erro de historia, forca)
echo.
echo Mesclando mudancas...
git merge upstream/main
if %errorlevel% neq 0 (
    echo.
    echo [!] TENTANDO MESCLAGEM FORCADA (Primeira vez?)...
    git merge upstream/main --allow-unrelated-histories
)

:: 5. Verifica se deu conflito
if %errorlevel% neq 0 (
    echo.
    echo ❌ CONFLITO DETECTADO!
    echo O script parou para voce resolver os arquivos conflitantes manualmente.
    echo Corrija, use 'git add .' e 'git commit'.
    pause
    exit /b
)

:: 6. Envia para o seu GitHub
echo.
echo Enviando para o seu GitHub...
git push

echo.
echo ✅ TUDO PRONTO! SEU REPO ESTA ATUALIZADO.
pause