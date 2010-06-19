//
//  TimerScale.hx
//  
//
//  Created by Ali Jaya Meilio Lie on 3/1/10.
//  Copyright 2010 alijaya. All rights reserved.
//

package manaGearz.animation;

class TimerScale 
{
	public var scale(default, null):Float;
	public var func(default, null):Void->Void;
	
	public var sum(default, null):Float;
	
	public var isPlaying(default, null):Bool;
	
	public function new(scale:Float, func:Void->Void)
	{
		this.scale = scale;
		this.func = func;
		sum = 0;
		resume();
	}
	
	public function step()
	{
		if(!isPlaying) return;
		sum += scale;
		var count:Int = Std.int(sum);
		sum -= count;
		for(n in 0...count)
		{
			func();
		}
	}
	
	public function pause()
	{
		isPlaying = false;
	}
	
	public function resume()
	{
		isPlaying = true;
	}
}