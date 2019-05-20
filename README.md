# Epi_liftOver
> 1. lọc bỏ các phần gap trên gennome cũ
> 2. chạy chuyển đổi bằng liftOver tool
> 3. lọc bỏ các phần gap trên new gennome
> 4. lọc bỏ các phần không tốt: lặp lại, alt chromosome, not CG (CpGs, WGBS),...
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
yêu cầu dữ liệu đầu vào:
#### cấu trúc file đầu vào phai 4 cột là: chromosome, start, end, value
#### tên file đầu vào phải ở dạng đuôi .bed
#### các file dữ liệu để ở 1 thư mục riêng chỉ có file đuôi .bed
#### Nếu là mẫu CpGs thì khoảng cách giữa star và end là 1 nucleotic
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
## cài đặt liftOver UCSC:
* tải tool liftOver từ ucsc http://hgdownload.soe.ucsc.edu/admin/exe/
* tải chain file http://hgdownload.soe.ucsc.edu/goldenPath/hg19/liftOver/
* tải các dữ liệu trong phần data để chung thư mục với mẫu:  hg19.between2un-gapped.bed; hg19.bgapped.bed; hg19.tgapped.bed; hg38.between2un-gapped.bed; hg38.bgapped.bed; hg38.tgapped.bed; blacklist.hg19.bed; blacklist.hg38.bed
# How to install liftOver UCSC
tạo path tới liftOver tool:
export PATH=$PATH:/path/to/file/liftOvertool/
# hướng dẫn sử dụng epiliftOver
epiliftOver input output
