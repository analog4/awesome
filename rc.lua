-- Standard awesome library
require("awful")
require("awful.autofocus")
require("awful.rules")
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")
-- Widgets
require("vicious")
-- Shifty
-- require("shifty")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.add_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
beautiful.init(".config/awesome/themes/zenburn/theme.lua")
--wallpaper_cmd = { "nitrogen --restore" }
--exec("nitrogen --restore", false)
terminal = "urxvt"
dmenu = "dmenu_run"
--editor = os.getenv("EDITOR") or "nano"
editor = "geany"
--cli_editor = "nano"
editor_cmd = terminal .. " -e " .. editor
fm = "spacefm"
cli_fm = terminal .. " -e ranger"
browser = "luakit"

--paths 
icons           = "/home/dakota/.config/awesome/themes/redhalo/logo/"

-- Default modkey.
modkey = "Mod4"
exec   = awful.util.spawn
sexec  = awful.util.spawn_with_shell
-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
-- awful.layout.suit.tile.bottom,
-- awful.layout.suit.tile.top,
    awful.layout.suit.fair,
-- awful.layout.suit.fair.horizontal,
-- awful.layout.suit.spiral,
-- awful.layout.suit.spiral.dwindle,
-- awful.layout.suit.max,
-- awful.layout.suit.max.fullscreen,
-- awful.layout.suit.magnifier
}
-- }}}

 -- {{{ Tags
 -- Define a tag table which will hold all screen tags.
 tags = {
   names  = { "web", "term", "edit", "misc" },
layout = { layouts[2], layouts[1], layouts[2], layouts[1] 
 }}
 for s = 1, screen.count() do
     -- Each screen has its own tag table.
     tags[s] = awful.tag(tags.names, s, tags.layout)
 end
 -- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu

                    
myawesomemenu = {
-- { "manual", terminal .. " -e man awesome" },
-- { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", awesome.quit },
   { "reboot", "urxvt -e sudo reboot" },
   { "shutdown", "urxvt -e sudo shutdown -h 0" },
   }
   config = {
   -- { "dual monitors", "xrandr --output VGA1 --mode 1280x1024 --right-of LVDS1" },
   -- { "wallpaper", "nitrogen" },
   { "rc.lua", "geany /home/dakota/.config/awesome/rc.lua" },
   { "theme.lua", "geany /home/dakota/.config/awesome/themes/zenburn/theme.lua" },
-- { "conkyrc", "geany /home/dakota/.conkyrc" },
-- { "tint2rc", "geany /home/dakota/.config/tint2/tint2rc"},
   { "bash", "geany /home/dakota/.bashrc" },
   { "zsh", "geany /home/dakota/.zshrc" },
   { "ncmpcpp", "geany /home/dakota/.ncmpcpp/config" },
   { "irssi", "geany /home/dakota/.irssi/config" },
   { "xdefaults", "geany /home/dakota/.Xdefaults" },
   { "xinitrc", "geany /home/dakota/.xinitrc" },
   { "rc", "gksudo geany /etc/rc.conf"},
   { "pacman", "gksudo geany /etc/pacman.conf"},
   { "─────────────────", nil }, -- seperator
   { "lxappearance", "lxappearance" },
   { "vga off", "xrandr --output VGA1 --off" },
   { "vga on", "xrandr --output LVDS1 --auto --output VGA1 --auto --right-of LVDS1" },
   { "wifi", "urxvt -e wicd-curses" },
   --{ "Script Sauvergarde", "urxvt -e sh -c 'sudo /home/Stockage/Projets/Bash/sauvegarde.sh'" }
  
}
 apps = {
   { "browser", "firefox" },
   { "fmanager", function () exec(fm) end},
   { "terminal", terminal },
   { "root fm", "gksudo spacefm" },
-- { "transmission", "transmission-gtk" },
   { "geany", "geany" },
   { "writer", "lowriter" },
   { "─────────────────", nil }, -- seperator
   { "ranger", terminal .. " -e ranger" },
   { "ncmpcpp", terminal .. " -e ncmpcpp" },
   { "mutt", terminal .. " -e mutt" },
   { "irssi", terminal .. " -e irssi" },
   { "rtorrent", terminal .. " -e rtorrent" },
   { "youtube", terminal .. " -e youtube-viewer" },
   { "system monitor", terminal .. " -e htop" },
   

  
}
pentest = {
   { "mtr scan", "urxvt -e /home/dakota/scripts/pentest/mtr.sh" },
-- { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "nmap scan", "urxvt -e sh -c 'cd /home/dakota/scripts/pentest/ ; sudo ./quicknmap.sh'" },
   }

--moc = {
   --{ "Play", "mocp -p" },
   --{ "Pause", "mocp -P" },
   --{ "Prev", "mocp -r" },
   --{ "Next", "mocp -f" },
   --{ "Stop", "mocp -s" }
--}

mymainmenu = awful.menu({ items = {                                     
									{ "awesome", myawesomemenu }, --for icons myawesomemenu, icons .."awesome-blue.png" }
                                    { "apps", apps },
                                    { "config", config },

                                 -- { "MoC-Player", moc },
                                 -- { "─────────────────", nil }, -- seperator
                                    
                                  }
                        })

mylauncher = awful.widget.launcher({ image = image(beautiful.awesome_icon),
                                     menu = mymainmenu })
-- }}}

