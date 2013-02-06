CAT = cat
RUBY = ruby1.9

all: run

run: parse_json parse_tsv_with_ruby parse_tsv_with_gauche parse_s

parse_json: log.json parse_json.rb
	time $(CAT) log.json | $(RUBY) parse_json.rb > /dev/null

parse_s: log.s parse_s.scm
	time $(CAT) log.s | gosh parse_s.scm > /dev/null

parse_tsv_with_ruby: log.tsv parse_tsv.rb
	time $(CAT) log.tsv | $(RUBY) parse_tsv.rb > /dev/null

parse_tsv_with_gauche: log.tsv parse_tsv.scm
	time $(CAT) log.tsv | gosh parse_tsv.scm > /dev/null

log.tsv: gen.rb
	$(RUBY) gen.rb > $@

log.json: log.tsv json.rb
	cat log.tsv | $(RUBY) json.rb > $@

log.s : log.tsv s.rb
	cat log.tsv | $(RUBY) s.rb > $@

gen: log.json log.s

clean:
	-rm log.*
