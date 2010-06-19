//
//  TimeTransition.hx
//  
//
//  Created by Ali Jaya Meilio Lie on 1/17/10.
//  Copyright 2010 alijaya. All rights reserved.
//

package manaGearz.transition;
import manaGearz.manager.GameStateManager;
import manaGearz.fsm.FSM;
import manaGearz.fsm.State;
import manaGearz.fsm.Transition;

class TimeTransition extends Transition
{
	public var defaultTime(default, null):Int;
	public var time(default, null):Int;
	
	public var defaultExecFirst(default, null):Bool;
	public var execFirst(default, null):Bool;
	
	public var defaultExecSecond(default, null):Bool;
	public var execSecond(default, null):Bool;
	
	public var curTime(default, null):Int;
	public var interval(default, null):Float;
	
	private function new(fsm:FSM, ?first:State, ?second:State)
	{
		super(fsm, first, second);
		defaultTime = 20;
		defaultExecFirst = true;
		defaultExecSecond = true;
		time = defaultTime;
		curTime = 0;
		interval = 0;
	}
	
	public override function init(d:Dynamic)
	{
		super.init(d);
		time = (d.time!=null)? d.time : defaultTime;
		execFirst = (d.execFirst!=null)? d.execFirst : defaultExecFirst;
		execSecond = (d.execSecond!=null)? d.execSecond : defaultExecSecond;
		curTime = 0;
		interval = 0;
	}
	
	public override function execute()
	{
		curTime++;
		interval = curTime/time;
		if(execFirst && first!=null) first.execute();
		if(execSecond && second!=null) second.execute();
		trans();
		if(curTime==time) fsm.changeState(second);
	}
	
	private function trans() : Void { }
}