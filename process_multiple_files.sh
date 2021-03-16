
for FILE in $(ls GSM*.txt)
do 
	echo $FILE
        echo "---site1 ade2------"
	awk '{split($3,a,"_"); print a[1]}' $FILE | sed '1d' |sort | uniq -c | wc -l
	awk '{split($3,a,"_"); print a[1]}' $FILE | sed '1d' |sort | uniq -c | sort -k 1nr | head -20

        echo "---site2 bam3------"
        awk '{split($3,a,"_"); print a[2]}' $FILE | sed '1d' |sort | uniq -c | wc -l
        awk '{split($3,a,"_"); print a[2]}' $FILE | sed '1d' |sort | uniq -c | sort -k 1nr | head -20

        echo "---site3 whiteB------"
        awk '{split($3,a,"_"); print a[3]}' $FILE | sed '1d' |sort | uniq -c | wc -l
        awk '{split($3,a,"_"); print a[3]}' $FILE | sed '1d' |sort | uniq -c | sort -k 1nr | head -20

# awk '{split($3,a,"_"); print a[1]}'  | sed '1d' |sort | uniq -c | wc -l
done

