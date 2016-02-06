# the domain name for gettext
PGOAL = drakstats

# perl files to search translatable strings in
PL_FILES = ../drakstats
# C-like files to search translatable strings in
#CFILES = 

POFILES = $(shell ls *.po)
MOFILES = $(POFILES:%.po=%.mo)
LANGS = $(POFILES:%.po=%)

DATADIR = $(PREFIX)/usr/share
LOCALEDIR=$(DATADIR)/locale

all: $(PGOAL).pot $(MOFILES)

%.mo: %.po
	msgfmt -o $@ $<

update_n_merge: $(PGOAL).pot merge

merge:
	@for n in $(POFILES); do \
		echo "Merging $$n"; \
		msgmerge "$$n" $(PGOAL).pot > "$$n"t; \
		mv -f "$$n"t "$$n"; \
	done

$(PGOAL).pot: $(PL_FILES)
	perl_checker -q --generate-pot $(PGOAL).pot $(PL_FILES)

install:
	for l in $(LANGS); do \
		install -d $(LOCALEDIR)/$$l/LC_MESSAGES; \
		install -m 644 $$l.mo $(LOCALEDIR)/$$l/LC_MESSAGES/$(PGOAL).mo; \
	done

clean:
	@rm -rf *.mo $(POFILES:%=%t) $(PGOAL).pot

