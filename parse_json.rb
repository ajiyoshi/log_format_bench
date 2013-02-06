require 'json'

p STDIN.reduce(Hash.new 0) {|acc, line|
    json = JSON.parse(line)
    unit = json['p']
    acc.update({ unit => acc[unit] + 1 })
} 
