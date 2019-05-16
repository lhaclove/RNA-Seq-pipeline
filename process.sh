prefix=$PWD
basename1="_1.clean.fq"
basename2="_2.clean.fq"
tail=
report=

if [ ! -d "./report/" ];then
mkdir ./report
fi


while read samplename;
 do
fastp -i ${prefix}/raw/${samplename}${basename1} -I ${prefix}/raw/${samplename}${basename2} -o ${prefix}/raw/${samplename}_1.filt.fq -O ${prefix}/raw/${samplename}_2.filt.fq -h ${prefix}/report/${samplename}.html

done  < sample

