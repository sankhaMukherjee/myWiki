[Home](./)
<hr>

For installation, first close this repository, and generate the virtual environment required for running the programs. 

This project framework uses [venv](https://docs.python.org/3/library/venv.html) for maintaining virtual environments. Please familiarize yourself with [venv](https://docs.python.org/3/library/venv.html) before working with this repository. You do not want to contaminate your system python while working with this repository.

A convenient script for doing this is present in the file [`bin/vEnv.sh`](../blob/master/bin/vEnv.sh). This is automatically do the following things:

1. Generate a virtual environment
2. activate this environment
3. install all required libraries
4. deactivate the virtual environment and return to the prompt. 

At this point you are ready to run programs. However, remember that you will need to activate the virtual environment any time you use the program.

For activating your virtual environment, type `source env/bin/activate` in the project folder in [bash](https://www.gnu.org/software/bash/) or `source env/bin/activate.fish` if you are using the [fish](https://fishshell.com/) shell.
For deactivating, just type deactivate in your shell
