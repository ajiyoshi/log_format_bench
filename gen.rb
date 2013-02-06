
pageid = (10 .. 1000).to_a
num = pageid.length

(0 .. 300000).each {|i|
    puts "ts:%d\tp:%d" % [ Time.now, pageid[ rand(num) ] ]
}
