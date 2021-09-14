package;

import flixel.addons.effects.FlxSkewedSprite;
import Controls.KeyboardScheme;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.transition.FlxTransitionSprite.GraphicTransTileDiamond;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.transition.TransitionData;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup;
import flixel.input.gamepad.FlxGamepad;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.system.FlxSound;
import flixel.system.ui.FlxSoundTray;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import io.newgrounds.NG;
import lime.app.Application;
import openfl.Assets;

#if windows
import Discord.DiscordClient;
#end

using StringTools;

class TitleState extends MusicBeatState
{
	static var initialized:Bool = false;

	var blackScreen:FlxSprite;
	var credGroup:FlxGroup;
	var credTextShit:Alphabet;
	var textGroup:FlxGroup;
	var ngSpr:FlxSprite;
	var ngSpr2:FlxSprite;
	var actualNG:FlxSprite;
	var backupMen:FlxSprite;
	var bglol:FlxSprite;
	var bgblack:FlxSprite;
	var bgred:FlxSprite;
	var fire:FlxSprite;
	var fire2:FlxSprite;

	var curWacky:Array<String> = [];

	var wackyImage:FlxSprite;

	override public function create():Void
	{
		#if polymod
		//polymod.Polymod.init({modRoot: "mods", dirs: ['introMod']});
		#end
		
		#if sys
		if (!sys.FileSystem.exists(Sys.getCwd() + "\\assets\\replays"))
			sys.FileSystem.createDirectory(Sys.getCwd() + "\\assets\\replays");
		#end

		if (FlxG.save.data.newInput == null)
			FlxG.save.data.newInput = false;

		if (FlxG.save.data.downscroll == null)
			FlxG.save.data.downscroll = false;

		if (FlxG.save.data.dfjk == null)
			FlxG.save.data.dfjk = false;

		PlayerSettings.init();

		#if windows
		DiscordClient.initialize();

		Application.current.onExit.add (function (exitCode) {
			DiscordClient.shutdown();
		 });
		 
		#end

		curWacky = FlxG.random.getObject(getIntroTextShit());

		// DEBUG BULLSHIT

		super.create();

		// NGio.noLogin(APIStuff.API);

		#if ng
		var ng:NGio = new NGio(APIStuff.API, APIStuff.EncKey);
		trace('NEWGROUNDS LOL');
		#end

		FlxG.save.bind('funkin', 'ninjamuffin99');


		
		loadingImage = new FlxSprite(0,0).loadGraphic(Paths.image('loadingButNotDone','auditor'));
		loadingDone = new FlxSprite(0,0).loadGraphic(Paths.image('loadingButDone','auditor'));
		loadingImage.alpha = 0;
		loadingDone.alpha = 0;
		add(loadingImage);
		add(loadingDone);


		


		logoBl = new FlxSprite(390, 670);
		logoBl.frames = Paths.getSparrowAtlas('AuditorLogoFIRE','auditor');
		logoBl.antialiasing = true;
		logoBl.animation.addByPrefix('bump', 'logo bumpin', 30);
		logoBl.animation.play('bump');
		logoBl.scale.set(0.67,0.67);
		logoBl.updateHitbox();
		// logoBl.screenCenter();
		// logoBl.color = FlxColor.BLACK;

		gfDance = new FlxSprite(140, -290);
		gfDance.frames = Paths.getSparrowAtlas('titleaudi','auditor');
		gfDance.animation.addByPrefix('dance', 'auditortitle',24, true);
		gfDance.antialiasing = true;
		gfDance.scale.set(0.67,0.67);

		fire = new FlxSprite(-470, 50);
		fire.frames = Paths.getSparrowAtlas('firetitle','auditor');
		fire.animation.addByPrefix('startfire', 'downfire',24, true);
		fire.antialiasing = true;
		fire.scale.set(0.67,0.67);
		//imagine forgetting to make an animation play lol. - nate
		fire.animation.play('startfire');

		fire2 = new FlxSprite(550, 50);
		fire2.frames = Paths.getSparrowAtlas('firetitle','auditor');
		fire2.animation.addByPrefix('startfire', 'downfire',24, true);
		fire2.antialiasing = true;
		fire2.scale.set(0.67,0.67);
		fire2.animation.play('startfire');
		fire2.flipX = true;


		


		
		chains = new FlxSprite(90, -180);
		chains.frames = Paths.getSparrowAtlas('chains','auditor');
		chains.animation.addByPrefix('move', 'chain',24, true);
		chains.antialiasing = true;
		chains.scale.set(0.67,0.67);
		chains.animation.play('move');

		chains2 = new FlxSprite(835, -180);
		chains2.frames = Paths.getSparrowAtlas('chains','auditor');
		chains2.animation.addByPrefix('move', 'chain',24, true);
		chains2.antialiasing = true;
		chains2.scale.set(0.67,0.67);
		chains2.flipX = true;
		chains2.animation.play('move');



		titleText = new FlxSprite(135, FlxG.height * 0.8);
		titleText.frames = Paths.getSparrowAtlas('titleEnter');
		titleText.animation.addByPrefix('idle', "Press Enter to Begin", 24);
		titleText.animation.addByPrefix('press', "ENTER PRESSED", 24);
		titleText.antialiasing = true;
		titleText.animation.play('idle');
		titleText.updateHitbox();
		// titleText.screenCenter(X);

		var logo:FlxSprite = new FlxSprite().loadGraphic(Paths.image('logo'));
		logo.screenCenter();
		logo.antialiasing = true;
		// add(logo);

		// FlxTween.tween(logoBl, {y: logoBl.y + 50}, 0.6, {ease: FlxEase.quadInOut, type: PINGPONG});
		// FlxTween.tween(logo, {y: logoBl.y + 50}, 0.6, {ease: FlxEase.quadInOut, type: PINGPONG, startDelay: 0.1});

		credGroup = new FlxGroup();
		textGroup = new FlxGroup();

		blackScreen = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		credGroup.add(blackScreen);

		credTextShit = new Alphabet(0, 0, "ninjamuffin99\nPhantomArcade\nkawaisprite\nevilsk8er", true);
		credTextShit.screenCenter();

		// credTextShit.alignment = CENTER;

		credTextShit.visible = false;

		ngSpr = new FlxSprite(0, FlxG.height * 0.55).loadGraphic(Paths.image('ThePalsV3','auditor'));
		ngSpr.visible = false;
		ngSpr.setGraphicSize(Std.int(ngSpr.width * 1.1));
		ngSpr.updateHitbox();
		ngSpr.screenCenter(X);
		ngSpr.y -= 100;
		ngSpr.antialiasing = true;
//
		bglol = new FlxSprite(0, 0).loadGraphic(Paths.image('FULLRED','auditor'));
		bglol.scale.set(0.67,0.67);
		bglol.updateHitbox();
		bglol.screenCenter(X);
		bglol.antialiasing = true;

		bgblack = new FlxSprite(0, 0).loadGraphic(Paths.image('blacklight','auditor'));
		bgblack.scale.set(0.67,0.67);
		bgblack.updateHitbox();
		bgblack.screenCenter(X);
		bgblack.antialiasing = true;

		bgred = new FlxSprite(0, 0).loadGraphic(Paths.image('redlight','auditor'));
		bgred.scale.set(0.67,0.67);
		bgred.updateHitbox();
		bgred.screenCenter(X);
		bgred.antialiasing = true;



//
		ngSpr2 = new FlxSprite(0, FlxG.height * 0.55).loadGraphic(Paths.image('ThePalsV2','auditor'));
		ngSpr2.visible = false;
		ngSpr2.setGraphicSize(Std.int(ngSpr2.width * 1.1));
		ngSpr2.updateHitbox();
		ngSpr2.screenCenter(X);
		ngSpr2.y -= 100;
		ngSpr2.antialiasing = true;

		actualNG= new FlxSprite(0, FlxG.height * 0.55).loadGraphic(Paths.image('newgrounds_logo','auditor'));
		actualNG.visible = false;
		actualNG.setGraphicSize(Std.int(actualNG.width * 1.1));
		actualNG.updateHitbox();
		actualNG.screenCenter(X);
		actualNG.y -= 70;
		actualNG.antialiasing = true;

		backupMen= new FlxSprite(0, FlxG.height * 0.55).loadGraphic(Paths.image('TheBackupMen','auditor'));
		backupMen.visible = false;
		backupMen.setGraphicSize(Std.int(backupMen.width * 1.1));
		backupMen.updateHitbox();
		backupMen.screenCenter(X);
		backupMen.y -= 100;
		backupMen.antialiasing = true;


		CachedFrames.loadEverything();

		Highscore.load();

		if (FlxG.save.data.weekUnlocked != null)
		{
			// FIX LATER!!!
			// WEEK UNLOCK PROGRESSION!!
			// StoryMenuState.weekUnlocked = FlxG.save.data.weekUnlocked;

			if (StoryMenuState.weekUnlocked.length < 4)
				StoryMenuState.weekUnlocked.insert(0, true);

			// QUICK PATCH OOPS!
			if (!StoryMenuState.weekUnlocked[0])
				StoryMenuState.weekUnlocked[0] = true;
		}

		#if FREEPLAY
		FlxG.switchState(new FreeplayState());
		#elseif CHARTING
		FlxG.switchState(new ChartingState());
		#else
		#end
	}

