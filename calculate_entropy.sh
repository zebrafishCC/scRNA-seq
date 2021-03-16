#bash scripts
echo "Calculate the entropy for 7 embryos using allele table data from Chan et al. Nature, 2019"

#the home directory is "/home/chengchen/data/lineage_tree/target-sequencing/"
#run this script by "bash ./scripts/calculate_entropy.sh >& entropy_records"

#create a file to save indel frequency information for each target site or each intergration site
mkdir -p indelFreqs

for FILE in $(ls GSM*.txt)
do
	#extract the embryo information
	##embryo (p,1,p)
	embryo=$(echo ${FILE} | cut -d "_" -f 2)
	echo "-------------------------------------------------"
	echo "##Process ${embryo}"
	echo " "

	echo "The copy number frequency in cells of ${embryo}:"
	echo "Frequency Intergration-number"
	cut -f 1  $FILE | sort | uniq -c | sort -k 1nr| awk '$1=$1'| cut -d " " -f 1 | uniq -c | awk '$1=$1' | sed 's/ /\t/g'
	echo " "
	
	
	echo "Extract indels information for site1 ade2"
	echo "the total number of alleles for ade2:"
	awk '{split($3,a,"_"); print a[1]}' $FILE | sed '1d' |sort | uniq -c | sort -k 1nr | wc -l
	awk '{split($3,a,"_"); print a[1]}' $FILE | sed '1d' |sort | uniq -c | sort -k 1nr | awk '$1=$1' > ./indelFreqs/${embryo}_ade2.txt
	Rscript ./scripts/entropy_calculation.r ./indelFreqs/${embryo}_ade2.txt
	echo " "

	echo "Extract indels information for site2 bam3"
	echo "the total number of alleles for bam3:"
	awk '{split($3,a,"_"); print a[2]}' $FILE | sed '1d' |sort | uniq -c | sort -k 1nr | wc -l
	awk '{split($3,a,"_"); print a[2]}' $FILE | sed '1d' |sort | uniq -c | sort -k 1nr | awk '$1=$1' > ./indelFreqs/${embryo}_bam3.txt
	Rscript ./scripts/entropy_calculation.r ./indelFreqs/${embryo}_bam3.txt
	echo " "

	echo "Extract indels information for site3 whiteB"
	echo "the total number of alleles for whiteB:"
	awk '{split($3,a,"_"); print a[3]}' $FILE | sed '1d' |sort | uniq -c | sort -k 1nr | wc -l
	awk '{split($3,a,"_"); print a[3]}' $FILE | sed '1d' |sort | uniq -c | sort -k 1nr | awk '$1=$1' > ./indelFreqs/${embryo}_whiteB.txt
	Rscript ./scripts/entropy_calculation.r ./indelFreqs/${embryo}_whiteB.txt
	echo " "	

	echo "Extract the information of three sites (one intergration site) based alleles"
	echo "the total number of alleles for Intergration sites:"
	awk '{print $2,$3}' $FILE | sed '1d' | sort | uniq -c | sort -k 1nr| wc -l
	awk '{print $2,$3}' $FILE | sed '1d' | sort | uniq -c | sort -k 1nr| awk '$1=$1' > ./indelFreqs/${embryo}_three_site_allele.txt
	Rscript ./scripts/entropy_calculation.r ./indelFreqs/${embryo}_three_site_allele.txt
	echo " "

done






