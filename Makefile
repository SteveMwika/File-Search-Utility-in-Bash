# Makefile for myfind.sh

# Compiler and flags
SHELL := /bin/bash
SCRIPT_NAME := Source

# Define phony targets
.PHONY: all clean run

# Default target
all: $(SCRIPT_NAME)

# Target to create the script
$(SCRIPT_NAME): $(SCRIPT_NAME).sh
	@install -m 755 $< $@
	@cp $< $@ && chmod +x $@

# Target to clean up 
clean:
	@rm -f $(SCRIPT_NAME)

# Target to run the script with an example
run: $(SCRIPT_NAME)
	@./$(SCRIPT_NAME) /path/to/search -name filename.txt
