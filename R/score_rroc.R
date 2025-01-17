#' @title Area Over the Curve for RROC Curves
#'
#' @description The area over the Regression Receiver Operating Characteristic.
#'
#' @param object An object of class 'explainer' created with function \code{\link[DALEX]{explain}} from the DALEX package.
#'
#' @return an object of class 'score_audit'.
#'
#' @examples
#' dragons <- DALEX::dragons[1:100, ]
#'
#' # fit a model
#' model_lm <- lm(life_length ~ ., data = dragons)
#'
#' # create an explainer
#' exp_lm <- DALEX::explain(model_lm, data = dragons, y = dragons$life_length)
#'
#' # calculate score
#' score_rroc(exp_lm)
#'
#'
#' @seealso \code{\link{plot_rroc}}
#'
#' @references Hernández-Orallo, José. 2013. ‘ROC Curves for Regression’. Pattern Recognition 46 (12): 3395–3411.
#'
#' @rdname score_rroc
#'
#' @export


score_rroc <- function(object) {
  if(!("explainer" %in% class(object))) stop("The function requires an object created with explain() function from the DALEX package.")

  object <- model_residual(object)

  RROCF <- make_rroc_df(object)
  RROCF <- RROCF[RROCF$`_curve_` == TRUE,]
  x <- RROCF$`_rroc_x_`
  y <- RROCF$`_rroc_y_`

  aoc <- 0
  for (i in 2:(length(x) - 2)) {
    aoc <- aoc + 0.5 * (y[i+1] + y[i]) * (x[i+1] - x[i])
  }

  rroc_results <- list(
    name = "rroc",
    score = aoc
  )

  class(rroc_results) <- "score_audit"
  rroc_results

}


#' @rdname score_rroc
#' @export
scoreRROC<- function(object) {
  message("Please note that 'scoreRROC()' is now deprecated, it is better to use 'score_rroc()' instead.")
  score_rroc(object)
}
