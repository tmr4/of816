#!/bin/bash
c:\cc65\ca65 -I ../../inc py65816.s -l py65816.lst
../../build.sh py65816
c:\cc65\ld65 -vm -C py65816.cfg -S 0x8000 py65816.o ../../forth.o -m forth.map -o forth.bin

