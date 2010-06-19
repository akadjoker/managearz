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
		for(n in loops)
		{
			n();
		}
	}
	
	public function setDelay(delay:Int)
	{
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
	}
	
	public function resume()
	{
		isPlaying = true;
	}
}