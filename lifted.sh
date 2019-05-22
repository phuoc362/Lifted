################################################################################
########################    CpGs   #############################################
################################################################################
################################################################################
### nhan bien , nhan file bed = cach ? 
bedpath=$1
outputmap=$2
outputunmap=$3

### filter input

# blacklist and gap(2 gap)
awk '{print $1"\t"$2"\t"$3"\t"$4"\t"$1"."$2"."$3}' $bedpath| sort -k1,1 -k2,2n  >temp0
bedtools subtract -a temp0 -b hg19.bgap.tgap.and.blacklist.bed > temp
## lifftover
liftOver temp hg19ToHg38.over.chain temp1 $outputunmap
### filter gap in hg38, remove in full CPGs
sort -k1,1 -k2,2n temp1 > temp01
sort -k1,1 -k2,2n hg19.between2un-gapped.bed > temp02
bedtools intersect -a temp01 -b temp02 -v > temp2
#### filter not cg, duplicate, alt chr
sort -k1,1 -k2,2n temp2|grep -E "chr(.|..)[[:blank:]]"|sort -k5,5|uniq -f4 -u|sort -k1,1 -k2,2n > temp002
bedtools merge -i  temp002 -c 5 -o collapse -delim "_" > temp003
awk '{if($5!~"_"){print $0}}' temp003|sort -k1,1 -k2,2n > $outputmap


rm temp*





## kiem tra length thay doi, them filter duplication, chr_, 


# chay thu full cpgs
# chay chipseq ESRR1
# so sanh ket qua: so Cpgs, so length, ..... doc tren bai viet so sanh voi segment


# y nhu hinh so 3
# esrr1 hinh 7,8

















