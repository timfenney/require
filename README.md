Hello!
======

This is the README for [reQuiRe](http://104.131.228.159:49153/), the
recursive QR Code generator. (That is, the experience of the user is like
a recursion; the links and codes themselves are computed iteratively.)

The code needs work in a few places. It needs a little DRY-ing out,
and it should get configuration regarding the Redis service from
environment variables. I have posted it at someone's
request, so besides changing the assets to something I am allowed to
publish, the code is identical.

ReQuire is a [Sinatra](http://www.sinatrarb.com/) app, of course ;-)
[Redis](http://redis.io) is used to store QR code image blobs with
SHA's for keys.

This app makes use of the [Amelia theme](http://bootswatch.com/amelia/)
for [Bootstrap](http://getboostrap.com).

Also of note, instead of having to wire up all the folders and things
between Bootstrap and Sinatra myself, I decided to try out this
[sinatra-bootstrap](https://github.com/bootstrap-ruby/sinatra-bootstrap)
template.

How to deploy?
==============

I won't go into it all here, but suffice to say it is wasn't too much of an
ordeal to get an app like this running with
[Dokku](https://github.com/progrium/dokku).

Once you have a Dokku instance up and running, add the server as a remote to
your git repo and push your branch to master and you're done. (For hints look
at the included rackup and gemfile files.)

(Of course you would still need a  plugin such as
[this one by jezdez](https://github.com/jezdez/dokku-redis-plugin),
which itself depends on the
[dokku-redis-link plugin](https://github.com/rlaneve/dokku-link).)