-- {{{ My widgets
--netwidget = widget({type = "textbox"})
--vicious.register(netwidget, vicious.widgets.net, '<span color="#7F9F7F">D ${eth0 down_kb}</span> <span color="#CC8080">U ${eth0 up_kb}</span>', 3)
--separator = widget({type = "textbox"})
--separator.text = " "

--bat_clo = battery.batclosure("BAT0")
--batterywidget = widget({type = "textbox"})
--batterywidget.text = bat_clo()
--battimer = timer({timeout = 10})
--battimer:add_signal("timeout", function() batterywidget.text = string.format("<span color=\"#ffffff\">%s</span>", bat_clo()) end)
--battimer:start()

--volwidget = widget({ type = "textbox" })
--vicious.register(volwidget, vicious.widgets.volume, '<span color="#4F9F4F">$1%</span>', 1, "Master")
--volicon = widget({ type = "imagebox" })
--volicon.image = image("/home/dakota/.config/awesome/themes/icons/him/vol.png")

-- }}}


-- {{{ Wibox
-- {{{ Reusable separators
spacer = widget({ type = "textbox"  })
spacer.text     = " "
separator = widget({ type = "textbox" })
separator.text  = " | "
-- }}}
 
    fmtstart =  '<span color="'..beautiful.fg_focus..'">'
    fmtend = '</span>'

    mytextclock = awful.widget.textclock({ align = "right" })
   -- Create a battery widget
baticon = widget({ type = "imagebox" })
baticon.image = image("/home/dakota/.config/awesome/themes/icons/him/batw.png")
--Initialize widget
batwidget = widget({ type = "textbox" })
vicious.register(batwidget, vicious.widgets.bat, fmtstart..' Batt: '..fmtend.."$2", 32, "BAT0")

 -- Uptime
  uptimewidget = widget({ type = "textbox" })
  vicious.register(uptimewidget, vicious.widgets.uptime, fmtstart..'   Up: '..fmtend.."$2:$3", 61)


    -- RAM Usage widget                              
    memwidget = widget({ type = "textbox" })
    vicious.register(memwidget, vicious.widgets.mem, fmtstart..' Mem: '..fmtend.."$1% ($2MB)", 10) 
    
    -- SWAP File widget
   -- swapwidget = widget({ type = "textbox" })
    --vicious.register(swapwidget, vicious.widgets.mem, fmtstart..'   Swap : '..fmtend..'$5%', 10)

    -- CPU Usage widget      
    cpuwidget = widget({ type = "textbox" })
    vicious.register(cpuwidget, vicious.widgets.cpu, fmtstart..' Cpu: '..fmtend.."$1%")
    cpuicon = widget({ type = "imagebox" })
    cpuicon.image = image("/home/dakota/.config/awesome/themes/icons/awesome/cpuinfo.png")

    -- Cpu Temp
tempicon = widget({ type = "textbox" })
tempicon.text  = " @ "
--tempicon.image = image("/home/dakota/.config/awesome/themes/icons/sunjack/temp.png")
-- Temp Widget
tempwidget = widget({ type = "textbox" })
vicious.register(tempwidget, vicious.widgets.thermal, "$1C", 9, "thermal_zone0")

-- File System
filewidgetp = widget({ type = "textbox" })
vicious.register(filewidgetp, vicious.widgets.fs, fmtstart..' Hd: '..fmtend.."${/ used_p}%", 180)
filewidget = widget({ type = "textbox" })
vicious.register(filewidget, vicious.widgets.fs, "(${/ used_gb}GB)", 180)
---- Pacman Icon
pacicon = widget({type = "imagebox" })
pacicon.image = image("/home/dakota/.config/awesome/themes/icons/him/pacman.png")
-- Pacman Widget
pacwidget = widget({type = "textbox"})
vicious.register(pacwidget, vicious.widgets.pkg, fmtstart..' Pac: '..fmtend.."$1", 180, "Arch")
                --function(widget,args)
                    --local io = { popen = io.popen }
                    --local s = io.popen("pacman -Qu")
                    --local str = ''
                    --for line in s:lines() do
                        --str = str .. line .. "\n"
                    --end
                    --pacwidget_t:set_text(str)
                    --s:close()
                    --return " " .. args[1]
                --end, 1800, "Arch")
                --'1800' means check every 30 minutes
    
    -- Network Usage widget : Initialise and Register widget
   dnicon = widget({ type = "imagebox" })
   upicon = widget({ type = "imagebox" })
   dnicon.image = image("/home/dakota/.config/awesome/themes/icons/him/downw.png")
   upicon.image = image("/home/dakota/.config/awesome/themes/icons/him/up.png")
    netlabel = widget({ type = "textbox" })
    netlabel.text = fmtstart..'   net : '..fmtend
    netwidget = widget({ type = "textbox" })
    vicious.register(netwidget, vicious.widgets.net, fmtstart..' Net: '..fmtend..'${wlan0 down_kb} ${wlan0 up_kb}', 2)
    --U:${wlan0 up_kb}

-- Create a systray
mysystray = widget({ type = "systray" })

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, awful.tag.viewnext),
                    awful.button({ }, 5, awful.tag.viewprev)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)

    -- Create a tasklist widget
    --mytasklist[s] = awful.widget.tasklist(function(c)
      --                                        return awful.widget.tasklist.label.currenttags(c, s)
        --                                  end, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s })
    -- Add widgets to the wibox - order matters
    mywibox[s].widgets = {
        {
            mylauncher,
            mytaglist[s],
            mypromptbox[s],
            layout = awful.widget.layout.horizontal.leftright
        },
        mylayoutbox[s],
        mytextclock, separator, spacer,
--    batwidget, baticon, spacer,
		batwidget,
        netwidget,
        pacwidget,
        memwidget,
        tempwidget, spacer, cpuwidget,  
        filewidget, spacer, filewidgetp,     
        uptimewidget,
        s == 1 and mysystray or nil,
        --mytasklist[s],
        layout = awful.widget.layout.horizontal.rightleft
        }

