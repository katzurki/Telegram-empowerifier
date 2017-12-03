function vardump(value, depth, key)
  local linePrefix = ""
  local spaces = ""
  
  if key ~= nil then
    linePrefix = "["..key.."] = "
  end
  
  if depth == nil then
    depth = 0
  else
    depth = depth + 1
    for i=1, depth do spaces = spaces .. "  " end
  end
  
  if type(value) == 'table' then
    mTable = getmetatable(value)
    if mTable == nil then
      print(spaces ..linePrefix.."(table) ")
    else
      print(spaces .."(metatable) ")
        value = mTable
    end   
    for tableKey, tableValue in pairs(value) do
      vardump(tableValue, depth, tableKey)
    end
  elseif type(value)  == 'function' or 
      type(value) == 'thread' or 
      type(value) == 'userdata' or
      value   == nil
  then
    print(spaces..tostring(value))
  else
    print(spaces..linePrefix.."("..type(value)..") "..tostring(value))
  end
end


local lgi = require ('lgi')
local notify = lgi.require('Notify')
notify.init ("Telegram updates")
local utf8 = require('lua-utf8')

chats = {}

function do_notify (user, msg)
  local n = notify.Notification.new(user, msg)
  n:show ()
end

function dl_cb (arg, data)
end

function strike (s)
          --s = string.gsub(s, "[\192-\255][\128-\191]*", "%1" .. utf8.char(822))
          s = string.gsub(s, "[\000-\127]","%1" .. utf8.char(822))
          s = string.gsub(s,"[\192-\255][\128-\191]", "%1" .. utf8.char(822)) 
          s = string.gsub(s,"~","")
          return s
          end

function tdcli_update_callback (data)
  --  vardump(data)

--This is what handles the strikethru editing (plus the function strike above). 
  if(data.ID == "UpdateNewMessage") then
    if((data.message_.send_state_.ID == "MessageIsSuccessfullySent") and (data.message_.can_be_edited_ == true) and (data.message_.sender_user_id_ == my_id)) then
      local editmsg = data.message_
        _, _, textToStrike = string.find(editmsg.content_.text_,"(%b~~)")
        if (textToStrike) then textStruckthru = strike(textToStrike) 
        editmsg.content_.text_ = string.gsub(editmsg.content_.text_,textToStrike,textStruckthru)
   tdcli_function ({ID="EditMessageText", chat_id_=editmsg.chat_id_, message_id_=editmsg.id_, reply_markup_=nil, input_message_content_={ID="InputMessageText", text_=editmsg.content_.text_, disable_web_page_preview_=1, clear_draft_=0,entities_ = {}, parse_mode_=editmsg.parse_mode_}}, dl_cb, nil)
   end
 end
 end

--This is the forwarder / messagekeeper / notifier
  if (data.ID == "UpdateNewMessage") then
    local msg = data.message_
    local d = data.disable_notification_
    local chat = chats[msg.chat_id_]

    if ((not d) and chat) then
      if msg.content_.ID == "MessageText" then
        do_notify (chat.title_, msg.content_.text_)
      else
        do_notify (chat.title_, msg.content_.ID)
      end
    end


    if msg.content_.ID == "MessageText" then
       tdcli_function ({ID="SendMessage", chat_id_=my_id, reply_to_message_id_=msg.id_, disable_notification_=0, from_background_=1, reply_markup_=nil, input_message_content_={ID="InputMessageForwarded", from_chat_id_=msg.chat_id_, message_id_=msg.id_, in_game_share_=0 }}, dl_cb, nil)    
    end
  elseif (data.ID == "UpdateChat") then
    chat = data.chat_
    chats[chat.id_] = chat
  elseif (data.ID == "UpdateOption" and data.name_ == "my_id") then
    tdcli_function ({ID="GetChats", offset_order_="9223372036854775807", offset_chat_id_=0, limit_=20}, dl_cb, nil)    
  end
end
