setwd("C:/Users/Kristian/Documents/jassys_spul_voor_school")
getwd()
unzip("Data_RA_raw", exdir = "project_data")
install.packages('BiocManager')
BiocManager::install('Rsubread')
library(Rsubread)

buildindex(
  basename = 'ref_human',
  reference = 'Homo_sapiens.GRCh38.dna.toplevel_1.fa',
  memory = 4000,
  indexSplit = TRUE)

# Ethanol monsters
align.control1 <- align(index = "ref_human", readfile1 = "Data_RA_raw/SRR4785819_1_subset_controle1_fw.fastq", readfile2 = "Data_RA_raw/SRR4785819_2_subset_controle1_rv.fastq", output_file = "control1.BAM")
align.control2 <- align(index = "ref_human", readfile1 = "Data_RA_raw/SRR4785820_1_subset_controle2_fw.fastq", readfile2 = "Data_RA_raw/SRR4785820_2_subset_controle2_rv.fastq", output_file = "control2.BAM")
align.control3 <- align(index = "ref_human", readfile1 = "Data_RA_raw/SRR4785828_1_subset_controle3_fw.fastq", readfile2 = "Data_RA_raw/SRR4785828_2_subset_controle3_rv.fastq", output_file = "control3.BAM")
align.control4 <- align(index = "ref_human", readfile1 = "Data_RA_raw/SRR4785831_1_subset_controle4_fw.fastq", readfile2 = "Data_RA_raw/SRR4785831_2_subset_controle4_rv.fastq", output_file = "control4.BAM")
align.RA1 <- align(index = "ref_human", readfile1 = "Data_RA_raw/SRR4785979_1_subset_RA1_fw.fastq", readfile2 = "Data_RA_raw/SRR4785979_2_subset_RA1_rv.fastq", output_file = "RA1.BAM")
align.RA2 <- align(index = "ref_human", readfile1 = "Data_RA_raw/SRR4785980_1_subset_RA2_fw.fastq", readfile2 = "Data_RA_raw/SRR4785980_2_subset_RA2_rv.fastq", output_file = "RA2.BAM")
align.RA3 <- align(index = "ref_human", readfile1 = "Data_RA_raw/SRR4785986_1_subset_RA3_fw.fastq", readfile2 = "Data_RA_raw/SRR4785986_2_subset_RA3_rv.fastq", output_file = "RA3.BAM")
align.RA4 <- align(index = "ref_human", readfile1 = "Data_RA_raw/SRR4785988_1_subset_RA4_fw.fastq", readfile2 = "Data_RA_raw/SRR4785988_2_subset_RA4_rv.fastq", output_file = "RA4.BAM")


BiocManager::install("Rsamtools")
library(Rsamtools)
samples <- c('control1', 'control2', 'control3', 'control4', 'RA1', 'RA2', 'RA3', 'RA4')
lapply(samples, function(s) {sortBam(file = paste0(s, '.BAM'), destination = paste0(s, '.sorted'))})
lapply(samples, function(s) {indexBam(file = paste0(s, '.sorted.bam'))})
#################
library(readr)
library(dplyr)
library(Rsamtools)
library(Rsubread)

gff <- read_tsv("Homo_sapiens.GRCh38.114.gtf.gz", comment = "#", col_names = FALSE)
colnames(gff) <- c("seqid", "source", "type", "start", "end", "score", "strand", "phase", "attributes")
gff_gene <- gff %>% filter(type == "gene")
gff_gene$type <- "exon"
bam_chr <- names(scanBamHeader("RA1.BAM")[[1]]$targets)[1]
gff_gene$seqid <- bam_chr
write_delim(gff_gene, "Homo_sapiens.GRCh38.114.gtf", delim = "\t", col_names = FALSE)

allsamples <- c("control1.BAM", "control2.BAM", "control3.BAM", "control4.BAM", "RA1.BAM", "RA2.BAM", "RA3.BAM", "RA4.BAM")


count_matrix <- featureCounts(files = allsamples ,
  annot.ext = "Homo_sapiens.GRCh38.114.gft)
  isPairedEnd = TRUE,
  isGTFAnnotationFile = TRUE,
  GTF.attrType = "gene_id",
  useMetaFeatures = TRUE
)

head(count_matrix$annotation)
head(count_matrix$counts)
str(count_matrix)
counts <- count_matrix$counts
colnames(counts) <- c("control1.BAM", "control2.BAM", "control3.BAM", "control4.BAM", "RA1.BAM", "RA2.BAM", "RA3.BAM", "RA4.BAM")
write.csv(counts, "bewerkt_countmatrix.csv")



