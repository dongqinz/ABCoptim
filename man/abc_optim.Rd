% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/RcppExports.R, R/abc_optim.R
\name{abc_cpp}
\alias{abc_answer}
\alias{abc_cpp}
\alias{abc_optim}
\alias{print.abc_answer}
\title{Artificial Bee Colony Optimization}
\usage{
abc_cpp(par, fn, ub = 1e+20, lb = -1e+20, FoodNumber = 20L,
  limit = 100L, maxCycle = 1000L, criter = 50L)

abc_optim(par, fn, ..., FoodNumber = 20, lb = -1e+20, ub = +1e+20,
  limit = 100, maxCycle = 1000, optiinteger = FALSE, criter = 50)

\method{print}{abc_answer}(x, ...)
}
\arguments{
\item{par}{Initial values for the parameters to be optimized over}

\item{fn}{A function to be minimized, with first argument of the vector of
parameters over which minimization is to take place. It should return a
scalar result.}

\item{ub}{Upper bound of the parameters to be optimized.}

\item{lb}{Lower bound of the parameters to be optimized.}

\item{FoodNumber}{Number of food sources to exploit. Notice that the param
\code{NP} has been deprecated.}

\item{limit}{Limit of a food source.}

\item{maxCycle}{Maximum number of iterations.}

\item{criter}{Stop criteria (numer of unchanged results) until stopping}

\item{...}{Further arguments to be passed to 'fn'.}

\item{optiinteger}{Whether to optimize binary parameters or not.}

\item{x}{An object of class \code{abc_answer}.}
}
\value{
An list of class \code{abc_answer}, holding the following elements:
\item{Foods}{Numeric matrix. Last position of the bees.}
\item{f}{Numeric vector. Value of the function evaluated at each set of \code{Foods}.}
\item{fitness}{Numeric vector. Fitness of each \code{Foods}.}
\item{trial}{Integer vector. Number of trials at each \code{Foods}.}
\item{value}{Numeric scalar. Value of the function evaluated at the optimum.}
\item{par}{Numeric vector. Optimum found.}
\item{counts}{Integer scalar. Number of cycles.}
\item{hist}{Numeric matrix. Trace of the global optimums.}
}
\description{
Implements Karaboga (2005) Artificial Bee Colony (ABC) Optimization algorithm.
}
\details{
This implementation of the ABC algorithm was developed based on the basic
version written in \code{C} and published at the algorithm's official
website (see references).

\code{abc_optim} and \code{abc_cpp} are two different implementations of the
algorithm, the former using pure \code{R} code, and the later using \code{C++},
via the \pkg{Rcpp} package. Besides of the output, another important
difference between the two implementations is speed, with \code{abc_cpp}
showing between 50\% and 100\% faster performance.


If \code{D} (the number of parameters to be optimzed) is greater than one,
then \code{lb} and \code{ub} can be either scalars (assuming that all the
parameters share the same boundaries) or vectors (the parameters have
different boundaries each other).
}
\examples{

# EXAMPLE 1: The minimum is at (pi,pi) ----------------------------------------
fun <- function(x) {
  -cos(x[1])*cos(x[2])*exp(-((x[1] - pi)^2 + (x[2] - pi)^2))
}

ans0 <- abc_optim(rep(0,2), fun, lb=-10, ub=10, criter=50)
ans0[c("par", "counts", "value")]

ans1 <- abc_cpp(rep(0,2), fun, lb=-10, ub=10, criter=50)
ans1[c("par", "counts", "value")]

# EXAMPLE 2: global minimum at about (-15.81515)
fw <- function (x)
  10*sin(0.3*x)*sin(1.3*x^2) + 0.00001*x^4 + 0.2*x+80

ans <- abc_optim(50, fw, lb=-100, ub=100, criter=100)
ans[c("par", "counts", "value")]

# EXAMPLE 3: 5D sphere, global minimum at about (0,0,0,0,0)
fs <- function(x) sum(x^2)

ans <- abc_optim(rep(10,5), fs, lb=-100, ub=100, criter=200)
ans[c("par", "counts", "value")]

}
\author{
George Vega Yon \email{g.vegayon@gmail.com}
}
\references{
D. Karaboga, \emph{An Idea based on Honey Bee Swarm for
Numerical Optimization}, tech. report TR06,Erciyes University, Engineering
Faculty, Computer Engineering Department, 2005
\url{http://mf.erciyes.edu.tr/abc/pub/tr06_2005.pdf}

Artificial Bee Colony (ABC) Algorithm (website)
\url{http://mf.erciyes.edu.tr/abc/index.htm}

Basic version of the algorithm implemented in \code{C} (ABC's official
website) \url{http://mf.erciyes.edu.tr/abc/form.aspx}
}
\keyword{optimization}

