### NGS Workshop - Mark duplicate reads ###

# The location of the workshop data
project=/work/sdusundworkshop

# Let's go to our working directory, we do this with 
# the cd command (cd = change directory)
cd ${project}/$(whoami)

### MarkDuplicates ###

# We use the picard tool (now part of gatk4) called MarkDuplicate 
# to mark duplicate reads introduced during e.g. PCR

# son
gatk --java-options -Xmx12G MarkDuplicates \
--INPUT=HG002_son_sorted.bam \
--OUTPUT=HG002_son_sorted_nodup.bam \
--METRICS_FILE=quality_control/HG002_son_duplicate_metrics.txt \
--CREATE_INDEX=TRUE \
--REMOVE_DUPLICATES=FALSE \
--OPTICAL_DUPLICATE_PIXEL_DISTANCE=2500 # Should be set to 2500 for 
# patterned flowcells like Illumina Hiseq 3000/4000 and Novaseq 6000 
# and set to 100 for unpatterned flowcells like HiSeq 2500

# father
gatk --java-options -Xmx12G MarkDuplicates \
--INPUT=HG003_father_sorted.bam \
--OUTPUT=HG003_father_sorted_nodup.bam \
--METRICS_FILE=quality_control/HG003_father_duplicate_metrics.txt \
--CREATE_INDEX=TRUE \
--REMOVE_DUPLICATES=FALSE \
--OPTICAL_DUPLICATE_PIXEL_DISTANCE=2500

# mother
gatk --java-options -Xmx12G MarkDuplicates \
--INPUT=HG004_mother_sorted.bam \
--OUTPUT=HG004_mother_sorted_nodup.bam \
--METRICS_FILE=quality_control/HG004_mother_duplicate_metrics.txt \
--CREATE_INDEX=TRUE \
--REMOVE_DUPLICATES=FALSE \
--OPTICAL_DUPLICATE_PIXEL_DISTANCE=2500

# Let's see that we have created three new bam files with extension _sorted_nodup.bam
ls

# We can see duplicates with samtools by typing (head shows first 10 cases)
samtools view -F 0x400 HG002_son_sorted_nodup.bam | head

# To see everything but duplicates type (head shows first 10 cases)
samtools view -f 0x400 HG002_son_sorted_nodup.bam | head

# Remove old sam files as they are no longer needed and takes up space
# rm -f HG002_son.sam
# rm -f HG003_father.sam
# rm -f HG004_mother.sam

# Remove old bam files as they are no longer needed and takes up space
# rm -f HG002_son_sorted.ba{m,i}
# rm -f HG003_father_sorted.ba{m,i}
# rm -f HG004_mother_sorted.ba{m,i}