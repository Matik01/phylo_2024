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
![]("tree_viz.svg")
