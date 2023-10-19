#!/usr/bin/env bash
#
# This is a script I use to create a virtual environment for user packages

VENV_DIR=~/.local/pyvenv

pyvenv () {
	python3 -m venv $VENV_DIR

	# add dot2smv project to the PYTHONPATH
	source $VENV_DIR/bin/activate

	# Make sure that the pip version is up-to-date
	python3 -m pip install --upgrade pip
}

[ -f "$VENV_DIR/bin/activate" ] || pyvenv
