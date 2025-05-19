-- Base
import XMonad
import System.Exit (exitSuccess)
import qualified XMonad.StackSet as W
import qualified Data.Map as M
import Control.Monad (zipWithM_)
import Data.Monoid
import System.IO (hPutStrLn)

-- Actions
import XMonad.Actions.CycleWS (Direction1D(..), moveTo, shiftTo, WSType(..), nextScreen, prevScreen)

-- Hooks
import XMonad.Hooks.DynamicLog (dynamicLogWithPP, xmobarPP, xmobarColor, shorten, PP(..), wrap)
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks (avoidStruts, docks, manageDocks, ToggleStruts(..))
import XMonad.Hooks.ManageHelpers (isFullscreen, doFullFloat)

-- Layouts
import XMonad.Layout.ResizableTile
import XMonad.Layout.SimplestFloat

-- Layouts modifiers
import XMonad.Layout.LayoutModifier
import XMonad.Layout.MultiToggle (mkToggle, single, EOT(EOT), (??))
import qualified XMonad.Layout.MultiToggle as MT
import XMonad.Layout.MultiToggle.Instances (StdTransformers(NBFULL, MIRROR, NOBORDERS))
import XMonad.Layout.NoBorders
import XMonad.Layout.Renamed
import XMonad.Layout.Spacing

-- Utilities
import XMonad.Util.EZConfig (additionalKeysP, additionalKeys)
import XMonad.Util.Run (spawnPipe)
import XMonad.Util.SpawnOnce (spawnOnce)


myFont :: String
myFont = "xft:SauceCodePro Nerd Font Mono:regular:size=9:antialias=true:hinting=true"

myModMask :: KeyMask
myModMask = mod4Mask        -- Super/Windows key for MOST operations

myTerminal :: String
myTerminal = "alacritty"

myBorderWidth :: Dimension
myBorderWidth = 2

myNormColor :: String
myNormColor   = "#282c34"

myFocusColor :: String
myFocusColor  = "#61afef"

myStartupHook :: X ()
myStartupHook = do
  spawnOnce "picom &"
  return ()

mySpacing :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing i = spacingRaw False (Border i i i i) True (Border i i i i) True

tall     = renamed [Replace "Tall"]
           $ smartBorders
           $ mySpacing 8
           $ ResizableTall 1 (3/100) (1/2) []
monocle  = renamed [Replace "Monocle"]
           $ smartBorders
           $ Full
floats   = renamed [Replace "Floats"]
           $ smartBorders
           $ simplestFloat

myLayoutHook = avoidStruts $ mkToggle (NBFULL ?? NOBORDERS ?? EOT) myDefaultLayout
  where
    myDefaultLayout = withBorder myBorderWidth tall
                   ||| noBorders monocle
                   ||| floats

myWorkspaces :: [String]
myWorkspaces = ["1","2","3","4","5","6","7","8","9"]

myManageHook :: XMonad.Query (Data.Monoid.Endo WindowSet)
myManageHook = composeAll
  [ isFullscreen --> doFullFloat
  ]

