PACKAGE = drakstats
VERSION = 0.23.1

NAME = drakstats
SUBDIRS = po
localedir = $(prefix)/usr/share/locale

PREFIX = /
DATADIR = $(PREFIX)/usr/share
ICONSDIR = $(DATADIR)/icons
PIXDIR = $(DATADIR)/$(NAME)
BINDIR = $(PREFIX)/usr/bin
SBINDIR = $(PREFIX)/usr/sbin

localedir = $(PREFIX)/usr/share/locale
override CFLAGS += -DPACKAGE=\"$(NAME)\" -DLOCALEDIR=\"$(localedir)\"

all: drakstats
	for d in $(SUBDIRS); do ( cd $$d ; make $@ ) ; done

clean:
	$(MAKE) -C po $@
	rm -f core .#*[0-9]
	for d in $(SUBDIRS); do ( cd $$d ; make $@ ) ; done
	find . -name '*~' | xargs rm -f

install: all
	$(MAKE) -C po $@
	install -d $(PREFIX)/usr/{sbin,share/{$(NAME)/pixmaps,icons/{large,mini,hicolor/{16x16,32x32,48x48}/apps}},lib/libDrakX/network}
	install -m755 $(NAME) $(SBINDIR)
	install -m644 icons/$(NAME)16.png $(ICONSDIR)/mini/$(NAME).png
	install -m644 icons/$(NAME)32.png $(ICONSDIR)/$(NAME).png
	install -m644 icons/$(NAME)48.png $(ICONSDIR)/large/$(NAME).png
	install -m644 icons/$(NAME)16.png $(ICONSDIR)/hicolor/16x16/apps/$(NAME).png
	install -m644 icons/$(NAME)32.png $(ICONSDIR)/hicolor/32x32/apps/$(NAME).png
	install -m644 icons/$(NAME)48.png $(ICONSDIR)/hicolor/48x48/apps/$(NAME).png
	install -m644 icons/$(NAME)_banner.png $(DATADIR)/$(NAME)/pixmaps/
	for d in $(SUBDIRS); do ( cd $$d ; make $@ ) ; done

dist: cleandist copy tar

cleandist:
	rm -rf $(PACKAGE)-$(VERSION) ../$(PACKAGE)-$(VERSION).tar.bz2

copy: clean
	svn export -q -rBASE . $(PACKAGE)-$(VERSION)
	find $(PACKAGE)-$(VERSION) -type d -name .svn|xargs rm -rf 

tar:
	tar cvf ../$(PACKAGE)-$(VERSION).tar $(PACKAGE)-$(VERSION)
	bzip2 -9vf ../$(PACKAGE)-$(VERSION).tar
	rm -rf $(PACKAGE)-$(VERSION)

.PHONY: ChangeLog log changelog

log: ChangeLog

changelog: ChangeLog

ChangeLog:
	svn2cl --accum --authors ../../soft/common/username.xml
	rm -f *.bak
