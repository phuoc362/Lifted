


####################################################################################
########################    Chipsseq   #############################################
####################################################################################
####################################################################################

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

cp *.bed  input/
cd input
##########################################  create ID in column 5
for i in `ls *.bed `; do echo $i
awk '{print $1"\t"$2"\t"$3"\t"$4"\t"$1"."$2"."$3}' > ${i/.bed/.bed1}

done
########################################## filter gap hg19 ++>  liftOver ++> filter gap hg38
for i in `ls input/*.bed1 `; do echo $i
bedtool subtract -a <(sort -k1,1 -k2,2n $i) -b process/hg19.gap.and.blacklist.bed > temp
liftOver temp /process/hg19ToHg38.over.chain  process/${i/.bed1/.lo19to38.bed2} ${i/.bed1/.unliftOver}
bedtools subtract -a <(sort ${i/.bed1/.lo19to38.bed2}) -b <(sort -k1,1 -k2,2n process/hg19.between2un-gapped.bed) > ${i/.bed1/.f1.bed2}


########################################## filtered alt chr; duplicate
bedtools merge -i  <(sort -k1,1 -k2,2n ${i/.bed1/.f1.bed2}|grep -E "chr(.|..)[[:blank:]]"|sort -k5,5|uniq -f4 -u|sort -k1,1 -k2,2n) -c 5 -o collapse -delim "_"|awk '{if($5!~"_"){print $0}}'|sort -k1,1 -k2,2n> ${i/.bed1/.f2.bed2}
# filter not cg
bedtools intersect -a ${i/.bed1/.f2.bed2} -b /process/removed.bed -v -wa -f 1 > ${i/.bed1/.lo19to38.filtered.bed}


done

########### remove
rm input/*.bed2
########### transfer file to output
cd ..
mv input/*.lo19to38.filtered.bed  output/
mv input/*.unliftOver	output/





