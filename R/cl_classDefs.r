#' @include aquap2.r
#' @include cl_classFunctions.r

# classes ---------------------------------------
setClassUnion(name="matNull", members = c("matrix", "NULL"))
setClassUnion(name="dfNull", members = c("data.frame", "NULL"))
setClassUnion(name="listNull", members =c("list", "NULL"))
setClassUnion(name="numChar", members =c("numeric", "character"))
##	
setClass("aquap_md", contains="list")
setClass("aquap_ap", contains="list")
setClass("aquap_data", slots=c(ncpwl="numeric"), contains="data.frame")
setClass("aquap_cpt", slots=c(splitVars="list", wlSplit="list", smoothing="logical", noise="logical", len="numeric"))
setClass("aqg_calc", slots = c(ID="character", classVar="character", itemIndex="numeric", avg="matrix", colRep="numChar", possN="numeric", selInds="numeric", bootRes="matNull", rawSpec="dfNull", avgSpec="dfNull", subtrSpec="dfNull"))
setClassUnion(name="aqgCalcNull", members =c("aqg_calc", "NULL"))
setClass("aquap_set", slots=c(dataset="aquap_data", idString="character", pca="listNull", plsr="listNull", simca="listNull", aquagr="listNull")) 
setClass("aquap_cube", slots=c(metadata="aquap_md", anproc="aquap_ap", cp="data.frame", cpt="aquap_cpt"), contains="list")
setClass("aqg_cr", slots = c(res="list", ran="listNull"))


# methods ----------------------------------------
setMethod("show", signature(object = "aquap_data"), definition = show_aquap_data )
setMethod("show", signature(object = "aquap_cube"), definition = showCube )


#' @title 'aquap_data' Methods
#' @description Available methods for objects of class 'aquap_data'
#' @details For subscripting via \code{[}, only values for rownumbers are 
#' accepted.
#' @note \code{drop} is always set to \code{FALSE} for substrictping via \code{[}
#' @param x An object of class 'aquap_data'
#' @param i subsricpting indices for rows 
#' @docType methods
#' @rdname aquap_data-methods
#' @examples 
#' \dontrun{
#'  dataset <- gfd()
#'  ds <- dataset[1:5,]
#'  ds <- dataset[1:5] # the same as above
#' }
#' @export
setMethod("[", signature(x = "aquap_data"), definition = function(x, i) {
			drop=FALSE
			header <- x$header[i, , drop=drop]
			colRep <- x$colRep[i, , drop=drop]
			NIR <- matrix(x$NIR, nrow=nrow(x$NIR))[i, , drop=drop]	      
			rownames(NIR) <- rownames(x$NIR)[i]
			colnames(NIR) <- colnames(x$NIR)
			fd <- reFactor(data.frame(I(header), I(colRep), I(NIR)))
			return(new("aquap_data", fd, ncpwl=x@ncpwl))
		} )


#' @title *** Plot All Available Models ***
#' @description Plot all available analysis graphics from the models in the 
#' cube-object. Function \code{plot} is a convenience function, it basically 
#' calls  \code{plot_cube}, what is the work-horse for plotting the 
#' cube-object.
#' @details The graphical parameters are taken from the analysis procedure 
#' stored in the cube-object. Via the \code{...} argument it is possible to 
#' override any of these parameters. Please see \code{\link{anproc_file}} for a 
#' complete listing and e.g. \code{\link{plot_pca_args}} and there the other 
#' functions of the 'Plot arguments' family for a separate listing of possible 
#' arguments.
#' @usage plot(x, y, ...)
#' @param x An object of class 'aquap_cube' as produced by \code{\link{gdmm}}.
#' @param y will be ignored
#' @param ... Additional parameter to override the values of the graphical 
#' parameter in the analysis procedure file of the cube-object, see details.
#' @return A PDF or graphic device.
#' @docType methods
#' @rdname plot
#' @family Core functions
#' @family Plot functions
#' @export
#' @examples
#' \dontrun{
#'  dataset <- gfd()
#'  cube <- gdmm(dataset)
#'  plot(cube)
#'  plot(cube, what="all") # the same as above
#'  plot(cube, what="pca")
#' }
setGeneric("plot", function(x, y, ...) standardGeneric("plot"))

#' @rdname plot
setMethod("plot", signature(x = "aquap_cube"), definition = plot_cube_M)



setGeneric("getNcpwl", function(object) standardGeneric("getNcpwl"))
setMethod("getNcpwl", "aquap_data", function(object) object@ncpwl)

setGeneric("getExpName", function(object) standardGeneric("getExpName"))
setMethod("getExpName", "aquap_md", function(object) object$meta$expName)
setMethod("getExpName", "aquap_cube", function(object) object@metadata$meta$expName)

setGeneric("getPCAObject", function(object) standardGeneric("getPCAObject"))
setMethod("getPCAObject", "aquap_set", function(object) object@pca$model)

setGeneric("getPCAClassList", function(object) standardGeneric("getPCAClassList"))
setMethod("getPCAClassList", "aquap_ap", function(object) object$pca$colorBy)

setGeneric("getColRep", function(object) standardGeneric("getColRep"))
setMethod("getColRep", "aquap_set", function(object) object@dataset$colRep)

setGeneric("getHeader", function(object) standardGeneric("getHeader"))
setMethod("getHeader", "aquap_set", function(object) object@dataset$header)

setGeneric("getIdString", function(object) standardGeneric("getIdString"))
setMethod("getIdString", "aquap_set", function(object) object@idString)

setGeneric("getDataset", function(object) standardGeneric("getDataset"))
setMethod("getDataset", "aquap_set", function(object) object@dataset)
