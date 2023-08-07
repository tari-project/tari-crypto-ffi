# Copyright 2019. The Tari Project
# SPDX-License-Identifier: BSD-3-Clause

ifeq ($(shell uname),Darwin)
    LDFLAGS := -Ltarget/release/
else
    LDFLAGS := -Ltarget/release/
endif

SRC = libtari
BIN = bin
PWD = $(shell pwd)

CC=cc

CFLAGS   =

clean:
	rm $(SRC)/tari_crypto.h
	rm $(BIN)/demo

$(LIB)/tari_crypto.h target/release/libtari_crypto.a:
	cargo build --release

target/debug/libtari_crypto.a:
	cargo build

$(BIN)/demo: $(LIB)/tari_crypto.h target/release/libtari_crypto.a
	mkdir -p $(BIN)
	$(CC) $(SRC)/demo.c $(LDFLAGS) -ltari_crypto -o $@

demo: $(BIN)/demo

ffi: target/debug/libtari_crypto.a

ffi-release: target/release/libtari_crypto.a
