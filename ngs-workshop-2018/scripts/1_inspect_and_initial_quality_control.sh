### NGS Workshop - Data inspection and FastQC ###

# The location of the workshop data
project=/work/sdusundworkshop

# Path to data, scripts, reference genome and resource directories
DATA=${project}/data
REF=${project}/reference
RES=${project}/resources
SCRIPTS=${project}/scripts

# Let's go to our working directory, 
# we do this with the cd command (cd = change directory)
cd ${project}/$(whoami)

# Let's look inside the data, scripts, reference genome 
# and resource directories
ls $DATA
ls $REF
ls $RES
ls $SCRIPTS

# Take a quick look in one of our data files 
# (should be similar to the one shown in the presentation)
zcat $DATA/HG002_son_R1_001.fastq.gz | head

# We will create a direcotory to store all our quality control reports
mkdir -p quality_control


# Let's check the quality of our fastq files 
# in the data directory using fastqc

# son
fastqc $DATA/HG002_son_R1_001.fastq.gz -o quality_control
fastqc $DATA/HG002_son_R2_001.fastq.gz -o quality_control

# father
fastqc $DATA/HG003_father_R1_001.fastq.gz -o quality_control
fastqc $DATA/HG003_father_R2_001.fastq.gz -o quality_control

# mother
fastqc $DATA/HG004_mother_R1_001.fastq.gz -o quality_control
fastqc $DATA/HG004_mother_R2_001.fastq.gz -o quality_control

# Now check that we have created HTML reports for the fastq files 
# using the ls command
ls quality_control