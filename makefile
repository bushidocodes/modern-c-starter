### If you wish to use extra libraries (math.h for instance),
### add their flags here (-lm in our case) in the "LIBS" variable.
LIBS = 

CC		= gcc
CFLAGS  = -std=c11
CFLAGS += -g
# CFLAGS += -DDEBUG
CFLAGS += -Wall
CFLAGS += -Wextra
CFLAGS += -pedantic
CFLAGS += -Werror
CFLAGS += -Wmissing-declarations

TEST_CFLAGS = $(CFLAGS)
TEST_CFLAGS += -DUNITY_SUPPORT_64

ASANFLAGS  = -fsanitize=address
ASANFLAGS += -fno-common
ASANFLAGS += -fno-omit-frame-pointer

SRC_FILES = $(wildcard src/*.c)
TEST_FILES = $(filter-out src/main.c, $(SRC_FILES)) 
TEST_FILES += test/vendor/unity.c test/*.c

.PHONY: test
test: tests.out
	@./build/tests.out
	@rm ./build/tests.out

.PHONY: memcheck
memcheck: test/*.c src/*.c src/*.h
	@mkdir -p ./build
	@$(CC) $(ASANFLAGS) $(CFLAGS) $(SRC_FILES) -o build/memcheck.out $(LIBS)
	@./build/memcheck.out
	@echo "Memory check passed"

.PHONY: clean
clean:
	@rm -rf build/*

tests.out: test/*.c src/*.c src/*.h
	@mkdir -p ./build
	@$(CC) $(TEST_CFLAGS) $(TEST_FILES) -o build/tests.out $(LIBS)

build: clean
	@mkdir -p ./build
	@$(CC) $(CFLAGS) $(SRC_FILES) -o build/main.out $(LIBS)

run: build
	@mkdir -p ./build
	@./build/main.out

format:
	@clang-format -style=file -i src/*

