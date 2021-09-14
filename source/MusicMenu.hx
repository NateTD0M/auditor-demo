import flixel.system.FlxSound;
import flixel.FlxG;
import flixel.addons.display.FlxBackdrop;
import flixel.FlxSprite;

class MusicMenu extends MusicBeatState
{

    var tapeComodo:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menu/music/Cassette Comodo','auditor')); //rozebud
    var tapeSirf:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menu/music/Cassette Sirfitness','auditor'));
    var tapeYing:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menu/music/Cassette YingYang','auditor'));

    // THIS CODE IS BAD I'M SORRY
    // - kade

    // liteartly don't ever do this, i'm doing it because i'm stupid.
    // - kade

    var theMen:Array<TrickyTextButton> = [];
    var comodoSongs:Array<TrickyTextButton> = [];
    var exp:TrickyTextButton;
    var yingSongs:Array<TrickyTextButton> = [];

    public static var Vocals:FlxSound;

    public static var currentSong:String = "none";
    public static var selectedIndex:Int = 0;
    public static var comodoSelected:Int = 0;
    public static var sirfSelected:Int = -1;
    public static var yingSelected:Int = -1;

    var selecting:Bool = false;
    
    var currentSelected:TrickyTextButton;

    var circleOne:FlxSprite;
    var circleTwo:FlxSprite;

    var debug:Bool = false;

