
#calculate entropy
entropy = function(data) {
    freqs = data/sum(data)  #data actually means data$V1
    -sum(freqs*log2(freqs))
    
}


#read data files
#get the file name[arg1] and embryo[arg2] information from command lines
args = commandArgs(T)
data = read.table(args[1], sep = " ")

print(paste("the entropy is", entropy(data$V1)))
