/**
 * ...
 * @author alijaya
 */

package manaGearz.fsm;

class State 
{

	public var fsm(default, null):FSM;
	
	private function new(fsm:FSM)
	{
		this.fsm = fsm;
	}
	
	public function init(d:Dynamic):Void { }
	
	public function execute():Void { }
	
	public function enter():Void { }
	
	public function exit():Void { }
	
}