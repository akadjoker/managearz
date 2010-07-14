Another example of Input Manager. (you probably have seen this in TimerManaging example)

Okay... I will tell you how to use it.

the generic thing is to get the user input, mainly key input *may be*.
so we need to set up the input manager.

as I tell you before, the input manager needs to be updated in the last of the loop.

so, if you use the onEnterFrame loop you will need write this:
function enterFrame(e:Event)
{
	// some code in loop
	// .
	// .
	// .
	
	Manager.input.update();
}

but if you want to use the timer manager, you just write:
Manager.timer.addLoop(mainLoop); // where the code work out
Manager.timer.addLoop(Manager.input.update);

or you can call Manager.input.update in your mainLoop as the last call.

so talked about the update thing, you may think what it does.
it will make pressed state to be false, so you won't get the pressed state fires many times.

confuse?

okay... let's see the function of the input manager.
1.	isDown
	the isDown accept a string. what?? a string?? not an int??? yes :D
	for the easy thing, you just pass the key string *not key code, in the engine, it will translate it self. so if you want get the isDown of "A" key, you can pass "A" in the function. Note : it's case insensitive, so "a" and "A" worked samely. How about the special key and punctuation key? Just write as it looks. if you refer to the slash/question mark key you can just pass "/" or "slash". Make sure that you pass the lower punctuation not the upper, it doesn't work if you pass "?", maybe I will add it later :p
2.	isUp
	same, it accepts a string. and it detect whether the key is up or not
3.	isPressed
	seemly same with isDown, but it differs. if isDown fires everytime in the loop when the key is hold down, the isPressed just fires once when the key just pressed down. if you hold down the key, it can't fire it anymore before the key is released and pressed down again.