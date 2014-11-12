import           Data.List
import qualified Data.Map as M
import XMonad.Actions.FloatKeys
import           System.Exit
import           Text.EditDistance
import           Text.Regex.Posix
import           XMonad
import           XMonad.Actions.GridSelect
import           XMonad.Actions.TopicSpace
import           XMonad.Actions.WindowBringer
import           XMonad.Hooks.DynamicLog
import           XMonad.Hooks.EwmhDesktops
import           XMonad.Hooks.ManageDocks
import           XMonad.Hooks.ManageHelpers
import           XMonad.Hooks.SetWMName
import           XMonad.Hooks.UrgencyHook
import           XMonad.Layout.NoBorders
import           XMonad.Layout.SimplestFloat
import           XMonad.Layout.Spiral
import           XMonad.Prompt
import           XMonad.Prompt.Shell
import           XMonad.Prompt.Window
import           XMonad.Prompt.Workspace
import qualified XMonad.StackSet as W
import           XMonad.Util.EZConfig
import           XMonad.Util.NamedScratchpad
import           XMonad.Util.Run

main = do
  h <- spawnPipe "xmobar"
  xmonad $ ewmh $ withUrgencyHook NoUrgencyHook $ defaultConfig
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

scratchpads = [NS "pavucontrol" "pavucontrol" (className =? "Pavucontrol") (customFloating $ W.RationalRect (1/6) (1/6) (2/3) (2/3))]
myManageHook = namedScratchpadManageHook scratchpads <+> composeAll [ isFullscreen --> doFullFloat ]

myLayout =  spiral (1 / 1.618) ||| Full ||| Mirror tiled  ||| tiled ||| simplestFloat
  where
    -- default tiling algorithm partitions the screen into two panes
    tiled   = Tall nmaster delta ratio

    -- The default number of windows in the master pane
    nmaster = 1

    -- Default proportion of screen occupied by master pane
    ratio   = 1/2

    -- Percent of screen to increment by when resizing panes
    delta   = 3/100

myKeys c =
  mkKeymap c $
  [("M-<Return>",spawn $ terminal c)
  ,("M-a",shellPrompt defaultXPConfig {position = Top})
  ,("M-f",fuzzySpawn)
  ,("M-S-c",kill)
  ,("M-<Space>",sendMessage NextLayout)
  ,("M-S-<Space>",setLayout $ layoutHook c)
  ,("M-r",windows W.focusDown)
  ,("M-t",windows W.focusUp)
  ,("M-m",windows W.focusMaster)
  ,("M-S-<Return>",windows W.swapMaster)
  ,("M-S-r",windows W.swapDown)
  ,("M-S-t",windows W.swapUp)
  ,("M-n",sendMessage Shrink)
  ,("M-d",sendMessage Expand)
  ,("M-w",withFocused $ windows . W.sink)
  ,("M-,",sendMessage (IncMasterN 1))
  ,("M-.",sendMessage (IncMasterN (-1)))
  ,("M-S-q",io (exitWith ExitSuccess))
  ,("M-q",spawn "xmonad --recompile; xmonad --restart")
  ,("M-b",sendMessage ToggleStruts)
  ,("M-p",namedScratchpadAction scratchpads "pavucontrol")
  ,("M-g",promptedGoto)
  ,("M-S-g",promptedShift)] ++
  [(m ++ k,windows $ f w) | (w,k) <- zip (workspaces c)
                                         ((map show [1 .. 9]) ++
                                          ["0"])
                          , (m,f) <- [("M-",W.greedyView),("M-S-",W.shift)]] ++
  [(m ++ k
   ,screenWorkspace s >>=
    flip whenJust (windows . f)) | (s,k) <- zip [0 ..]
                                                ["v","l"]
                                 , (m,f) <- [("M-",W.view),("M-S-",W.shift)]] ++
  [("M-C-" ++ dir,withFocused (keysMoveWindow (dx,dy))) | (dir,dx,dy) <- [("n"
                                                                          ,-20
                                                                          ,0)
                                                                         ,("d"
                                                                          ,20
                                                                          ,0)
                                                                         ,("t"
                                                                          ,0
                                                                          ,-20)
                                                                         ,("r"
                                                                          ,0
                                                                          ,20)]]


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

myTopics :: [Topic]
myTopics =
  ["uni"
  ,"audio"]

myTopicConfig :: TopicConfig
myTopicConfig =
  defaultTopicConfig {topicDirs =
                        M.fromList $
                        [("uni","docs/studium"),("audio","noise")]}

goto :: Topic -> X ()
goto = switchTopic myTopicConfig

promptedGoto :: X ()
promptedGoto = workspacePrompt defaultXPConfig goto

promptedShift :: X ()
promptedShift = workspacePrompt defaultXPConfig $ windows . W.shift
