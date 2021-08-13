#!/bin/bash

# reference : https://docs.conda.io/projects/conda/en/latest/user-guide/configuration/use-condarc.html

CONDARC_FILES=()
USER_HOME_DIR=$(eval echo "~")
USER=$(whoami)
CONDARC_DIR_LOCATIONS=(
    "/etc/conda/condarc.d/"
    "/var/lib/conda/condarc.d/"
    "$(eval echo \"$USER_HOME_DIR/.conda/condarc.d/\")"
)
CONDARC_FILE_LOCATIONS=(
    "/etc/conda/.condarc"
    "/etc/conda/condarc"
    "/var/lib/conda/.condarc"
    "/var/lib/conda/condarc"
    "$(eval echo \"$USER_HOME_DIR/.conda/.condarc\")"
    "$(eval echo \"$USER_HOME_DIR/.conda/condarc\")"
    "$(eval echo \"$USER_HOME_DIR/.condarc\")"
)

if [[ $CONDA_ROOT ]] && [ ! -z "$CONDA_ROOT" ]; then
    CONDARC_FILE_LOCATIONS+=(
	"$(eval echo \"$CONDA_ROOT/.condarc\")"
	"$(eval echo \"$CONDA_ROOT/condarc\")"
    )
    CONDARC_DIR_LOCATIONS+=(
	"$(eval echo \"$CONDA_ROOT/condarc.d/\")"
    )
fi

if [[ $CONDA_PREFIX ]] && [ ! -z "$CONDA_PREFIX" ]; then
    CONDARC_FILE_LOCATIONS+=(
	"$(eval echo \"$CONDA_PREFIX/.condarc\")"
	"$(eval echo \"$CONDA_PREFIX/condarc\")"
    )
    CONDARC_DIR_LOCATIONS+=(
	"$(eval echo \"$CONDA_PREFIX/condarc.d/\")"
    )
fi

if [[ $CONDARC ]] && [ ! -z "$CONDARC" ]; then
    if [ -d "$CONDARC" ]; then
	if [ $(echo "${CONDARC: -1}") = "/" ]; then
	    CONDARC_DIR_LOCATIONS+=( "$CONDARC" )
	else
	    CONDARC_DIR_LOCATIONS+=( "$CONDARC/" )
	fi
    elif [ -f "$CONDARC" ]; then
	CONDARC_FILE_LOCATIONS+=( "$CONDARC" )
    fi
fi

for CONDARC_FILE in ${CONDARC_FILE_LOCATIONS[*]}; do
    if [ -f "$CONDARC_FILE" ]; then
	CONDARC_FILES+=( $CONDARC_FILE)
    fi
done

for CONDARC_DIR in ${CONDARC_DIR_LOCATIONS[*]}; do
    if [ -d "$CONDARC_DIR" ]; then
	for CONDARC_FILE in $(ls "$CONDARC_DIR"); do
	    if [ -f "$CONDARC_DIR$CONDARC_FILE" ]; then
		CONDARC_FILES+=( "$CONDARC_DIR$CONDARC_FILE" ) 
	    fi 
	done
    fi
done

SHELRC_FILES=(
    "$(eval echo \"$USER_HOME_DIR/.bashrc\")"
    "$(eval echo \"$USER_HOME_DIR/.zshrc\")"
    "$(eval echo \"$USER_HOME_DIR/.config/fish/config.fish\")"
    "$(eval echo \"$USER_HOME_DIR/.xonshrc\")"
    "$(eval echo \"$USER_HOME_DIR/.tcshrc\")"
)
ACTIVATED_SHELRC_FILES=()

for SHELRC_FILE in ${SHELRC_FILES[*]}; do
    if [ -f $SHELRC_FILE ]; then
	if grep -q "conda initialize" "$SHELRC_FILE"; then
	    ACTIVATED_SHELRC_FILES+=( "$SHELRC_FILE" )
	fi
    fi
done


CONDA_INSTALLATION=false
if [[ $CONDA_EXE ]]; then
     if [ -d "$CONDA_EXE" ]; then
	 CONDA_INSTALLATION=true
     fi
fi

CAN_AUTO_REMOVE=true
if [ ! ${#CONDARC_FILES[@]} -eq 0 ] || [ $CONDA_INSTALLATION = true ] || [ ! ${#ACTIVATED_SHELRC_FILES[@]} -eq 0 ]; then

    if [[ $CONDA_EXE ]]; then
	CONDA_INSTALL_DIR="$(dirname ${CONDA_EXE})"
	CONDA_INSTALL_DIR="$(dirname ${CONDA_INSTALL_DIR})"
	echo "Your system already holds a conda installation in '$CONDA_INSTALL_DIR' !"
	if [ ! -w "$CONDA_INSTALL_DIR" ]; then
	    CAN_AUTO_REMOVE=false
	fi
    fi

    if [ ! ${#CONDARC_FILES[@]} -eq 0 ]; then
	echo "Your system holds the following files that need removal:"
	for CONDARC_FILE in ${CONDARC_FILES[*]}; do
	    echo "  - $CONDARC_FILE"
	    if [ ! -w "$CONDARC_FILE" ]; then
		CAN_AUTO_REMOVE=false
	    fi
	done
    fi

    if [ ! ${#ACTIVATED_SHELRC_FILES[@]} -eq 0 ]; then
	echo "The following shelrc files activate conda:"
	for SHELRC_FILE in ${ACTIVATED_SHELRC_FILES[*]}; do
	    echo "  - $SHELRC_FILE"
	    if [ ! -w "$SHELRC_FILE" ]; then
		CAN_AUTO_REMOVE=false
	    fi
	done
    fi

    if $CAN_AUTO_REMOVE ; then
	echo 
	read  -n 1 -p "do you want to remove the older conda installation? [Y/n]" Yn
	case $Yn in
	    [Yy]* ) AUTO_REMOVAL=true
		    ;;
	    [Nn]* ) AUTO_REMOVAL=false
		    ;;
	    * ) if [ -z "$Yn" ]; then
		    AUTO_REMOVAL=true
		else
		    AUTO_REMOVAL=false
		fi
		;;
	esac
	if $AUTO_REMOVAL; then
	    echo -n "removing '$CONDA_INSTALL_DIR/*' ... "
	    $(rm -rf "$CONDA_INSTALL_DIR")
	    echo "Done"

	    for CONDARC_FILE in ${CONDARC_FILES[*]}; do
		echo "removing '$CONDARC_FILE' ... "
		$(rm -f "$CONDARC_FILE")
		echo "Done"
	    done

	    for SHELRC_FILE in ${ACTIVATED_SHELRC_FILES[*]}; do
		echo -n "remiving conda section in '$SHELRC_FILE' ... "
		$(awk -v 'RS=# >>> conda initialize >>>|# <<< conda initialize <<<' -v ORS= NR%2 < "$SHELRC_FILE" > "$SHELRC_FILE.cleaned")
		$(rm -f "$SHELRC_FILE")
		$(mv "$SHELRC_FILE.cleaned" "$SHELRC_FILE")
		echo "Done"
	    done
	else
	    echo
	    echo "Please remove the old conda installation yourselve."
	    echo "Installation will now be aborted."
	    read -n 1 -p "hit any key to proceed ..." Yn
	    exit 1
	fi
    else
	echo
	echo "Please remove the old conda installation."
	echo "Installation will now be aborted."
	read -n 1 -p "hit any key to proceed ..." Yn
	exit 1
    fi

    # 
fi
