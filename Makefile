CXX       := g++
CXXFLAGS  := -std=c++17 -Wall -Wextra -Wpedantic -g -O0
CPPFLAGS  := -Iinclude
LDFLAGS   :=

SRC_DIR   := src
INC_DIR   := include
BUILD_DIR := build

ifeq ($(OS),Windows_NT)
    EXE := .exe
else
    EXE :=
endif

TARGET := $(BUILD_DIR)/emulator$(EXE)

ifneq ($(findstring cmd.exe,$(SHELL)),)
    MKDIR   = if not exist "$(subst /,\,$(1))" mkdir "$(subst /,\,$(1))"
    RMDIR   = if exist "$(subst /,\,$(1))" rmdir /s /q "$(subst /,\,$(1))"
    RUN_CMD = "$(subst /,\,$(TARGET))"
else
    MKDIR   = mkdir -p $(1)
    RMDIR   = rm -rf $(1)
    RUN_CMD = ./$(TARGET)
endif

SRCS := $(wildcard $(SRC_DIR)/*.cpp)
OBJS := $(patsubst $(SRC_DIR)/%.cpp,$(BUILD_DIR)/%.o,$(SRCS))
DEPS := $(OBJS:.o=.d)

all: $(TARGET)

$(TARGET): $(OBJS)
	@$(call MKDIR,$(patsubst %/,%,$(dir $@)))
	$(CXX) $(OBJS) -o $@ $(LDFLAGS)
	@echo Build completed: $(TARGET)

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.cpp
	@$(call MKDIR,$(patsubst %/,%,$(dir $@)))
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -MMD -MP -c $< -o $@

run: all
	$(RUN_CMD) $(ARGS)

clean:
	@$(call RMDIR,$(BUILD_DIR))
	@echo $(BUILD_DIR) removed

rebuild: clean all

-include $(DEPS)

.PHONY: all run clean rebuild
