package manaGearz.math;
import flash.Lib;

using manaGearz.math.MathEx;

/**
 * ...
 * @author Achmad Aulia Noorhakim
 */

class MathEx
{
	/**
	 *	Math Constant
	 */
	public static inline var NaN = Math.NaN;
	public static inline var NEGATIVE_INFINITY = Math.NEGATIVE_INFINITY;
	public static inline var POSITIVE_INTINITY = Math.POSITIVE_INFINITY;
	
	/**
	 *	Common Constant
	 */
	public static inline var E       =  2.71828182845905;
	public static inline var LN10    =  2.302585092994046;
	public static inline var LN2     =  0.6931471805599453;
	public static inline var LOG10E  =  0.4342944819032518;
	public static inline var LOG2E   =  1.442695040888963387;
	public static inline var SQRT1_2 =  0.7071067811865476;
	public static inline var SQRT2   =  1.4142135623730951;
		
	/**
	 *	PI Constant
	 */
	public static inline var QUAR_PI =  0.7853981633974483;
	public static inline var HALF_PI =  1.5707963267948966;
	public static inline var PI      =  3.141592653589793;
	public static inline var DOBL_PI =  6.283185307179586;
	
	/**
	 *	Radian Constant
	 */
	public static inline var RAD_0   =  0.0;
	public static inline var RAD_45  =  0.7853981633974483;
	public static inline var RAD_90  =  1.5707963267948966;
	public static inline var RAD_135 =  2.356194490192345;
	public static inline var RAD_180 =  3.141592653589793;
	public static inline var RAD_270 =  4.71238898038469;
	public static inline var RAD_360 =  6.283185307179586;
	
	/*
	 *	Convert Degree And Radian Constant
	 */
	public static inline var DEG2RAD =  0.017453292519943295;
	public static inline var RAD2DEG =  57.29577951308232;
	
	/**
	 *	Trigonometry Function
	 */
	 
	/**
	 * 
	 * Calculate sin of angle x (in radian)
	 * Note: keep 0 < x < 2PI;
	 * Speed: 3.9x
	 * 
	 * @param	x
	 * @return	sin of x
	 */
	public static inline function sin(x:Float):Float
	{
		var sgn = (x > PI) ? -1 : 1;
		var ang = (x > PI) ? x - PI : x;
		var sqr = ang * ang;
		/*var res = -0.0000000239;
		
		res *= sqr;
		res += 0.0000027526;
		res *= sqr;
		res -= 0.000198409;
		res *= sqr;
		res += 0.0083333315;
		res *= sqr;
		res -= 0.1666666664;
		res *= sqr;
		res += 1.0;
		res *= ang;*/
		
		return (-0.0000000239).mul(sqr).add(0.0000027526).mul(sqr).sub(0.000198409).mul(sqr).add(0.0083333315).mul(sqr).sub(0.1666666664).mul(sqr).add(1.0).mul(ang).mul(sgn);
	}
	
	/**
	 * 
	 * Calculate cos of angle x (in radian)
	 * Note: keep 0 < x < 2PI;
	 * Speed: 3.9x
	 * 
	 * @param	x
	 * @return	cos of x
	 */
	public static inline function cos(x:Float):Float
	{
		var sgn = (x > PI) ? -1 : 1;
		var ang = (x > PI) ? x - PI : x;
		var sqr = ang * ang;
		/*var res = -0.0000002605;
		
		res *= sqr;
		res += 0.0000247609;
		res *= sqr;
		res -= 0.0013888397;
		res *= sqr;
		res += 0.0416666418;
		res *= sqr;
		res -= 0.4999999963;
		res *= sqr;
		res += 1.0;*/
		
		return (-0.0000002605).mul(sqr).add(0.0000247609).mul(sqr).sub(0.0013888397).mul(sqr).add(0.0416666418).mul(sqr).sub(0.4999999963).mul(sqr).add(1.0).mul(sgn);
	}
	
	/**
	 * 
	 * Calculate tangent of angle x (in radian)
	 * Note: keep 0 < x < (PI / 2);
	 * Speed: 9.0x
	 * 
	 * @param	x
	 * @return	tangent of x
	 */
	public static inline function tan(x:Float):Float 
	{
		var sqr = x * x;
		/*var res = 0.0095168091;
		
		res *= sqr;
		res += 0.002900525;
		res *= sqr;
		res += 0.0245650893;
		res *= sqr;
		res += 0.0533740603;
		res *= sqr;
		res += 0.1333923995;
		res *= sqr;
		res += 0.3333314036;
		res *= sqr;
		res += 1.0;
		res *= x;*/
		
		return (0.0095168091).mul(sqr).add(0.002900525).mul(sqr).add(0.0245650893).mul(sqr).add(0.0533740603).mul(sqr).add(0.1333923995).mul(sqr).add(0.3333314036).mul(sqr).add(1.0).mul(x);
	}
	
	/**
	 * 
	 * Calculate arctangent from coordinate (x,y);
	 * Speed: 5.9x
	 * 
	 * @param	y
	 * @param	x
	 * @return	angle in radian
	 */
	public static inline function atan2(y:Float, x:Float):Float 
	{
		var ay = abs(y) + 0.0000000001;      // kludge to prevent 0/0 condition
		var r  = 0.0;
		var a  = 0.0;
		
		if (x >= 0) {
			r = (x - ay) / (x + ay);
			a = 0.1963 * r * r * r - 0.9817 * r + RAD_45;
		} else {
			r = (x + ay) / (ay - x);
			a = 0.1963 * r * r * r - 0.9817 * r + RAD_135;
		}

		return (y < 0) ? -a : a;
	}
	
