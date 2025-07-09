@echo off
SETLOCAL

REM Verifica se a pasta atual já é um repositório Git
IF EXIST ".git" (
    echo Esta pasta ja e um repositório Git. Verificando se aponta para o repositório correto...

    REM Captura a URL do origin atual
    for /f "tokens=*" %%i in ('git remote get-url origin') do set CURRENT_REMOTE=%%i

    REM Define o remote esperado
    set EXPECTED_REMOTE=git@github.com:SatouYuri/ponasound-track-shop.git

    REM Compara com o esperado
    IF /I "%CURRENT_REMOTE%"=="%EXPECTED_REMOTE%" (
        echo Origin correto detectado. Fazendo git pull...
        git pull origin main
    ) ELSE (
        echo Esta pasta e um repositório Git, mas com um origin diferente.
        echo Corrigindo origin para: %EXPECTED_REMOTE%
        git remote set-url origin %EXPECTED_REMOTE%
        git pull origin main
    )
) ELSE (
    echo Esta pasta nao e um repositório Git. Clonando para uma pasta temporaria...

    git clone %EXPECTED_REMOTE% temp-clone
    xcopy temp-clone\* . /E /H /C /I /Y
    rmdir /S /Q temp-clone

    echo Repositório clonado com sucesso para a pasta atual.
)

ENDLOCAL
pause
