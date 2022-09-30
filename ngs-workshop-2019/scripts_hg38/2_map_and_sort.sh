### NGS Workshop - Alignment with BWA ###

# The location of the workshop data
project=/work/workshop

# Let's go to our working directory with the cd command
work=/work/analysis_results
cd ${work}

### Alignment and Sorting ###

# Path to reference genome and data
REF=${project}/resources/Homo_sapiens_assembly38.fasta
DATA=${project}/data

# Step 1: Align reads to reference genome with BWA

# Step 1.1: First we need to define Read groups information

RG_son="@RG\\tID:son\\tLB:Illumina\\tPL:HiSeq\\tSM:son\\tPU:C2FAGACXX"
RG_father="@RG\\tID:father\\tLB:Illumina\\tPL:HiSeq\\tSM:father\\tPU:C2FAGACXX"
RG_mother="@RG\\tID:mother\\tLB:Illumina\\tPL:HiSeq\\tSM:mother\\tPU:C2FAGACXX"

# Step 1.2: Use bwa to align reads to reference genome 

# son
bwa mem -t 4 -M -R ${RG_son} $REF $DATA/HG002_son_R1_001.fastq.gz \
$DATA/HG002_son_R2_001.fastq.gz > HG002_son.sam

# father
bwa mem -t 4 -M -R ${RG_father} $REF $DATA/HG003_father_R1_001.fastq.gz \
$DATA/HG003_father_R2_001.fastq.gz > HG003_father.sam

# mother
bwa mem -t 4 -M -R ${RG_mother} $REF $DATA/HG004_mother_R1_001.fastq.gz \
$DATA/HG004_mother_R2_001.fastq.gz > HG004_mother.sam

# Let's take a look in our working directory to see 
# we have created new sam files with the aligned reads
ls

# Let's check the what's inside one of these sam files
samtools view HG002_son.sam | head -n 20

# Step 2: Use SortSam to sort the aligned reads by coordinate 
# and convert to bam file to save space

# son
gatk --java-options -Xmx2G SortSam \
--INPUT HG002_son.sam \
--OUTPUT HG002_son_sorted.bam \
--VALIDATION_STRINGENCY LENIENT \
--SORT_ORDER coordinate \
--CREATE_INDEX TRUE

# father
gatk --java-options -Xmx2G SortSam \
--INPUT HG003_father.sam \
--OUTPUT HG003_father_sorted.bam \
--VALIDATION_STRINGENCY LENIENT \
--SORT_ORDER coordinate \
--CREATE_INDEX TRUE

# mother
gatk --java-options -Xmx2G SortSam \
--INPUT HG004_mother.sam \
--OUTPUT HG004_mother_sorted.bam \
--VALIDATION_STRINGENCY LENIENT \
--SORT_ORDER coordinate \
--CREATE_INDEX TRUE

# We should now have created three bam files with extension _sorted.bam
# Again we check this with the ls command
ls

# Let's also check that the contents of the bam files are now sorted
samtools view HG002_son_sorted.bam | head -n 20