	var logoBl:FlxSprite;
	var gfDance:FlxSprite;
	var gfhand:FlxSprite;

	var chains:FlxSprite;
	var chains2:FlxSprite;
	var danceLeft:Bool = false;
	var titleText:FlxSprite;
	var loadingImage:FlxSprite;
	var loadingDone:FlxSprite;
	

	function startIntro()
	{
		if (!initialized)
		{
			var diamond:FlxGraphic = FlxGraphic.fromClass(GraphicTransTileDiamond);
			diamond.persist = true;
			diamond.destroyOnNoUse = false;

			FlxTransitionableState.defaultTransIn = new TransitionData(FADE, FlxColor.BLACK, 1, new FlxPoint(0, -1), {asset: diamond, width: 32, height: 32},
				new FlxRect(-2000, -200, FlxG.width * 5, FlxG.height * 3));
			FlxTransitionableState.defaultTransOut = new TransitionData(FADE, FlxColor.BLACK, 0.7, new FlxPoint(0, 1),
				{asset: diamond, width: 32, height: 32}, new FlxRect(-2000, -200, FlxG.width * 5, FlxG.height * 3));

			transIn = FlxTransitionableState.defaultTransIn;
			transOut = FlxTransitionableState.defaultTransOut;

			// HAD TO MODIFY SOME BACKEND SHIT
			// IF THIS PR IS HERE IF ITS ACCEPTED UR GOOD TO GO
			// https://github.com/HaxeFlixel/flixel-addons/pull/348

			// var music:FlxSound = new FlxSound();
			// music.loadStream(Paths.music('freakyMenu'));
			// FlxG.sound.list.add(music);
			// music.play();
			FlxG.sound.playMusic(Paths.music('Tiky_Demce','auditor'), 0);
			

			FlxG.sound.music.fadeIn(4, 0, 0.7);
			Conductor.changeBPM(104);
			
		}

		persistentUpdate = true;

		
		// bg.antialiasing = true;
		// bg.setGraphicSize(Std.int(bg.width * 0.6));
		// bg.updateHitbox();

        var justblack:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		
		

		add(bglol);
		add(bgblack);
		add(chains);
		add(chains2);
		add(bgred);
		add(fire);
		add(gfDance);
		add(fire2);
		add(logoBl);
		
		
		// add(logoBl);
		add(titleText);
		add(credGroup);
		add(ngSpr);
		add(ngSpr2);
		add(actualNG);
		add(backupMen);



		FlxTween.tween(credTextShit, {y: credTextShit.y + 20}, 2.9, {ease: FlxEase.quadInOut, type: PINGPONG});

		KadeEngineData.initSave();

		FlxG.mouse.visible = false;

		if (initialized)
			skipIntro();
		else
			initialized = true;

		// credGroup.add(credTextShit);
	}

