
webサーバのログみたいなものを、どんなふうに吐くべきか？
====

以下の３つのフォーマットで、試した

* JSON
* LTSV
  * http://stanaka.hatenablog.com/entry/2013/02/05/214833
* S式

パースだけのベンチも微妙なので、以下の様なログ(この例はLTSV)を仮定して、ページごとのPVを集計する。
(ログもどきは gen.rb で生成しており、約1000種類のページIDがあり、300000行のログがあるものとした）

    ts:[unix timestamp] p:[page id]

JSONではあるログ１行は次のようになる

    {"ts":1360134080,"p":473}

S式では次のようになる

    ((ts 1360134080)(p 473))


使い方：

    $ make
    ruby1.9 gen.rb > log.tsv
    cat log.tsv | ruby1.9 json.rb > log.json
    time cat log.json | ruby1.9 parse_json.rb > /dev/null
    
    real    0m2.978s
    user    0m2.772s
    sys     0m0.042s
    time cat log.tsv | ruby1.9 parse_tsv.rb > /dev/null
    
    real    0m2.114s
    user    0m2.002s
    sys     0m0.030s
    cat log.tsv | ruby1.9 s.rb > log.s
    time cat log.s | gosh parse_s.scm > /dev/null
    
    real    0m1.338s
    user    0m1.195s
    sys     0m0.041s
