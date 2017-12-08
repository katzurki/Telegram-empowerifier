# Telegram-self-empowerifier

There are bots and the Bot API, and there are regular user accounts that can be made to act like bots. In fact, setting up your main account as a user bot allows you some enhanced functionality (more like dirty hacks). Right now it allows you to sort of Undelete deleted messages, and to add Strikethrough capability to the standard markup options.

<h3><b>1. Pseudo Undelete</b></h3>

In reality it forwards all incoming text messages to your contact's chat in Telegram, effectively creating a sequential log of all incoming messages. The authenticity of the messages relies on fwd_from header, which is saved and shown whenever the message is forwarded.

TODO: Add some sort of hash-based way to sort the messages, add a way to configure exclusions. Add checking freshly edited messages for tags. Process multiple tags in one messages (currently doesn't work).

<h3><b>2. Strikethrough markup</b></h3>

The script also parses all messages that are outgoing and have just been delivered. If the message contains text inside ~ ~ tags, the script replaces it with its ̶s̶t̶r̶i̶k̶e̶s̶ ̶t̶h̶r̶o̶u̶g̶h̶ equivalent by editing the message for you. Currently there is no convenient way to avoid the (edited) mark.

ADDED: Support for UTF8 strikethrough

TODO: Add more fancy stuff! Add more aliases. Figure out lua_register_function.

<h3><b>Requirements</h3></b>

You will need lua-utf8 built for Lua5.2 or higher. Currently, luarocks seems to want to compile it with lua5.1 headers. I just did it manually.

The script uses tdcli-1222 from valtman.name/telegram-cli.

<h3><b>Usage</h3></b>

On Telegram, message @JsonDumpBot and find out your chat.id; add it to the script.

<pre>chmod +x ./tdcli-1222
./tdcli-1222 -s script.lua</pre>

(You will need to fully authorize yourself the first time.)

TODO: Switch to MadelineProto!

Binary tdcli-1222 included for build compatibility reasons only, please get a binary you trust.
