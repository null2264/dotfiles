from libqtile.config import key, screen, group, drag, click, match
from libqtile.command import lazy

mod = 'mod4' 
mod = "mod4"                                     # Sets mod key to SUPER/WINDOWS
myTerm = "urxvt"                                    # My terminal of choice
myConfig = "/home/ziro/.config/qtile/config.py"    # Qtile config file location

def app_or_group(group, app):
    def f(qtile):
        if qtile.groupMap[group].windows:
            qtile.groupMap[group].cmd_toscreen()
        else:
            qtile.groupMap[group].cmd_toscreen()
            qtile.cmd_spawn(app)
    return f

@lazy.function
def window_to_prev_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i - 1].name)

@lazy.function
def window_to_next_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i + 1].name)

keys = [
            Key(
                [mod, 'control'], 'q',
                lazy.spawn('sh /home/ziro/.scripts/prompt')
                ),
            Key(
                [mod], "Return",
                lazy.spawn(myTerm)                      # Opn terminal
                ),
            Key(
                [mod], "Tab",
                lazy.next_layout()                      # Toggle through layouts
                ),
            Key(
                [mod], "q",
                lazy.window.kill()                      # Kill active window
                ),
            Key(
                [mod, "shift"], "r",
                lazy.restart()                          # Restart Qtile
                ),
            Key(
                [mod, "shift"], "q",
                lazy.shutdown()                         # Shutdown Qtile
                ),
            Key([mod], "w",
                lazy.to_screen(0)                       # Keyboard focus screen(0)
                ),
            Key([mod], "e",
                lazy.to_screen(1)                       # Keyboard focus screen(1)
                ),
            Key([mod], "r",
                lazy.to_screen(2)                       # Keyboard focus screen(2)
                ),
#            Key([mod, "control"], "k",
#                lazy.layout.section_up()                # Move up a section in treetab
#                ),
#            Key([mod, "control"], "j",
#                lazy.layout.section_down()              # Move down a section in treetab
#                ),
            ### Window controls
            Key(
                [mod], "k",
                lazy.layout.down()                      # Switch between windows in current stack pane
                ),
            Key(
                [mod], "i",
                lazy.layout.up()                        # Switch between windows in current stack pane
                ),
            Key(
                [mod], "j",
                lazy.layout.left()                      # Switch between windows in current stack pane
                ),
            Key(
                [mod], "l",
                lazy.layout.right()                        # Switch between windows in current stack pane
                ),
            Key(
                [mod, "shift"], "k",
                lazy.layout.shuffle_down()              # Move windows down in current stack
                ),
            Key(
                [mod, "shift"], "i",
                lazy.layout.shuffle_up()                # Move windows up in current stack
                ),
            Key(
                [mod, "shift"], "j",
                lazy.layout.shuffle_left()              # Move windows down in current stack
                ),
            Key(
                [mod, "shift"], "l",
                lazy.layout.shuffle_right()                # Move windows up in current stack
                ),
            Key(
                [mod, "shift"], "period",
                lazy.layout.grow(),                     # Grow size of current window (XmonadTall)
                lazy.layout.increase_nmaster(),         # Increase number in master pane (Tile)
                ),
            Key(
                [mod, "shift"], "comma",
                lazy.layout.shrink(),                   # Shrink size of current window (XmonadTall)
                lazy.layout.decrease_nmaster(),         # Decrease number in master pane (Tile)
                ),
            Key(
                [mod, "shift"], "Left",                 # Move window to workspace to the left
                window_to_prev_group
                ),
            Key(
                [mod, "shift"], "Right",    
                window_to_next_group
                ),
            Key(
                [mod], "n",
                lazy.layout.normalize()        
                ),
            Key(
                [mod], "m",
                lazy.layout.maximize()   
                ),
            Key(
                [mod, "shift"], "p",
                lazy.window.toggle_floating()
                ),
            Key(
                [mod, "shift"], "space",
                lazy.layout.rotate(),
                lazy.layout.flip()
                ),
            ### Stack controls
            Key(
                ["mod1"], "space",
                lazy.layout.next()
                ),
            Key(
                [mod, "control"], "Return",
                lazy.layout.toggle_split()              
                ),

            ### Dmenu Run Launcher
            Key(
                ["mod4"], "space",
                lazy.spawn("dmenu_run -fn 'Google Sans:size=8' -nb '#282a36' -nf '#ffffff' -sb '#00a8ff' -sf '#282a36' -p 'dmenu:'")
                ),

            ### Application Launch Shortcuts
            Key(
                [mod, "mod1"], "k",
                lazy.spawn("passmenu")
                ),
            Key(
                [mod, "mod1"], "Print",
                lazy.spawn("gnome-screenshot")
                ),
            Key(
                [mod, "mod1"], "p",
                lazy.spawn("sh /home/ziro/.scripts/play.sh")
                ),
            Key(
                [mod, "mod1"], "m",
                lazy.spawn("sh /home/ziro/.scripts/musicplayer.sh")
                ),
            Key(
                [mod, "mod1"], "v",
                lazy.spawn("sh /home/ziro/.scripts/video.sh")
                ),
            Key(
                [mod, "mod1"], "c",
                lazy.spawn(myTerm+" -e calcurse")
                ),
            Key(
                [mod, "mod1"], "u",
                lazy.spawn("sh /home/ziro/.scripts/dmenumount")
                ),
            Key(
                [mod, "mod1"], "y",
                lazy.spawn(myTerm+" -e youtube-viewer")
                ),
            Key(
                [mod, "mod1"], "b",
                lazy.spawn("firefox")
                ),
            Key(
                [mod, "mod1"], "g",
                lazy.spawn("/home/ziro/my\ Files/Gravit/GravitDesigner.AppImage")
                ),
            Key(
                [mod, "mod1"], "o",
                lazy.spawn("obs")
                ),
            #myCustom Stuff
            Key(
                [mod], "leftarrow",
                lazy.screen.next_group()
                ),
            Key(
                [mod], "rightarrow",
                lazy.screen.prev_group()
                ),
        ]
