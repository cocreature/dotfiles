import           Data.List
import qualified Data.Map as M
import           System.Exit
import XMonad.Layout.MosaicAlt
import           Text.EditDistance
import           Text.Regex.Posix
import           XMonad
import           XMonad.Actions.GridSelect
import           XMonad.Actions.WindowBringer
import           XMonad.Hooks.DynamicLog
import           XMonad.Hooks.EwmhDesktops
import           XMonad.Hooks.EwmhDesktops
import           XMonad.Hooks.ManageDocks
import           XMonad.Hooks.ManageHelpers
import           XMonad.Hooks.SetWMName
import           XMonad.Hooks.UrgencyHook
import           XMonad.Layout.NoBorders
import           XMonad.Layout.Spiral
import           XMonad.Layout.TrackFloating
import           XMonad.Prompt
import           XMonad.Prompt.Shell
import           XMonad.Prompt.Window
import qualified XMonad.StackSet as W
import           XMonad.Util.EZConfig
import           XMonad.Util.Run

main = do
  h <- spawnPipe "xmobar"
  xmonad $ fullscreenFix $ ewmh $ withUrgencyHook NoUrgencyHook $ defaultConfig
        { borderWidth        = 2
        , normalBorderColor  = "#cccccc"
        , focusedBorderColor = "#cd8b00"
        , logHook            = dynamicLogWithPP $ xmobarPP { ppOutput = hPutStrLn h }
        , layoutHook         = avoidStruts $ lessBorders Screen $ myLayout
        , manageHook         = myManageHook
        , handleEventHook    = handleEventHook defaultConfig <+> fullscreenEventHook <+> docksEventHook
        , workspaces         = ["1:shell", "2:web", "3:news", "4:media", "5", "6", "7", "8", "9", "0:emacs"]
        , modMask            = mod4Mask
        , terminal           = "urxvt"
        , keys               = myKeys
        }

fullscreenFix :: XConfig a -> XConfig a
fullscreenFix c = c {
                      startupHook = startupHook c <+> setSupportedWithFullscreen
                    }

setSupportedWithFullscreen :: X ()
setSupportedWithFullscreen = withDisplay $ \dpy -> do
    r <- asks theRoot
    a <- getAtom "_NET_SUPPORTED"
    c <- getAtom "ATOM"
    supp <- mapM getAtom ["_NET_WM_STATE_HIDDEN"
                         ,"_NET_WM_STATE_FULLSCREEN"
                         ,"_NET_NUMBER_OF_DESKTOPS"
                         ,"_NET_CLIENT_LIST"
                         ,"_NET_CLIENT_LIST_STACKING"
                         ,"_NET_CURRENT_DESKTOP"
                         ,"_NET_DESKTOP_NAMES"
                         ,"_NET_ACTIVE_WINDOW"
                         ,"_NET_WM_DESKTOP"
                         ,"_NET_WM_STRUT"
                         ]
    io $ changeProperty32 dpy r a c propModeReplace (fmap fromIntegral supp)

    setWMName "xmonad"

myManageHook = composeAll [ isFullscreen --> doFullFloat]

myLayout =  spiral (1 / 1.618) ||| Full ||| Mirror tiled  ||| tiled
  where
    -- default tiling algorithm partitions the screen into two panes
    tiled   = Tall nmaster delta ratio

    -- The default number of windows in the master pane
    nmaster = 1

    -- Default proportion of screen occupied by master pane
    ratio   = 1/2

    -- Percent of screen to increment by when resizing panes
    delta   = 3/100




myKeys c = mkKeymap c $
           [ ("M-<Return>"  , spawn $ terminal c)
           , ("M-a"         , shellPrompt defaultXPConfig {position = Top})
           , ("M-f"         , fuzzySpawn)
           , ("M-S-c"       , kill)
           , ("M-<Space>"   , sendMessage NextLayout)
           , ("M-S-<Space>" , setLayout $ layoutHook c)
           , ("M-r"         , windows W.focusDown)
           , ("M-t"         , windows W.focusUp)
           , ("M-m"         , windows W.focusMaster)
           , ("M-S-<Return>", windows W.swapMaster)
           , ("M-S-r"       , windows W.swapDown)
           , ("M-S-t"       , windows W.swapUp)
           , ("M-n"         , sendMessage Shrink)
           , ("M-d"         , sendMessage Expand)
           , ("M-w"         , withFocused $ windows . W.sink)
           , ("M-,"         , sendMessage (IncMasterN 1))
           , ("M-."         , sendMessage (IncMasterN (-1)))
           , ("M-S-q"       , io (exitWith ExitSuccess))
           , ("M-q"         , spawn "xmonad --recompile; xmonad --restart")
           , ("M-b"         , sendMessage ToggleStruts)
           ] ++
           [(m ++ k, windows $ f w)
           | (w, k) <- zip (workspaces c) ((map show [1..9]) ++ ["0"])
           , (m, f) <- [("M-", W.greedyView), ("M-S-", W.shift)]] ++
           [(m ++ k, screenWorkspace s >>= flip whenJust (windows . f))
           | (s, k) <- zip [0..] ["v", "l"]
           , (m, f) <- [("M-", W.view), ("M-S-", W.shift)]]


data FuzzySpawn = FuzzySpawn deriving (Read, Show)
instance XPrompt FuzzySpawn where
  showXPrompt _ = "Find window: "

winAction a m    = flip whenJust (windows . a) . flip M.lookup m
gotoAction       = winAction W.focusWindow
fuzzySpawn = do
  wm <- windowMap
  a <- fmap gotoAction windowMap
  mkXPrompt FuzzySpawn defaultXPConfig {position = Top, alwaysHighlight = True, promptKeymap = emacsLikeXPKeymap} (compList wm) a
    where
      weight s c = levenshteinDistance defaultEditCosts { deletionCosts = ConstantCost 1000,
                                                          substitutionCosts = ConstantCost 1000 } s c
      regex s = foldr (\a b -> a:'.':'*':b) [] s
      compList m s = return . map snd . sort . map (\c -> (weight s c, c))
                     . filter (\a -> a =~ regex s) . map fst . M.toList $ m
