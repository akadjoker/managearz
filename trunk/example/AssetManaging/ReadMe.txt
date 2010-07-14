Okay... in this example I will show how asset managing in manaGearz works.

Firstly, asset managing in manaGearz has two ways.
The first one is loading in run-time
The second one is embeding in compile-time

And I will show it to you :D

In this folder you will see many files :D...
but let's concern only with these files:
1. assets folder
2. compile.hxml
3. main.hx

as you see, the assets folder contains all of our resource, such as graphic, sound, data, etc.

So this is the little explanation what the system is going on.

first we place our resource in hierarchy folder.
after that we use our tools (located in root folder of this engine), search Loader.n from loader folder
use it like this:
	neko path/to/engine/tools/loader/Loader.n path/to/your/resources/folderName
	
and it will generate 'folderName.json' in siblings with your 'folderName' folder
if you see the file, it will contain the structure of the folder in jsonly.

and the main.hx will load the 'folderName.json' (in case of we use loading not embeding), and it will store globally.
for loading you just must add this code:
	Manager.loader.load("path/to/your/resources/folderName.json", completeFunction);

oh... forgot to mention, the extension of the resource files is very important, because it determines what the file will convert to.
- '.mp3' -> flash.media.Sound
- '.png', '.jpeg', '.jpg' -? flash.display.Bitmap
- '.txt' -> String
- '.json' -> Dynamic
- another -> flash.utils.ByteArray

for the sake of loading, the engine can not store the Class, but it stores the instance.
okay... now, you may asked how to duplicate the source, here it is:
for sound file, why you want to duplicate it anyway??? one instance can produce many sound if you call sound.play() many times :D (so i think it's duplicable)
for graphic file, it has BitmapData, you can clone it, make new Bitmap and pass it :D
for string, it is always duplicable
for Dynamic, why you want to duplicate it if that only contains data?
for ByteArray, it is always duplicable

okay... now, how to retrieve data from loading?
in case we want to retrieve data in "folder/anotherFolder/resource.mp3" in our base resource folder use this:
	Manager.data.get(["folder", "anotherFolder", "resource"]);
or this:
	Manager.data.get("folder.anotherFolder.resource");



Are you happy now?

//------------------------------------

Okay next :D

the embeding thingy :D *YAY!!!

for embeding thingy you must have swfmill :D

okay... 

do this:
	neko path/to/engine/tools/loader/Loader.n path/to/your/resources/folderName
	
you may ask why it's same as the above, yes it's same, we still need the folder structure data, why? i explain it later.

and do this
	neko path/to/engine/tools/swfmillLoader/SwfmillLoader.n path/to/your/resources/folderName
	
and it's produce the xml file and swf file.
So you may ask me what it's doing

with our tools, it obtain the folder, and it check for the files in it, and it write the xml file for the swfmill (remember, if you want to make a library with swfmill you must make a xml?)
and then, it calls swfmill to compile the xml to swf.
it gets the swf file again (what the?), you know, the swfmill doesn't create stub class >.<
okay... after it gets the swf, it makes stub class in it. And... voila... our library is hot from the oven *LOL

okay... now is how to use it.
in your hxml
add this:
	-resource path/to/your/resources/folderName.swf@someIdentifier
	-resource path/to/your/resources/folderName.json@anotherIdentifier

what??? I use resource instead of -swf-lib??
Yes :D, you are right...
for why thingy, my best answer is to prevent the overlapped id in swf *may be :p
And the resource is may be hardly to be decompiled... (you know? you must decompile the main swf file, get the binary source that you have no idea what it is, and you must decompile it again to get the resource)

Okay... next part...
in our main.hx, add this
	Manager.embed.load("someIdentifier", "anotherIdentifier", completeFunction);

it will search all the class that contained in the swf, make the instance and store it globally.

And how to retrieve it???
Okay... you have asked the same thing :p
We can retrieve it in same way with loading thingy doing (NO WAY!)
Yes it can :D...

//----------------------------

Now... for another thingy :D

You may notice why the resource name write weirdly.
Okay there is some symbol to control your resource.

You may be want add some ReadMe file or another file in your folder, but you don't want to load the file in you swf.
You just can use '!' in the beginning of the name, it will prevent it from loaded.

for the '#' mark, i will explain later.

I will go to the data container, namely .json file
you can write your file in officially way, there is object, array, string, float, int, bool, and null.
but how if you want add graphic or sound or binary to your data???
you can do with write a string where the file located, and add '@' in the beginning.
it will search for the file relatively.
if you want to search the file from the root of resource folder use '$' as the root.

another thing is if you want the file is only to be in .json file but not stored in global data.
You can add '#' in beginning of the file name, when you get it from json file, it is there, if you access it from Manager.data.get, it isn't there.


may be that's all about the asset managing.

If you don't clearly understand what this example about, or you want to give me a suggestion don't hestitate to contact me in alijayameilio[at]google[dot]com *wink2 ;)