# intellij_cygwin
Integrating Cygwin/Babun as Intellij IDEA Terminal

I use it mostly to work with Ansible/Docker on Windows

## Install babun

Set user environment variable HOME=%USERPROFILE%. You will enjoy better navigation to ~/IdeaProjects

    reg add HKCU\Environment /v HOME /t REG_EXPAND_SZ /d ^%USERPROFILE^%

 * Install [babun](http://babun.github.io/)

## Rebase cygwin libraries
    # Close all cygwin windows and exit all cygwin processes
    # Start -> Run 
    %USERPROFILE%/.babun\cygwin\bin\dash.exe
    /usr/bin/rebaseall -v

## Configure babun and environment
    # Update /etc/passwd to reflect new HOME
    mkpasswd -l -p "$(cygpath -H)" > /etc/passwd
  	
    # Tweak mintty to support middle-button paste
    curl https://raw.githubusercontent.com/vermut/intellij_cygwin/master/minttyrc > ~/.minttyrc

    # Make zsh completion a bit like bash
    cat <<EOF >> ~/.zshrc
setopt BASH_AUTO_LIST AUTO_MENU NOBAD_PATTERN HIST_IGNORE_DUPS
unsetopt NOMATCH
EOF

## Use zsh as Terminal replacement for IDEA
The command is "$MAVEN_REPOSITORY$\..\..\.babun\cygwin\bin\env.exe CHERE_INVOKING=true /bin/zsh -"

I used a rather ugly dependency on MAVEN_REPOSITORY because I couldn't find the way to pass USERPROFILE variable.

    curl https://raw.githubusercontent.com/vermut/intellij_cygwin/master/terminal.xml > ~/.IdeaIC15/config/options/terminal.xml

## Configure PuTTY settings (default and existing sessions)
Mostly from [here](https://github.com/jblaine/solarized-and-modern-putty) with middle-button paste and no alt-screen.

    curl https://raw.githubusercontent.com/vermut/intellij_cygwin/master/putty-mass-settings-update.sh | bash

## Add support for Pageant
    pact install ssh-pageant
    echo >> ~/.babunrc
    echo 'eval $(/usr/bin/ssh-pageant -r -a "/tmp/.ssh-pageant-$USERNAME")' >> ~/.babunrc

## Install python-pip, Docker and Ansible
    curl https://bootstrap.pypa.io/get-pip.py | python
    pip install ansible docker-py

    # Or the latest devel
    # (cd /usr/local ; pip install -v -U -e git+https://github.com/ansible/ansible.git@devel#egg=ansible )

## Docker file type for IDEA
    mkdir ~/.IdeaIC15/config/filetypes
    wget -O ~/.IdeaIC15/config/filetypes/Dockerfile.xml https://raw.githubusercontent.com/maesgari/docker-intellij-idea/master/Dockerfile.xml

## Install Kitematic and variables for Docker
    echo 'eval "$(~/AppData/Local/Kitematic/app-*/resources/resources/docker-machine.exe env kitematic --shell bash)"' >> ~/.babunrc
    ln -s ~/AppData/Local/Kitematic/app-*/resources/resources/docker /usr/bin/docker
    ln -s ~/AppData/Local/Kitematic/app-*/resources/resources/docker-machine /usr/bin/docker-machine

Comment commonName exception in the last line of  /usr/lib/python2.7/site-packages/backports/ssl_match_hostname/__init__.py
