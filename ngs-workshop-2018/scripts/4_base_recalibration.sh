### NGS Workshop - Base Recalibration ###

# The location of the workshop data
project=/work/sdusundworkshop

# Let's go to our working directory with the cd command
cd ${project}/$(whoami)

# Path to reference genome and resource files
REF=${project}/reference/human_g1k_v37_decoy.fasta
BED=${project}/resources/workshop_chr21_regions_g1k.bed
dbsnp=${project}/resources/dbsnp_138.b37.vcf
mills_1000g=${project}/resources/Mills_and_1000G_gold_standard.indels.b37.vcf
phase1_1000g=${project}/resources/1000G_phase1.indels.b37.vcf

### Base recalibration ###

# Base recalibration is a two step process: First find bases to recalibrate, second apply the recalibration (it's actually three steps but last step is optional and only produces a statistics of our recalibration)

# Step 1: Generate recalibration table

# son
gatk --java-options -Xmx12G BaseRecalibrator \
	-R=$REF \
	-I=HG002_son_sorted_nodup.bam \
	--known-sites=${dbsnp} \
	--known-sites=${mills_1000g} \
	--known-sites=${phase1_1000g} \
	-L $BED \
	-O=quality_control/HG002_son_pre_recalibration.grp

# father
gatk --java-options -Xmx12G BaseRecalibrator \
	-R=$REF \
	-I=HG003_father_sorted_nodup.bam \
	--known-sites=${dbsnp} \
	--known-sites=${mills_1000g} \
	--known-sites=${phase1_1000g} \
	-L $BED \
	-O=quality_control/HG003_father_pre_recalibration.grp

# mother
gatk --java-options -Xmx12G BaseRecalibrator \
	-R=$REF \
	-I=HG004_mother_sorted_nodup.bam \
	--known-sites=${dbsnp} \
	--known-sites=${mills_1000g} \
	--known-sites=${phase1_1000g} \
	-L $BED \
	-O=quality_control/HG004_mother_pre_recalibration.grp
# Step 2: Apply recalibration

# son
gatk --java-options -Xmx12G ApplyBQSR \
	-R=$REF \
	-I=HG002_son_sorted_nodup.bam \
	--bqsr-recal-file=quality_control/HG002_son_recalibrate.grp \
	-L $BED \
	-O=HG002_son_recalibrated.bam

# father
gatk --java-options -Xmx12G ApplyBQSR \
	-R=$REF \
	-I=HG003_father_sorted_nodup.bam \
	--bqsr-recal-file=quality_control/HG003_father_recalibrate.grp \
	-L $BED \
	-O=HG003_father_recalibrated.bam

# mother
gatk --java-options -Xmx12G ApplyBQSR \
	-R=$REF \
	-I=HG004_mother_sorted_nodup.bam \
	--bqsr-recal-file=quality_control/HG004_mother_recalibrate.grp \
	-L $BED \
	-O=HG004_mother_recalibrated.bam

# Step 3: Generate recalibration table of newly recalibrated bases
# (optional step)

# son
gatk --java-options -Xmx12G BaseRecalibrator \
	-R=$REF \
	-I=HG002_son_recalibrated.bam \
	--known-sites=${dbsnp} \
	--known-sites=${mills_1000g} \
	--known-sites=${phase1_1000g} \
	-L $BED \
	-O=quality_control/HG002_son_post_recalibration.grp

# father
gatk --java-options -Xmx12G BaseRecalibrator \
	-R=$REF \
	-I=HG003_father_recalibrated.bam \
	--known-sites=${dbsnp} \
	--known-sites=${mills_1000g} \
	--known-sites=${phase1_1000g} \
	-L $BED \
	-O=quality_control/HG003_father_post_recalibration.grp

# mother
gatk --java-options -Xmx12G BaseRecalibrator \
	-R=$REF \
	-I=HG004_mother_recalibrated.bam \
	--known-sites=${dbsnp} \
	--known-sites=${mills_1000g} \
	--known-sites=${phase1_1000g} \
	-L $BED \
	-O=quality_control/HG004_mother_post_recalibration.grp

# We will check the results of our recalibration together with
# the aligment statistics we create in the next step.

# Again, we remove old bam files so they don't take up space
# rm -f HG002_son_sorted_nodup.ba{m,i}
# rm -f HG003_father_sorted_nodup.ba{m,i}
# rm -f HG004_mother_sorted_nodup.ba{m,i}
