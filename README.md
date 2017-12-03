# Telegram-self-bot-for-fancy-stuff

This is basically your regular telegram-cli with a Lua script that takes care of things. In its current revision it does two things:

1. Pseudo Undelete capability.
In reality it forwards all incoming text messages to your contact's chat, effectively creating a sequential log of all incoming messages. The messages are forwarded, preserving the author's name. TODO: Add some sort of hash-based way to sort the messages, add a way to configure exclusions.

2. Strikethrough tag.

The script also parses all messages that are outgoing and have just been delivered. If the message contains text inside ~ ~ tags, the script replaces it with its ̶s̶t̶r̶i̶k̶e̶s̶ ̶t̶h̶r̶o̶u̶g̶h̶ equivalent by editing the message for you. Currently there is no convenient way to avoid the marking the message edited because its id may yet change until it's been delivered.

ADDED: Support for Russian strikethrough

TODO: Add more fancy stuff! Add more aliases. Figure out lua_register_function.

Requirements: 

You will need lua-utf8 built for Lua5.2 or higher. If you're getting Lua errors check that your compiler's includes do not include lua/5.1.

The script uses tdcli-1222.

