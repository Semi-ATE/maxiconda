call %PREFIX%\condabin\activate.bat
call conda config --set channel_priority strict
call conda config --append channels Semi-ATE
call mamba create -n _spyder_ spyder ffmpeg spyder-screencast spyder-remote-client -y
call mamba create -n maxiconda numpy ipython -y
REM call mamba install maxiconda-shortcuts -y