    override function create()
    {

        #if debug
        debug = true;
        #end

        theMen.push(new TrickyTextButton(0,0,"COMODO","COMODO",48,comodo));

        theMen[0].spriteOne.screenCenter();
        theMen[0].spriteOne.y += 30;

        // comodo songs

        comodoSongs.push(new TrickyTextButton(0,0,"ENCAVMAPHOBIA","ENCAVMAPHOBIA",28,selectSongComodo,"ENCAVMAPHOBIA"));
        var thing = comodoSongs[0];
        thing.spriteOne.screenCenter();
        thing.spriteOne.y += 110;
        thing.spriteOne.x -= 290;
        comodoSongs.push(new TrickyTextButton(0,0,"SUPREMACY","SUPREMACY",28,selectSongComodo,"SUPREMACY"));
        var thing = comodoSongs[1];
        thing.spriteOne.screenCenter();
        thing.spriteOne.y += 110;
        comodoSongs.push(new TrickyTextButton(0,0,"?????????","?????????",28,selectSongComodo,"?????????"));
        var thing = comodoSongs[2];
        thing.spriteOne.screenCenter();
        thing.spriteOne.y += 110;
        thing.spriteOne.x += 315;
        if (FlxG.save.data.beatenHard || debug)
        {
            theMen.push(new TrickyTextButton(0,0,"SIRFITNESS","SIRFITNESS",48,sirf));

            trace(sirf);

            theMen[1].spriteOne.screenCenter();
            theMen[1].spriteOne.y += 220;
            theMen[1].spriteOne.x -= 290;

            theMen.push(new TrickyTextButton(0,0,"YINGYANG","YINGYANG",48,yang));
            theMen[2].spriteOne.screenCenter();
            theMen[2].spriteOne.y += 220;
            theMen[2].spriteOne.x += 245;
        }
        else
        {
            theMen.push(new TrickyTextButton(0,0,"YINGYANG","YINGYANG",48,yang));
            theMen[1].spriteOne.screenCenter();
            theMen[1].spriteOne.y += 220;
            theMen[1].spriteOne.x += 245;
        }

        // ying songs


        yingSongs.push(new TrickyTextButton(0,0,"MAIN MENU","MAIN MENU",28,selectSongYing, "YANG-MENU"));
        var thing = yingSongs[0];
        thing.spriteOne.screenCenter();
        thing.spriteOne.x += 218;
        thing.spriteOne.y += 343;

        var bg:FlxSprite = new FlxSprite(-10,-10).loadGraphic(Paths.image('menu/freeplay/RedBG','auditor'));
		add(bg);
		var hedge:FlxSprite = new FlxSprite(-810,-335).loadGraphic(Paths.image('menu/freeplay/hedge','auditor'));
		hedge.setGraphicSize(Std.int(hedge.width * 0.65));
		add(hedge);
        
        var repeatLine:FlxBackdrop = new FlxBackdrop(Paths.image('menu/music/MusicRepeatLines','auditor'),1,1,false,true);
        repeatLine.velocity.set(0,14);
        repeatLine.screenCenter();
        repeatLine.x += 440;
        add(repeatLine);

        var menu:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menu/music/Red Box Music Menu','auditor'));
        menu.screenCenter();
        menu.setGraphicSize(Std.int(menu.width * 0.66));
        menu.y += 180;
        add(menu);

        tapeComodo.screenCenter();
        tapeSirf.screenCenter();
        tapeYing.screenCenter();

        tapeSirf.antialiasing = true;
        tapeComodo.antialiasing = true;
        tapeYing.antialiasing = true;

        tapeComodo.setGraphicSize(Std.int(tapeComodo.width * 0.6));
        tapeSirf.setGraphicSize(Std.int(tapeSirf.width * 0.6));
        tapeYing.setGraphicSize(Std.int(tapeYing.width * 0.6));

        tapeComodo.y -= 165;
        tapeSirf.y -= 165;
        tapeYing.y -= 165;

        


        circleOne = new FlxSprite().loadGraphic(Paths.image("menu/music/Circle1","auditor"));
        circleTwo = new FlxSprite().loadGraphic(Paths.image("menu/music/Circle2","auditor"));

        circleOne.antialiasing = true;
        circleTwo.antialiasing = true;

        circleOne.setGraphicSize(Std.int(circleOne.width * 0.6));
        circleTwo.setGraphicSize(Std.int(circleTwo.width * 0.6));

        circleOne.screenCenter();
        circleTwo.screenCenter();

        circleOne.y -= 180;
        circleOne.x -= 108;
        circleTwo.y -= 180;
        circleTwo.x += 108;

        add(circleOne);
        add(circleTwo);

        add(tapeComodo);
        add(tapeSirf);
        add(tapeYing);

        var indicator:FlxSprite;

        if (FlxG.save.data.beatenHard || debug)
            indicator =  new FlxSprite().loadGraphic(Paths.image("menu/music/MusicIndicationLines","auditor"));
        else 
            indicator =  new FlxSprite().loadGraphic(Paths.image("menu/music/noJadsLine","auditor"));

        indicator.screenCenter();
        indicator.setGraphicSize(Std.int(indicator.width * 0.66));
        indicator.y += 210;
        
        add(indicator);


		for (i in theMen)
			{
				add(i);
				add(i.spriteOne);
				add(i.spriteTwo);
			}

        for (i in comodoSongs)
			{
				add(i);
				add(i.spriteOne);
				add(i.spriteTwo);
			}

        for (i in yingSongs)
			{
				add(i);
				add(i.spriteOne);
				add(i.spriteTwo);
			}

        if (FlxG.save.data.beatenHard || debug)
        {
            exp = new TrickyTextButton(0,0,"DEATH THEME","DEATH THEME",24,selectSongSirf,"SIRF-DEATHMUSIC");
            add(exp);
            add(exp.spriteOne);
            add(exp.spriteTwo);

            exp.spriteOne.screenCenter();

            exp.spriteOne.y += 305;
            exp.spriteOne.x -= 290;

            trace(selectSongSirf);

            trace(exp.spriteOne);
        }


		var menuShade:FlxSprite = new FlxSprite(-1350,-1190).loadGraphic(Paths.image("menu/freeplay/Menu Shade","auditor"));
		menuShade.setGraphicSize(Std.int(menuShade.width * 0.7));
		add(menuShade);

        theMen[selectedIndex].highlight();
        if (comodoSelected != -1)
        {
            tapeComodo.visible = true;
            tapeYing.visible = false;
            tapeSirf.visible = false;
            comodoSongs[comodoSelected].highlight();
            currentSelected = comodoSongs[comodoSelected];
            trace(currentSelected.pognt);
            updateSong(comodoSongs[comodoSelected].pognt);
        }
        if (FlxG.save.data.beatenHard || debug)
        {
            if (sirfSelected != -1)
            {
                tapeComodo.visible = false;
                tapeYing.visible = false;
                tapeSirf.visible = true;
                exp.highlight();
                currentSelected = exp;
                updateSong(exp.pognt);
            }
        }
        if (yingSelected != -1)
        {
            tapeComodo.visible = false;
            tapeYing.visible = true;
            tapeSirf.visible = false;
            yingSongs[yingSelected].highlight();
            currentSelected = yingSongs[yingSelected];
            updateSong(yingSongs[yingSelected].pognt);
        }
    }

