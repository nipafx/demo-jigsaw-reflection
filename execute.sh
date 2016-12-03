#!/bin/bash

echo " > creating clean directories"
rm -r classes
mkdir classes
rm -r mods
mkdir mods

echo " > creating intruder"
javac9 \
	-d classes/intruder \
	$(find intruder -name '*.java')
jar9 --create \
	--file mods/intruder.jar \
	--main-class intruder.Intruder \
	-C classes/intruder .

echo ""
echo " > running all in unnamed module"
javac9 \
	-p mods \
	-d classes/owner \
	$(find owner -name '*.java')
jar9 --create \
	--file classes/owner.jar \
	-C classes/owner .
java9 \
	-p mods \
	-cp classes/owner.jar:mods/intruder.jar \
	intruder.Intruder
rm -r classes/*

echo ""
echo " > running owner in unnamed module"
javac9 \
	-p mods \
	-d classes/owner \
	$(find owner -name '*.java')
jar9 --create \
	--file classes/owner.jar \
	-C classes/owner .
java9 \
	-p mods \
	-cp classes/owner.jar \
	-m intruder
rm -r classes/*

echo ""
echo " > running owner as automatic module"
javac9 \
	-p mods \
	-d classes/owner \
	$(find owner -name '*.java')
jar9 --create \
	--file mods/owner.jar \
	-C classes/owner .
./run.sh
rm -r classes/* mods/owner.jar

echo ""
echo " > running owner as named module; package exported"
./compileWith.sh "exports"
./run.sh

echo ""
echo " > running owner as named module; package exported to intruder"
./compileWith.sh "exports-qualified"
./run.sh

echo ""
echo " > running owner as named module; package open"
./compileWith.sh "opens"
./run.sh

echo ""
echo " > running owner as named module; package open for intruder"
./compileWith.sh "opens-qualified"
./run.sh

echo ""
echo " > running owner as named module; module open"
./compileWith.sh "open-module"
./run.sh
