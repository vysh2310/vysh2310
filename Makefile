CPPC = g++
CPPFLAGS = -I ./includes
SCRS = main.cpp board.cpp die.cpp game.cpp player.cpp square.cpp go_square.cpp property_square.cpp other_square.cpp lot_square.cpp railroad_square.cpp utility_square.cpp
DEPS =
ODIR = objects

OBJ = main.o board.o die.o \
	game.o player.o square.o go_square.o \
	property_square.o other_square.o \
	lot_square.o railroad_square.o \
	utility_square.o

%.o: %.c
	$(CPPC) -c -o $@ $< $(CPPFLAGS)

all: $(OBJ)
	$(CPPC) $(CPPFLAGS) -o main.exe $^ -enable-auto-import

.PHONY: clean

clean:
	rm -f *.o main.exe
