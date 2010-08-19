//
//  GeomUtils.hx
//  
//
//  Created by Ali Jaya Meilio Lie on 1/13/10.
//  Copyright 2010 alijaya. All rights reserved.
//

package manaGearz.math;
using manaGearz.math.PointUtils;

class PointUtils 
{
	public static inline function create(x:Float, y:Float) : Point
	{
		return { x:x, y:y };
	}
	
	public static inline function clone(p0:Point) : Point
	{
		return { x:p0.x, y:p0.y };
	}
	
	public static inline function lengthSqr(p0:Point) : Float
	{
		return p0.x*p0.x + p0.y*p0.y;
	}
	
	public static inline function length(p0:Point) : Float
	{
		return MathEx.sqrt(p0.x*p0.x + p0.y*p0.y);
	}
	
	public static inline function angle(p0:Point) : Float
	{
		return MathEx.atan2(p0.y, p0.x);
	}
	
	public static inline function angleBetween(p0:Point, p1:Point) : Float
	{
		return MathEx.atan2(p0.y, p0.x) - MathEx.atan2(p1.y, p1.x);
	}
	
	public static inline function distanceSqr(p0:Point, p1:Point) : Float
	{
		var x = p0.x-p1.x;
		var y = p0.y-p1.y;
		return x*x + y*y;
	}
	
	public static inline function distance(p0:Point, p1:Point) : Float
	{
		var x = p0.x-p1.x;
		var y = p0.y-p1.y;
		return MathEx.sqrt(x*x + y*y);
	}
	
	public static inline function dot(p0:Point, p1:Point) : Float
	{
		return p0.x*p1.x + p0.y*p1.y;
	}
	
	public static inline function cross(p0:Point, p1:Point) : Float
	{
		return p0.x*p1.y - p0.y*p1.x;
	}
	
	public static inline function equals(p0:Point, p1:Point) : Bool
	{
		return (p0.x == p1.x) && (p0.y == p1.y);
	}
	
	public static inline function nearEquals(p0:Point, p1:Point, ?t:Float=0.0) : Bool
	{
		var x = MathEx.abs(p0.x-p1.x);
		var y = MathEx.abs(p0.y-p1.y);
		return (x <= t) && (y <= t);
	}
	
	public static inline function gt(p0:Point, p1:Point) : Bool
	{
		return (p0.x > p1.x) && (p0.y > p1.y);
	}
	
	public static inline function gte(p0:Point, p1:Point) : Bool
	{
		return (p0.x >= p1.x) && (p0.y >= p1.y);
	}
	
	public static inline function lt(p0:Point, p1:Point) : Bool
	{
		return (p0.x < p1.x) && (p0.y < p1.y);
	}
	
	public static inline function lte(p0:Point, p1:Point) : Bool
	{
		return (p0.x <= p1.x) && (p0.y <= p1.y);
	}
	
	public static inline function polar(l:Float, a:Float) : Point
	{
		return { x:l*MathEx.cos(a), y:l*MathEx.sin(a) };
	}
	
	public static inline function add(p0:Point, p1:Point) : Point
	{
		return { x:p0.x+p1.x, y:p0.y+p1.y };
	}
	
	public static inline function sub(p0:Point, p1:Point) : Point
	{
		return { x:p0.x-p1.x, y:p0.y-p1.y };
	}
	
	public static inline function mul(p0:Point, s:Float) : Point
	{
		return { x:p0.x*s, y:p0.y*s };
	}
	
	public static inline function div(p0:Point, s:Float) : Point
	{
		return { x:p0.x/s, y:p0.y/s };
	}
	
	public static inline function abs(p0:Point) : Point
	{
		return { x:MathEx.abs(p0.x), y:MathEx.abs(p0.y) };
	}
	
	public static inline function opposite(p0:Point) : Point
	{
		return { x:-p0.x, y:-p0.y };
	}
	
	public static inline function perpendicular(p0:Point) : Point
	{
		return { x:-p0.y, y:p0.x };
	}
	
	public static inline function normalize(p0:Point, ?t:Float=1.0) : Point
	{
		var m = t/MathEx.sqrt(p0.x*p0.x + p0.y*p0.y);
		return { x:p0.x*m, y:p0.y*m};
	}
	
	public static inline function interpolate(p0:Point, p1:Point, f:Float) : Point
	{
		return { x:(p1.x-p0.x)*f+p0.x, y:(p1.y-p0.y)*f+p0.y};
	}
	
	public static inline function pivot(p0:Point, p1:Point, a:Float) : Point
	{
		var x = p0.x - p1.y;
		var y = p0.y - p1.y;
		var l = MathEx.sqrt(x*x + y*y);
		var an = MathEx.atan2(y, x)+a;
		return { x:p1.x+l*MathEx.cos(a), y:p1.y+l*MathEx.sin(a) };
	}
	
	public static inline function project(p0:Point, p1:Point) : Point
	{
		var il = 1/(MathEx.sqrt(p0.x*p0.x + p0.y*p0.y) * MathEx.sqrt(p1.x*p1.x + p1.y*p1.y));
		var m = (p0.x*p1.x + p0.y*p1.y) * il;
		return { x:p1.x*m, y:p1.y*m };
	}
	
	#if flash
	public static inline function toFlash(p0:Point) : flash.geom.Point
	{
		return new flash.geom.Point(p0.x, p0.y);
	}
	
	public static inline function fromFlash(p0:flash.geom.Point) : Point
	{
		return { x:p0.x, y:p0.y };
	}
	#end
}
