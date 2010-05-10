-- Andrew's widgets all in one place
--
require("vicious")

function get_ip()
	local filedescriptor = io.popen('/home/andrew/scripts/getip.sh')
	local value = filedescriptor:read()
	filedescriptor:close()

	return {value}
end

function get_local_ip()
	local filedescriptor = io.popen('/home/andrew/scripts/getlocalip.sh')
	local value = filedescriptor:read()
	filedescriptor:close()

	return {value}
end

function get_hostname()
	local filedescriptor = io.popen('hostname')
	local value = filedescriptor:read()
	filedescriptor:close()

	return {value}
end

function get_weather()
	local filedescriptor = io.open('/tmp/aw_cache/weathershort')
	if not filedescriptor then
		return {"n/a","n/a"}
	end
	local temperature = filedescriptor:read()
	local situation = filedescriptor:read()
	filedescriptor:close()

	return {temperature, situation}
end

function get_loki()
    local filedescriptor = io.open('/tmp/aw_cache/loki_status')
    if not filedescriptor then
	    return "n/a"
    end
    local loki_status = filedescriptor:read()
    filedescriptor:close()

    local lcolour = beautiful.fg_normal
    if loki_status:match("up") then
        lcolour = beautiful.up_green
    elseif loki_status:match("down") then
        lcolour = beautiful.down_red
    end

    if lcolour == nil then
        lcolour = "#ffffff"
    end

    loki_status_formatted = 'loki : <span color="' .. lcolour .. '">' .. loki_status .. '</span>'

    return {loki_status_formatted}
end

function get_wmail()
	local filedescriptor = io.open('/tmp/aw_cache/unreadcount')
	if not filedescriptor then
		return "?"
	end
	local unread_count = filedescriptor:read()
	filedescriptor:close()

	return {unread_count}
end
local hostname = io.popen('hostname'):read()

-- {{{ General use separators
spacer			= widget({ type = "textbox" })
separator		= widget({ type = "imagebox" })
spacer.text		= " "
separator.image	= image(beautiful.widget_sep)
-- }}}

-- {{{ Battery charge widget
baticon = widget({ type = "imagebox" })
baticon.image = image(beautiful.widget_bat)

batwidget = widget({ type = "textbox" })
vicious.register(batwidget, vicious.widgets.bat, "$1$2% \($3\)", 61, "BAT0")
-- }}}

-- Network usage widget
netwidget = widget({ type = "textbox" })
dnicon = widget({ type = "imagebox" })
upicon = widget({ type = "imagebox" })
dnicon.image = image(beautiful.widget_net)
upicon.image = image(beautiful.widget_netup)
-- Register network usage widget
local interface  = "wlan0"

if hostname == "fenrir" then
    vicious.register(netwidget, vicious.widgets.net,
            '<span color="#CC9393">${wlan0 down_kb}</span> <span color="#7F9F7F">${wlan0 up_kb}</span>', 1)
elseif hostname == "heimdall" then
    vicious.register(netwidget, vicious.widgets.net,
            '<span color="#CC9393">${eth1 down_kb}</span> <span color="#7F9F7F">${eth1 up_kb}</span>', 1)
else 
    vicious.register(netwidget, vicious.widgets.net,
            '<span color="#CC9393">${wlan0 down_kb}</span> <span color="#7F9F7F">${wlan0 up_kb}</span>', 1)
end

