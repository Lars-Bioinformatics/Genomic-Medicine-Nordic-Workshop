### NGS Workshop - Setup ###

# The location of the workshop data
project=/work/workshop

# Create working directory
work=/work/analysis_results
mkdir -p ${work}

# Note: Conda is already installed on SDU cloud, so we skip everything
# between >> <<
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
## Download and install the latest version of conda.
## conda is used to easily install the necessary tools for NGS analysis
#
# wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
# bash Miniconda3-latest-Linux-x86_64.sh -b
#
## Export the conda path to make the conda command available to us
#
# export PATH='$HOME/miniconda3/bin:$PATH'
# echo -e '\nexport PATH="$HOME/miniconda3/bin:$PATH"\n' >> ~/.bashrc
# <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

# Install bwa, samtools and GATK4 for the analysis. We also install Qualimap, FastQC
# and MultiQC to easily generate quality control report for our NGS data.

conda install -c bioconda bwa samtools gatk4 qualimap fastqc multiqc -y