# Epi_liftOver
> 1. lọc bỏ các phần gap trên gennome cũ
> 2. chạy chuyển đổi bằng liftOver tool
> 3. lọc bỏ các phần gap trên new gennome
> 4. lọc bỏ các phần không tốt: lặp lại, alt chromosome, not CG (CpGs, WGBS),...
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

yêu cầu dữ liệu đầu vào:
#### cấu trúc file đầu vào phai 4 cột là: chromosome, start, end, value
#### tên file đầu vào phải ở dạng đuôi .bed
#### các file samples và file trong mục data để ở chung 1 thư mục riêng
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

## requỉre fỏ run this tool:
* Download and install  liftOver tool from UCSC:  http://hgdownload.soe.ucsc.edu/admin/exe/
* Download chain file http://hgdownload.soe.ucsc.edu/goldenPath/hg19/liftOver/
* Download template:  hg19.between2un-gapped.bed; hg19.bgap.tgap.and.blacklist.bed; remove.bed(only for CpGs)
# install liftOver UCSC
tạo path tới liftOver tool:
export PATH=$PATH:/path/to/file/liftOvertool/

# hướng dẫn sử dụng 
## đối với loại mẫu CPGs
sh liftedCpGs.sh inputfile  output_liffted_name_file output_unlifted_name_file 
## đối với loại mẫu khác
sh lifted.sh  inputfile  output_liffted_name_file output_unlifted_name_file
