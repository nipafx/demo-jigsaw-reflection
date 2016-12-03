#!/bin/bash

cp owner/src/main/java/module-info.java{.$1,}
javac9 \
	-p mods \
	-d classes/owner \
	$(find owner -name '*.java')
rm owner/src/main/java/module-info.java
jar9 --create \
	--file mods/owner.jar \
	-C classes/owner .
