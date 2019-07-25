#!/bin/sh

MAIL_RELAY=
MAIL_PORT=25
MAIL_SUBJECT=
MAIL_SENDER=
RELAY_USER=
RELAY_PASSWORD=

mail(){
echo "$MAIL_BODY" | mailx \
-r "$MAIL_SENDER" \
-s "$MAIL_SUBJECT" \
-S smtp="$MAIL_RELAY:$MAIL_PORT" \
-S smtp-auth=login \
-S smtp-auth-user="$RELAY_USER" \
-S smtp-auth-password="$RELAY_PASSWORD" \
-S ssl-verify=ignore \
$MAIL_RECPT
}

usage(){
echo 'This is a mail script to send emails via mailx using an external email relay.
Script usage:

   s - Mail subject
   b - The body/content of the email
   r - The recipient e-mail address
'
}

while getopts 's:b:r:' option
do
  case $option in
    s) MAIL_SUBJECT=$OPTARG ;;
    b) MAIL_BODY=$OPTARG ;;
    r) MAIL_RECPT=$OPTARG ;;
    ?) usage && exit 0 ;;
  esac
done

mail
EXIT_CODE=$?

exit $EXIT_CODE
