/**
 * ...
 * @author alijaya
 */

package manaGearz.manager;
import flash.events.Event;
import flash.media.Sound;
import flash.media.SoundChannel;
import flash.media.SoundTransform;

class SoundManager 
{

	private static var _instance : SoundManager;
	public static var instance(get_instance, null) : SoundManager;
	public static function get_instance() : SoundManager
	{
		if (_instance == null) _instance = new SoundManager();
		return _instance;
	}
	
	var bgmLibrary:Hash<SoundTweak>; // collection of BGM
	
	public var bgmMute(default, null):Bool; // player choice to mute the BGM
	public var bgmVolume(default, null):Float; // player choice of bgm in options
	public var bgmMasterVolume(default, null):Float; // for tweaking
	public var curBGM(default, null):String;
	public var bgmFinishHandler(default, null):Void->Void;
	
	var bgmPosition:Float;
	var bgmChannel:SoundChannel;
	var bgmST:SoundTweak;
	
	var sfxLibrary:Hash<SoundTweak>; // collection of SFX
	
	public var sfxMute(default, null):Bool; // player choice to mute the SFX
	public var sfxVolume(default, null):Float; // player choice of sfx in options
	public var sfxMasterVolume(default, null):Float; // for tweaking
	
	private function new() 
	{
		bgmMute = false;
		sfxMute = false;
		
		bgmPosition = 0;
		
		bgmVolume = 1;
		bgmMasterVolume = 1;
		
		sfxVolume = 1;
		sfxMasterVolume = 1;
		
		var d = DataManager.instance;
		bgmLibrary = cast d.getDir(["manaGearz","bgm"]);
		sfxLibrary = cast d.getDir(["manaGearz","sfx"]);
	}
	
	public function addBGM(name:String, bgm:Sound, ?tweakVolume:Float=1.0)
	{
		bgmLibrary.set(name, {sound:bgm, tweak:tweakVolume});
	}
	
	public function addSFX(name:String, sfx:Sound, ?tweakVolume:Float=1.0)
	{
		sfxLibrary.set(name, {sound:sfx, tweak:tweakVolume});
	}
	
	//{ BGM
	
	public function setBGM(name:String, ?autoplay:Bool=true, ?finishHandler:Void->Void)
	{
		if (!bgmLibrary.exists(name)) return;
		curBGM = name;
		bgmST = bgmLibrary.get(curBGM);
		bgmFinishHandler = finishHandler;
		if (autoplay)
		{
			stopBGM();
			playBGM();
		}
	}
	
	public function playBGM()
	{
		if (bgmMute) return;
		if (curBGM == null) return;
		if (bgmChannel != null) return;
		bgmChannel = bgmST.sound.play(bgmPosition, new SoundTransform(bgmST.tweak * bgmVolume * bgmMasterVolume));
		bgmChannel.addEventListener(Event.SOUND_COMPLETE, soundComplete );
	}
	
	private function soundComplete(e:Event)
	{
		bgmChannel.removeEventListener(Event.SOUND_COMPLETE, soundComplete);
		bgmPosition = 0;
		bgmChannel = null;
		if (bgmFinishHandler != null) bgmFinishHandler();
		playBGM();
	}
	
	public function pauseBGM()
	{
		if (bgmMute) return;
		if (bgmChannel == null) return;
		bgmPosition = bgmChannel.position;
		bgmChannel.stop();
		bgmChannel = null;
	}
	
	public function stopBGM()
	{
		pauseBGM();
		bgmPosition = 0;
	}
	
	public function setBGMMute(mute:Bool)
	{
		if(mute)
		{
			pauseBGM();
			bgmMute = true;
		} else
		{
			bgmMute = false;
			playBGM();
		}
	}
	
	public function setBGMVolume(volume:Float)
	{
		bgmVolume = volume;
		updateBGMVolume();
	}
	
	public function setBGMMasterVolume(volume:Float)
	{
		bgmMasterVolume = volume;
		updateBGMVolume();
	}
	
	private function updateBGMVolume()
	{
		if (bgmChannel == null) return;
		bgmChannel.soundTransform.volume = bgmST.tweak * bgmVolume * bgmMasterVolume;
	}
	
	//}
	
	//{ SFX
	
	public function playSFX(name:String, ?loop:Int=0)
	{
		if (sfxMute) return;
		if (!sfxLibrary.exists(name)) return;
		var st = sfxLibrary.get(name);
		st.sound.play(0, loop, new SoundTransform(st.tweak * sfxVolume * sfxMasterVolume));
	}
	
	public function setSFXMute(mute:Bool)
	{
		sfxMute = mute;
	}
	
	public function setSFXVolume(volume:Float)
	{
		sfxVolume = volume;
	}
	
	public function setSFXMasterVolume(volume:Float)
	{
		sfxMasterVolume = volume;
	}
	
	//}
}

typedef SoundTweak = {sound:Sound, tweak:Float}