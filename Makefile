# check https://docs.microsoft.com/en-us/cpp/build/reference/nmake-reference?view=msvc-160
# to simplify
E = c:\cc65
TARGET = forth.bin
P = C:\Users\tmrob\Documents\Projects\Forth\of816\platforms\py65816
O = C:\Users\tmrob\Documents\Projects\Forth\of816\obj
SOURCES = forth.s $P\py65816.s $P\platform-lib.s
OBJECTS = $O\forth.o $O\py65816.o

all : $(TARGET) 

$(TARGET) : $(OBJECTS) $(SOURCES) $P\py65816.cfg inc\config.inc asm\forth-dictionary.s asm\system.s
	$E\ca65 --cpu 65816 -I inc -I platforms\py65816 -g -l py65816.lst -o $O\py65816.o $P\py65816.s
	$E\ca65 --cpu 65816 -I inc -I platforms\py65816 -g -l forth.lst -o $O\forth.o forth.s
	$E\ld65 -vm -o $(TARGET) -m forth.map -Ln forth.sym -C $P\py65816.cfg $(OBJECTS)