    function updateSong(song:String)
    {
        if (currentSong != song)
            {
                FlxG.sound.music.stop();
                if (Vocals != null)
                    Vocals.stop();

                // HARD CODED
                switch(song)
                {
				case "SIRF-DEATHMUSIC":
					if (Vocals != null)
					{
						Vocals.stop();
						Vocals = null;
					}
                    FlxG.sound.playMusic(Paths.music('gameOver','auditor'));
				case "YANG-HONKERS":
					if (Vocals != null)
					{
						Vocals.stop();
						Vocals = null;
					}
					FlxG.sound.playMusic(Paths.sound("honkers", "auditor"));     
                    case "YANG-MENU":
                        if (Vocals != null)
                        {
                            Vocals.stop();
                            Vocals = null;
                        }
                        FlxG.sound.playMusic(Paths.music("nexus_other","auditor"));
                    default:
                        Vocals = new FlxSound().loadEmbedded(Paths.voices(song.toLowerCase()),true);
                        
                        Vocals.persist = true;
                        Vocals.autoDestroy = false;
        
                        FlxG.sound.playMusic(Paths.inst(song.toLowerCase()), 1, true);
                        Vocals.play();
                        FlxG.sound.list.add(Vocals);
                }

                currentSong = song;
            }
    }

    function resyncVocals():Void
        {
            Vocals.pause();
    
            FlxG.sound.music.play();
            Vocals.time = FlxG.sound.music.time;
            Vocals.play();
        }

    function selectSongComodo()
    {
        updateSong(comodoSongs[comodoSelected].pognt);
        circleOne.angle = 0;
        circleTwo.angle = 0;
        tapeComodo.visible = true;
        tapeYing.visible = false;
        tapeSirf.visible = false;
    }

    function selectSongSirf()
    {
        updateSong(exp.pognt);
        circleOne.angle = 0;
        circleTwo.angle = 0;
        tapeComodo.visible = false;
        tapeYing.visible = false;
        tapeSirf.visible = true;
    }

    function selectSongYing()
    {
        updateSong(yingSongs[yingSelected].pognt);
        circleOne.angle = 0;
        circleTwo.angle = 0;
        tapeComodo.visible = false;
        tapeYing.visible = true;
        tapeSirf.visible = false;
    }

    function comodo()
    {
        selecting = true;
        comodoSelected = 0;
        sirfSelected = -1;
        yingSelected = -1;
        currentSelected.unHighlight();
        comodoSongs[comodoSelected].highlight();
        currentSelected = comodoSongs[comodoSelected];
    }

    function sirf()
    {
        selecting = true;
        sirfSelected = 0;
        comodoSelected = -1;
        yingSelected = -1;
        trace(currentSelected.pognt);
        currentSelected.unHighlight();
        exp.highlight();
        currentSelected = exp;
    }

    function yang()
    {
        selecting = true;
        yingSelected = 0;
        comodoSelected = -1;
        sirfSelected = -1;
        currentSelected.unHighlight();
        yingSongs[yingSelected].highlight();
        currentSelected = yingSongs[yingSelected];
    }


