

################################################################################
########################    CpGs   #############################################
################################################################################
################################################################################


mkdir input output process

mv hg19.between2un-gapped.bed process/
mv blacklist.hg19.bed process/
mv hg19.gap.and.blacklist.bed process/
mv remove.bed process/
########################################## input filename in bed file ; have 4 column with chr, start, end, value
##########################################
# for i in `ls *.bed *.bedGraph`; do echo $i
# awk 'NF==4{print "input have 4 columns"}else {print "stop run"}' $i  ?
# done

mv *.bed  input/

##########################################  length of CpGs =1 nu
########################################## filter gap hg19 ++>  liftOver ++> filter gap hg38
for i in `ls input/*.bed `; do echo $i
bedtools subtract -a <( sort -k1,1 -k2,2n $i ) -b process/hg19.gap.and.blacklist.bed > temp
liftOver temp hg19ToHg38.over.chain  ${i/.bed/.lo19to38.bed1} ${i/.bed/.unliftOver}
bedtools subtract -a <(sort ${i/.bed/.lo19to38.bed1}) -b <(sort -k1,1 -k2,2n process/hg19.between2un-gapped.bed) > ${i/.bed/.f1.bed1}
 
##########################################  filtered alt chr; duplicate
sort -k1,1 -k2,2n ${i/.bed/.f1.bed1}|grep -E "chr(.|..)[[:blank:]]"|awk '{print $0"\t"$1"."$2"."$3}'|sort -k5,5|uniq -f4 -u|sort -k1,1 -k2,2n|awk '{print $1"\t"$2"\t"$3"\t"$4}' > ${i/.bed/.f2.bed1}

# filter not cg
bedtools intersect -a ${i/.bed/.f2.bed1} -b process/remove.bed -v -wa -f 1 > ${i/.bed/.filtered.bed}
#

done

###########
rm input/*.bed1
########### 

mv input/*.lo19to38.filtered.bed  output/
mv input/*.unliftOver	output/
















