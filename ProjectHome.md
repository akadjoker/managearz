manaGearz is a flash game engine for haXe.

The concept and idea of the engine is manager and plug-in.
The name 'manaGearz' is from that idea.
'manaGearz' sounds like 'manager'
and the 'G' is emphasized to separated the word into two word, 'mana' and 'Gearz' that means 'plug-in'

The engine consists of several manager class in singleton.

The goal of this engine is:
  1. No bond to the engine, so the engine will not choose what you will to do, but you choose it
  1. Cover all repetitive thing in making game, such as importing assets, play sounds, game state, input, etc
  1. Easy to extend, so the game engine is fully extendable (it's plugin based)
  1. Easy to combine with another engine


The current feature is:
  * Import asset in runtime or compile without change many of your code
  * Easily make preloading
  * Manage the global data, so it can be access anywhere in your code
  * Manage change state with transition
  * Manage the game loop, pause, resume, etc
  * Manage the sound thingy in easy way
  * Manage the cursor display in easy way too
  * Manage the user input, keyboard key and mouse click and position
  * Have Scale9Grid for bitmap, it'is like BitmapScale from www.bytearray.com
  * Handling the animation with spritesheet
  * Handling camera thingy
  * Easy way to create button
  * Handling the tiling system, it can use RMXP autotile and RMVX autotile :p


this is my blog about it http://managearz.blogspot.com/