	function getIntroTextShit():Array<Array<String>>
	{
		var fullText:String = Assets.getText(Paths.txt('introText'));

		var firstArray:Array<String> = fullText.split('\n');
		var swagGoodArray:Array<Array<String>> = [];

		for (i in firstArray)
		{
			swagGoodArray.push(i.split('--'));
		}

		return swagGoodArray;
	}

	var transitioning:Bool = false;

	var once:Bool = false;

	override function update(elapsed:Float)
	{
		if (!CachedFrames.cachedInstance.loaded)
		{
			loadingImage.alpha = CachedFrames.cachedInstance.progress / 100;
		}
		else if (!once)
		{
			once = true;
			var snd:FlxSound = new FlxSound().loadEmbedded(Paths.sound('complete','auditor'));
			snd.play();
			loadingImage.alpha = 0;
			loadingDone.alpha = 1;
			FlxTween.tween(loadingDone,{alpha: 0}, 1);
			new FlxTimer().start(1.2, function(tmr:FlxTimer)
				{
					canSkip = true;
					startIntro();
				});
		}
		if (FlxG.sound.music != null)
			Conductor.songPosition = FlxG.sound.music.time;
		// FlxG.watch.addQuick('amp', FlxG.sound.music.amplitude);

		if (FlxG.keys.justPressed.F)
		{
			FlxG.fullscreen = !FlxG.fullscreen;
		}

		var pressedEnter:Bool = FlxG.keys.justPressed.ENTER;

		#if mobile
		for (touch in FlxG.touches.list)
		{
			if (touch.justPressed)
			{
				pressedEnter = true;
			}
		}
		#end

		var gamepad:FlxGamepad = FlxG.gamepads.lastActive;

		if (gamepad != null)
		{
			if (gamepad.justPressed.START)
				pressedEnter = true;

			#if switch
			if (gamepad.justPressed.B)
				pressedEnter = true;
			#end
		}

		if (pressedEnter && !transitioning && skippedIntro)
		{
			#if !switch
			NGio.unlockMedal(60960);

			// If it's Friday according to da clock
			if (Date.now().getDay() == 5)
				NGio.unlockMedal(61034);
			#end

			titleText.animation.play('press');

			FlxG.camera.flash(FlxColor.WHITE, 1);
			FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);

			transitioning = true;
			// FlxG.sound.music.stop();

			FlxG.sound.music.fadeOut(1,0);

			new FlxTimer().start(1.4, function(tmr:FlxTimer)
			{
				FlxG.switchState(new MainMenuState());
			});
			// FlxG.sound.play(Paths.music('titleShoot'), 0.7);
		}

