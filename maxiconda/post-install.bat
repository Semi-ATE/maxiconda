echo >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> start : post-install <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

echo %PREFIX%

set /p DUMMY=Hit ENTER to continue...

call %PREFIX%\condabin\activate.bat
call conda config --set channel_priority strict
call conda config --append channels Semi-ATE

call mamba create -n _spyder_ spyder>=5 ffmpeg spyder-screencast spyder-remote-client -y

call mamba create -n maxiconda numpy ipython maxiconda-shortcuts -y

echo >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> end : post-install <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