    override function update(elapsed)
    {
        super.update(elapsed);

        if (Vocals != null)
        {
            if (Vocals.playing)
            {
                if (FlxG.sound.music.time > Vocals.time + 20 || FlxG.sound.music.time < Vocals.time - 20)
                    resyncVocals();

                circleOne.angle += 1;
                circleTwo.angle += 1;
            }
            else
            {
                circleOne.angle = 0;
                circleTwo.angle = 0;
            }
        }

        if (Vocals == null && FlxG.sound.music.playing)
        {
            circleOne.angle += 1;
            circleTwo.angle += 1;
        }

        if (!selecting)
        {
            if (FlxG.keys.justPressed.RIGHT)
			{
				if (selectedIndex + 1 < theMen.length)
				{
					theMen[selectedIndex].unHighlight();
					theMen[selectedIndex + 1].highlight();
					selectedIndex++;
					trace('selected ' + selectedIndex);
				}
				else
				{
					theMen[selectedIndex].unHighlight();
					selectedIndex = 0;
					theMen[selectedIndex].highlight();
					trace('selected ' + selectedIndex);
				}
			}
			if (FlxG.keys.justPressed.LEFT)
			{
				if (selectedIndex > 0)
				{
					theMen[selectedIndex].unHighlight();
					theMen[selectedIndex - 1].highlight();
					selectedIndex--;
					trace('selected ' + selectedIndex);
				}
				else
				{
					theMen[selectedIndex].unHighlight();
					theMen[theMen.length - 1].highlight();
					selectedIndex = theMen.length - 1;
					trace('selected ' + selectedIndex);
				}
			}

            if (FlxG.keys.justPressed.ENTER)
            {
                theMen[selectedIndex].select();
            }

            if (FlxG.keys.justPressed.ESCAPE)
                FlxG.switchState(new MainMenuState());
        }
        else
        {
            if (comodoSelected != -1)
            {
                if (FlxG.keys.justPressed.RIGHT)
                    {
                        if (comodoSelected + 1 < comodoSongs.length)
                        {
                            currentSelected.unHighlight();
                            comodoSongs[comodoSelected + 1].highlight();
                            comodoSelected++;
                            currentSelected = comodoSongs[comodoSelected];
                            trace('selected ' + comodoSelected);
                        }
                        else
                        {
                            currentSelected.unHighlight();
                            comodoSelected = 0;
                            comodoSongs[comodoSelected].highlight();
                            currentSelected = comodoSongs[comodoSelected];
                            trace('selected ' + comodoSelected);
                        }
                    }
                    if (FlxG.keys.justPressed.LEFT)
                    {
                        if (comodoSelected > 0)
                        {
                            currentSelected.unHighlight();
                            comodoSongs[comodoSelected - 1].highlight();
                            comodoSelected--;
                            currentSelected = comodoSongs[comodoSelected];
                            trace('selected ' + comodoSelected);
                        }
                        else
                        {
                            currentSelected.unHighlight();
                            comodoSongs[comodoSongs.length - 1].highlight();
                            comodoSelected = comodoSongs.length - 1;
                            currentSelected = comodoSongs[comodoSelected];
                            trace('selected ' + comodoSelected);
                        }
                    }
                
                if (FlxG.keys.justPressed.ENTER)
                {
                    comodoSongs[comodoSelected].select();
                }
            }
            if (sirfSelected != -1)
            {
                if (FlxG.keys.justPressed.ENTER)
                {
                    exp.select();
                }
            }

            if (yingSelected != -1)
            {
                if (FlxG.keys.justPressed.DOWN)
                    {
                        if (yingSelected + 1 < yingSongs.length)
                        {
                            currentSelected.unHighlight();
                            yingSongs[yingSelected + 1].highlight();
                            yingSelected++;
                            currentSelected = yingSongs[yingSelected];
                            trace('selected ' + yingSelected);
                        }
                        else
                        {
                            currentSelected.unHighlight();
                            yingSelected = 0;
                            yingSongs[yingSelected].highlight();
                            currentSelected = yingSongs[yingSelected];
                            trace('selected ' + yingSelected);
                        }
                    }
                    if (FlxG.keys.justPressed.UP)
                    {
                        if (yingSelected > 0)
                        {
                            currentSelected.unHighlight();
                            yingSongs[yingSelected - 1].highlight();
                            yingSelected--;
                            currentSelected = yingSongs[yingSelected];
                            trace('selected ' + yingSelected);
                        }
                        else
                        {
                            currentSelected.unHighlight();
                            yingSongs[yingSongs.length - 1].highlight();
                            yingSelected = yingSongs.length - 1;
                            currentSelected = yingSongs[yingSelected];
                            trace('selected ' + yingSelected);
                        }
                    }
                
                if (FlxG.keys.justPressed.ENTER)
                {
                    yingSongs[yingSelected].select();
                }
            }

            if (FlxG.keys.justPressed.ESCAPE)
                selecting = false;
        }
    }
}
