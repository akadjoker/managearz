//
//  StateTransition.hx
//  
//
//  Created by Ali Jaya Meilio Lie on 1/6/10.
//  Copyright 2010 alijaya. All rights reserved.
//

package manaGearz.fsm;

class Transition extends State
{
	private var first:State;
	private var second:State;
	private var nextInit:Dynamic;
	
	private function new(fsm:FSM, ?first:State, ?second:State)
	{
		super(fsm);
		this.first = first;
		this.second = second;
	}
	
	public override function init(d:Dynamic)
	{
		first = d.first;
		second = d.second;
		nextInit = d.nextInit;
		if(second != null) second.init(nextInit);
	}
}