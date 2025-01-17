% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/score_dw.R
\name{score_dw}
\alias{score_dw}
\alias{scoreDW}
\title{Durbin-Watson Score}
\usage{
score_dw(object, variable = NULL)

scoreDW(object, variable = NULL)
}
\arguments{
\item{object}{An object of class 'explainer' created with function \code{\link[DALEX]{explain}} from the DALEX package.}

\item{variable}{Name of model variable to order residuals.}
}
\value{
An object of class 'auditor_score'.
}
\description{
Score based on Durbin-Watson test statistic.
The score value is helpful in comparing models. It is worth pointing out that results of tests like p-value makes sense only
when the test assumptions are satisfied. Otherwise test statistic may be considered as a score.
}
\examples{
dragons <- DALEX::dragons[1:100, ]

# fit a model
model_lm <- lm(life_length ~ ., data = dragons)

# create an explainer
exp_lm <- DALEX::explain(model_lm, data = dragons, y = dragons$life_length)

# calculate score
score_dw(exp_lm)


}
