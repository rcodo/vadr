% Generated by roxygen2 (4.1.0): do not edit by hand
% Please edit documentation in R/dots.R
\name{dots_unpack}
\alias{dots_unpack}
\alias{unpack}
\title{Show information about a \dots object.}
\usage{
dots_unpack(...)

unpack(x)
}
\arguments{
\item{...}{Any number of arguments. Usually, you will pass in the
... from the body of a function,
e.g. \code{dots_unpack(...)}. Technically this creates a copy of the
dots list, but it should have identical effect.}

\item{x}{A \code{\link{dots}} object.}
}
\value{
A data frame, with one row for each element of
\code{\dots}, and columns: \describe{ \item{"name"}{The name of
each argument, or "" if present.}  \item{"envir"}{The enviroment
the promise came from.}  \item{"expr"}{The expression attached to
the promise. If the promise has been evaluated, this will be NULL.}
\item{"value"}{The value attached to the promise. If the promise
has not been evaluated, this will be NULL. (in reality is it
usually the "missing value," but it would cause too much
strangeness to return missing values from a function.}}
}
\description{
This unpacks the contents of a \dots object, returning the results
in a data frame. In the R implementation, a \dots object is a
pairlist of promises, usually bound to the special name
\code{"..."} and, when bound to that name, given special
dispensation by the R interpreter when appearing in the argument
list of a call. Dots objects are normally opaque to R code, and
usually don't explicitly appear in user code, but you can obtain a
\code{\dots} inside of R by using \code{get("...")}.
}
\note{
There are some problems with R printing data frames
containing lists of language objects (and more problems when
working with "missing value" objects.) Therefore this sets the
class on the columns to one that has a special as.character method.
}
\author{
Peter Meilstrup
}
\seealso{
dots_names dots_missing dots_expressions dots
}

