P = function(v)
  print(vim.inspect(v))
  return v
end

-- Debug Notification
-- (value, context_message)
DN = function(v, cm)
  local time = os.date '%H:%M'
  local context_msg = cm or ' '
  local msg = context_msg .. ' ' .. time
  require('notify')(vim.inspect(v), 'debug', { title = { 'Debug Output', msg } })
  return v
end

RELOAD = function(...)
  return require('plenary.reload').reload_module(...)
end

R = function(name)
  RELOAD(name)
  return require(name)
end

-- clear nvim-notify notifications history
CH = function()
  local choice = vim.fn.confirm('Clear Notification History?', '&Yes\n&No\n&Cancel')
  if choice == 1 then
    R('notify')
    print 'Notification History Cleared'
  else
    print 'Notification History Remains'
  end
end
