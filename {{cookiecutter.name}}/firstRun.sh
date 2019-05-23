#!/bin/bash

git init
git remote add origin {{cookiecutter.remote}}
git add .
git commit -m 'first commit'
git push --force origin master
