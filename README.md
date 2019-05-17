# liftOver_filter
liftOver_filter
# liftOver_filter function proccess
1. lọc bỏ các phần gap trên gennome cũ
2. chạy chuyển đổi bằng liftOver tool
3. lọc bỏ các phần gap trên new gennome
4. lọc bỏ các phần không tốt: lặp lại, alt chromosome, not CG (CpGs, WGBS),...
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

## 1. lọc bỏ các phần gap trên gennome cũ




## 2. chạy chuyển đổi bằng liftOver tool

huong dan cach loai bo cac phan khong tot trong mau CpGs va chipseq
* tải tool liftOver từ ucsc http://hgdownload.soe.ucsc.edu/admin/exe/
* tải chain file http://hgdownload.soe.ucsc.edu/goldenPath/hg19/liftOver/
# How to install 
tạo path tới liftOver tool:
export PATH=$PATH:/path/to/file/liftOvertool/
# sử dụng:
### kent source version 381 ###
liftOver - Move annotations from one assembly to another
usage:
   liftOver oldFile map.chain newFile unMapped

oldFile and newFile are in bed format by default, but can be in GFF and
maybe eventually others with the appropriate flags below.
The map.chain file has the old genome as the target and the new genome
as the query.

***********************************************************************
WARNING: liftOver was only designed to work between different
         assemblies of the same organism. It may not do what you want
         if you are lifting between different organisms. If there has
         been a rearrangement in one of the species, the size of the
         region being mapped may change dramatically after mapping.
***********************************************************************

options:
   -minMatch=0.N Minimum ratio of bases that must remap. Default 0.95
   -gff  File is in gff/gtf format.  Note that the gff lines are converted
         separately.  It would be good to have a separate check after this
         that the lines that make up a gene model still make a plausible gene
         after liftOver
   -genePred - File is in genePred format
   -sample - File is in sample format
   -bedPlus=N - File is bed N+ format (i.e. first N fields conform to bed format)
   -positions - File is in browser "position" format
   -hasBin - File has bin value (used only with -bedPlus)
   -tab - Separate by tabs rather than space (used only with -bedPlus)
   -pslT - File is in psl format, map target side only
   -ends=N - Lift the first and last N bases of each record and combine the
             result. This is useful for lifting large regions like BAC end pairs.
   -minBlocks=0.N Minimum ratio of alignment blocks or exons that must map
                  (default 1.00)
   -fudgeThick    (bed 12 or 12+ only) If thickStart/thickEnd is not mapped,
                  use the closest mapped base.  Recommended if using 
                  -minBlocks.
   -multiple               Allow multiple output regions
   -noSerial               In -multiple mode, do not put a serial number in the 5th BED column
   -minChainT, -minChainQ  Minimum chain size in target/query, when mapping
                           to multiple output regions (default 0, 0)
   -minSizeT               deprecated synonym for -minChainT (ENCODE compat.)
   -minSizeQ               Min matching region size in query with -multiple.
   -chainTable             Used with -multiple, format is db.tablename,
                               to extend chains from net (preserves dups)
   -errorHelp              Explain error messages


## 3. lọc bỏ các phần gap trên new gennome



## 4. lọc bỏ các phần không tốt: lặp lại, alt chromosome, not CG (CpGs, WGBS),...


