% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plotHist.R
\name{plotHist}
\alias{plotHist}
\title{Plot histogram of clonotype frequencies in negative and positive samples.}
\usage{
plotHist(comb)
}
\arguments{
\item{comb}{List containing both negtive (n) and positive (v) clonotype percentages.}
}
\value{
ggplot histogram of clonotype frequencies in negative and positive samples
}
\description{
Plot histogram of clonotype frequencies in negative and positive samples.
}
\examples{
FIELD <- "vGeneName aminoAcid jGeneName"
P_CUTOFF <- 0.1
MIN_PUBLIC <- 2

listPos <- tsvDir(system.file("extdata", "Post", package="iCAT"))
listNeg <- tsvDir(system.file("extdata", "Pre", package="iCAT"))

naive <- readTrn(listNeg, FIELD, "naive")
vaccs <- readTrn(listPos, FIELD, "vacc")  

mod <- train(naive, vaccs, listNeg, listPos, FIELD, P_CUTOFF, MIN_PUBLIC, NULL)
plotHist(mod)
}
