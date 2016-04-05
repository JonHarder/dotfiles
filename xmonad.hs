import           XMonad

-- import XMonad.Actions.Volume
import           XMonad.Actions.CycleWS

import           XMonad.Hooks.DynamicLog
import           XMonad.Hooks.ManageDocks
import           XMonad.Hooks.ManageHelpers
import           XMonad.Hooks.SetWMName

import           XMonad.Layout.Grid
import           XMonad.Layout.NoBorders
import           XMonad.Layout.Spacing        hiding (SmartSpacing)
import           XMonad.Layout.Tabbed

import qualified Data.Map                     as M
import qualified XMonad.StackSet              as W

import           XMonad.Util.EZConfig
import           XMonad.Util.Scratchpad

import           Graphics.X11.ExtraTypes.XF86

import           Control.Monad                (void)

type Program = String

myTerminal :: Program
myTerminal = "xterm"

tmux :: Program
tmux = myTerminal ++ " -e tmux"

myWorkspaces :: [String]
myWorkspaces = ["1:main", "2:code", "3:music", "4:misc", "5", "6", "7", "8", "9"]

dmenu :: Program
dmenu = "dmenu_run -fn '-*-ohsnap-medium-*-*-*-14-*-*-*-*-*-iso8859-*' -nb '" ++ myNormalBorderColor ++ "' -nf '"  ++ myFocusedBorderColor
    ++ "' -sb '" ++ myFocusedBorderColor ++ "' -sf '" ++ myNormalBorderColor ++ "' -l 8 "
    ++ "-p 'Run: ' -b"

-- myBrowser = "firefox"
-- myBrowser = "google-chrome-stable"
myBrowser :: Program
myBrowser = "chromium"

myEditor :: Program
myEditor = "emacsclient -c"
-- myEditor = myTerminal ++ " -e nvim"

myMusic :: Program
myMusic = myTerminal ++ " -e ncmpcpp"

myRadio :: Program
myRadio = myTerminal ++ " -e pianobar"

myLock :: Program
myLock = "~/bin/lock"

myBar :: Program
myBar = "~/.cabal/bin/xmobar"

myInternet :: Program
myInternet = myTerminal ++ " -e wicd-curses"

myPDF :: Program
myPDF = "zathura"

myUpdater :: Program
myUpdater = myTerminal ++ " -e aptitude update && sudo aptitude upgrade"

reload :: Program
reload = "xmonad --recompile; xmonad --restart"

configure :: Program
configure = myEditor ++ " ~/.xmonad/xmonad.hs"

myNormalBorderColor :: String
-- myNormalBorderColor = "#fdf6e3" -- "#839496"
myNormalBorderColor = bg myTheme

myFocusedBorderColor :: String
-- myFocusedBorderColor = "#268bd2" -- "#fdf6e3"
myFocusedBorderColor = fg myTheme

myModMask :: KeyMask
myModMask = mod4Mask

data ColorTheme = ColorTheme { bg :: String, fg :: String }

solarized :: ColorTheme
solarized = ColorTheme { bg = "#002b36", fg = "#b58900" }

gruvbox :: ColorTheme
gruvbox = ColorTheme { bg = "#2a2a2a", fg = "#c59910" }

moe :: ColorTheme
moe = ColorTheme { bg = "#333333", fg = "#fdfde7" }

myTheme = gruvbox

main :: IO ()
main = xmonad =<< statusBar myBar (myPP myTheme) toggleStrutsKey myConfig

myPP :: ColorTheme -> PP
myPP c = xmobarPP { ppCurrent = xmobarColor (bg c)  (fg c)  -- . wrap "[" "]"
                  , ppHidden = xmobarColor (fg c) ""
                  , ppLayout = const ""
                  , ppTitle = xmobarColor (fg c) ""
                  , ppSep = "  =<<  " }

myManageHook :: ManageHook
myManageHook = scratchpadManageHookDefault <+> composeAll
    [ isFullscreen --> doFullFloat
    , title =? "thegame" --> doFullFloat
    , className =? "Gimp"  --> doFloat
    , className =? "gimp"  --> doFloat
    , className =? "sun-awt-X11-XFramePeer" --> doFloat
    , title =? "Pandora Radio" --> doShift "3:music"
    ]

toggleStrutsKey :: XConfig t -> (KeyMask, KeySym)
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)


