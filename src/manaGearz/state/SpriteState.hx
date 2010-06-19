//
//  SpriteState.hx
//  
//
//  Created by Ali Jaya Meilio Lie on 1/17/10.
//  Copyright 2010 alijaya. All rights reserved.
//

package manaGearz.state;
import flash.display.Sprite;

import manaGearz.fsm.FSM;
import manaGearz.fsm.State;

class SpriteState extends State
{
	public var sprite(default,null):Sprite;
	
	private function new(fsm:FSM)
	{
		super(fsm);
		sprite = new Sprite();
		sprite.mouseEnabled = false;
		sprite.mouseChildren = false;
	}
	
	public override function enter()
	{
		sprite.mouseEnabled = true;
		sprite.mouseChildren = true;
	}
	
	public override function exit()
	{
		sprite.mouseEnabled = false;
		sprite.mouseChildren = false;
	}
}