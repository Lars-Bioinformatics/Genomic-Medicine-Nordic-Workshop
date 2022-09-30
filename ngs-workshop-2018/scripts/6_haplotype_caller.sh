### NGS Workshop - HaplotypeCaller ###

# The location of the workshop data
project=/work/sdusundworkshop

# Let's go to our working directory (if you're not already there)
cd ${project}/$(whoami)

# Path to reference genome and regions file
REF=${project}/reference/human_g1k_v37_decoy.fasta
BED=${project}/resources/workshop_chr21_regions_g1k.bed

### HaplotypeCaller ###

# Call variants on samples using GATK's HaplotypeCaller

gatk --java-options -Xmx12g HaplotypeCaller  \
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
# grep: filters out header lines, so we don't count them as variants
# wc -l: counts number of lines in file
zcat trio-variants.vcf.gz | grep -v ^# | wc -l

# At last, let's also take a quick look of the contents in the vcf file
# with all of the discovered variants
zcat trio-variants.vcf.gz | less -S