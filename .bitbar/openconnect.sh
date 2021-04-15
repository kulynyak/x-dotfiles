#!/bin/zsh
# Credit for original concept and initial work to: Jesse Jarzynka, Ventz Petkov

#########################################################
# REQUIREMENTS #
#########################################################

# You should install bitbar, openconnect, vpn-slice, jq:
# brew install bitbar openconnect vpn-slice jq
# put this script into bitbar plugins folder

# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# END-OF-REQUIREMENTS #
#########################################################


#########################################################
# USER CHANGES #
#########################################################

# 1.) Updated your sudo config with (edit "osx-username" with your username):
#osx-username ALL=(ALL) NOPASSWD: /usr/local/bin/openconnect
#osx-username ALL=(ALL) NOPASSWD: /usr/bin/killall -2 openconnect
#osx-username ALL=(ALL) NOPASSWD: /sbin/route
#osx-username ALL=(ALL) NOPASSWD: /usr/local/bin/vpn-slice
#osx-username ALL=(ALL) NOPASSWD: /sbin/ifconfig
# use sudo visudo -f /etc/sudoers.d/sudoers for it

# 2.) Make sure openconnect binary is located here:
#     (If you don't have it installed: "brew install openconnect")
VPN_EXECUTABLE=/usr/local/bin/openconnect

# 3.) Create an encrypted credentials entry in your OS X Keychain:
#      a.) Open "Keychain Access" and
#      b.) Click on "login" keychain (top left corner)
#      c.) Click on "Passwords" category (bottom left corner)
#      d.) From the "File" menu, select -> "New Password Item..."
#      e.) For "Keychain Item Name" use the value for "KEYCHAIN_ITEM_NAME"
#      f.) For "Account Name" - it is up to you, this does not matter
#      g.) For "Password" use minified json string with the following format: 
# {
#  "url":"<vpn host name>",
#  "username":"<vpn username>",
#  "password":"<vpn password>", 
#  "group": "<vpn group>"
# } 


# 3.) Update your Keychain Item Name
KEYCHAIN_ITEM_NAME="work-vpn-credentials"

# 4.) Provide file with list of fqdn names to be resolved on the start
# this should be a list of domain names, one per line
FQDN_LIST_FILE="$HOME/bin/work-vpn.fqdn.txt"

# 5.) Push 2FA (ex: Duo), or Pin/Token (ex: Yubikey, Google Authenticator, TOTP)
PUSH_OR_PIN="push"
#PUSH_OR_PIN="Yubikey"
# ---
# * For Push (and other Duo specifics), options include:
# "push", "sms", or "phone"
# ---
# * For Yubikey/Google Authenticator/other TOTP, specify any name for prompt:
# "any-name-of-product-to-be-prompted-about"
# PUSH_OR_PIN="Yubikey" | PUSH_OR_PIN="Google Authenticator" | PUSH_OR_PIN="Duo"
# (essentially, anything _other_ than the "push", "sms", or "phone" options)
# ---

# This will retrieve that password securely at run time when you connect, and feed it to openconnect
# No storing vpn credentials unenin plain text files! :)
VPN_CREDS=$(security find-generic-password -wl "$KEYCHAIN_ITEM_NAME")

# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# END-OF-USER-SETTINGS #
#########################################################

VPN_INTERFACE="utun20"

# Command to determine if VPN is connected or disconnected
VPN_CONNECTED="/sbin/ifconfig | grep -A3 $VPN_INTERFACE | grep inet"
# Command to run to disconnect VPN
VPN_DISCONNECT_CMD="sudo killall -2 openconnect && sudo ifconfig $VPN_INTERFACE -alias"

# GUI Prompt for your token/key (ex: Duo/Yubikey/Google Authenticator)
function prompt_2fa_method() {
	if [ "$1" == "push" ]; then
		echo "push"
	elif [ "$1" == "sms" ]; then
		echo "sms"
	elif [ "$1" == "phone" ]; then
		echo "phone"
	else
		osascript <<EOF
		tell app "System Events"
			text returned of (display dialog "Enter $1 token:" with hidden answer default answer "" buttons {"OK"} default button 1 with title "$(basename $0)")
		end tell
EOF
	fi
}


case "$1" in
    connect)
        VPN_HOST=$(echo $VPN_CREDS | jq -r '.url')
        VPN_USERNAME=$(echo $VPN_CREDS | jq -r '.username')
        VPN_PASSWORD=$(echo $VPN_CREDS | jq -r '.password')
        VPN_AUTH_GROUP=$(echo $VPN_CREDS | jq -r '.group')  
        DNS_L=$(cat "$FQDN_LIST_FILE" | tr -s "\n" " ")

        # VPN connection command, should eventually result in $VPN_CONNECTED,
        # may need to be modified for VPN clients other than openconnect

        # Connect based on your 2FA selection (see: $PUSH_OR_PIN for options)
        # For anything else (non-duo) - you would provide your token (see: stoken)
        trash $HOME/tmp/vpn-slice.log
        echo -e "${VPN_PASSWORD}" | sudo "$VPN_EXECUTABLE" \
        --user="$VPN_USERNAME" \
        --script="vpn-slice -K --verbose $DNS_L >>$HOME/tmp/vpn-slice.log 2>&1" \
        --authgroup="$VPN_AUTH_GROUP" \
        --passwd-on-stdin \
        -i "$VPN_INTERFACE" \
        "$VPN_HOST" &> /dev/null &
        # echo -e "${VPN_PASSWORD}" | sudo "$VPN_EXECUTABLE" \
        # --user="$VPN_USERNAME" \
        # --authgroup="$VPN_AUTH_GROUP" \
        # --passwd-on-stdin \
        # -i "$VPN_INTERFACE" \
        # "$VPN_HOST" &> /dev/null &
        # Wait for connection so menu item refreshes instantly
        until eval "$VPN_CONNECTED"; do sleep 1; done
        ;;
    disconnect)
        eval "$VPN_DISCONNECT_CMD"
        # Wait for disconnection so menu item refreshes instantly
        until [ -z "$(eval "$VPN_CONNECTED")" ]; do sleep 1; done
        ;;
esac


if [ -n "$(eval "$VPN_CONNECTED")" ]; then
    echo "vpn🔒"
    echo '---'
    echo "Disconnect VPN | bash='$0' param1=disconnect terminal=false refresh=true"
    exit
else
    echo "vpn🚫"
    # Alternative icon -> but too similar to "connected"
    # echo "vpn🔓"
    echo '---'
    echo "Connect VPN | bash='$0' param1=connect terminal=false refresh=true"
    # For debugging!
    # echo "Connect VPN | bash='$0' param1=connect terminal=true refresh=true"
    exit
fi
