# Telegram Empowerifier

<h3>TL;DR</h3>
It doesn't use Bot API. This script is tdcli authorized to your account and watching your messages. It forwards every text message to your Saved Messages, thereby implementing a crude but working Undelete capability. It also watches for markup tags in your messages. Just as you would add **text** to make text bold, you can use ~text~ to mark it up as struck-through.

<h3><b>1. Pseudo Undelete</b></h3>

In reality it forwards all incoming text messages to your contact's chat in Telegram, effectively creating a sequential log of all incoming messages. The authenticity of the messages relies on fwd_from header, which is saved and shown whenever the message is forwarded.

TODO: Add some sort of hash-based way to sort the messages, add a way to configure exclusions. Add checking freshly edited messages for tags. Process multiple tags in one messages (currently doesn't work).

<h3><b>2. Strikethrough markup</b></h3>

The script also parses all messages that are outgoing and have just been delivered. If the message contains text inside ~ ~ tags, the script replaces it with its ̶̶̶s̶̶t̶̶r̶̶i̶̶k̶̶e̶̶s̶̶ ̶̶t̶̶h̶̶r̶̶o̶̶u̶̶g̶̶h̶̶  equivalent by editing the message for you. Currently there is no convenient way to avoid the (edited) mark.

ADDED: Support for UTF8 strikethrough—doesn't properly handle UTF16 as of right now.

TODO: Add more fancy stuff! Add more aliases. Figure out lua_register_function.

<h3><b>Requirements</h3></b>

Make sure your luarocks is set up to use Lua >= 5.2. 

You need the utf8 rock for UTF8 support:

<pre>luarocks install utf8</pre>

The script uses tdcli-1222 or higher from valtman.name/telegram-cli.

On Telegram, message @JsonDumpBot and find out your chat.id; add it to the script.

<h3><b>Usage</h3></b>

<pre>chmod +x ./tdcli-1222
./tdcli-1222 -s script.lua</pre>

(You will need to fully authorize yourself the first time this runs.)

TODO: Switch to MadelineProto!

Binary tdcli-1222 included for build compatibility reasons only, please get a binary you trust.
