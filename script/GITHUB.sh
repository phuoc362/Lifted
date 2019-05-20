

####################################################################################
########################    CpGs   #############################################
####################################################################################
####################################################################################


mkdir input output process
mv <(hg19.between2un-gapped.bed hg19.bgapped.bed hg19.tgapped.bed hg38.between2un-gapped.bed hg38.bgapped.bed hg38.tgapped.bed blacklist.hg19.bed blacklist.hg38.bed) /process/ 
########################################## input filename in bed file ; have 4 column with chr, start, end, value
##########################################
# for i in `ls *.bed *.bedGraph`; do echo $i
# awk 'NF==4{print "input have 4 columns"}else {print "stop run"}' $i  ?
# done

mv *.bed  input/
cd input
##########################################  length of CpGs =1


########################################## filter gap hg19 ++>  liftOver ++> filter gap hg38
for i in `ls *.bed `; do echo $i
bedtool subtract -a <(sort $i) -b process/gap.hg19.bed > temp
liftOver temp /process/hg19ToHg38.over.chain  process/${i/.bed/.lo19to38.bed} ${i/.bed/.unliftOver}
bedtools subtract -a <(sort ${i/.bed/.lo19to38.bed}) -b /process/gap.hg38.bed > ${i/.bed/.lo19to38.f1.bed}

##########################################  filtered alt chr; duplicate
sort -k1,1 -k2,2n ${i/.bed/.lo19to38.f1.bed}|grep -E "chr(.|..)[[:blank:]]"|awk '{if($3-$2==1) print $0}'|awk '{print $0"\t"$1"."$2"."$3}'|sort -k5,5|uniq -f4 -u|sort -k1,1 -k2,2n|awk '{print $1"\t"$2"\t"$3"\t"$4}' > ${i/.bed/.lo19to38.f2.bed}
# filter not cg
bedtools intersect -a ${i/.bed/.lo19to38.f2.bed} -b /process/lo19to38.CpG.notcg.bed -v -wa -f 1 > ${i/.bed/.lo19to38.filtered.bed}
done

###########
rm *.lo19to38.f1.bed *.lo19to38.f2.bed
########### 
cd ..
mv input/*.lo19to38.bed  output/
mv input/*.unliftOver	output/
mv input/*.lo19to38.filtered.bed  output/







####################################################################################
########################    Chipsseq   #############################################
####################################################################################
####################################################################################

mkdir input output process

########################################## input filename in bed file ; have 4 column with chr, start, end, value
##########################################
# for i in `ls *.bed *.bedGraph`; do echo $i
# awk 'NF==4{print "input have 4 columns"}else {print "stop run"}' $i  ?
# done

cp *.bed  input/
cd input
##########################################  create ID in column 5
for i in `ls *.bed `; do echo $i
awk '{print $1"\t"$2"\t"$3"\t"$4"\t"$1"."$2"."$3}' > ${i/.bed/.chipseq.bed}

done
########################################## filter gap hg19 ++>  liftOver ++> filter gap hg38
for i in `ls *.chipseq.bed `; do echo $i
bedtool subtract -a <(sort $i) -b process/gap.hg19.bed > temp
liftOver temp /process/hg19ToHg38.over.chain  process/${i/.bed/.lo19to38.bed} ${i/.bed/.unliftOver}
bedtools subtract -a <(sort ${i/.bed/.lo19to38.bed}) -b /process/gap.hg38.bed > ${i/.bed/.lo19to38.f1.bed}

########################################## filtered alt chr; duplicate
bedtools merge -i  <(sort -k1,1 -k2,2n ${i/.bed/.lo19to38.f1.bed}|grep -E "chr(.|..)[[:blank:]]"|sort -k5,5|uniq -f4 -u|sort -k1,1 -k2,2n) -c 5 -o collapse -delim "_"|awk '{if($5!~"_"){print $0}}'|sort -k1,1 -k2,2n> ${i/.bed/.lo19to38.f2.bed}
# filter not cg
bedtools intersect -a ${i/.bed/.lo19to38.f2.bed} -b /process/lo19to38.CpG.notcg.bed -v -wa -f 1 > ${i/.bed/.lo19to38.filtered.bed}> ${i/.bed/.lo19to38.f2.bed}
done

########### remove
rm *.lo19to38.f1.bed *.lo19to38.f2.bed
########### transfer file to output
cd ..
mv input/*.lo19to38.bed  output/
mv input/*.unliftOver	output/
mv input/*.lo19to38.filtered.bed  output/
































