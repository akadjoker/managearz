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
		return MathEx.sqrt(p0.lengthSqr());
	}
	
	public static inline function angle(p0:Point) : Float
	{
		return MathEx.atan2(p0.y, p0.x);
	}
	
	public static inline function angleBetween(p0:Point, p1:Point) : Float
	{
		return p0.angle() - p1.angle();
	}
	
	public static inline function distance(p0:Point, p1:Point) : Float
	{
		return p1.sub(p0).length();
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
		var p = p1.sub(p0).abs();
		return (p.x <= t) && (p.y <= t);
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
		return p0.mul(t/p0.length());
	}
	
	public static inline function interpolate(p0:Point, p1:Point, f:Float) : Point
	{
		return p1.add(p1.sub(p0).mul(f));
	}
	
	public static inline function pivot(p0:Point, p1:Point, a:Float) : Point
	{
		var p = p0.sub(p1);
		return p1.add(polar(p.length(), p.angle()+a));
	}
	
	public static inline function project(p0:Point, p1:Point) : Point
	{
		return p1.mul(p0.normalize().dot(p1.normalize()));
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