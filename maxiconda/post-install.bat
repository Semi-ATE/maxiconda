call %PREFIX%\condabin\activate.bat
call conda config --set channel_priority strict
call conda config --append channels Semi-ATE
REM call mamba install maxiconda-base
call mamba create -n _spyder_ _spyder_ -y
call mamba create -n maxiconda maxiconda -y