myConfig = defaultConfig
    { terminal           =   myTerminal
    , modMask            = myModMask
    , borderWidth        =   2
    , manageHook         =   manageDocks <+> myManageHook <+> manageHook defaultConfig
    , workspaces         =   myWorkspaces
    , normalBorderColor  =   myNormalBorderColor
    , focusedBorderColor =   myFocusedBorderColor
    , layoutHook         =   avoidStruts $ smartBorders myLayout
    , startupHook        =   setWMName "LG3D"
    } `additionalKeys` myKeys

myLayout = tiled ||| Grid ||| Mirror tiled ||| Full ||| simpleTabbed
    where
        -- tiled = smartSpacing 8 $ Tall nmaster delta ratio
        -- tiled = Tall nmaster delta ratio
        tiled = spacing 18 $ Tall nmaster delta ratio
        nmaster = 1
        ratio = 1/2
        delta = 3/100

modmask :: KeyMask
modmask = myModMask

fullKeyBind :: KeyMask -> KeySym -> Program -> ((KeyMask, KeySym), X ())
fullKeyBind mask key app = ((mask, key), spawn app)

-- button to bind, program to bind it to
keybind :: KeySym -> Program -> ((KeyMask, KeySym), X ())
keybind = fullKeyBind modmask

myKeys :: [((KeyMask, KeySym), X ())]
myKeys = [keybind xK_c "chromium"
         ,keybind xK_d "dwarffortress-ih"
         ]
         ++
         -- this bit of code golf make a key binding for every combination
         -- of xK_comma, xK_period, and shiftMask for moving to and shifting windows
         -- to different screens
         do
             (key, sc) <- zip [xK_comma, xK_period] [0..]
             (f, m)    <- [(W.view, 0), (W.shift, shiftMask)]
             return ((m .|. modmask, key), screenWorkspace sc >>= flip whenJust (windows . f))
         ++
         [keybind xK_f "firefox"
         ,keybind xK_g (myTerminal ++ " -e ghci")
         ,keybind xK_i myInternet
         ,keybind xK_m myMusic
         ,keybind xK_p dmenu
         ,keybind xK_e "e"
         ,keybind xK_o "opera"
         ,keybind xK_0 "amixer -D pulse set Master 1+ toggle"
         ,keybind xK_bracketleft "amixer set Master playback 4-"
         ,keybind xK_bracketright "amixer set Master playback 4+"
         -- ,keybind xK_r reload
         ,(( modmask .|. shiftMask, xK_r) , spawn reload)
         ,keybind xK_u myUpdater
         ,keybind xK_v "gvim"
         -- ,keybind xK_w myBrowser
         ,keybind xK_z myPDF
         ,keybind xK_a "xterm -e alsamixer"
         ,(( modmask .|. shiftMask, xK_e), spawn configure)
         ,(( modmask .|. shiftMask, xK_Return), spawn tmux)
         ,(( modmask, xK_Return), spawn myTerminal)
         ,fullKeyBind (modmask .|. shiftMask) xK_p myRadio
         -- audio configuration
         ,(( modmask .|. controlMask, xK_p), spawn "echo -n ' ' > ~/.config/pianobar/ctl")
         ,(( modmask .|. controlMask, xK_n), spawn "echo -n 'n' > ~/.config/pianobar/ctl")
         ,(( modmask .|. controlMask, xK_l), shiftToNext >> nextWS)
         ,(( modmask .|. controlMask, xK_h), shiftToPrev >> prevWS)
         -- ,(( 0, xF86XK_AudioMute), toggleMute >> return ())
         -- ,(( 0, xF86XK_AudioLowerVolume), lowerVolume 2 >> return ())
         -- ,(( 0, xF86XK_AudioRaiseVolume), raiseVolume 2 >> return ())
         ,(( 0, xF86XK_AudioPlay), spawn "ncmpcpp toggle")
         ,(( 0, xF86XK_AudioNext), spawn "ncmpcpp next")
         ,(( 0, xF86XK_AudioPrev), spawn "ncmpcpp prev")
         ,(( 0, xF86XK_AudioStop), spawn "ncmpcpp stop")
         -- scratchpad actions
         ,((modmask, xK_minus), scratchpadSpawnActionTerminal myTerminal)
         ]
