% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/net.loads.R
\name{net.loads}
\alias{net.loads}
\title{Network Loadings}
\usage{
net.loads(A, wc, pos.manifold = FALSE, min.load = 0, plot.NL = FALSE)
}
\arguments{
\item{A}{Matrix, data frame, or \code{\link[EGAnet]{EGA}} object.
An adjacency matrix of network data}

\item{wc}{Numeric or character vector.
A vector of community assignments.
If input into \code{A} is an \code{\link[EGAnet]{EGA}} object,
then \code{wc} is automatically detected}

\item{pos.manifold}{Boolean.
Should a positive manifold be applied (i.e., should
all dimensions be positively correlated)?
Defaults to \code{FALSE}.
Set to \code{TRUE} for a positive manifold}

\item{min.load}{Numeric.
Sets the minimum loading allowd in the standardized
network loading matrix. Values equal or greater than
the minimum loading are kept in the output. Values
less than the minimum loading are removed. This matrix can
be viewed using \code{print()} or \code{summary()}
Defaults to \code{0}}

\item{plot.NL}{Boolean.
Should proportional loadings be plotted?
Defaults to \code{FALSE}.
Set to \code{TRUE} for plot with pie charts
visualizing the proportion of loading associated with
each dimension}
}
\value{
Returns a list containing:

\item{unstd}{A matrix of the unstandardized within- and between-community
strength values for each node}

\item{std}{A matrix of the standardized within- and between-community
strength values for each node}

\item{minLoad}{The minimum loading to appear in summary of network loadings.
Use \code{print()} or \code{summary()} to view}

\item{plot}{A \code{\link[qgraph]{qgraph}} plot of the network loadings.
Use \code{plot} to view}
}
\description{
Computes the between- and within-community
\code{\link[NetworkToolbox]{strength}} of each item
for each community. This function uses the
\code{\link[NetworkToolbox]{comcat}} and
\code{\link[NetworkToolbox]{stable}} functions to calculate
the between- and within-community strength of each item, respectively.
}
\details{
Simulation studies have demonstrated that a node's strength
centrality is roughly equivalent to factor loadings
(Christensen, Golino, & Silvia, 2019; Hallquist, Wright, & Molenaar, in press).
Hallquist and colleagues (in press) found that node strength represented a
combination of dominant and cross-factor loadings. This function computes
each node's strength within each specified dimension, providing a rough
equivalent to factor loadings (including cross-loadings).

For more details, type \code{vignette("Network_Scores")}
}
\examples{

# Load data
wmt <- wmt2[,7:24]

\dontrun{
# Estimate EGA
ega.wmt <- EGA(wmt)

}

# Network loadings
net.loads(ega.wmt)

}
\references{
Christensen, A. P., & Golino, H. (2021).
On the equivalency of factor and network loadings.
\emph{Behavior Research Methods}.
\doi{10.3758/s13428-020-01500-6}

Christensen, A. P., Golino, H., & Silvia, P. J. (in press).
A psychometric network perspective on the validity and validation of personality trait questionnaires.
\emph{European Journal of Personality}.
\doi{10.1002/per.2265}

Hallquist, M., Wright, A. C. G., & Molenaar, P. C. M. (2019).
Problems with centrality measures in psychopathology symptom networks: Why network psychometrics cannot escape psychometric theory.
\emph{Multivariate Behavioral Research}, 1-25.
\doi{10.1080/00273171.2019.1640103}
}
\author{
Alexander P. Christensen <alexpaulchristensen@gmail.com> and Hudson Golino <hfg9s at virginia.edu>
}
