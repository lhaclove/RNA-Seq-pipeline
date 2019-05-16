prefix=$PWD
basename1="_1.clean.fq"
basename2="_2.clean.fq"
export REF439GTF="/public/home/liuhao/ref/V439/Zea_mays.AGPv4.39.chr.gtf"
export REF439HTI="/public/home/liuhao/ref/V439/Zea_mays.AGPv4.hisat2"
export REF439BWI="/public/home/liuhao/ref/V439/Zea_mays.AGPv4.bowtie2"
export REF439FA="/public/home/liuhao/ref/V439/Zea_mays.AGPv4.dna.toplevel.fa"
export REF439IGV="/public/home/liuhao/tool/IGVTools/v439.genome"


if [ ! -d "./report/" ];then
mkdir ./report
fi

if [ ! -d "./align/" ];then
mkdir ./align
fi

if [ ! -d "./ballgown/" ];then
mkdir ./ballgown
fi




while read samplename;
 do
fastp -i ${prefix}/raw/${samplename}${basename1} -I ${prefix}/raw/${samplename}${basename2} -o ${prefix}/raw/${samplename}_1.filt.fq -O ${prefix}/raw/${samplename}_2.filt.fq -h ${prefix}/report/${samplename}.html
bowtie2 -p 30 -x /public/home/liuhao/ref/V439/Zea_mays.AGPv4.bowtie2 -1 $prefix/raw/${samplename}.1.filt.fq.gz -2 $prefix/raw/${samplename}.2.filt.fq.gz -S $prefix/align/${samplename}.sam &&
hisat2 -p 60 -t --dta -x $REF439HTI -1 $prefix/raw/${samplename}.1.filt.fq.gz -2 $prefix/raw/${samplename}.2.filt.fq.gz -S $prefix/align/${samplename}.sam &&



samtools  sort -@60 $prefix/aligned/${samplename}.sam -o $prefix/aligned/${samplename}_sorted.bam &&
stringtie -e -B -p 60 -G /public/home/liuhao/ref/Zea_mays.AGPv4.39.chr.gtf -o $prefix/ballgown/${samplename}/${samplename}_sorted.gtf -l ${samplename} $prefix/aligned/${samplename}_sorted.bam;




done  < sample

