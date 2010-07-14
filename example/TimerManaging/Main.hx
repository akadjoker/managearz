package ;

import flash.Lib;
import haxe.Log;
import manaGearz.manager.Manager;

/**
 * ...
 * @author alijaya
 */

class Main 
{
	static function main()
	{
		// Timer manager use for add loop or process into the game
		// the timer start automatically
		// you can add function to be called in a time with addLoop
		// you can set the delay between each call with setDelay, default 20, minimum 1, in miliseconds
		// you can pause or resume the time with pause and resume function
		// it's not recommended to pause the main timer manager, because it will pause all the game, and the input manager can't work as expected
		// and you can get the delta between current tick and last tick, in seconds
		Manager.timer.addLoop(mainLoop); // add a loop
		Manager.timer.addLoop(anotherLoop); // add another loop
		Manager.timer.addLoop(Manager.input.update); // update the input manager, must be in last loop
	}
	
	static function mainLoop()
	{
		Log.clear();
		trace("press up and down to change the delay");
		trace("this is main Loop");
		
		if(Manager.input.isDown("down"))
		{
			Manager.timer.setDelay(Manager.timer.delay-1);
		}
		
		if(Manager.input.isDown("up"))
		{
			Manager.timer.setDelay(Manager.timer.delay+1);
		}
	}
	
	static function anotherLoop()
	{
		trace("this is anotherLoop, current delay is : "+Manager.timer.delay+", the time delta is : "+Manager.timer.delta);
	}
}