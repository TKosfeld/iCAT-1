#' Statistics about training data.
#'
#' @param listPre Vector of negative training samples.
#' @param listPost Vector of positive training samples.
#' @param field String containing the column or columns (space-delimited) of interest.
#' @return Dataframe containing number of samples, colonotypes, and unique seqs in training data.
#' @export
#' @examples 
#' FIELD <- "vGeneName aminoAcid jGeneName"
#' 
#' listPos <- tsvDir(system.file("extdata", "Pre", package="iCAT"))
#' listNeg <- tsvDir(system.file("extdata", "Post", package="iCAT"))
#' 
#' trnStats(listPos, listNeg, FIELD)
trnStats <- function(listPre, listPost, field) {
  fs <- strsplit(field, ' ')[[1]]
  
  pre <- rbindlist(lapply(listPre, function(x) {
    dat <- fread(x, select = c(fs, "count (reads)", "copy"))
  }))
  
  DTpre <- as.data.table(pre)
  pre <- DTpre[, lapply(.SD, sum), by = fs, .SDcols = "count (reads)"]
  pref <- c(length(listPre), length(pre$`count (reads)`), sum(pre$`count (reads)`))
  
  post <- rbindlist(lapply(listPost, function(x) {
    dat <- fread(x, select = c(fs, "count (reads)"))
  }))
  
  DTpost <- as.data.table(post)
  post <- DTpost[, lapply(.SD, sum), by = fs, .SDcols = "count (reads)"]
  postf <- c(length(listPost), length(post$`count (reads)`), sum(post$`count (reads)`))
  
  both <- rbind(pref, postf)
  colnames(both) <- c("# Samples", "# Clonotypes", "# Unique Sequences")
  rownames(both) <- c("Negative", "Positive")
  
  return(both)
}
