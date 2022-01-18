objdir = obj
srcdir = src

SRC_PATH = . \
	src
OBJ_PATH = obj
GTEST_PATH = gtest

SRC = $(foreach dir, $(SRC_PATH), $(wildcard $(dir)/*.c))
OBJ = $(patsubst $(srcdir)/%.c, $(objdir)/%.o, $(SRC))
#OBJS = $(patsubst %.c, %.o, $(SRCS))

SRC_GTEST_PATH = gtest \
	src
SRC_GTEST = $(foreach dir, $(SRC_GTEST_PATH), $(wildcard $(dir)/*.c))
SRC_GTEST += $(foreach dir, $(SRC_GTEST_PATH), $(wildcard $(dir)/*.cpp))
# OBJ_GTEST = $(patsubst $(GTEST_PATH)/%,$(OBJ_PATH)/%,$(SRC_GTEST:%.c=%.o))
# OBJ_GTEST = $(patsubst $(GTEST_PATH)/%,$(OBJ_PATH)/%,$(SRC_GTEST:%.cpp=%.o))

CC = gcc
CXX = g++
INCLUDES = -Iinc
LIBS = -lgtest \
    -lpthread \
    -lgtest_main \
	-lmockcpp
CFLAGS = -g -Wall -O0
CTESTFLAGS = -fprofile-arcs \
    -ftest-coverage

target = my_app

all : $(target)

my_app : $(SRC)
	@echo $(SRC)
	@echo $(OBJ)
	$(CC) $^ -o $@ $(INCLUDES) $(CFLAGS)

my_gtest : $(SRC_GTEST)
	@echo $(SRC_GTEST)
	$(CXX) $^ -o $@ $(CFLAGS) $(CTESTFLAGS) $(INCLUDES) $(LIBS)
	./my_gtest
	lcov -d . -t test -o test.info -b . -c
	genhtml -o result test.info

# $(objdir)/%.o : %.c
# 	@echo $^
# 	@echo $@
# 	$(CC) $(CFLAGS) -c $^ -o $@

# $(OBJ_GTEST) : $(SRC_GTEST)
# 	@echo $(SRC_GTEST)
# 	@echo $(OBJ_GTEST)
# 	$(CCC) -c $^ -o $@ $(CFLAGS) $(CTESTFLAGS) $(INCLUDES) $(LIBS)

clean:
	rm my_app

clean_test:
	rm my_gtest
	rm *.gcda
	rm *.gcno
	rm *.info
	rm -rf result/*
	
