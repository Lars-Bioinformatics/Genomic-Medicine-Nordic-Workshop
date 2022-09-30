### NGS Workshop - HaplotypeCaller ###

# The location of the workshop data
project=/work/workshop

# Let's go to our working directory (if you're not already there)
work=/work/analysis_results
cd ${work}

# Path to reference genome and regions file
REF=${project}/resources/Homo_sapiens_assembly38.fasta
BED=${project}/resources/workshop_chr21_regions_hg38.bed

### HaplotypeCaller ###

# Call variants on samples using GATK's HaplotypeCaller

gatk --java-options -Xmx2g HaplotypeCaller \
-R $REF \
-I HG002_son_recalibrated.bam \
-I HG003_father_recalibrated.bam \
-I HG004_mother_recalibrated.bam \
-L $BED \
-O trio-variants.vcf.gz

# Now, let's see that we created our trio-variants.vcf.gz file
ls

# Let's count the number of variants we found
# zcat: allows to look into compressed files
# grep -v: filters out header lines (starting with #)
# wc -l: counts number of lines in file
zcat trio-variants.vcf.gz | grep -v ^# | wc -l

# At last, let's also take a quick look of the contents in the vcf file
# with all of the discovered variants
zcat trio-variants.vcf.gz | more