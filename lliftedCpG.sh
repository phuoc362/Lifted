

################################################################################
########################    CpGs less conservative  #############################################
################################################################################
################################################################################
#### required  hg19.bgap.tgap.and.blacklist.bed file
#### required remove.notcg.bed; hg19.between2un-gapped.bed files
#### required hg19ToHg38.over.chain file
#### required liftOver tools

### input
bedpath=$1
outputmap=$2
outputunmap=$3

# format bed file with 4 column:  chromosome_start_end_value
awk '{print $1"\t"$2"\t"$3"\t"$4}' $bedpath| sort -k1,1 -k2,2n  >temp0

# filtered blacklist and gap(gapped-in-hg19, gapped-in-both and blacklist)
bedtools subtract -a temp0 -b hg19.bgap.tgap.and.blacklist.bed > temp

## liftover
liftOver temp hg19ToHg38.over.chain temp2 $outputunmap

### filter gap in hg38, not cg, duplicates
sort -k1,1 -k2,2n temp2 > temp02
cat remove.notcg.bed  hg19.between2un-gapped.bed|sort -k1,1 -k2,2n > temp03
bedtools intersect -a temp02 -b temp03 -v > temp3

#### filter alt chr
sort -k1,1 -k2,2n temp3|grep -E "chr(.|..)[[:blank:]]"|sort -k1,1 -k2,2n > $outputmap

rm temp*
