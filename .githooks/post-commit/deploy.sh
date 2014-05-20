#!/usr/bin/env bash
jekyll build && rsync -avz --delete _site/ andreasherten:~/httpdocs/andreasherten/static
