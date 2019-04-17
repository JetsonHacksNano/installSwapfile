#!/bin/bash
# 
DRIVE_LABEL=""
function usage
{
    echo "usage: autoMount.sh [ [-l label] | [-h]]"
    echo "  -l | --label  <labelname>   Label to lookup"
    echo "  -h | --help  This message"
}

if [ $# -eq 0 ]
  then
    echo "No arguments supplied"
    usage
    exit 1
fi

while [ "$1" != "" ]; do
    case $1 in
        -l | --label | -L )     shift
                                DRIVE_LABEL=$1
                                ;;
        -h | --help )           usage
                                exit
                                ;;
        * )                     usage
                                exit 1
    esac
    shift
done

echo 'Looking up UUID from the Label:' "$DRIVE_LABEL"

DEVICE_NAME=""
UUID_STRING=""
if [ "$DRIVE_LABEL" != "" ] ; then
   DEVICE_NAME=$(findfs LABEL="$DRIVE_LABEL")
   if [ "$DEVICE_NAME" != "" ] ; then
      echo "Device: " $DEVICE_NAME
      # Lookup UUID
      UUID_STRING=$(findmnt $DEVICE_NAME -o UUID)
      if [ "$UUID_STRING" != "" ] ; then
         UUID_STRING=`echo "$UUID_STRING" | sed -n '1!p'`
         echo "UUID: ""$UUID_STRING"
         # Get the target name (mount path)
         TARGET_STRING=$(findmnt $DEVICE_NAME -o TARGET)
         if [ "$TARGET_STRING" != "" ] ; then
            echo $TARGET_STRING
            TARGET_STRING=`echo "$TARGET_STRING" | sed -n '1!p'`
            echo "Mount Path: ""$TARGET_STRING"
            echo ""
            FSTAB_STRING=`echo "UUID=""$UUID_STRING" "$TARGET_STRING"" auto nosuid,nodev,nofail 0 0"`
            echo "Proposed entry to add to /etc/fstab:"
            echo "$FSTAB_STRING"
            echo ""
            echo "Adding this entry will automate the process of mounting the partion at boot:"
            echo "Device: "$DEVICE_NAME
            echo "UUID: ""$UUID_STRING"
            echo "Path: ""$TARGET_STRING"
            read -p "Would you like to add this entry to /etc/fstab (y/n)? " answer
            case ${answer:0:1} in
               y|Y )
                  echo ""
                  echo "Appending to /etc/fstab"
                  echo "$FSTAB_STRING" | sudo tee -a /etc/fstab
                  # Mount for changes to take effect
                  sudo mount -a
              ;;
               * )
                  echo ""
                  echo "No action taken"
               ;;
            esac
         else
            echo "Unable to locate target mount point"
         fi
      else
         echo "Unable to match " $DEVICE_NAME " with UUID"
         exit 1
      fi
   else
      echo "Unable to match drive label with a currently mounted device. Exiting"
      exit 1
   fi
else
   echo "Please enter a label"
   usage
   exit 1
fi
