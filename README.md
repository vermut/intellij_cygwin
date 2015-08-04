# intellij_cygwin
Integrating Cygwin/Babun as Intellij IDEA Terminal

I use it mostly to work with Ansible on Windows

## Install babun

Set user environment variable HOME=%USERPROFILE%. You will enjoy better navigation to ~/IdeaProjects

    reg add HKCU\Environment /v HOME /t REG_EXPAND_SZ /d ^%USERPROFILE^%

 * Install [babun](http://babun.github.io/)

## Rebase cygwin libraries
    # Close all cygwin windows and exit all cygwin processes
    # Start -> Run -> cmd
    .babun\cygwin\bin\dash.exe
    /usr/bin/rebaseall -v

## Configure babun and environment
    # Update /etc/passwd to reflect new HOME
    mkpasswd -l -p "$(cygpath -H)" > /etc/passwd
  	
    # Tweak mintty to support middle-button paste
    curl https://raw.githubusercontent.com/vermut/intellij_cygwin/master/minttyrc > ~/.minttyrc

## Use zsh as Terminal replacement for IDEA
The command is "$MAVEN_REPOSITORY$\..\..\.babun\cygwin\bin\env.exe CHERE_INVOKING=true /bin/zsh -"

I used a rather ugly dependency on MAVEN_REPOSITORY because I couldn't find the way to pass USERPROFILE variable.

    curl https://raw.githubusercontent.com/vermut/intellij_cygwin/master/terminal.xml > ~/.IdeaIC15/config/options/terminal.xml

## Configure PuTTY settings (default and existing sessions)
Mostly from [here](https://github.com/jblaine/solarized-and-modern-putty) with middle-button paste and no alt-screen.

    curl https://raw.githubusercontent.com/vermut/intellij_cygwin/master/putty-mass-settings-update.sh | bash

## Add support for Pageant
    pact install ssh-pageant
    echo 'eval $(/usr/bin/ssh-pageant -r -a "/tmp/.ssh-pageant-$USERNAME")' >> ~/.babunrc

## Install python-pip, Docker and Ansible
    curl https://bootstrap.pypa.io/get-pip.py | python
    pip install ansible docker-py

## Docker file type for IDEA
    mkdir ~/.IdeaIC15/config/filetypes
    wget -O ~/.IdeaIC15/config/filetypes/Dockerfile.xml https://raw.githubusercontent.com/maesgari/docker-intellij-idea/master/Dockerfile.xml

## Install Kitematic and variables for Docker
    echo 'eval "$(~/AppData/Local/Kitematic/app-*/resources/resources/docker-machine.exe env kitematic --shell bash)"' >> ~/.babunrc
    ln -s ~/AppData/Local/Kitematic/app-*/resources/resources/docker /usr/bin/docker
