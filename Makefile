#
# This is the main file of the game.
# You can create and destroy a new game here.
#


#
# Building containers
#
build:
	fsociety/scripts/make.sh
	docker compose build

#
# Running the game
#
run:
ifdef num
	docker compose up -d --force-recreate --scale fsociety=$(num)
else
	docker compose up -d --force-recreate
endif
	

clean:
	docker compose down -v
	rm -rf fsociety/scripts/build