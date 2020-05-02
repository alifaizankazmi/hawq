#!/bin/sh

poll_interval=2

code_file=$1

test_file=./tests/$(echo $code_file | rev | cut -d/ f1 | rev)
test_file=${test_file/.q/_test.q}

qunit="[path-to-QUnit]"

echo "          _______           _______          .---.        .---.       "
echo "|\     /|(  ___  )|\     /|(  ___  )        /^^^^^\  __  /^^^^^\      "
echo "| )   ( || (   ) || )   ( || (   ) |       /^^^^^^^\(  )/^^^^^^^\     "
echo "| (___) || (___) || | _ | || |   | |      /^^^^^^^^^ \/ ^^^^^^^^^\    "
echo "|  ___  ||  ___  || |( )| || |   | |     /^^^/     \^^^^/     \^^^\   "
echo "| (   ) || (   ) || || || || | /\| |    /^^/        \^^/        \^^\  "
echo "| )   ( || )   ( || () () || (_\ \ |   /^/          /..\          \^\ "
echo "|/     \||/     \|(_______)|(___\/_)          =====VV==VV=====        "
echo
echo "Started listening to changes for $code_file..."

last_changed=$(date -r $code_file)

while true
do
	sleep $poll_interval

	next_changed=$(date -r $code_file)
	if test "$last_changed" != "$next_changed"
	then
		last_changed=$next_changed
		echo "$code_file was changed at $last_changed"
		echo "Running QUnit for $test_file"
		$qunit -t $test_file
	fi
done
