# Autogenerated config.py
# Documentation:
#   qute://help/configuring.html
#   qute://help/settings.html

# Uncomment this to still load settings configured via autoconfig.yml
# config.load_autoconfig()

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'file://*')

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'chrome://*/*')

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'qute://*/*')

# Set a reasonable zoom level
config.set('zoom.default','125')
config.set('fonts.hints','bold 12pt monospace')
# config.set('fonts.hints','bold 12pt monospace')

# config.set('content.autoplay',False)

# Bindings for normal mode
config.bind(';M', 'hint url spawn umpv --title=hdmi_qb {hint-url}')
config.bind('<Ctrl-M>', 'spawn umpv --title=hdmi_qb  {url}')
config.bind('J', 'tab-prev')
config.bind('K', 'tab-next')
config.bind('j', 'scroll up')
config.bind('j', 'scroll up', mode='caret')
config.bind('k', 'scroll down')
config.bind('k', 'scroll down', mode='caret')
config.bind('<Alt+q>', 'set-cmd-text -s :quickmark-load -t')
config.bind('<Alt+w>', 'open-editor', mode='insert')
# config.bind('', 'set-cmd-text -s quit --save')
# Bindings for hint mode
# config.bind(';M', 'spawn mpv {hint-url}', mode='hint')
