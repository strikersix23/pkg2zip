BIN=pkg2zip
SRC=pkg2zip.c pkg2zip_aes.c pkg2zip_crc32.c pkg2zip_out.c pkg2zip_psp.c pkg2zip_sys.c pkg2zip_zip.c pkg2zip_zrif.c miniz_tdef.c puff.c
OBJ=${SRC:.c=.o}
DEP=${SRC:.c=.d}

CFLAGS=-std=c99 -pipe -fvisibility=hidden -Wall -Wextra -Werror -DNDEBUG -D_GNU_SOURCE -O2
LDFLAGS=-s

.PHONY: all clean

all: ${BIN}

clean:
	@${RM} ${BIN} ${OBJ} ${DEP}

${BIN}: ${OBJ}
	@echo [L] $@
	@${CC} ${LDFLAGS} -o $@ $^

%.o: %.c
	@echo [C] $<
	@${CC} ${CFLAGS} -MMD -c -o $@ $<

-include ${DEP}
