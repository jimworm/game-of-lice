game-of-lice
===================

`./game.sh [width=int] [height=int] [speed=(1..100)] [rounds=int] [random=bool] [prob=int] [filename]`

width, height
-------------
Width and height of field, default 5.

speed
-----
Adds pause between rounds, lowest speed 1 adds 2 seconds, default zero pause.

rounds
------
Number of rounds to play, default 100.

random
------
Randomize field before running, default true.

prob
----
If random=true, the probability of life appearing in a cell is (1/prob), default 10.

filename
--------
Level file to load. Looks in current dir or levels dir. Overrides random, prob, width and height.