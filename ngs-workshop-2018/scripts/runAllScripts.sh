### NGS Workshop - Run complete pipeline ###

# The location of the workshop data
project=/work/sdusundworkshop

# Create working directory and cd into it
mkdir -p ${project}/$(whoami)
cd ${project}/$(whoami)

# bash /work/${project}/scripts/0_setup.sh	# Only need to run once for each machine
bash ${project}/scripts/1_inspect_and_initial_quality_control.sh
bash ${project}/scripts/2_map_and_sort.sh
bash ${project}/scripts/3_mark_duplicates.sh
bash ${project}/scripts/4_base_recalibration.sh
bash ${project}/scripts/5_quality_control_and_statistics.sh
bash ${project}/scripts/6_haplotype_caller.sh