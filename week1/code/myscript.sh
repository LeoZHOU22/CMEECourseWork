

echo $PATH
find /home/ -maxdepth 3 -name 'bin' -type d
mkdir ~/.local/bin # in ".local" to keep it to only current user
export "PATH=$PATH:$HOME/.local/bin"