--- {{{ Loki status widget
lokiwidget = widget({ type = "textbox" })
vicious.register(lokiwidget, get_loki, "$1", 300)


-- {{{ WiFi widget
if hostname == "bragi" then
    wifiicon = widget ({ type = "imagebox" })
    wifiicon.image = image(beautiful.widget_wifi)
    wifiwidget = widget({ type = "textbox" })
    vicious.register(wifiwidget, vicious.widgets.wifi, "${ssid} ${link}% ${rate} Mbps", 3, interface)
end
-- }}}


-- {{{ CPU usage and temperature
cpuicon = widget({ type = "imagebox" })
cpuicon.image = image(beautiful.widget_cpu)
-- Initialize widgets
cpugraph  = awful.widget.graph()
tzswidget = widget({ type = "textbox" })
-- Graph properties
cpugraph:set_width(40)
cpugraph:set_height(14)
cpugraph:set_background_color(beautiful.fg_off_widget)
cpugraph:set_color(beautiful.fg_end_widget)
cpugraph:set_gradient_angle(0)
cpugraph:set_gradient_colors({ beautiful.fg_end_widget,
   beautiful.fg_center_widget, beautiful.fg_widget
}) -- Register widgets
vicious.register(cpugraph,  vicious.widgets.cpu,     "$1")
vicious.register(tzswidget, vicious.widgets.thermal, "$1C", 19, "thermal_zone0")
-- }}}

--- {{{ Available updates widget
updatewidget = widget({ type = "textbox" })
updateicon = widget({ type = "imagebox" })
updateicon.image = image(beautiful.widget_pacman)
vicious.register(updatewidget, vicious.widgets.pkg, "$1", 600, "Arch")
-- package updates

function get_upg()
    local fp = io.open("/tmp/aw_cache/available_updates")
    if not fp then
        return "?"
    end
    local updates = ""
    updates = fp:read("*all")
    fp:close()

    if updates == "" then
        return "System is up to date"
    else
        return "Available updates:\n\n" .. updates 
    end
end

function popup_pac()
    naughty.notify { text = get_upg(), timeout = 5, hover_timeout = 0.5, position = "top_right", screen = screen.count() }
end

-- buttons
updateicon:buttons(awful.util.table.join(awful.button({ }, 1, popup_pac)))
updatewidget:buttons(awful.util.table.join(awful.button({ }, 1, popup_pac)))

-- --}}}
--
ipwidget = widget ({ type = "textbox" })
vicious.register(ipwidget, get_ip, "remote: $1", 600)
localipwidget = widget ({ type = "textbox" })
vicious.register(localipwidget, get_local_ip, "local: $1", 600)
hostnamewidget = widget ({ type = "textbox" })
vicious.register(hostnamewidget, get_hostname, "$1", 600)
 
weatherwidget = widget ({ type = "textbox" })
vicious.register(weatherwidget, get_weather, "$2, $1°C", 600)
 
wmailwidget = widget ({ type = "textbox" })
vicious.register(wmailwidget, get_wmail, "$1", 120)
wmailicon = widget ({ type = "imagebox" })
wmailicon.image = image(beautiful.widget_mail)

--{{{ MPD now playing widget
mpdwidget = widget({ type = "textbox" })
mpdicon	  = widget({ type = "imagebox" })
mpdicon.image = image(beautiful.widget_phones)
vicious.register(mpdwidget, vicious.widgets.mpd, "[${state}] ${Artist} - ${Album}", 1, {} )
---}}}
--
-- {{{ volume level 
volicon = widget({ type = "imagebox" })
volicon.image = image(beautiful.widget_vol)
volwidget = widget({ type = "textbox" })
--vicious.enable_caching(vicious.widgets.volume)
vicious.register(volwidget, vicious.widgets.volume, "$1%", 1, "Master")
-- Register mouse buttons
volwidget:buttons(awful.util.table.join(
    awful.button({ }, 1, function () exec(terminal .. " -e alsamixer") end),
    awful.button({ }, 2, function () exec("amixer -q set Master toggle") end),
    awful.button({ }, 4, function () exec("amixer -q set Master 2+") end),
    awful.button({ }, 5, function () exec("amixer -q set Master 2-") end)
	))
	-- register on icon also
volicon:buttons(volwidget:buttons())

-- {{{ Memory usage
memicon = widget({ type = "imagebox" })
memicon.image = image(beautiful.widget_mem)
-- Initialize widget
membar = awful.widget.progressbar()
-- Pogressbar properties
membar:set_width(10)
membar:set_height(14)
membar:set_vertical(true)
membar:set_background_color(beautiful.fg_off_widget)
membar:set_border_color(beautiful.border_widget)
membar:set_color(beautiful.fg_widget)
membar:set_gradient_colors({ beautiful.fg_widget,
   beautiful.fg_center_widget, beautiful.fg_end_widget
}) -- Register widget
vicious.register(membar, vicious.widgets.mem, "$1", 13)
memtext = widget({ type = "textbox" })
vicious.register(memtext, vicious.widgets.mem, "RAM: $1%", 9)

-- -- Memory details popup
-- 
-- -- }}}
-- 
-- -- {{{ File system usage
-- fsicon = widget({ type = "imagebox" })
-- fsicon.image = image(beautiful.widget_fs)
-- -- Initialize widgets
-- fs = {
--   r = awful.widget.progressbar(),  h = awful.widget.progressbar(),
--   s = awful.widget.progressbar(),  b = awful.widget.progressbar()
-- }
-- -- Progressbar properties
-- for _, w in pairs(fs) do
--   w:set_width(5)
--   w:set_height(12)
--   w:set_vertical(true)
--   w:set_background_color(beautiful.fg_off_widget)
--   w:set_border_color(beautiful.border_widget)
--   w:set_color(beautiful.fg_widget)
--   w:set_gradient_colors({ beautiful.fg_widget,
--      beautiful.fg_center_widget, beautiful.fg_end_widget
--   }) -- Register buttons
--   w.widget:buttons(awful.util.table.join(
--     awful.button({ }, 1, function () exec("rox", false) end)
--   ))
-- end -- Enable caching
-- vicious.enable_caching(vicious.widgets.fs)
-- ---- Register widgets
-- vicious.register(fs.r, vicious.widgets.fs, "${/ used_p}",            599)
-- --vicious.register(fs.h, vicious.widgets.fs, "${/media/Elements used_p}", 599)
-- if hostname == "fenrir" then
-- 	vicious.register(fs.h, vicious.widgets.fs, "${/home used_p}",599)
-- elseif hostname == "heimdall" then
-- 	--vicious.register(fs.h, vicious.widgets.fs, "${/media/photos used_p}", 599)
-- end
-- }}}
