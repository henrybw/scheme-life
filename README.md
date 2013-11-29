scheme-life
===========

Game of Life implemented in Scheme.

Architecture
------------

* `life-core`: Implementation of the core Game of Life logic.
* `drscheme-driver`: DrScheme-based driver that presents a graphical view of `life-core`.

Usage
-----

Open `drscheme-driver` in DrScheme/DrRacket, and run it. The main driver function is `game-of-life`.

Under the hood, `drscheme-driver` invokes `life-core` by calling `evolve`, passing a 2D list of cells and getting an evolved version of the 2D list in return.

