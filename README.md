
webサーバのログみたいなものをどんなふうに吐くべきか？
====

以下の３つのフォーマットで試した

* JSON
* LTSV
  * http://stanaka.hatenablog.com/entry/2013/02/05/214833
* S式

パースだけのベンチも微妙なので、以下の様なログ(この例はLTSV)を仮定して、ページごとのPVを集計する。
(ログもどきは gen.rb で生成しており、約1000種類のページIDがあり、300000行のログがあるものとした）

    ts:[unix timestamp] p:[page id]

JSONでは、あるログ１行は次のようになる

    {"ts":1360134080,"p":473}

S式では次のようになる

    ((ts 1360134080)(p 473))


使い方：

    $ make
    ruby1.9 gen.rb > log.tsv
    cat log.tsv | ruby1.9 json.rb > log.json
    time cat log.json | ruby1.9 parse_json.rb > /dev/null
    
    real    0m3.190s
    user    0m2.880s
    sys     0m0.050s
    time cat log.tsv | ruby1.9 parse_tsv.rb > /dev/null
    
    real    0m2.311s
    user    0m2.101s
    sys     0m0.033s
    time cat log.tsv | gosh parse_tsv.scm > /dev/null
    
    real    0m1.544s
    user    0m1.384s
    sys     0m0.039s
    cat log.tsv | ruby1.9 s.rb > log.s
    time cat log.s | gosh parse_s.scm > /dev/null
    
    real    0m1.433s
    user    0m1.212s
    sys     0m0.046s

