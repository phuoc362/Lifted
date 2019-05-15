







########################################## input filename in bed file ; have 4 column with chr, start, end, value
##########################################  length of CpGs =1
for i in `ls filename`; do echo $i
bedtool subtract -a <(sort $i) -b /path/to/file/gap.hg19.bed > temp
liftOver temp /path/to/file/hg19ToHg38.over.chain  /path/output/file/name.output.bed /path/output/name_unliftOver
bedtools subtract -a <(sort name.output.bed) -b /path/to/file/gap.hg38.bed > output.liftOvered
done


########################################## filtered
for i in `ls output.liftOvered`; do echo $i
sort -k1,1 -k2,2n $i|grep -E "chr(.|..)[[:blank:]]"|awk '{if($3-$2==1) print $0}'|awk '{print $0"\t"$1"."$2"."$3}'|sort -k5,5|uniq -f4 -u|sort -k1,1 -k2,2n|awk '{print $1"\t"$2"\t"$3"\t"$4}' > output.filtered.step1
# filter not cg
bedtools intersect -a output.filtered.step1 -b lo19to38.CpG.notcg.bed -v -wa -f 1 > output.filtered
done
########### 
























