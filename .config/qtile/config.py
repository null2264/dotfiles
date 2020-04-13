# -*- coding: utf-8 -*-
# A customized config.py for Qtile window manager (http://www.qtile.org)
# Modified by ZiRO based on DT's (DistroTube) custom config
#
# The following comments are the copyright and licensing information from the default
# qtile config. Copyright (c) 2010 Aldo Cortesi, 2010, 2014 dequis, 2012 Randall Ma,
# 2012-2014 Tycho Andersen, 2012 Craig Barnes, 2013 horsik, 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of this
# software and associated documentation files (the "Software"), to deal in the Software
# without restriction, including without limitation the rights to use, copy, modify,
# merge, publish, distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to the following
# conditions:
#
# The above copyright notice and this permission notice shall be included in all copies
# or substantial portions of the Software.

##### IMPORTS #####

import os
import re
import socket
import subprocess
from keys import keys
from libqtile.config import Key, Screen, Group, Drag, Click, Match
from libqtile.command import lazy
from libqtile import layout, bar, widget, hook
from libqtile.widget import Spacer, Net

##### Dbus Register #####

@hook.subscribe.startup
def dbus_register():
    id = os.environ.get('DESKTOP_AUTOSTART_ID')
    if not id:
        return
    subprocess.Popen(['dbus-send',
                      '--session',
                      '--print-reply',
                      '--dest=org.gnome.SessionManager',
                      '/org/gnome/SessionManager',
                      'org.gnome.SessionManager.RegisterClient',
                      'string:qtile',
                      'string:' + id])


##### KEYBINDINGS #####

def init_keys():
    keys 
    return keys

##### BAR COLORS #####

def init_colors():
    return [["#2f3640", "#2f3640"], # [0] panel background
            ["#00a8ff", "#00a8ff"], # [1] background for current screen tab
            ["#ffffff", "#ffffff"], # [2] font color for group names
            ["#ff5555", "#ff5555"], # [3] background color for layout widget
            ["#000000", "#000000"], # [4] background for other screen tabs
            ["#00a8ff", "#00a8ff"], # [5] dark green gradiant for other screen tabs
            ["#c23616", "#c23616"], # [6] background color for network widget
            ["#0097e6", "#0097e6"], # [7] background color for pacman widget
            ["#9AEDFE", "#9AEDFE"], # [8] background color for cmus widget
            ["#000000", "#000000"], # [9] background color for clock widget
            ["#434758", "#434758"]] # [10] background color for systray widget

##### GROUPS #####

def init_group_names():
    return [#internet
            ("  ", {'layout': '﬿',
                    'matches': [Match(wm_class=["Firefox",
                                                "firefox"
                                                ])]
            }),
            #system (Terminal and stuff)
            ("  ", {'layout': '﬿',
                    'matches': [Match(wm_class=["atom",
                                                "thunar",
                                                "urxvt",
                                                "st"
                                                ],
                                            title=["st","urxvt","Atom"]
                                                )]
            }),
            #arch stuff
            ("  ", {'layout': '﬿',
                    'matches': [Match(wm_class=["thunar",
                                                "st",
                                                "urxvt",
                                                ],
                                            title=["st","urxvt","Atom"]
                                                )]
            }),
            #video
            ("  ", {'layout': '',
                    'matches': [Match(wm_class=["kodi",
                                                "vlc",
                                                "mpv",
                                                "obs",
                                                "youtube-viewer",
                                                "electronplayer"
                                                ],
                                            title=["youtube-viewer"]
                                                )]
            }),
            #vbox
            ("  ", {'layout': '﬿'
            }),
            #floating
            ("  ", {'layout': ''
            }),
            #music
            ("  ", {'layout': '﬿',
                    'matches': [Match(wm_class=["spotify",
                                                "Spotify",
                                                "vlc",
                                                "cmus"
                                                ],
                                            title=["Spotify", "cmus"])]
            }),
            #gaming
            (" 調 ", {'layout': '',
                    'matches': [Match(wm_class=["mcpelauncher-client",
                                                "citra","citra-qt",
                                                "PCSX2"
                                                ],
                                                title=["Minecraft", "Citra", "PCSX2"])]
            }),
            #gfx
            ("  ", {'layout': '',
                    'matches': [Match(wm_class=["GravitDesigner",
                                                "gnome-screenshot"
                                                ],
                                                title=["gnome-screenshot"])]
            })
            ]

def init_groups():
    return [Group(name, **kwargs) for name, kwargs in group_names]


##### LAYOUTS #####

def init_floating_layout():
    return layout.Floating(border_focus="#00a8ff")

def init_layout_theme():
    return {"border_width": 2,
            "margin": 10,
            "border_focus": "00a8ff",
            "border_normal": "1D2330",
            "opacity": 0.5,
           }