end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
--  awful.button({ }, 1, function () sysmenu:toggle() end),    --<<<< Left-Click entry
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),
	awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
  --awful.key({ modkey,           }, "w", function () mymainmenu:show({keygrabber=true}) end),
    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),
        


    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey,           }, "q", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),
	awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),
    awful.key({ modkey, "Control" }, "n", awful.client.restore),
    awful.key({ modkey, "Shift"		  }, "f", function () awful.util.spawn(cli_fm) end),
    awful.key({ modkey,           }, "p", function () awful.util.spawn(dmenu) end),
    awful.key({ modkey,           }, "w", function () awful.util.spawn(browser) end),
    
    -- Prompt
     --awful.key({ modkey         }, "r", function () mypromptbox[mouse.screen]:run() end),
    awful.key({ modkey,           }, "r", 
              function () awful.prompt.run({prompt="Run:"},
                                           mypromptbox[mouse.screen].widget,
                                           check_for_terminal,
                                           clean_for_completion,
                                           awful.util.getdir("cache") .. "/history") end),
    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey,           }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,   
--awful.key({ modkey,           }, "r", 
  --            function () awful.prompt.run({prompt="Run:"},
    --                                       mypromptbox[mouse.screen].widget,
      --                                     check_for_terminal,
        --                                   clean_for_completion,
          --                                 awful.util.getdir("cache") .. "/history") end),
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        if tags[screen][i] then
                            awful.tag.viewonly(tags[screen][i])
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      if tags[screen][i] then
                          awful.tag.viewtoggle(tags[screen][i])
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.movetotag(tags[client.focus.screen][i])
                      end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.toggletag(tags[client.focus.screen][i])
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = true,
                     keys = clientkeys,
                     buttons = clientbuttons } },
    { rule = { class = "MPlayer" },
      properties = { floating = true } },
    { rule = { class = "pinentry" },
      properties = { floating = true } },
    { rule = { class = "gimp" },
      properties = { floating = true } },
    -- Set Firefox to always map on tags number 1 of screen 1.
	{ rule = { class = "Firefox" },
	  properties = { tag = tags[1][1] } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.add_signal("manage", function (c, startup)
    -- Add a titlebar
    -- awful.titlebar.add(c, { modkey = modkey })

    -- Enable sloppy focus
    c:add_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end
end)

client.add_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

--os.execute("tint2 &")
-- {{{ functions to help launch run commands in a terminal using ":" keyword 
--function check_for_terminal (command)
   --if command:sub(1,1) == ":" then
      --command = terminal .. ' -e "' .. command:sub(2) .. '"'
   --end
   --awful.util.spawn(command)
--end
   
--function clean_for_completion (command, cur_pos, ncomp, shell)
   --local term = false
   --if command:sub(1,1) == ":" then
      --term = true
      --command = command:sub(2)
      --cur_pos = cur_pos - 1
   --end
   --command, cur_pos =  awful.completion.shell(command, cur_pos,ncomp,shell)
   --if term == true then
      --command = ':' .. command
      --cur_pos = cur_pos + 1
   --end
   --return command, cur_pos
--end
-- }}}
