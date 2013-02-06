STDIN.each {|line|
    _ts, ts, _t, u = line.chomp.split(/[\t:]/)
    puts '((ts %s)(p %s))' % [ts, u]
}
