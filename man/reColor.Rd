% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/gen_general.r
\name{reColor}
\alias{reColor}
\title{Re-Color a dataset}
\usage{
reColor(dataset)
}
\arguments{
\item{dataset}{An object of class 'aquap_data' as produced e.g. by 
\code{\link{gfd}}.}
}
\value{
The dataset with recalculated color representation.
}
\description{
Recalculate all the colors contained in \code{colRep} in a 
dataset.
}
\details{
This can be useful if, for example, a subset of data taken from 
a rather big dataset where a possible color-gradient was very wide, only 
presents itself as having more or less the same color.
}
\examples{
\dontrun{
fd <- gfd()
fd2 <- reColor(fd)
}
}
\seealso{
Other Helper Functions: \code{\link{genFolderStr}},
  \code{\link{genNoiseRecExp}},
  \code{\link{genTempCalibExp}}, \code{\link{getcd}},
  \code{\link{getcm}}, \code{\link{instAquap2Examples}},
  \code{\link{printStdColnames}}, \code{\link{saveAQdata}},
  \code{\link{siWlg}}, \code{\link{updateAquap2}},
  \code{\link{updateSettings}}
}
\concept{Helper Functions}
