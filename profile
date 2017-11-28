# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# Add gradle to path
if [ -d "/opt/gradle/bin" ] ; then
    PATH="/opt/gradle/bin:$PATH"
fi

#export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64
#export JAVA_HOME=/opt/jdk1.8.0_31

export GOPATH=/home/andlin/projects/go
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin

export ANDROID_HOME="/opt/android-sdk/adt-bundle-linux-x86_64-20140321/sdk"
export PATH="$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$PATH"

# Bit requires us to set -Dfilen.encoding in JAVA_TOOL_OPTIONS
# Ref: https://prosjektwiki.kantega.no/display/BIT/SD_Kom+i+gang+med+utvikling
#export JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF-8

emacs(){ 
    emacsclient "$@" 2>/dev/null || /usr/bin/emacs "$@" 
}

# Add ~/bin to path
if [ -d "$HOME/bin" ] ; then
    export PATH="$HOME/bin:$PATH"
fi

# Add golang binaries to path
if [ -d "/usr/local/go/bin" ] ; then
    export PATH=$PATH:/usr/local/go/bin
    export GOPATH=$HOME/projects/go
fi

# Gobo BIT_ENV
if [ -d "/home/andlin/workspaces/bit-gobo" ] ; then
    export BIT_ENV=DEV
fi
#echo "Loaded ~/.profile"
