//
//  AbstractButton.hx
//  
//
//  Created by Ali Jaya Meilio Lie on 1/9/10.
//  Copyright 2010 alijaya. All rights reserved.
//

package manaGearz.button;

class Button 
{
	public var over:Dynamic;
	public var down:Dynamic;
	public var click:Dynamic;
	
	public var toggleable(default, null):Bool;
	public var toggled(default, null):Bool;
	public var pressed(default, null):Bool;
	public var rolled(default, null):Bool;
	public var disabled(default, null):Bool;
	
	public var state(default, null):ButtonState;
	
	private function new(style:Dynamic)
	{
		pressed = false;
		rolled = false;
		toggled = false;
		setToggleable(false);
		setToggled(false);
		setDisabled(false);
	}
	
	// override this if needed
	public function setToggleable(toggleable:Bool)
	{
		this.toggleable = toggleable;
	}
	
	// override this if needed
	public function setToggled(toggled:Bool)
	{
		if(toggleable)
		{
			this.toggled = toggled;
			changeState(state);
		}
	}
	
	// override this if needed
	public function setDisabled(disabled:Bool)
	{
		this.disabled = disabled;
		if(this.disabled)
		{
			changeDisabled();
		} else
		{
			if(rolled&&pressed) changeDown() else if(!rolled&&!pressed) changeUp() else changeOver();
		}
	}
	
	private function changeState(state:ButtonState)
	{
		switch(state)
		{
			case ButtonState.UP: changeUp();
			case ButtonState.OVER: changeOver();
			case ButtonState.DOWN: changeDown();
			case ButtonState.DISABLED: changeDisabled();
		}
	}
	
	// override this if needed
	private function changeUp()
	{
		state = ButtonState.UP;
	}
	
	// override this if needed
	private function changeOver()
	{
		state = ButtonState.OVER;
	}
	
	// override this if needed
	private function changeDown()
	{
		state = ButtonState.DOWN;
	}
	
	private function changeDisabled()
	{
		state = ButtonState.DISABLED;
	}
	
	private function clickInternal()
	{
		if(click!=null) click();
	}
	
	private function overInternal()
	{
		if(over!=null) over();
	}
	
	private function downInternal()
	{
		if(down!=null) down();
	}
}