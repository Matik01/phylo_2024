# Zaire ebolavirus 2014 phylogenetic
### Сначала было отобрано 10 образцов из базы данных NCBI: https://www.ncbi.nlm.nih.gov/popset/?term=661348595, а именно:
	KM034563.1 Zaire ebolavirus isolate Ebola virus/H.sapiens-wt/SLE/2014/Makona-G3687.1, complete genome
	KM034562.1 Zaire ebolavirus isolate Ebola virus/H.sapiens-wt/SLE/2014/Makona-G3686.1, complete genome
	KM034561.1 Zaire ebolavirus isolate Ebola virus/H.sapiens-wt/SLE/2014/Makona-G3683.1, complete genome
	KM034560.1 Zaire ebolavirus isolate Ebola virus/H.sapiens-wt/SLE/2014/Makona-G3682.1, complete genome
	KM034559.1 Zaire ebolavirus isolate Ebola virus/H.sapiens-wt/SLE/2014/Makona-G3680.1, complete genome
	KM034558.1 Zaire ebolavirus isolate Ebola virus/H.sapiens-wt/SLE/2014/Makona-G3679.1, complete genome
	KM034557.1 Zaire ebolavirus isolate Ebola virus/H.sapiens-wt/SLE/2014/Makona-G3677.2, complete genome
	KM034556.1 Zaire ebolavirus isolate Ebola virus/H.sapiens-wt/SLE/2014/Makona-G3677.1, complete genome
	KM034555.1 Zaire ebolavirus isolate Ebola virus/H.sapiens-wt/SLE/2014/Makona-G3676.2, complete genome
	KM034554.1 Zaire ebolavirus isolate Ebola virus/H.sapiens-wt/SLE/2014/Makona-G3676.1, complete genome

### В качестве outgroup отобраны образцы из Гвинеи 2014 года:
	KR534507.1
	KR534508.1
	KR534509.1
### Маркерные последовательности: gene=NP и gene=VP3
После скачивания устанавливаем необходимый софт:
```
sudo dpkg -i mafft_7.526-1_amd64.deb 
conda create --name phylogen
conda install bioconda::fasttree -y
```
Запускаем MAFFT
```
cat data/gin/*.fasta >> all.fasta
cat data/sl/*.fasta >> all.fasta
mafft --auto all.fasta > ebola_align.fasta
```
Запускаем FastTree
```
FastTree -gtr -boot 1000 -quote -nt ebola_align.fasta > ebola.newick
```
### Визуализация iTol:
![](tree_viz.svg)

### Анализ
Ген нуклеопротеина (NP) для двух видов вируса из Гвинеи и Сиерры-Лиона разошёлся раньше и они близки между собой по стру
ктуре. В общем можно сказать, что ген NP мутировал меньше, чем VP35. В особенности, если проанализировать все идентифика
торы, то можно увидеть, что гены VP35 (белок полимеразы) из разных видов сформировали единый клад. Что может указывать н
а решающую роль в развитии эпидемии в регионе.
Данные из UNIPROT не могут значительно указать на структурные изменения белков между разными генами, так как большая час
ть последовательности никак не аннотирована.

## Альтернативный пайплайн с MrBayes:
Конвертируем FASTA в Nexus-формат с помощью seqmagick
Установка:
```
conda create --name seqmagick python=3.10
conda activate seqmagick
pip install seqmagick
```
Использование:
```
seqmagick convert --output-format nexus --alphabet dna ebola_align.fasta ebola_align.nex
```
Форматируем ID сиквенсов для запуска MrBayes:
```
sed 's/lcl|//g' ebola_align.nex > formatted_align.nex
```
Устанавливаем MrBayes по инструкции на GitHub.
Подбор параметров MrBayes:
```
execute formatted_align.nex
outgroup KR534507.1_cds_AKG65094.1_1
mcmcp ngen=1000000 nruns=2 nchains=2 samplefreq=200 burninfrac=0.2
```
Запуск MrBayes:
```
mcmc
sump
sumt
```
### Визуализация ITol:
![](mrbayes_tree.svg)

# Анализ:
В целом, MrBayes показал похожую картину, где ген NP находится в единых кладах и указывает на возможную решающую роль в развитии эпидемии в Сиерре-Лионе. Также интересно, что он сформировал клады между двумя генами внутри одного вида, как например, KM034560.1 или KM034562.1. Также между видами из Гвинеи KR534508.1 и KR534507.1 образовали клад между генами NP и VP35, соответственно. 