def init_bsp_layout():
    return layout.Bsp(border_focus="#00a8ff")

def init_border_args():
    return {"border_width": 2}

def init_layouts():
    return [#layout.MonadWide(**layout_theme),
            #layout.Bsp(**layout_theme),
            #layout.Stack(stacks=2, **layout_theme),
            #layout.Columns(**layout_theme),
            #layout.RatioTile(**layout_theme),
            #layout.VerticalTile(**layout_theme),
            #layout.Tile(shift_windows=True, **layout_theme),
            #layout.Matrix(**layout_theme),
            #layout.Zoomy(**layout_theme),
            layout.MonadTall(name = "﬿", align = "_right", **layout_theme),
            layout.Max(name = "", **layout_theme),
            #layout.TreeTab(
            #    font = "Ubuntu",
            #    fontsize = 10,
            #    sections = ["FIRST", "SECOND"],
            #    section_fontsize = 11,
            #    bg_color = "141414",
            #    active_bg = "90C435",
            #    active_fg = "000000",
            #    inactive_bg = "384323",
            #    inactive_fg = "a0a0a0",
            #    padding_y = 5,
            #    section_top = 10,
            #    panel_width = 300,
            #    **layout_theme
            #    ),
            layout.Floating(name = "", **layout_theme)]

##### WIDGETS #####

def init_widgets_defaults():
    return dict(font="Google Sans",
                fontsize = 12,
                padding = 2,
                background=colors[2])

def init_widgets_list():
    prompt = "{0}@{1}: ".format(os.environ["USER"], socket.gethostname())
    widgets_list = [
               widget.TextBox(
                        text='',
                        background = colors[10],
                        foreground = colors[0],
                        padding=0,
                        fontsize=37
                        ),
               widget.GroupBox(font="UbuntuMono Nerd Font",
                        disable_drag = True,
                        fontsize = 14,
                        margin_y = 0,
                        margin_x = 0,
                        padding_y = 5,
                        padding_x = 5,
                        borderwidth = 1,
                        active = colors[2],
                        inactive = colors[2],
                        rounded = False,
                        highlight_method = "block",
                        this_current_screen_border = colors[5],
                        this_screen_border = colors [1],
                        other_current_screen_border = colors[0],
                        other_screen_border = colors[0],
                        foreground = colors[2],
                        background = colors[10]
                        ),
               widget.TextBox(
                        text='',
                        background = colors[0],
                        foreground = colors[10],
                        padding=0,
                        fontsize=37
                        ),
               widget.Prompt(
                        prompt=prompt,
                        font="Iosevka",
                        padding=5,
                        foreground = colors[3],
                        background = colors[1]
                        ),
               widget.Sep(
                        linewidth = 0,
                        padding = 10,
                        foreground = colors[2],
                        background = colors[0]
                        ),
               widget.WindowName(font="Iosevka",
                        fontsize = 11,
                        foreground = colors[5],
                        background = colors[0],
                        padding = 5
                        ),
               widget.TextBox(
                        text=' ',
                        background = colors[0],
                        foreground = colors[5],
                        padding=0,
                        fontsize=37
                        ),
               widget.TextBox(
                        text='',
                        background = colors[10],
                        foreground = colors[0],
                        padding=0,
                        fontsize=37
                        ),
               widget.Systray(
                        background=colors[10],
                        padding = 0,
                        icon_size=13
                        ),
               widget.TextBox(
                        text='',
                        background = colors[5],
                        foreground = colors[10],
                        padding=0,
                        fontsize=40
                        ),
               widget.TextBox(
                        text=" ",
                        foreground=colors[2],
                        background=colors[5],
                        padding = 0,
                        fontsize=13
                        ),
               widget.Net(
                        interface = "enp2s0",
                        update_interval = 1,
                        foreground = colors[2],
                        background = colors[5],
                        padding = 5
                        ),
               widget.TextBox(
                        text='',
                        background = colors[7],
                        foreground = colors[5],
                        padding=0,
                        fontsize=40
                        ),
#               widget.TextBox(
#                        font="Google Sans Bold",
#                        text="﩯 ",
#                        padding = 0,
#                        foreground=colors[2],
#                        background=colors[5],
#                        fontsize=20
#                        ),
               widget.CurrentLayout(
                        foreground = colors[2],
                        background = colors[7],
                        padding = 5,
                        fontsize=18
                        ),
               widget.TextBox(
                        text='',
                        background = colors[7],
                        foreground = colors[5],
                        padding=0,
                        fontsize=40
                        ),
               widget.TextBox(
                        font="UbuntuMono Nerd Font",
                        text="  ",
                        padding = 0,
                        foreground=colors[2],
                        background=colors[5],
                        fontsize=14
                        ),
               widget.Volume(
                        font="Google Sans",
                        background=colors[5],
                        foreground=colors[2],
                        fontsize=12
                       ),
               widget.TextBox(
                        text=' ',
                        background = colors[5],
                        foreground = colors[7],
                        padding=0,
                        fontsize=14
                        ),
               widget.TextBox(
                        text='',
                        background = colors[5],
                        foreground = colors[7],
                        padding=0,
                        fontsize=40
                        ),
               widget.TextBox(
                        font="UbuntuMono Nerd Font",
                        text=" ﱘ ",
                        padding = 0,
                        foreground=colors[2],
                        background=colors[7],
                        fontsize=14
                        ),
               widget.Cmus(
                        font="Google Sans",
                        fontsize=12,
                        max_chars = 30,
                        update_interval = 1,
                        foreground=colors[2],
                        noplay_color=colors[2],
                        play_color='dcdde1',
                        background = colors[7]
                        ),
               widget.TextBox(
                        text=' ',
                        background = colors[7],
                        foreground = colors[5],
                        padding=0,
                        fontsize=14
                        ),
               widget.TextBox(
                        text='',
                        background = colors[7],
                        foreground = colors[5],
                        padding=0,
                        fontsize=40
                        ),
               widget.TextBox(
                        font="UbuntuMono Nerd Font",
                        text="  ",
                        foreground=colors[2],
                        background=colors[5],
                        padding = 0,
                        fontsize=14
                        ),
               widget.Clock(
                        foreground = colors[2],
                        background = colors[5],
                        format="%d/%m/%y • %H:%M"
                        ),
               widget.TextBox(
                        text='   ',
                        background = colors[5],
                        foreground = colors[5],
                        padding=0,
                        fontsize=14
                        ),
               widget.Sep(
                        linewidth = 0,
                        padding = 5,
                        foreground = colors[0],
                        background = colors[5]
                        ),
              ]
    return widgets_list

