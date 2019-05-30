# liftOver filter tool
We have implemented a guideline to improve the result of conversion of epigenome sequencing data, namely, Lifted. From the enrichment analyses described in previous sections, all the gapped regions that can cause corruption were gathered to build three annotation files, namely, gapped-in-hg19, gapped-in-both and gapped-in-hg38. To liftover from hg19 to hg38, first, we filter the input coordinates by gapped-in-hg19, gapped-in-both and blacklist. The remaining coordinates are all ungapped on hg19, so the liftover can be safely performed at this stage. 
Here we propose two options to remove gapped-in-hg38. The first option is conservative where all output intervals that overlap with gapped-in-hg38 are excluded after liftover. This ensures that only the input data situated in the ungapped regions will be converted and the users can then maximize output quality. However this approach will result in a reduction of the number of converted data but the output will be of high quality. The second option is less conservative, whereby the input intervals in hg19 that overlap the coordinates of gapped-in-hg38 are split before liftover to cut out 2bp in a similar manner to how the data were simulated in picture. This approach can preserve the number of convertible intervals, however the quality of conversion may not be as high and will contain false positive. The users should consider the advantages and disadvantages of each option to choose the appropriate one for their purposes. In both approaches, the inappropriate data such as duplication, alternative chromosome, not CG is filtered.
### * Figures explain:
#### The coordination of gapped-in-hg19, gapped-in-both, gap in hg38 and ungap
![vidu2](https://user-images.githubusercontent.com/19143879/58646612-fc3bf480-832f-11e9-8a8f-442efc97c3f7.png)

#### Intervals in hg19 that overlap the coordinates of gapped-in-hg38 are split
![vidu1](https://user-images.githubusercontent.com/19143879/58646622-ff36e500-832f-11e9-9af4-1af87843777c.png)

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

### require input data:
Data input must have fomat: chromosome, start, end, value
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

### require for run this tool:
* Download and install  liftOver tool from UCSC:  http://hgdownload.soe.ucsc.edu/admin/exe/
* Download chain file http://hgdownload.soe.ucsc.edu/goldenPath/hg19/liftOver/
* Download template:  hg19.between2un-gapped.bed; hg19.bgap.tgap.and.blacklist.bed; remove.bed(only for CpGs)
# install liftOver UCSC
make path to liftOver tool:
export PATH=$PATH:/path/to/file/liftOvertool/

## Manual
### for CPGs samples use conservative filtered:
sh liftedCpGs.lifted.conservative.sh sh____inputfile____output.liffted.name.file____output.unlifted.name.file 
### another samples use conservative filtered:
sh lifted.lifted.conservative.sh.sh____inputfile____output.liffted.name.file____output.unlifted.name.file 
### for CPGs samples use less_conservative filtered:
sh liftedCpGs.lifted.less_conservative.sh sh____inputfile____output.liffted.name.file____output.unlifted.name.file
### for CPGs samples use less_conservative filtered:
sh liftedCpGs.lifted.less_conservative.sh sh____inputfile____output.liffted.name.file____output.unlifted.name.file

### exsample compare on ESR1 ans full CPGs

![Picture4](https://user-images.githubusercontent.com/19143879/58645815-4623db00-832e-11e9-9d6a-4ab9fb4581a2.png)
##### compare ratio CpGs/intervals chipseq between conservative - less_conservative and segment filtered on Full CpGs and ESR1
![Picture3](https://user-images.githubusercontent.com/19143879/58645843-5471f700-832e-11e9-9680-a16c354d29b6.png)
##### compare correlation and jaccard ratio intervals chipseq between conservative - less_conservative and segment filtered on ESR1 sample.