	/**
	 *
	 * Speed: 0.9x
	 */
	public static inline function asin(x:Float):Float 
	{
		var sqrt = sqrt(1.0 - x);
		/*var res  = -0.0187293;
		
		res *= x;
		res += 0.0742610;
		res *= x;
		res -= 0.2121144;
		res *= x;
		res += 1.5707288;
		res = HALF_PI - sqrt * res;*/
		
		return HALF_PI.sub((-0.0187293).mul(x).add(0.0742610).mul(x).sub(0.2121144).mul(x).add(1.5707288).mul(sqrt));
	}
	
	/**
	 *
	 * Speed: 0.9x
	 */
	public static inline function acos(x:Float):Float
	{
		var sqrt = sqrt(1.0 - x);
		/*var res  = -0.0187293;
		
		res *= x;
		res += 0.0742610;
		res *= x;
		res -= 0.2121144;
		res *= x;
		res += 1.5707288;
		res *= sqrt;*/
		
		return (-0.0187293).mul(x).add(0.0742610).mul(x).sub(0.2121144).mul(x).add(1.5707288).mul(sqrt);
	}
	
	/**
	 *
	 * Speed: 6.8x
	 */
	public static inline function atan(x:Float):Float
	{
		var sqr = x * x;
		/*var res = 0.0028662257;
		
		res *= sqr;
		res -= 0.0161657367;
		res *= sqr;
		res += 0.0429096138;
		res *= sqr;
		res -= 0.0752896400;
		res *= sqr;
		res += 0.1065626393;
		res *= sqr;
		res -= 0.1420889944;
		res *= sqr;
		res += 0.1999355085;
		res *= sqr;
		res -= 0.3333314528;
		res *= sqr;
		res += 1.0;
		res *= x;*/
		
		return (0.0028662257).mul(sqr).sub(0.0161657367).mul(sqr).add(0.0429096138).mul(sqr).sub(0.0752896400).mul(sqr).add(0.1065626393).mul(sqr).sub(0.1420889944).mul(sqr).add(0.1999355085).mul(sqr).sub(0.3333314528).mul(sqr).add(1.0).mul(x);
	}
	
	/**
	 *	Invert Square And Squre Function
	 */
	public static inline function invSqrt(x:Float):Float
	{
		#if flash10
		var half = 0.5 * x;
		flash.Memory.setFloat(0,x);
		var i = flash.Memory.getI32(0);
		i = 0x5f3759df - (i>>1);
		flash.Memory.setI32(0,i);
		x = flash.Memory.getFloat(0);
		x = x * (1.5 - half*x*x);
		return x;
		#else
		return 1/Math.sqrt(x);
		#end
	}
	
	public static inline function sqrt(x:Float):Float
	{
		#if flash10
		return 1/invSqrt(x);
		#else
		return Math.sqrt(x);
		#end
	}
	
	/**
	 *	Convert Float And Int Function
	 */
	public static inline function round(x:Float)		 :Int	{ x += 0.5; var i:Int = Std.int(x); if(x-i < 0.0) i -= 1; return i; }
	public static inline function floor(x:Float)         :Int   { var i:Int = Std.int(x); if(x-i < 0.0) i -= 1; return i; }
	public static inline function ceil (x:Float)         :Int   { var i:Int = Std.int(x); if(x-i > 0.0) i += 1; return i; }
	
	/**
	 *	Float Function
	 */
	public static inline function abs  (x:Float)								:Float { return (x < 0) ? -x : x; }
	public static inline function max  (a:Float, b:Float)						:Float { return (a < b) ? b : a; }
	public static inline function min  (a:Float, b:Float)						:Float { return (a > b) ? b : a; }
	public static inline function clamp (value:Float, min:Float, max:Float)		:Float { return MathEx.min(MathEx.max(value,min),max); }
	public static inline function wrap (value:Float, min:Float, max:Float)		:Float { var d:Float = max-min; return value - MathEx.floor((value-min)/d)*d; }
	public static inline function interpolate (min:Float, max:Float, t:Float)	:Float { return min+(max-min)*t; }
	public static inline function sign (x:Float)								:Int { return if(x > 0) 1 else if(x < 0) -1 else 0; }
	
	/**
	 *	Int Function
	 */
	public static inline function absi (x:Int)							:Int { return (x < 0) ? -x : x; }
	public static inline function maxi (a:Int, b:Int)					:Int { return (a < b) ? b : a; }
	public static inline function mini (a:Int, b:Int)					:Int { return (a > b) ? b : a; }
	public static inline function clampi (value:Int, min:Int, max:Int)	:Int { return MathEx.mini(MathEx.maxi(value,min),max); }
	public static inline function wrapi (value:Int, min:Int, max:Int)	:Int { var d:Int = max-min; return value - MathEx.floor((value-min)/d)*d; }
	public static inline function isPoT (x:Int)							:Bool { return (x > 0) && ((x & (x - 1)) == 0); }
	
	/**
	 *	Math Function
	 */
	public static inline function exp(x:Float)			:Float { return Math.exp(x); }
	public static inline function log(x:Float)			:Float { return Math.log(x); }
	public static inline function pow(x:Float, y:Float)	:Float { return Math.pow(x, y); }
	public static inline function random()				:Float { return Math.random(); }
	public static inline function isFinite(x:Float)		:Bool { return Math.isFinite(x); }
	public static inline function isNaN(x:Float)		:Bool { return Math.isNaN(x); }
	
	/**
	 *	Operation Function
	 */
	public static inline function add(a:Float, b:Float)		:Float { return a+b; }
	public static inline function sub(a:Float, b:Float)		:Float { return a-b; }
	public static inline function mul(a:Float, b:Float)		:Float { return a*b; }
	public static inline function div(a:Float, b:Float)		:Float { return a/b; }
	public static inline function mod(a:Float, b:Float)		:Float { return a%b; }
}