-- Keybindings that will use myModMask (Super key) OR specified modifiers
myKeyBindings :: [(String, X ())]
myKeyBindings =
  -- Xmonad Essentials
  [ ("M-C-r", spawn "xmonad --recompile")
  , ("M-S-r", spawn "xmonad --restart")
  , ("M-S-q", io exitSuccess)
  , ("M-S-c", kill)                            -- Kill focused window (Super+Shift+C)
  , ("M-S-<Return>", spawn "dmenu_run")        -- Run prompt (dmenu) (Super+Shift+Enter)
  , ("M-S-b", sendMessage ToggleStruts)        -- Toggle bar show/hide

  -- Window Navigation (Ctrl + HJKL)
  , ("C-j", windows W.focusDown)               -- Focus next window (Ctrl+J)
  , ("C-k", windows W.focusUp)                 -- Focus previous window (Ctrl+K)
  -- For "C-h" and "C-l" to control layout shrinking/expanding, we'll use Super for that
  -- If you want Ctrl+H/L for focus left/right, that requires more complex navigation setup
  -- as standard focusDown/Up are stack-based. Let's keep it simple for now.
  -- You can still use Super+H and Super+L for shrink/expand.

  -- Moving windows (Super + Shift + HJKL - standard Vim-like)
  , ("M-S-j", windows W.swapDown)              -- Swap with next window (Super+Shift+J)
  , ("M-S-k", windows W.swapUp)                -- Swap with previous window (Super+Shift+K)
  -- M-S-h and M-S-l can be added if you want to swap left/right in certain layouts

  -- Focus master
  , ("M-m", windows W.focusMaster)             -- Focus master window (Super+M)
  , ("M-S-m", windows W.swapMaster)            -- Swap with master (Super+Shift+M)

  -- Favorite programs
  , ("M-<Return>", spawn myTerminal)           -- Launch terminal (Super+Enter)

  -- Monitors
  , ("M-.", nextScreen)
  , ("M-,", prevScreen)

  -- Switch layouts
  , ("M-<Space>", sendMessage NextLayout)
  , ("M-S-<Space>", sendMessage (MT.Toggle NBFULL) >> sendMessage ToggleStruts)

  -- Window resizing (using Super key)
  , ("M-h", sendMessage Shrink)
  , ("M-l", sendMessage Expand)
  , ("M-M1-j", sendMessage MirrorShrink)        -- Super+Alt+J
  , ("M-M1-k", sendMessage MirrorExpand)        -- Super+Alt+K

  -- Floating windows
  , ("M-f", withFocused $ windows . W.sink)
  , ("M-t", withFocused float)

  -- Increase/decrease windows in master
  , ("M-S-<Up>", sendMessage (IncMasterN 1))
  , ("M-S-<Down>", sendMessage (IncMasterN (-1)))

  -- Moving windows to a specific workspace (Super + Shift + Number)
  , ("M-S-1", windows $ W.shift $ myWorkspaces !! 0)
  , ("M-S-2", windows $ W.shift $ myWorkspaces !! 1)
  , ("M-S-3", windows $ W.shift $ myWorkspaces !! 2)
  , ("M-S-4", windows $ W.shift $ myWorkspaces !! 3)
  , ("M-S-5", windows $ W.shift $ myWorkspaces !! 4)
  , ("M-S-6", windows $ W.shift $ myWorkspaces !! 5)
  , ("M-S-7", windows $ W.shift $ myWorkspaces !! 6)
  , ("M-S-8", windows $ W.shift $ myWorkspaces !! 7)
  , ("M-S-9", windows $ W.shift $ myWorkspaces !! 8)
  ]

-- Keybindings for workspace switching with Ctrl + Number
-- This function generates Map (modifier, keysym) (X ())
myCtrlWorkspaceKeysConf :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
myCtrlWorkspaceKeysConf conf = M.fromList $
    -- Switch to workspace: Ctrl + [1..9]
    [((controlMask, k), windows $ W.greedyView i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
    ]
    -- NO Ctrl + Shift + Number for moving windows here anymore

main :: IO ()
main = do
  xmproc <- spawnPipe "xmobar"
  xmonad $ ewmh $ docks $ def
    { manageHook         = myManageHook <+> manageDocks
    , handleEventHook    = mempty
    , modMask            = myModMask -- Default modifier is Super
    , terminal           = myTerminal
    , startupHook        = myStartupHook
    , layoutHook         = myLayoutHook
    , workspaces         = myWorkspaces
    , borderWidth        = myBorderWidth
    , normalBorderColor  = myNormColor
    , focusedBorderColor = myFocusColor
    , logHook = dynamicLogWithPP $ xmobarPP
        { ppOutput = hPutStrLn xmproc
        , ppCurrent = xmobarColor "#c3e88d" "" . wrap "[" "]"
        , ppVisible = xmobarColor "#c3e88d" "" . wrap "(" ")"
        , ppHidden = xmobarColor "#82aaff" "" . wrap "*" ""
        , ppHiddenNoWindows = xmobarColor "#82aaff" ""
        , ppTitle = xmobarColor "#b392f0" "" . shorten 60
        , ppSep =  "<fc=#666666> | </fc>"
        , ppUrgent = xmobarColor "#ff5555" "" . wrap "!" "!"
        , ppOrder  = \(ws:l:t:_) -> [ws,l,t]
        }
    -- Combine keys:
    -- 1. Our Ctrl + Number for workspace switching
    -- 2. The default keys from XMonad (which additionalKeysP will modify)
    , keys = \c -> myCtrlWorkspaceKeysConf c `M.union` keys def c
    } `additionalKeysP` myKeyBindings -- Add our string-defined keys (which can use 'M-' for Super or 'C-' for Ctrl)
