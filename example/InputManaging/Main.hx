package ;

import flash.Lib;
import flash.display.Sprite;
import haxe.Log;
import manaGearz.manager.Manager;

/**
 * ...
 * @author alijaya
 */

class Main 
{
	static var sprite : Sprite;
	static var isCircle : Bool;
	
	static function main()
	{
		sprite = new Sprite(); // a sprite that will be moved
		changeCircle(); // init the sprite with red circle graphics
		
		// set position to the center of the stage
		sprite.x = 320;
		sprite.y = 240;
		
		Lib.current.addChild(sprite); // add the Sprite to the stage, so we can see it :D
		
		
		Manager.timer.addLoop(mainLoop); // this is the loop where we get the input
		Manager.timer.addLoop(Manager.input.update); // update the input manager, it is necessary for isPressed working properly
	}
	
	static function changeSquare()
	{
		sprite.graphics.clear();
		sprite.graphics.beginFill(0xFF0000); // fill the sprite with red
		sprite.graphics.drawRect(-25,-25,50,50); // draw a rect that have 50px width and 50px height
		
		isCircle = false;
	}
	
	static function changeCircle()
	{
		sprite.graphics.clear();
		sprite.graphics.beginFill(0xFF0000); // fill the sprite with red
		sprite.graphics.drawCircle(0,0,25); // draw a circle that have radius 25px
		
		isCircle = true;
	}
	
	static function mainLoop()
	{
		Log.clear();
		trace("mouse is : "+(Manager.input.mouseLeave?"leave":"in stage"));
		if(Manager.input.mouseDown) trace("mouse is down");
		if(Manager.input.mousePressed) trace("mouse is pressed");
		if(Manager.input.mouseUp) trace("mouse is up");
		if(Manager.input.mouseReleased) trace("mouse is released");
		trace("the position of the mouse is : ( "+Std.int(Manager.input.mouseX)+", "+Std.int(Manager.input.mouseY)+" )");
		trace("the wheel delta : "+Manager.input.wheelDelta);
		
		
		// the function of isDown is to see whether the key is pressed down and held
		if(Manager.input.isDown("up"))
		{
			sprite.y -= 10; // move up the sprite if the UP key isDown
		}
		if(Manager.input.isDown("down"))
		{
			sprite.y += 10; // move down the sprite if the DOWN key isDown
		}
		if(Manager.input.isDown("left"))
		{
			sprite.x -= 10; // move left the sprite if the LEFT key isDown
		}
		if(Manager.input.isDown("right"))
		{
			sprite.x += 10; // move right the sprite if the RIGHT key isDown
		}
		
		// the function isPressed is to see the key is just pressed, so when you hold the key, it only fires once
		if(Manager.input.isPressed("z"))
		{
			if(isCircle) changeSquare() else changeCircle(); // change the shape if the Z key isPressed
		}
		
		// compare to this
		if(Manager.input.isDown("x"))
		{
			if(isCircle) changeSquare() else changeCircle(); // change the shape if the Z key isDown
		}
	}
}