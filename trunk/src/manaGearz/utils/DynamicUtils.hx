//
//  DynamicUtils.hx
//  
//
//  Created by Ali Jaya Meilio Lie on 1/17/10.
//  Copyright 2010 alijaya. All rights reserved.
//

package manaGearz.utils;

class DynamicUtils 
{
	public static inline function concat(d0:Dynamic, d1:Dynamic) : Dynamic
	{
		for(n in Reflect.fields(d1))
		{
			Reflect.setField(d0, n, Reflect.field(d1, n));
		}
		return d0;
	}
	
	public static inline function toHash<T>(d:Dynamic<T>) : Hash<T>
	{
		var h:Hash<T> = new Hash<T>();
		for(n in Reflect.fields(d))
		{
			h.set(n, Reflect.field(d, n));
		}
		return h;
	}
}