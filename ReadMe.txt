This is manaGearz, flash game engine, authored by alijaya.
It has dependencies... you must install 'hxJson2' in your computer.

use this:
haxelib install hxJson2

another dependency is swfmill

and another dependency (optionally if you want to compile the tools) is 'format'
use this:
haxelib install format

and in the format, you must change little thing in the code...
In beginClass function copy-paste this

//-------------------------------------------

	public function beginClass( path : String, ?callsuper:Bool=false ) {
		endClass();
		var tpath = this.type(path);
		beginFunction([],null);
		var st = curFunction.f.type;
		op(ORetVoid);
		endFunction();
		beginFunction([],null);
		var cst = curFunction.f.type;
		if (callsuper) {
			curFunction.f.maxStack=1;
			op(OThis);
			op(OConstructSuper(0));
		}
		op(ORetVoid);
		endFunction();
		fieldSlot = 1;
		curClass = {
			name : tpath,
			superclass : this.type("Object"),
			interfaces : [],
			isSealed : false,
			isInterface : false,
			isFinal : false,
			namespace : null,
			constructor : cst,
			statics : st,
			fields : [],
			staticFields : [],
		};
		data.classes.push(curClass);
		classes.push({
			name: tpath,
			slot: 0,
			kind: FClass(Idx(data.classes.length - 1)),
            metadatas: null,
		});
		curFunction = null;
		return curClass;
	}

//-------------------------------------------

In endClass function copy-paste this


//-------------------------------------------

	public function endClass(?sub:Bool=false) {
		if( curClass == null )
			return;
		endFunction();
		curFunction = init;
		ops([
			OGetGlobalScope,
			OGetLex( sub ? curClass.superclass : this.type("Object") ),
			OScope,
			OGetLex( curClass.superclass ),
			OClassDef( Idx(data.classes.length - 1) ),
			OPopScope,
			OInitProp( curClass.name ),
		]);
		curFunction = null;
		curClass = null;
	}

//-------------------------------------------


I think that's all that I can tell you now.

Make sure to see the examples if you are stuck :D