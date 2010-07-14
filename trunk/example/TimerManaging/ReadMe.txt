In this part i want to introduce the Timer Manager.

This class manage the loop of the game. (Like onEnterFrame or Timer)

This class has some function such as:
1.	addLoop
	maybe you have several loop, not only one loop, so you can add many loop with this, and it will execute orderly
2.	removeLoop
	inverse thing from addLoop
3.	setDelay
	you can set the delay between each call in miliseconds
4.	pause
	for pausing the loop, it will pause everything, the loop, include the input thing (if you check input in the loop with input manager)
5.	resume
	inverse thing from pause
5.	delta
	you can get the delta from this tick and before tick (it's use for time base with seconds)

for a note, you need to add Manager.input.update as a last loop, because it needs update in the end of the tick. The update controls the pressed and released thing.