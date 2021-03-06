% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plot_classif_gen.r
\name{plot_classifX_indepPred}
\alias{plot_classifX_indepPred}
\title{Plot Independent Predictions}
\usage{
plot_classifX_indepPred(indepDataset, cube, ccv = NULL, icv = NULL,
  pl = TRUE, toxls = "def", info = "def", confirm = "def",
  predList = NULL, apPlot = "def", ...)
}
\arguments{
\item{indepDataset}{The dataset containing the independent data. An object 
of class 'aquap_data' as produced by \code{\link{gfd}}.}

\item{cube}{An object of class 'aquap_cube' as produced by \code{\link{gdmm}}. 
It is an error to have no classification models in the cube.}

\item{ccv}{"Cube class variable", character vector or NULL. The names of 
one or more class variables in the cube on which classification models have 
been calculated. Leave at the default NULL to use \strong{all} of the class 
variables on which a classification model has been calculated, or provide a 
character vector with valid variable names for a sub-selection. For the selected 
variables, predictions from the data in the independent dataset will be made. 
If argument \code{icv} is left at its default NULL, class variables with 
exactly the same name are looked for in the independent dataset and, if 
present, are used for validating the predictions.}

\item{icv}{"Independent class variable", character vector or NULL. The names 
of class variables in the independent dataset. If left at the default 
NULL, class variables in the independent dataset with exactly the same 
name(s) as specified in argument \code{ccv} are looked for and, if present, 
are used for validating the predictions. If a character vector is provided, 
it has to have the same length as the one in \code{ccv}, and those variables 
will be used, in the given sequence, for validating the predictions.}

\item{pl}{Logical, defaults to TRUE. If predicted data should be plotted 
at all. If FALSE, only the calculation and the (possible) export to an excel 
file (see details) will be performed.}

\item{toxls}{'def' or logical. If left at the default 'def' the value from 
\code{cl_indepPred_exportToExcel} in the settings file is used. Set to TRUE 
or FALSE to directly control if export of predicted data to excel should be 
performed or not.}

\item{info}{'def' or logical. If left at the default 'def' the value from 
\code{cl_indepPred_showInfo} in the settings file is used. Set to TRUE 
or FALSE to directly control if information regarding the pairing of class 
variables in the model and those in the independent dataset used for validation 
should be displayed.}

\item{confirm}{'def' or logical. If left at the default 'def' the value from 
\code{cl_indepPred_confirm} in the settings file is used. Set to TRUE 
or FALSE to directly control if manual confirmation is required after the 
(possible) display of pairing-information (see above). Ignored if \code{info} 
is \code{FALSE}.}

\item{predList}{NULL or list. If left at the default null, the independent 
dataset is used to make predictions on all available classification models,
resulting in a list containing the predictions. If this list is in turn 
provided to \code{predList}, no calculations are performed and the results 
are plotted straight away.}

\item{apPlot}{The analysis procedure used for plotting.}

\item{...}{General plotting parameters, see XXX.}
}
\value{
An (invisible) list containing the numerical results of the 
predictions, and if parameter \code{toXls} is TRUE, these data are exported 
to an excel file in the results folder as well.
}
\description{
Calculate and plot predictions from independent, manually provided 
data. One or more of the implemented classifier-models (see e.g. 
\code{\link{calc_discrimAnalysis_args}} and the links to other classifier 
functions there) have to be present in the cube. The manually provided data 
in \code{indepDataset} are then projected into each single classification 
model present in the cube, and the results are validated using either the class 
variable present in the independent dataset that has the exactly same name as the 
class variable used to generate the models, or a user-defined class variable 
(parameter \code{icv}) can be used for validation.
}
\details{
For every single element in the cube, i.e. for every split-variation 
of the original dataset (as produced in \code{\link{gdmm}} the according 
subgroups within the independent dataset are constructed. In case of a dataset 
resulting in no observations the process is aborted. Also, the data pre- and
post- treatments (see \code{\link{dpt_modules}}) as defined in the analysis 
procedure used to produce the cube are applied to the independent dataset resp. 
to its subgroups as defined by the application of possible split-variables 
(see above).
If \code{toXls} is TRUE, the results of the predictions will be exported to Excel.
}
\examples{
\dontrun{
fd <- gfd() # loading or importing the rawdata
fd1 <- ssc(fd, C_Foo!="bar") # manually splitting up the dataset
fd2 <- ssc(fd, C_Foo=="bar") 
cube <- gdmm(fd1) # this is assuming that the standard analysis procedure is set
# up to perform a classifier method
# we are using `fd1` to produce the cube, and then `fd2` as independent dataset
# to perform independent predictions on all the models in the cube
predictions <- plot_classifX_indepPred(fd2, cube)
predictions <-  plot_classifX_indepPred(fd2, cube, icv="C_blabla", pl=FALSE)
# to redirect the original validation to class-variable "C_blabla"
}
}
\seealso{
Other Classification functions: \code{\link{calc_NNET_args}},
  \code{\link{calc_SVM_args}},
  \code{\link{calc_discrimAnalysis_args}},
  \code{\link{calc_randomForest_args}}

Other Plot functions: \code{\link{plot,aquap_cube,missing-method}},
  \code{\link{plot,aquap_data,missing-method}},
  \code{\link{plot_aqg}},
  \code{\link{plot_da,aquap_cube-method}},
  \code{\link{plot_nnet,aquap_cube-method}},
  \code{\link{plot_pca,aquap_cube-method}},
  \code{\link{plot_pls,aquap_cube-method}},
  \code{\link{plot_pls_indepPred}},
  \code{\link{plot_rnf,aquap_cube-method}},
  \code{\link{plot_simca,aquap_cube-method}},
  \code{\link{plot_svm,aquap_cube-method}}
}
\concept{Classification functions}
\concept{Plot functions}