		if (pressedEnter && !skippedIntro && CachedFrames.cachedInstance.loaded && canSkip)
		{
			FlxG.sound.playMusic(Paths.music('auditorskip','auditor'), 0);
			skipIntro();
		}

		super.update(elapsed);
	}

	var canSkip = false;

	function createCoolText(textArray:Array<String>, yOffset:Float = 0)
	{
		for (i in 0...textArray.length)
		{
			var money:Alphabet = new Alphabet(0, 0, textArray[i], true, false);
			money.screenCenter(X);
			if (yOffset != 0)
				money.y -= yOffset;
			money.y += (i * 60) + 200;
			credGroup.add(money);
			textGroup.add(money);
		}
	}

	function addMoreText(text:String, yOffset:Float = 0)
	{
		var coolText:Alphabet = new Alphabet(0, 0, text, true, false);
		coolText.screenCenter(X);
		if (yOffset != 0)
			coolText.y -= yOffset;
		credGroup.add(coolText);
		textGroup.add(coolText);
		
		FlxTween.tween(coolText,{y: coolText.y + (textGroup.length * 60) + 200},0.4,{ease: FlxEase.expoInOut, onComplete: function(flxTween:FlxTween) 
			{ 
			}});


	}

	function deleteCoolText()
	{
		while (textGroup.members.length > 0)
		{
			credGroup.remove(textGroup.members[0], true);
			textGroup.remove(textGroup.members[0], true);
		}
	}

	override function beatHit()
	{
		super.beatHit();

		trace('beat ' + curBeat);

		logoBl.animation.play('bump');

		gfDance.animation.play('dance');

		FlxG.log.add(curBeat);

		switch (curBeat)
		{
			case 1:
				createCoolText(['Tricky Engine by'], 135);
			case 2:
				addMoreText('KadeDev', 135);
			case 3:
				addMoreText('Banbuds', 135);
			case 4:
				addMoreText('Cval', 135);
			case 5:
				addMoreText('Rozebud', 135);
			case 6:
				deleteCoolText();
			case 7:
				addMoreText('WITH HELP FROM', 135);
			case 8:
				addMoreText('ICL', 135);
			case 9:
				addMoreText('Naive', 135);
			case 10:
				deleteCoolText();
				ngSpr.visible = false;
				createCoolText(['Auditor Mod Team'], 135);
			case 11:
				addMoreText('JustBruh - sirfitness', 135);
			case 12:
				addMoreText('Comodo_ - NateTDOM', 135);
			case 13:
				addMoreText('Egg Overlord', 135);
			case 14:
				ngSpr2.visible = true;
			case 15:

			case 16:
				deleteCoolText();
				ngSpr2.visible = false;
				curWacky = FlxG.random.getObject(getIntroTextShit());
				createCoolText([curWacky[0]]);
			case 17:	
				addMoreText(curWacky[1]);
			case 18:
				deleteCoolText();
				curWacky = FlxG.random.getObject(getIntroTextShit());				
				createCoolText([curWacky[0]]);
			case 19:
				addMoreText(curWacky[1]);
			case 20:
				deleteCoolText();
				curWacky = FlxG.random.getObject(getIntroTextShit());				
				createCoolText([curWacky[0]]);
			case 21:
				addMoreText(curWacky[1]);
			case 22:
				deleteCoolText();
				curWacky = FlxG.random.getObject(getIntroTextShit());
				createCoolText([curWacky[0]]);		
			case 23:
				addMoreText('SEX WEEK WHEN');
			case 24:
				deleteCoolText();
				curWacky = FlxG.random.getObject(getIntroTextShit());
				createCoolText([curWacky[0]]);
			case 25:
				addMoreText(curWacky[1]);	
			case 26:
				deleteCoolText();
				curWacky = FlxG.random.getObject(getIntroTextShit());
				createCoolText([curWacky[0]]);
			case 27:
				addMoreText(curWacky[1]);
			case 28:
				deleteCoolText();
				addMoreText('AGENCY');
			case 29:
				addMoreText('AGAINST');
			case 30:
				addMoreText('HANK');
			case 31:
				addMoreText('WIMBLETON');
			case 32:
				deleteCoolText();
				skipIntro();
		}
	}

	var skippedIntro:Bool = false;

	function skipIntro():Void
	{
		if (!skippedIntro)
		{
			remove(ngSpr);
			remove(ngSpr2);
			remove(actualNG);
			remove(backupMen);
			PlayerSettings.player1.controls.loadKeyBinds();
			FlxG.camera.flash(FlxColor.WHITE, 4);
			remove(credGroup);
			skippedIntro = true;
			
			new FlxTimer().start(0.1, function(tmr:FlxTimer)
				{
					
				
				FlxTween.tween(logoBl,{y: 380},1.1,{ease: FlxEase.expoInOut, onComplete: function(flxTween:FlxTween) 
					{ 
					}});

				});	

		}
	}
}
