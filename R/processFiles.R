#' Internal function for transforming input files.
#'
#' @param x Input file.
#' @param field String containing the column or columns (space-delimited) of interest.
#' @return data.table of transformed input file
#' @import data.table
processFiles <- function(x, field) {
  fs <- strsplit(field, ' ')[[1]]
  # get sequenceStatus column to use as filter, then remove it
  #dat <- readLines(x)
  #dat <- dat[grep('^[A-Za-z]', dat)]
  #dat <- read.table(textConnection(dat), sep="\t", header=T)
  #dat <- select(dat, fs, "sequenceStatus")
  dat <- data.table::fread(x, select = c(fs, "sequenceStatus"))
  dat0 <- dat[dat$sequenceStatus > 0, ,drop=FALSE]
  dat1 <- dat[dat$sequenceStatus == "In", , drop=FALSE]
  dat <- rbind(dat0, dat1)

  dat <- dat[, 1:length(fs), drop=FALSE]

  dat <- dat[!duplicated(dat), ,drop=FALSE]
  dat <- dat[order(dat[,1:length(fs)]), ,drop=FALSE]
  #print(dat)
}
