CC := clang++
CC_FLAGS := -Wall -Wextra -Wpedantic -std=c++17

BIN := bin/
DEP := ${BIN}deps/
INC := include/
INT := ${BIN}ints/
SRC := src/

SRCS := $(wildcard ${SRC}*.cpp)
OBJS = $(patsubst ${SRC}%.cpp,${INT}%.o,${SRCS})
DEPS = $(patsubst ${INT}%.o,${DEP}%.d,${OBJS})

.PHONY: all
all: ${OBJS}
	${CC} ${CC_FLAGS} -I${INC} $^

-include $(DEPS)
${DEP}%.d: ${SRC}%.cpp
	${eval b = $(notdir $(basename $@))}
	${CC} ${CC_FLAGS} -I${INC} $< -MM -MT ${INT}$b.o >$@
${INT}%.o: ${SRC}%.cpp
	${CC} ${CC_FLAGS} -I${INC} $< -o $@ -c

.PHONY: clean
clean: ${DEPS} ${OBJS}
	rm $^
