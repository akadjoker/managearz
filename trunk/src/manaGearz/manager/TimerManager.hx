//
//  TimerManager.hx
//  
//
//  Created by Ali Jaya Meilio Lie on 1/17/10.
//  Copyright 2010 alijaya. All rights reserved.
//

package manaGearz.manager;
import haxe.Timer;

class TimerManager 
{
	private static var _instance : TimerManager;
	public static var instance(get_instance, null) : TimerManager;
	public static function get_instance() : TimerManager
	{
		if (_instance == null) _instance = new TimerManager();
		return _instance;
	}
	
	public var curTime(default, null):Float;
	public var delta(default, null):Float;
	
	public var delay(default, null):Int;
	public var loops(default, null):List<Void->Void>;
	
	public var timer(default, null):Timer;
	
	public var isPlaying(default, null):Bool;
	
	private function new()
	{
		loops = new List<Void->Void>();
		delay = 20;
		timer = new Timer(delay);
		timer.run = run;
		resume();
	}
	
	private function run()
	{
		if(!isPlaying) return;
		var time = Timer.stamp();
		delta = time-curTime;
		curTime = time;
		for(n in loops)
		{
			n();
		}
	}
	
	public function setDelay(delay:Int)
	{
		if(delay < 1) delay = 1;
		timer.stop();
		this.delay = delay;
		timer = new Timer(delay);
		timer.run = run;
	}
	
	public function addLoop(loop:Void->Void)
	{
		loops.add(loop);
	}
	
	public function removeLoop(loop:Void->Void)
	{
		loops.remove(loop);
	}
	
	public function pause()
	{
		isPlaying = false;
		curTime = 0;
		delta = 0;
	}
	
	public function resume()
	{
		isPlaying = true;
		curTime = Timer.stamp();
		delta = 0;
	}
}