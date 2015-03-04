#!/bin/sh
exec 2>&1

RUNNER_BASE_DIR=/usr/lib/mongooseim
RUNNER_ETC_DIR=$RUNNER_BASE_DIR/etc
RUNNER_LOG_DIR=$RUNNER_BASE_DIR/log
# Note the trailing slash on $PIPE_DIR/
PIPE_DIR=/tmp/$RUNNER_BASE_DIR/
RUNNER_USER=mongooseim

mongooseim_SO_PATH=$RUNNER_BASE_DIR/lib/mongooseim-2.1.8/priv/lib
mongooseim_CONFIG_PATH=$RUNNER_ETC_DIR/mongooseim.cfg
export mongooseim_SO_PATH
export mongooseim_CONFIG_PATH


# Make sure CWD is set to runner base dir
cd $RUNNER_BASE_DIR

# Make sure log directory exists
mkdir -p $RUNNER_LOG_DIR

# Extract the target node name from node.args
NAME_ARG=`egrep -e '^-s?name' $RUNNER_ETC_DIR/vm.args`
if [ -z "$NAME_ARG" ]; then
    echo "vm.args needs to have either -name or -sname parameter."
    exit 1
fi

# Extract the target cookie
COOKIE_ARG=`grep -e '^-setcookie' $RUNNER_ETC_DIR/vm.args`
if [ -z "$COOKIE_ARG" ]; then
    echo "vm.args needs to have a -setcookie parameter."
    exit 1
fi

# Identify the script name
SCRIPT=mongooseim

# Parse out release and erts info
START_ERL=`cat $RUNNER_BASE_DIR/releases/start_erl.data`
ERTS_VSN=${START_ERL% *}
APP_VSN=${START_ERL#* }

# Add ERTS bin dir to our path
ERTS_PATH=$RUNNER_BASE_DIR/erts-$ERTS_VSN/bin

# Setup command to control the node
NODETOOL="$ERTS_PATH/escript $ERTS_PATH/nodetool $NAME_ARG $COOKIE_ARG"


HEART_COMMAND="$RUNNER_BASE_DIR/bin/$SCRIPT start"
export HEART_COMMAND
mkdir -p $PIPE_DIR
exec $ERTS_PATH/run_erl  $PIPE_DIR $RUNNER_LOG_DIR "exec $RUNNER_BASE_DIR/bin/$SCRIPT console"

#exec /usr/lib/mongooseim/bin/mongooseim console