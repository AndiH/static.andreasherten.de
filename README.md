# static.andreasherten.de
I needed a place to stare static websites. So I tested the new hip kid on the block: Jekyll.

Here's my stuff.

Look how it looks like at [static.andreasherten.de](http://static.andreasherten.de).

## Deploying
I use a `post commit` git hook to copy the content of `_site/` via rsync to my server. The hook can be found in `.githooks/post-commit/deploy.sh`. I organize them with [icefox's git-hooks tool](https://github.com/icefox/git-hooks).
