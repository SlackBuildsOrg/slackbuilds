?.eraseStipple:	stripe4
?.baseTranslations:	#override <Unmap>:Pause()
*Background:	black
*BorderColor:	white
*Font:	-*-helvetica-bold-r-*-*-*-120-*-*-*-*-*-*
*Frame*sensitive:	true
*Frame.Buttons*width:	100
*NewGame.fromVert:	Start
*NewGame.baseTranslations:	#replace <Btn1Down>,<Btn1Up>:NewGame() notify()
*Pause.mapWhenManaged:	False
*Pause.baseTranslations:	#override <Btn1Down>,<Btn1Up>:Pause()
*Quit.fromVert:	NewGame
*Quit.sensitive:	True
*Quit.baseTranslations:	#replace <Btn1Down>,<Btn1Up>:Quit() notify()
*About.fromVert:	Quit
*About.baseTranslations:	#replace <Btn1Down>: About()
*Scores.fromVert:	About
*Scores.baseTranslations:	#override <Btn1Down>: Scores()
*Start.resizeable:	True
*Start.sensitive:	True
*Start.baseTranslations:	#override <Btn1Down>,<Btn1Up>:Start()
*Buttons.borderWidth:	0
*Buttons.fromVert:	Status
*Buttons.hSpace:	0
*Buttons.vertDistance:	10
*Buttons.width:	120
*Canvas.fromHoriz:	TitleBar
*Canvas.fromVert:	TitleBar
*Canvas.height:	480
*Canvas.sensitive:	True
*CanvasFrame..baseTranslations:	#override <Expose>:Refresh()
*Canvas.accelerators:	#override !Shift<Btn1Down>:RotateCCW() \n !<Btn1Down>:MoveLeft() \n !Shift<Btn3Down>:RotateCW() \n !<Btn3Down>:MoveRight() \n !Shift<Btn2Down>:Drop() \n !<Btn2Down>:Drop() \n <Key>space:Drop() \n <Key>h:MoveLeft() \n <Key>q:Quit() \n <Key>p:Pause() \n <Key>s:Start() \n <Key>r:NewGame() \n <Key>Left:MoveLeft() \n <Key>j:RotateCW() \n <Key>Down:RotateCW() \n <Key>Begin:RotateCW() \n <Key>k:RotateCCW() \n <Key>Up:RotateCCW() \n <Key>l:MoveRight() \n <Key>Right:MoveRight()
*Canvas.vertDistance:	-22
*Canvas.width:	160
*NextObject.borderWidth:	0
*NextObject.fromHoriz:	TitleBar
*NextObject.fromVert:	NextObjectLabel
*NextObject.height:	64
*NextObject.horizDistance:	-100
*NextObject.width:	64
*NextObject.baseTranslations:	#override <Expose>:Refresh()
*NextObjectLabel.Label:	Next Object
*NextObjectLabel.borderWidth:	0
*NextObjectLabel.fromVert:	TitleBar
*NextObjectLabel.vertDistance:	20
*NextObjectLabel.width:	120
*Shadow.fromHoriz:	TitleBar
*Shadow.fromVert:	Canvas
*Shadow.height:	16
*Shadow.width:	160
*Shadow.baseTranslations:	#override <Expose>:Refresh()
*Status*borderWidth:	0
*Status*displayCaret:	False
*Status*resize:	True
*Status.Game.string:	"          "
*Status*width:	100
*Status.Level.string:	Level: 0
*Status.Rows.string:	Rows: 0
*Status.Score.string:	Score: 0
*Status.fromVert:	TitleBar
*Status.left:	ChainLeft
*Status.right:	ChainRight
*Status.vertDistance:	175
*Status.width:	120
*TitleBar.Font:	-*-new century schoolbook-*-i-*-*-*-120-*-*-*-*-*-*
*TitleBar.Label:	XTETRIS 2.6
*TitleBar.foreground:	white
*TitleBar.height:	20
*TitleBar.width:	120
*Object.Background:	black
?.ScoreFrame*font:	-*-clean-bold-r-*-*-16-*-*-*-*-*-*-*
?.ScoreFrame*baseTranslations:	#override <ButtonPress>,<ButtonRelease>:Done()\n <KeyPress>:Done()
?.ScoreFrame.width:	700
*ScoreText*editType:	read
*ScoreText.displayCaret:	False
*ScoreText*string:	
*ScoreText*length:	80
*ScoreText*Scroll:	whenNeeded
*ScoreText*width:	700
*ScoreText.height:	300
*ScoreText.resizable:	TRUE
*ScoreText*useStringInPlace:	True
?.AboutFrame*baseTranslations:	#override <ButtonPress>,<ButtonRelease>:Done()\n <KeyPress>:Done()
*AboutText.baseTranslations:	#override <ButtonPress>,<ButtonRelease>:Done()\n <KeyPress>:Done()
*AboutText.displayCaret:	False
*AboutText*Scroll:	whenNeeded
*AboutText.width:	600
*AboutText.height:	400
*customization:	.c
*Foreground:	wheat
*Frame.Buttons*borderColor:	darkslategrey
*Frame.Buttons.Pause.Background:	black
*Frame.Buttons.Pause.Foreground:	red
*Frame.Buttons.Start.Background:	black
*Frame.Buttons.Start.Foreground:	green
*Frame.Canvas.background:	darkslategrey
*Frame.Shadow.background:	darkslategrey
*Frame.Status.Game.Foreground:	white
*Frame.TitleBar.background:	blue1
*Frame.TitleBar.borderColor:	blue
*object0.foreground:	red1
*object0.background:	red4
*object1.foreground:	orange1
*object1.background:	orange4
*object2.foreground:	yellow1
*object2.background:	yellow4
*object3.foreground:	green1
*object3.background:	green4
*object4.foreground:	blue1
*object4.background:	blue4
*object5.foreground:	cyan1
*object5.background:	cyan4
*object6.foreground:	purple1
*object6.background:	purple4