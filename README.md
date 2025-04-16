# dev-env
This is my collection of configurations and scripts that are needed to quickly set up a development environment on a new machine. It is Linux-centric as that is my preferred operating system for development. I have successfully used this repository to install my development environment across four machines (both real and virtual), one of which was under WSL when Windows could not be avoided.

## Installation
To see what can be installed, run `./install.sh --help`. To install my complete development environment, run `sudo ./install.sh --all [package manager]` (only `dnf` is supported at the moment). Currently, programs and scripts are installed per-machine while configurations are installed per-user. I plan to make this consistent by installing everything per-user so that installation does not modify the machine at large. This will also remove the need for elevated permissions to install portions of my environment.

## Limitations
I am not leveraging symlinks, GNU `stow`, or any other program that manages dotfiles. This means that any change to the files under this repository need to be reinstalled to take effect. This sucks. Additionally, everything is one size fits all. I currently cannot manage machine-specific configurations.

## Future Improvements
After a cursory look at Nix's `home-manager`, I plan to attempt to migrate my environment to evaluate the ease of use. I like the idea of being able to leverage Nix's extensive package list to reduce the number of programs I need to download "manually". This would also remove the need to support different package managers depending on the distribution I'm using that day.

If I decide Nix is not the way forward, I do want to set up symlinks or GNU `stow` to remove the need for reinstallation. This process kills my ability to quickly make changes and test them and overall just feels wrong.