##### SCREENS ##### (TRIPLE MONITOR SETUP)

def init_widgets_screen1():
    widgets_screen1 = init_widgets_list()
    return widgets_screen1                       # Slicing removes unwanted widgets on Monitors 1,3

def init_widgets_screen2():
    widgets_screen2 = init_widgets_list()
    return widgets_screen2                       # Monitor 2 will display all widgets in widgets_list

def init_screens():
    return [Screen(top=bar.Bar(widgets=init_widgets_screen1(), opacity=0.95, size=25)),
            Screen(top=bar.Bar(widgets=init_widgets_screen2(), opacity=0.95, size=25)),
            Screen(top=bar.Bar(widgets=init_widgets_screen1(), opacity=0.95, size=25))]

##### FLOATING WINDOWS #####

@hook.subscribe.client_new
def floating(window):
    floating_types = ['notification', 'toolbar', 'splash', 'dialog']
    transient = window.window.get_wm_transient_for()
    if window.window.get_wm_type() in floating_types or transient:
        window.floating = True

def init_mouse():
    return [Drag([mod], "Button1", lazy.window.set_position_floating(),      # Move floating windows
                 start=lazy.window.get_position()),
            Drag([mod], "Button3", lazy.window.set_size_floating(),          # Resize floating windows
                 start=lazy.window.get_size()),
            Click([mod, "control"], "Button1", lazy.window.bring_to_front())]  # Bring floating window to front

##### DEFINING A FEW THINGS #####

if __name__ in ["config", "__main__"]:
    mod = "mod4"                                     # Sets mod key to SUPER/WINDOWS
    myTerm = "urxvt"                                    # My terminal of choice
    myConfig = "/home/ziro/.config/qtile/config.py"    # Qtile config file location

    colors = init_colors()
    keys = init_keys()
    mouse = init_mouse()
    group_names = init_group_names()
    groups = init_groups()
    floating_layout = init_floating_layout()
    layout_theme = init_layout_theme()
    border_args = init_border_args()
    layouts = init_layouts()
    screens = init_screens()
    widget_defaults = init_widgets_defaults()
    widgets_list = init_widgets_list()
    widgets_screen1 = init_widgets_screen1()
    widgets_screen2 = init_widgets_screen2()

##### SETS GROUPS KEYBINDINGS #####

for i, (name, kwargs) in enumerate(group_names, 1):
    keys.append(Key([mod], str(i), lazy.group[name].toscreen()))          # Switch to another group
    keys.append(Key([mod, "shift"], str(i), lazy.window.togroup(name)))   # Send current window to another group

##### STARTUP APPLICATIONS #####

@hook.subscribe.startup_once
#def start_once():
#    home = os.path.expanduser('~')
#    subprocess.call([home + '/.config/qtile/autostart.sh'])
def autostart():
    home = os.path.expanduser('~/.config/qtile/script/autostart.sh')
    subprocess.call([home])

##### NEEDED FOR SOME JAVA APPS #####

#wmname = "LG3D"
wmname = "qtile"
