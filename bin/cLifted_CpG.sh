

################################################################################
########################    CpGs conservative  #############################################
################################################################################
################################################################################
#### bedtools
#### required liftOver tools
### input
bedpath=$1
chainfile=$2
outputmap=$3
outputunmap=$4
rm temp*
# format bed file with 4 column:  chromosome_start_end_value
awk '{print $1"\t"$2"\t"$3"\t"$4}' $bedpath| sort -k1,1 -k2,2n  >temp0

# filtered blacklist and gap(gapped-in-hg19, gapped-in-both and blacklist)
bedtools subtract -a temp0 -b Lifted/data/hg19.gapped-in-hg38.bed|sort -k1,1 -k2,2n > temp001
bedtools subtract -a temp001 -b Lifted/data/gapped-in-both.bed|sort -k1,1 -k2,2n > temp002
bedtools subtract -a temp002 -b Lifted/data/blacklist.hg19.bed|sort -k1,1 -k2,2n > temp1
rm temp0*

## liftover
liftOver temp1 chainfile temp2 $outputunmap

### filter gap in hg38, not cg, duplicates
sort -k1,1 -k2,2n temp2 > temp20
cat Lifted/data/notCG.bed Lifted/data/gapped-in-hg38.bed Lifted/data/duplication.bed|sort -k1,1 -k2,2n > temp21
bedtools intersect -a temp20 -b temp21 -v > temp3

#### filter alt chr
sort -k1,1 -k2,2n temp3|grep -E "chr(.|..)[[:blank:]]"|sort -k1,1 -k2,2n > $outputmap

rm temp*
