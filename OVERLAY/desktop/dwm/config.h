/* See LICENSE file for copyright and license details. */

/*
 * =====================
 * APPEARANCE
 * =====================
 *
 * Visual choices are inspired by the current pekwm theme:
 * - Focused window border in gold/yellow
 * - Unfocused window border in dark gray
 * - Slightly thicker borders for mouse usage
 * - Consistent font with st (Iosevka Term)
 */

/* window border width (px) */
static const unsigned int borderpx  = 2;   /* thicker than default for clear focus */

/* snap pixel for window movement */
static const unsigned int snap      = 32;

/* bar visibility and position */
static const int showbar            = 1;   /* show the status bar */
static const int topbar             = 1;   /* bar at the top */

/*
 * Fonts
 * Same font used in st for visual consistency
 */
static const char *fonts[] = {
	"Iosevka Term:size=11:antialias=true:autohint=true"
};

static const char dmenufont[] =
	"Iosevka Term:size=11:antialias=true:autohint=true";

/*
 * Color scheme
 * SchemeNorm  -> unfocused windows
 * SchemeSel   -> focused window (gold border)
 */
static const char col_bg[]     = "#1c1c1c";
static const char col_fg[]     = "#cccccc";
static const char col_border[] = "#3a3a3a"; /* unfocused border */
static const char col_gold[]   = "#e0b800"; /* focused border */

static const char *colors[][3] = {
	/*               fg        bg        border */
	[SchemeNorm] = { col_fg,  col_bg,   col_border },
	[SchemeSel]  = { col_fg,  col_bg,   col_gold   },
};

/*
 * =====================
 * TAGS (WORKSPACES)
 * =====================
 *
 * Tags are treated as classic workspaces (1..9),
 * similar to pekwm mental model.
 */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };

/*
 * =====================
 * RULES
 * =====================
 *
 * Define where applications start and how they behave.
 * Rules define the *initial* placement only.
 */
static const Rule rules[] = {

	/* class, instance, title, tags mask, isfloating, monitor */
	
	/* Firefox always starts on tag 1 and floating */
	{ "Firefox", NULL,     NULL,  1 << 0,    1,           -1 },

	/* feh: image viewer, always floating */
	{ "feh",     NULL,     NULL,  0,         1,           -1 },

};

/*
 * =====================
 * LAYOUTS
 * =====================
 *
 * Tiling is available but not mandatory.
 * Primary usage is floating and monocle.
 */
static const float mfact     = 0.55;
static const int nmaster     = 1;
static const int resizehints = 1;
static const int lockfullscreen = 1;
static const int refreshrate = 120;

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* default tiling layout */
	{ "><>",      NULL },    /* floating layout */
	{ "[M]",      monocle }, /* fullscreen / focus layout */
};

/*
 * =====================
 * KEY DEFINITIONS
 * =====================
 *
 * MODKEY is Alt (Mod1), matching traditional Unix usage.
 * MODKEY is Super (Mod4), modern usage.  
 */
#define MODKEY Mod4Mask   /* Super */

#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/*
 * =====================
 * COMMANDS
 * =====================
 */
static char dmenumon[2] = "0";

static const char *dmenucmd[] = {
	"dmenu_run", "-m", dmenumon,
	"-fn", dmenufont,
	"-nb", col_bg,
	"-nf", col_fg,
	"-sb", col_gold,
	"-sf", col_bg,
	NULL
};

static const char *termcmd[]  = { "st", NULL };

/*
 * =====================
 * KEY BINDINGS
 * =====================
 *
 * Mouse-friendly defaults preserved.
 */
static const Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY,                       XK_p,      spawn,          {.v = dmenucmd } },
	{ MODKEY|ShiftMask,             XK_Return, spawn,          {.v = termcmd } },
	{ MODKEY,                       XK_b,      togglebar,      {0} },

	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },

	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },

	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY,                       XK_c,      killclient, {0} },

	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)

	{ MODKEY|ShiftMask,             XK_q,      quit,           {0} },
};

/*
 * =====================
 * MOUSE BINDINGS
 * =====================
 *
 * Designed for mouse usage similar to pekwm:
 * - Move windows with MOD + left click
 * - Resize with MOD + right click
 * - Click tags to change workspace
 */
static const Button buttons[] = {
	/* click            event mask  button   function        argument */
	{ ClkLtSymbol,      0,          Button1, setlayout,      {0} },
	{ ClkClientWin,     MODKEY,     Button1, movemouse,     {0} },
	{ ClkClientWin,     MODKEY,     Button3, resizemouse,   {0} },
	{ ClkTagBar,        0,          Button1, view,          {0} },
	{ ClkTagBar,        MODKEY,     Button1, tag,           {0} },
};

