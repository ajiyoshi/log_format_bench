CAT = cat
RUBY = ruby1.9
DEVNULL = > /dev/null


all: run

run: parse_json parse_tsv parse_s

parse_json: log.json parse_json.rb
	time $(CAT) log.json | $(RUBY) parse_json.rb $(DEVNULL)

parse_s: log.s parse_s.scm
	time $(CAT) log.s | gosh parse_s.scm $(DEVNULL)
	
parse_tsv: log.tsv parse_tsv.rb
	time $(CAT) log.tsv | $(RUBY) parse_tsv.rb $(DEVNULL)

log.tsv: gen.rb
	$(RUBY) gen.rb > $@

log.json: log.tsv json.rb
	cat log.tsv | $(RUBY) json.rb > $@

log.s : log.tsv s.rb
	cat log.tsv | $(RUBY) s.rb > $@

gen: log.json log.s

clean:
	-rm log.*
