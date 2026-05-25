### Add extra libraries here (e.g., -lm for math.h)
LIBS =

CC     = gcc
CFLAGS  = -std=c2x
CFLAGS += -g
CFLAGS += -Wall
CFLAGS += -Wextra
CFLAGS += -pedantic
CFLAGS += -Werror
CFLAGS += -Wshadow
CFLAGS += -Wformat=2
CFLAGS += -Wcast-align
CFLAGS += -Wconversion
CFLAGS += -fstack-protector-strong
CFLAGS += -Wmissing-declarations
# CFLAGS += -DDEBUG

ASANFLAGS  = -fsanitize=address,undefined
ASANFLAGS += -fno-common
ASANFLAGS += -fno-omit-frame-pointer

# Unity is vendored and compiled separately to avoid strict-warning noise
UNITY_CFLAGS = -std=c11 -g -DUNITY_SUPPORT_64

TEST_CFLAGS  = -std=c2x
TEST_CFLAGS += -g
TEST_CFLAGS += -Wall
TEST_CFLAGS += -Wextra
TEST_CFLAGS += -pedantic
TEST_CFLAGS += -Werror
TEST_CFLAGS += -Wshadow
TEST_CFLAGS += -Wmissing-declarations
TEST_CFLAGS += -DUNITY_SUPPORT_64

SRC_FILES = $(wildcard src/*.c)
OBJ_DIR   = build/obj
OBJS      = $(patsubst src/%.c, $(OBJ_DIR)/%.o, $(SRC_FILES))
DEPS      = $(OBJS:.o=.d)

TEST_SRC   = $(filter-out src/main.c, $(SRC_FILES))
TEST_UNITS = $(wildcard test/*.c)

.PHONY: all build run test asan format format-check clean

all: build

build: build/main.out

run: build/main.out
	@./build/main.out

test: build/tests.out
	@./build/tests.out

asan: build/asan-tests.out
	@./build/asan-tests.out
	@echo "Address/UB sanitizer check passed"

format:
	@clang-format -style=file -i src/*.c src/*.h test/*.c

format-check:
	@clang-format -style=file --dry-run --Werror src/*.c src/*.h test/*.c

clean:
	@rm -rf build/

build/main.out: $(OBJS)
	@$(CC) $(CFLAGS) $^ -o $@ $(LIBS)

$(OBJ_DIR)/%.o: src/%.c
	@mkdir -p $(OBJ_DIR)
	@$(CC) $(CFLAGS) -MMD -MP -c $< -o $@

build/unity.o: test/vendor/unity.c
	@mkdir -p build
	@$(CC) $(UNITY_CFLAGS) -c $< -o $@

build/unity-asan.o: test/vendor/unity.c
	@mkdir -p build
	@$(CC) $(UNITY_CFLAGS) $(ASANFLAGS) -c $< -o $@

build/tests.out: $(TEST_SRC) $(TEST_UNITS) src/*.h build/unity.o
	@mkdir -p build
	@$(CC) $(TEST_CFLAGS) $(TEST_SRC) $(TEST_UNITS) build/unity.o -o $@ $(LIBS)

build/asan-tests.out: $(TEST_SRC) $(TEST_UNITS) src/*.h build/unity-asan.o
	@mkdir -p build
	@$(CC) $(ASANFLAGS) $(TEST_CFLAGS) $(TEST_SRC) $(TEST_UNITS) build/unity-asan.o -o $@ $(LIBS)

-include $(DEPS)
