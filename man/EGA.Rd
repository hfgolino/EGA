% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/EGA.R
\name{EGA}
\alias{EGA}
\title{Applies the Exploratory Graph Analysis technique}
\usage{
EGA(
  data,
  n = NULL,
  uni.method = c("expand", "LE"),
  corr = c("cor_auto", "pearson", "spearman"),
  model = c("glasso", "TMFG"),
  model.args = list(),
  algorithm = c("walktrap", "louvain"),
  algorithm.args = list(),
  plot.EGA = TRUE,
  plot.type = c("GGally", "qgraph"),
  plot.args = list(),
  verbose = TRUE,
  ...
)
}
\arguments{
\item{data}{Matrix or data frame.
Variables (down columns) or correlation matrix.
If the input is a correlation matrix,
then argument \code{n} (number of cases) is \strong{required}}

\item{n}{Integer.
Sample size if \code{data} provided is a correlation matrix}

\item{uni.method}{Character.
What unidimensionality method should be used? 
Defaults to \code{"LE"}.
Current options are:

\itemize{

\item{\strong{\code{expand}}}
{Expands the correlation matrix with four variables correlated .50.
If number of dimension returns 2 or less in check, then the data 
are unidimensional; otherwise, regular EGA with no matrix
expansion is used. This is the method used in the Golino et al. (2020)
\emph{Psychological Methods} simulation.}

\item{\strong{\code{LE}}}
{Applies the leading eigenvalue algorithm (\code{\link[igraph]{cluster_leading_eigen}})
on the empirical correlation matrix. If the number of dimensions is 1,
then the leading eigenvalue solution is used; otherwise, regular EGA
is used. This is the final method used in the Christensen, Garrido,
and Golino (2021) simulation.}

}}

\item{corr}{Type of correlation matrix to compute. The default uses \code{\link[qgraph]{cor_auto}}.
Current options are:

\itemize{

\item{\strong{\code{cor_auto}}}
{Computes the correlation matrix using the \code{\link[qgraph]{cor_auto}} function from
\code{\link[qgraph]{qgraph}}}.

\item{\strong{\code{pearson}}}
{Computes Pearson's correlation coefficient using the pairwise complete observations via
the \code{\link[stats]{cor}}} function.

\item{\strong{\code{spearman}}}
{Computes Spearman's correlation coefficient using the pairwise complete observations via
the \code{\link[stats]{cor}}} function.
}}

\item{model}{Character.
A string indicating the method to use.
Defaults to \code{"glasso"}.
Current options are:

\itemize{

\item{\strong{\code{glasso}}}
{Estimates the Gaussian graphical model using graphical LASSO with
extended Bayesian information criterion to select optimal regularization parameter}

\item{\strong{\code{TMFG}}}
{Estimates a Triangulated Maximally Filtered Graph}

}}

\item{model.args}{List.
A list of additional arguments for \code{\link[EGAnet]{EBICglasso.qgraph}}
or \code{\link[NetworkToolbox]{TMFG}}}

\item{algorithm}{A string indicating the algorithm to use or a function from \code{\link{igraph}}
Defaults to \code{"walktrap"}.
Current options are:

\itemize{

\item{\strong{\code{walktrap}}}
{Computes the Walktrap algorithm using \code{\link[igraph]{cluster_walktrap}}}

\item{\strong{\code{louvain}}}
{Computes the Walktrap algorithm using \code{\link[igraph]{cluster_louvain}}}

}}

\item{algorithm.args}{List.
A list of additional arguments for \code{\link[igraph]{cluster_walktrap}}, \code{\link[igraph]{cluster_louvain}},
or some other community detection algorithm function (see examples)}

\item{plot.EGA}{Boolean.
If \code{TRUE}, returns a plot of the network and its estimated dimensions.
Defaults to \code{TRUE}}

\item{plot.type}{Character.
Plot system to use.
Current options are \code{\link[qgraph]{qgraph}} and \code{\link{GGally}}.
Defaults to \code{"GGally"}}

\item{plot.args}{List.
A list of additional arguments for the network plot.
For \code{plot.type = "qgraph"}:

\itemize{

\item{\strong{\code{vsize}}}
{Size of the nodes. Defaults to 6.}

}
For \code{plot.type = "GGally"} (see \code{\link[GGally]{ggnet2}} for
full list of arguments):

\itemize{

\item{\strong{\code{vsize}}}
{Size of the nodes. Defaults to 6.}

\item{\strong{\code{label.size}}}
{Size of the labels. Defaults to 5.}

\item{\strong{\code{alpha}}}
{The level of transparency of the nodes, which might be a single value or a vector of values. Defaults to 0.7.}

\item{\strong{\code{edge.alpha}}}
{The level of transparency of the edges, which might be a single value or a vector of values. Defaults to 0.4.}

 \item{\strong{\code{legend.names}}}
{A vector with names for each dimension}

\item{\strong{\code{color.palette}}}
{The color palette for the nodes. For custom colors,
enter HEX codes for each dimension in a vector.
See \code{\link[EGAnet]{color_palette_EGA}} for
more details and examples}

}}

\item{verbose}{Boolean.
Should network estimation parameters be printed?
Defaults to \code{TRUE}.
Set to \code{FALSE} for no print out}

\item{...}{Additional arguments.
Used for deprecated arguments from previous versions of \code{\link{EGA}}}
}
\value{
Returns a list containing:

\item{network}{A symmetric network estimated using either the
\code{\link{EBICglasso.qgraph}} or \code{\link[NetworkToolbox]{TMFG}}}

\item{wc}{A vector representing the community (dimension) membership
of each node in the network. \code{NA} values mean that the node
was disconnected from the network}

\item{n.dim}{A scalar of how many total dimensions were identified in the network}

\item{cor.data}{The zero-order correlation matrix}
}
\description{
Estimates the number of dimensions of a given dataset or correlation matrix
using the graphical lasso (\code{\link{EBICglasso.qgraph}}) or the
Triangulated Maximally Filtered Graph (\code{\link[NetworkToolbox]{TMFG}})
network estimation methods.
}
\details{
Two community detection algorithms, Walktrap (Pons & Latapy, 2006) and
Louvain (Blondel et al., 2008), are pre-programmed because of their
superior performance in simulation studies on psychological
data generated from factor models (Christensen & Golino; 2020; Golino et al., 2020).
Notably, any community detection algorithm from the \code{\link{igraph}}
can be used to estimate the number of communities (see examples).
}
\examples{
\donttest{# Estimate EGA
## plot.type = "qqraph" used for CRAN checks
## plot.type = "GGally" is the default
ega.wmt <- EGA(data = wmt2[,7:24], plot.type = "qgraph")

# Summary statistics
summary(ega.wmt)

# Estimate EGAtmfg
ega.wmt <- EGA(data = wmt2[,7:24], model = "TMFG", plot.type = "qgraph")

# Estimate EGA with Louvain algorithm
ega.wmt <- EGA(data = wmt2[,7:24], algorithm = "louvain", plot.type = "qgraph")

# Estimate EGA with Spinglass algorithm
ega.wmt <- EGA(data = wmt2[,7:24],
algorithm = igraph::cluster_spinglass, plot.type = "qgraph")

# Estimate EGA
ega.intel <- EGA(data = intelligenceBattery[,8:66], model = "glasso", plot.EGA = FALSE)

# Summary statistics
summary(ega.intel)
}

 \dontshow{# Fast for CRAN checks
# Pearson's correlation matrix
wmt <- cor(wmt2[,7:24])

# Estimate EGA
ega.wmt <- EGA(data = wmt, n = nrow(wmt2), model = "glasso", plot.EGA = FALSE)

}

}
\references{
# Louvain algorithm \cr
Blondel, V. D., Guillaume, J.-L., Lambiotte, R., & Lefebvre, E. (2008).
Fast unfolding of communities in large networks.
\emph{Journal of Statistical Mechanics: Theory and Experiment}, \emph{2008}, P10008.

# Compared all \emph{igraph} community detections algorithms, introduced Louvain algorithm, simulation with continuous and polytomous data \cr
# Also implements the Leading Eigenvalue unidimensional method \cr
Christensen, A. P., Garrido, L. E., & Golino, H. (2021).
Estimating factors with psychometric networks: A Monte Carlo simulation comparing community detection algorithms.
\emph{PsyArXiv}.
\doi{10.31234/osf.io/hz89e}

# Original simulation and implementation of EGA \cr
Golino, H. F., & Epskamp, S. (2017).
Exploratory graph analysis: A new approach for estimating the number of dimensions in psychological research.
\emph{PLoS ONE}, \emph{12}, e0174035..
\doi{10.1371/journal.pone.0174035}

Golino, H. F., & Demetriou, A. (2017).
Estimating the dimensionality of intelligence like data using Exploratory Graph Analysis.
\emph{Intelligence}, \emph{62}, 54-70.
\doi{10.1016/j.intell.2017.02.007}

# Current implementation of EGA, introduced unidimensional checks, continuous and dichotomous data \cr
Golino, H., Shi, D., Christensen, A. P., Garrido, L. E., Nieto, M. D., Sadana, R., & Thiyagarajan, J. A. (2020).
Investigating the performance of Exploratory Graph Analysis and traditional techniques to identify the number of latent factors: A simulation and tutorial.
\emph{Psychological Methods}, \emph{25}, 292-320.
\doi{10.1037/met0000255}

# Walktrap algorithm \cr
Pons, P., & Latapy, M. (2006).
Computing communities in large networks using random walks.
\emph{Journal of Graph Algorithms and Applications}, \emph{10}, 191-218.
\doi{10.7155/jgaa.00185}
}
\seealso{
\code{\link{bootEGA}} to investigate the stability of EGA's estimation via bootstrap
and \code{\link{CFA}} to verify the fit of the structure suggested by EGA using confirmatory factor analysis.
}
\author{
Hudson Golino <hfg9s at virginia.edu>, Alexander P. Christensen <alexpaulchristensen at gmail.com>, Maria Dolores Nieto <acinodam at gmail.com> and Luis E. Garrido <garrido.luiseduardo at gmail.com>
}
