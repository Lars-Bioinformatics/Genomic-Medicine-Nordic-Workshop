### NGS Workshop - Setup ###

# The location of the workshop data
project=/work/sdusundworkshop

# Create working directory
mkdir -p ${project}/$(whoami)

# Download and install the latest version of conda. 
# conda is used to easily install the necessary tools for NGS analysis

wget https://repo.continuum.io/miniconda/Miniconda3-3.7.0-Linux-x86_64.sh \
	-O ~/miniconda.sh
bash ~/miniconda.sh -b

# We export the conda path thus making the conda command available to us

export PATH='$HOME/miniconda3/bin:$PATH'
echo -e '\nexport PATH="$HOME/miniconda3/bin:$PATH"\n' >> ~/.bashrc

# Install bwa and GATK4 for the analysis. We also install Qualimap, FastQC
# and MultiQC to easily generate quality control report for our NGS data.

conda install -c bioconda bwa gatk4 qualimap fastqc pip samtools --yes
pip install multiqc # Newer version than the one in conda
