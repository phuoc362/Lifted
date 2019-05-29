################################################################################
########################    Chipseq   #############################################
################################################################################
################################################################################
#### required  hg19.bgap.tgap.and.blacklist.bed file
#### required  hg19.between2un-gapped.bed file
#### required hg19ToHg38.over.chain file
#### required liftOver tools



### input
bedpath=$1
outputmap=$2
outputunmap=$3



# format bed file with 4 column: chromosome_start_end_value
awk '{print $1"\t"$2"\t"$3"\t"$4"\t"$1"."$2"."$3}' $bedpath| sort -k1,1 -k2,2n  >temp0

# filtered blacklist and gap(gapped-in-hg19, gapped-in-both and blacklist)
bedtools subtract -a temp0 -b hg19.bgap.tgap.and.blacklist.bed > temp

## liftover
liftOver temp hg19ToHg38.over.chain temp1 $outputunmap

### filter gap in hg38 
sort -k1,1 -k2,2n temp1 > temp01
bedtools intersect -a temp01 -b hg19.between2un-gapped.bed -v > temp2

#### filter  duplicate, alt chromosome
sort -k1,1 -k2,2n temp2|grep -E "chr(.|..)[[:blank:]]"|sort -k5,5|uniq -f4 -u|sort -k1,1 -k2,2n > temp002
bedtools merge -i  temp002 -c 5 -o collapse -delim "_" > temp003
awk '{if($5!~"_"){print $0}}' temp003|sort -k1,1 -k2,2n > $outputmap


rm temp*



















