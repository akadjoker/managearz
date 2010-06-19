/**
 * ...
 * @author alijaya
 */

package manaGearz.fsm;

class FSM 
{

	public var curState(default, null):State;
	
	public function new() 
	{
		curState = null;
	}
	
	public function changeState(state:State)
	{
		if (curState != null) curState.exit();
		curState = state;
		if (curState != null) curState.enter();
	}
	
	public function execute()
	{
		if (curState != null) curState.execute();
	}
	
}