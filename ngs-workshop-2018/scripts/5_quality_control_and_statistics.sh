### NGS Workshop - Quality control and statistics ###

# The location of the workshop data
project=/work/sdusundworkshop

# Let's go to our working directory with the cd command
cd ${project}/$(whoami)

# Path to reference genome and resources
REF=${project}/reference/human_g1k_v37_decoy.fasta
BED=${project}/resources/workshop_chr21_regions_g1k.bed
INTERVALS=${project}/resources/workshop_chr21_regions_g1k.interval_list

### Quality Control and Bam File Metrics ###

# Collect Hs Metrics with gatk

# son
gatk --java-options -Xmx12G CollectHsMetrics \
--INPUT=HG002_son_recalibrated.bam \
--REFERENCE_SEQUENCE=$REF \
--OUTPUT=quality_control/HG002_son_HsMetrics.txt \
--BAIT_INTERVALS=$INTERVALS \
--TARGET_INTERVALS=$INTERVALS

# father
gatk --java-options -Xmx12G CollectHsMetrics \
--INPUT=HG003_father_recalibrated.bam \
--REFERENCE_SEQUENCE=$REF \
--OUTPUT=quality_control/HG003_father_HsMetrics.txt \
--BAIT_INTERVALS=$INTERVALS \
--TARGET_INTERVALS=$INTERVALS

# mother
gatk --java-options -Xmx12G CollectHsMetrics \
--INPUT=HG004_mother_recalibrated.bam \
--REFERENCE_SEQUENCE=$REF \
--OUTPUT=quality_control/HG004_mother_HsMetrics.txt \
--BAIT_INTERVALS=$INTERVALS \
--TARGET_INTERVALS=$INTERVALS

# Collect various metrics and generate HTML report using Qualimap

# son 
qualimap bamqc -bam HG002_son_recalibrated.bam -gff $BED -nt 24 -c \
-sd -outdir quality_control/HG002_son_qualimap --java-mem-size=4G

# father
qualimap bamqc -bam HG003_father_recalibrated.bam -gff $BED -nt 24 -c \
-sd -outdir quality_control/HG003_father_qualimap --java-mem-size=4G

# mother
qualimap bamqc -bam HG004_mother_recalibrated.bam -gff $BED -nt 24 -c \
-sd -outdir quality_control/HG004_mother_qualimap --java-mem-size=4G


# Combine all our statistics to one report with multiqc
multiqc quality_control -o quality_control \
-c ${project}/resources/multiqc_config.yaml

