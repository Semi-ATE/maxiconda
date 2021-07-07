call %PREFIX%\condabin\activate.bat
call conda config --set channel_priority strict
call conda config --append channels Semi-ATE
call mamba create -n _spyder_ _spyder_ -y
call mamba create -n maxiconda maxiconda -y
call mamba install menuinst maxiconda-shortcuts spyder-remote-server -y
REM need to activate the spyder-remote-server here ...
