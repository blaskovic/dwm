# dwm - dynamic window manager
# See LICENSE file for copyright and license details.

include config.mk

SRC = dwm.c
OBJ = ${SRC:.c=.o}

all: options dwm

options:
	@echo dwm build options:
	@echo "CFLAGS   = ${CFLAGS}"
	@echo "LDFLAGS  = ${LDFLAGS}"
	@echo "CC       = ${CC}"

.c.o:
	@echo CC $<
	@${CC} -c ${CFLAGS} $<

${OBJ}: config.h config.mk

config.h:
	@echo creating $@ from config.def.h
	@cp config.def.h $@

dwm: ${OBJ}
	@echo CC -o $@
	@${CC} -o $@ ${OBJ} ${LDFLAGS}

clean:
	@echo cleaning
	@rm -f dwm ${OBJ} dwm-${VERSION}.tar.gz

dist: clean
	@echo creating dist tarball
	@mkdir -p dwm-${VERSION}
	@cp -R LICENSE Makefile README config.def.h config.mk \
		dwm.1 ${SRC} dwm-${VERSION}
	@tar -cf dwm-${VERSION}.tar dwm-${VERSION}
	@gzip dwm-${VERSION}.tar
	@rm -rf dwm-${VERSION}

install: all
	@echo
	@echo ":: [ DWM core ] ::"
	@echo installing executable file to ${DESTDIR}${PREFIX}/bin
	@mkdir -p ${DESTDIR}${PREFIX}/bin
	@cp -f dwm ${DESTDIR}${PREFIX}/bin
	@chmod 755 ${DESTDIR}${PREFIX}/bin/dwm
	@echo installing manual page to ${DESTDIR}${MANPREFIX}/man1
	@mkdir -p ${DESTDIR}${MANPREFIX}/man1
	@sed "s/VERSION/${VERSION}/g" < dwm.1 > ${DESTDIR}${MANPREFIX}/man1/dwm.1
	@chmod 644 ${DESTDIR}${MANPREFIX}/man1/dwm.1
	@echo
	@echo ":: [ DWM session  ] ::"
	@echo installing dwm.desktop to ${XSESSIONS}
	@cp -f scripts/dwm.desktop ${XSESSIONS}/dwm.desktop
	@echo installing dwm-personalized to ${DESTDIR}${PREFIX}/bin
	@cp -f scripts/dwm-personalized ${DESTDIR}${PREFIX}/bin
	@chmod 755 ${DESTDIR}${PREFIX}/bin/dwm-personalized
	@echo
	@echo ":: [ DWM-PANEL ] ::"
	@echo installing dwm-panel service to /etc/init.d/
	@cp -f dwm-panel/dwm-panel /etc/init.d/dwm-panel
	@cp -f dwm-panel/dwm-panel-cycle /etc/init.d/dwm-panel-cycle
	@chmod +x /etc/init.d/dwm-panel /etc/init.d/dwm-panel-cycle
	@echo
	@echo ":: [ SCRIPTS ] ::"
	@echo "Installing 'open-browser.sh' to ${PREFIX}/bin/open-browser.sh"
	@sed "s/WEB_BROWSER/${WEB_BROWSER}/g" < scripts/open-browser.sh > ${DESTDIR}${PREFIX}/bin/open-browser.sh
	@echo "Installing 'dwm-menu.sh' to ${PREFIX}/bin/dwm-menu.sh"
	@cp -f scripts/dwm-menu.sh ${DESTDIR}${PREFIX}/bin/dwm-menu.sh
	@echo
	@echo ":: [ SCRIPTS - permissions ] ::"
	@chmod +x ${DESTDIR}${PREFIX}/bin/open-browser.sh
	@chmod +x ${DESTDIR}${PREFIX}/bin/dwm-menu.sh


uninstall:
	@echo "Warning! This script is not reliable - does NOT remove all files."
	@echo removing executable file from ${DESTDIR}${PREFIX}/bin
	@rm -f ${DESTDIR}${PREFIX}/bin/dwm
	@echo removing manual page from ${DESTDIR}${MANPREFIX}/man1
	@rm -f ${DESTDIR}${MANPREFIX}/man1/dwm.1

.PHONY: all options clean dist install uninstall
