p STDIN.reduce(Hash.new 0) {|acc, line|
    _ts, ts, _p, p = line.chomp.split(/[:\t]/)
    acc.update({ p => acc[p] + 1})
}
