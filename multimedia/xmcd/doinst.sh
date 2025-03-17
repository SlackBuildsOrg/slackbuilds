
CONFIGDIR=
XMCDLIB=
DISCOGDIR=

# Local discography dirs

for newgenre in \
    Blues \
        Classical \
        Country \
        Data \
        Folk \
        Jazz \
        New_Age \
        Reggae \
        Rock \
        Soundtrack \
        Unclassifiable
do
    d=${DISCOGDIR}/${newgenre}/General_${newgenre}
    mkdir -p $d
    chmod 777 $d
done

# Would like to check if common.cfg changed and warn user.
# But sbopkglint doesn't like it.




# # Check to see if common.cfg changed:

# if [ -f $CONFIG.new ]
# then
#     if [ -f $CONFIG ]
#     then
# 	if [ ! diff -q $CONFIG.new $CONFIG ]
# 	then
# 	    echo
# 	    echo NOTICE: $CONFIG changed.
# 	    echo Compare with $CONFIG.new
# 	    echo Resolve differences by hand.
# 	    echo
# 	else
# 	    echo
# 	    echo NOTICE: $CONFIG unchanged.
# 	    echo Can remove $CONFIG.new
# 	    echo
# 	fi
#     else
# 	echo
# 	echo NOTICE: No $CONFIG
# 	echo You probably need to mv $CONFIG.new
# 	echo to $CONFIG
# 	echo
#     fi
# fi

# Generate local discography index files

$XMCDLIB/scripts/genidx

cat << EOF

NOTICE: Before using xmcd/cda for the first time, you must set up the
software by running the following program as root:

     $CONFIGDIR/config.sh

EOF

