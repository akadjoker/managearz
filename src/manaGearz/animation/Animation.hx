//
//  Animation.hx
//  
//
//  Created by Ali Jaya Meilio Lie on 2/5/10.
//  Copyright 2010 alijaya. All rights reserved.
//

package manaGearz.animation;
import manaGearz.math.MathEx;

class Animation<T> 
{
	public var actions(default, null):Hash<Array<T>>;
	
	public var curAction(default, null):Array<T>;
	public var curFrame(default, null):T;
	
	public var curActionName(default, null):String;
	public var curFrameNumber(default, null):Int;
	
	public var isPlaying(default, null):Bool;
	
	public var loop(default, null):Bool;
	public var reverse(default, null):Bool;
	public var complete(default, null):Void->Void;
	
	public function new(actions:Hash<Array<T>>)
	{
		this.actions = actions;
		this.isPlaying = false;
		loop = false;
		reverse = false;
	}
	
	// override this
	public function executeFrame()
	{
		
	}
	
	public function setLoop(loop:Bool)
	{
		this.loop = loop;
	}
	
	public function setReverse(reverse:Bool)
	{
		this.reverse = reverse;
	}
	
	public function setComplete(complete:Void->Void)
	{
		this.complete = complete;
	}
	
	public function step()
	{
		if(!isPlaying) return;
		if(reverse) prevFrame() else nextFrame();
		if(curFrameNumber == ((reverse)?0:curAction.length))
		{
			if(!loop) pause();
			if(complete != null) complete();
		}
	}
	
	public function setAction(actionName:String, ?frameNumber:Int)
	{
		if(!actions.exists(actionName)) return;
		curActionName = actionName;
		curAction = actions.get(curActionName);
		if(frameNumber == null) reset() else setFrame(frameNumber);
	}
	
	public function setFrame(frameNumber:Int)
	{
		curFrameNumber = if(frameNumber < 0 || frameNumber >= curAction.length)
		{
			(loop)? MathEx.wrapi(frameNumber, 0, curAction.length) : MathEx.clampi(frameNumber, 0, curAction.length);
		} else
		{
			frameNumber;
		}
		curFrame = curAction[curFrameNumber];
		executeFrame();
	}
	
	public function nextFrame(?count:Int=1)
	{
		setFrame(curFrameNumber+count);
	}
	
	public function prevFrame(?count:Int=1)
	{
		setFrame(curFrameNumber-count);
	}
	
	public function play(?loop:Bool=false, ?reverse:Bool=false, ?complete:Void->Void=null)
	{
		setLoop(loop);
		setReverse(reverse);
		setComplete(complete);
		resume();
	}
	
	public function pause()
	{
		isPlaying = false;
	}
	
	public function resume()
	{
		isPlaying = true;
	}
	
	public function reset()
	{
		setFrame((reverse)?curAction.length:0);
	}
	
	public function stop()
	{
		pause();
		reset();
	}
}