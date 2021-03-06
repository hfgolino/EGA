#' Applies the Exploratory Graph Analysis technique
#'
#' Estimates the number of dimensions of a given dataset or correlation matrix
#' using the graphical lasso (\code{\link{EBICglasso.qgraph}}) or the
#' Triangulated Maximally Filtered Graph (\code{\link[NetworkToolbox]{TMFG}})
#' network estimation methods.
#'
#' Two community detection algorithms, Walktrap (Pons & Latapy, 2006) and
#' Louvain (Blondel et al., 2008), are pre-programmed because of their
#' superior performance in simulation studies on psychological
#' data generated from factor models (Christensen & Golino; 2020; Golino et al., 2020).
#' Notably, any community detection algorithm from the \code{\link{igraph}}
#' can be used to estimate the number of communities (see examples).
#'
#' @param data Matrix or data frame.
#' Variables (down columns) or correlation matrix.
#' If the input is a correlation matrix,
#' then argument \code{n} (number of cases) is \strong{required}
#'
#' @param n Integer.
#' Sample size if \code{data} provided is a correlation matrix
#' 
#' @param uni.method Character.
#' What unidimensionality method should be used? 
#' Defaults to \code{"LE"}.
#' Current options are:
#' 
#' \itemize{
#'
#' \item{\strong{\code{expand}}}
#' {Expands the correlation matrix with four variables correlated .50.
#' If number of dimension returns 2 or less in check, then the data 
#' are unidimensional; otherwise, regular EGA with no matrix
#' expansion is used. This is the method used in the Golino et al. (2020)
#' \emph{Psychological Methods} simulation.}
#'
#' \item{\strong{\code{LE}}}
#' {Applies the leading eigenvalue algorithm (\code{\link[igraph]{cluster_leading_eigen}})
#' on the empirical correlation matrix. If the number of dimensions is 1,
#' then the leading eigenvalue solution is used; otherwise, regular EGA
#' is used. This is the final method used in the Christensen, Garrido,
#' and Golino (2021) simulation.}
#' 
#' }
#' 
#' @param corr Type of correlation matrix to compute. The default uses \code{\link[qgraph]{cor_auto}}.
#' Current options are:
#'
#' \itemize{
#'
#' \item{\strong{\code{cor_auto}}}
#' {Computes the correlation matrix using the \code{\link[qgraph]{cor_auto}} function from
#' \code{\link[qgraph]{qgraph}}}.
#'
#' \item{\strong{\code{pearson}}}
#' {Computes Pearson's correlation coefficient using the pairwise complete observations via
#' the \code{\link[stats]{cor}}} function.
#'
#' \item{\strong{\code{spearman}}}
#' {Computes Spearman's correlation coefficient using the pairwise complete observations via
#' the \code{\link[stats]{cor}}} function.
#' }
#'
#' @param model Character.
#' A string indicating the method to use.
#' Defaults to \code{"glasso"}.
#' Current options are:
#'
#' \itemize{
#'
#' \item{\strong{\code{glasso}}}
#' {Estimates the Gaussian graphical model using graphical LASSO with
#' extended Bayesian information criterion to select optimal regularization parameter}
#'
#' \item{\strong{\code{TMFG}}}
#' {Estimates a Triangulated Maximally Filtered Graph}
#'
#' }
#'
#' @param model.args List.
#' A list of additional arguments for \code{\link[EGAnet]{EBICglasso.qgraph}}
#' or \code{\link[NetworkToolbox]{TMFG}}
#'
#' @param algorithm A string indicating the algorithm to use or a function from \code{\link{igraph}}
#' Defaults to \code{"walktrap"}.
#' Current options are:
#'
#' \itemize{
#'
#' \item{\strong{\code{walktrap}}}
#' {Computes the Walktrap algorithm using \code{\link[igraph]{cluster_walktrap}}}
#'
#' \item{\strong{\code{louvain}}}
#' {Computes the Walktrap algorithm using \code{\link[igraph]{cluster_louvain}}}
#'
#' }
#'
#' @param algorithm.args List.
#' A list of additional arguments for \code{\link[igraph]{cluster_walktrap}}, \code{\link[igraph]{cluster_louvain}},
#' or some other community detection algorithm function (see examples)
#'
#' @param plot.EGA Boolean.
#' If \code{TRUE}, returns a plot of the network and its estimated dimensions.
#' Defaults to \code{TRUE}
#'
#' @param plot.type Character.
#' Plot system to use.
#' Current options are \code{\link[qgraph]{qgraph}} and \code{\link{GGally}}.
#' Defaults to \code{"GGally"}
#'
#' @param plot.args List.
#' A list of additional arguments for the network plot.
#' For \code{plot.type = "qgraph"}:
#'
#' \itemize{
#'
#' \item{\strong{\code{vsize}}}
#' {Size of the nodes. Defaults to 6.}
#'
#'}
#' For \code{plot.type = "GGally"} (see \code{\link[GGally]{ggnet2}} for
#' full list of arguments):
#'
#' \itemize{
#'
#' \item{\strong{\code{vsize}}}
#' {Size of the nodes. Defaults to 6.}
#'
#' \item{\strong{\code{label.size}}}
#' {Size of the labels. Defaults to 5.}
#'
#' \item{\strong{\code{alpha}}}
#' {The level of transparency of the nodes, which might be a single value or a vector of values. Defaults to 0.7.}
#'
#' \item{\strong{\code{edge.alpha}}}
#' {The level of transparency of the edges, which might be a single value or a vector of values. Defaults to 0.4.}
#'
#'  \item{\strong{\code{legend.names}}}
#' {A vector with names for each dimension}
#'
#' \item{\strong{\code{color.palette}}}
#' {The color palette for the nodes. For custom colors,
#' enter HEX codes for each dimension in a vector.
#' See \code{\link[EGAnet]{color_palette_EGA}} for
#' more details and examples}
#'
#' }
#'
#' @param verbose Boolean.
#' Should network estimation parameters be printed?
#' Defaults to \code{TRUE}.
#' Set to \code{FALSE} for no print out
#'
#' @param ... Additional arguments.
#' Used for deprecated arguments from previous versions of \code{\link{EGA}}
#'
#' @author Hudson Golino <hfg9s at virginia.edu>, Alexander P. Christensen <alexpaulchristensen at gmail.com>, Maria Dolores Nieto <acinodam at gmail.com> and Luis E. Garrido <garrido.luiseduardo at gmail.com>
#'
#' @return Returns a list containing:
#'
#' \item{network}{A symmetric network estimated using either the
#' \code{\link{EBICglasso.qgraph}} or \code{\link[NetworkToolbox]{TMFG}}}
#'
#' \item{wc}{A vector representing the community (dimension) membership
#' of each node in the network. \code{NA} values mean that the node
#' was disconnected from the network}
#'
#' \item{n.dim}{A scalar of how many total dimensions were identified in the network}
#'
#' \item{cor.data}{The zero-order correlation matrix}
#'
#' @examples
#' \donttest{# Estimate EGA
#' ## plot.type = "qqraph" used for CRAN checks
#' ## plot.type = "GGally" is the default
#' ega.wmt <- EGA(data = wmt2[,7:24], plot.type = "qgraph")
#'
#' # Summary statistics
#' summary(ega.wmt)
#'
#' # Estimate EGAtmfg
#' ega.wmt <- EGA(data = wmt2[,7:24], model = "TMFG", plot.type = "qgraph")
#'
#' # Estimate EGA with Louvain algorithm
#' ega.wmt <- EGA(data = wmt2[,7:24], algorithm = "louvain", plot.type = "qgraph")
#'
#' # Estimate EGA with Spinglass algorithm
#' ega.wmt <- EGA(data = wmt2[,7:24],
#' algorithm = igraph::cluster_spinglass, plot.type = "qgraph")
#'
#' # Estimate EGA
#' ega.intel <- EGA(data = intelligenceBattery[,8:66], model = "glasso", plot.EGA = FALSE)
#'
#' # Summary statistics
#' summary(ega.intel)
#' }
#'
#'  \dontshow{# Fast for CRAN checks
#' # Pearson's correlation matrix
#' wmt <- cor(wmt2[,7:24])
#'
#' # Estimate EGA
#' ega.wmt <- EGA(data = wmt, n = nrow(wmt2), model = "glasso", plot.EGA = FALSE)
#'
#' }
#'
#' @seealso \code{\link{bootEGA}} to investigate the stability of EGA's estimation via bootstrap
#' and \code{\link{CFA}} to verify the fit of the structure suggested by EGA using confirmatory factor analysis.
#'
#' @references
#' # Louvain algorithm \cr
#' Blondel, V. D., Guillaume, J.-L., Lambiotte, R., & Lefebvre, E. (2008).
#' Fast unfolding of communities in large networks.
#' \emph{Journal of Statistical Mechanics: Theory and Experiment}, \emph{2008}, P10008.
#'
#' # Compared all \emph{igraph} community detections algorithms, introduced Louvain algorithm, simulation with continuous and polytomous data \cr
#' # Also implements the Leading Eigenvalue unidimensional method \cr
#' Christensen, A. P., Garrido, L. E., & Golino, H. (2021).
#' Estimating factors with psychometric networks: A Monte Carlo simulation comparing community detection algorithms.
#' \emph{PsyArXiv}.
#' \doi{10.31234/osf.io/hz89e}
#'
#' # Original simulation and implementation of EGA \cr
#' Golino, H. F., & Epskamp, S. (2017).
#' Exploratory graph analysis: A new approach for estimating the number of dimensions in psychological research.
#' \emph{PLoS ONE}, \emph{12}, e0174035..
#' \doi{10.1371/journal.pone.0174035}
#'
#' Golino, H. F., & Demetriou, A. (2017).
#' Estimating the dimensionality of intelligence like data using Exploratory Graph Analysis.
#' \emph{Intelligence}, \emph{62}, 54-70.
#' \doi{10.1016/j.intell.2017.02.007}
#'
#' # Current implementation of EGA, introduced unidimensional checks, continuous and dichotomous data \cr
#' Golino, H., Shi, D., Christensen, A. P., Garrido, L. E., Nieto, M. D., Sadana, R., & Thiyagarajan, J. A. (2020).
#' Investigating the performance of Exploratory Graph Analysis and traditional techniques to identify the number of latent factors: A simulation and tutorial.
#' \emph{Psychological Methods}, \emph{25}, 292-320.
#' \doi{10.1037/met0000255}
#'
#' # Walktrap algorithm \cr
#' Pons, P., & Latapy, M. (2006).
#' Computing communities in large networks using random walks.
#' \emph{Journal of Graph Algorithms and Applications}, \emph{10}, 191-218.
#' \doi{10.7155/jgaa.00185}
#'
#' @importFrom stats cor rnorm runif na.omit
#'
#' @export
#'
# Updated 08.03.2021
# LE adjustment 08.03.2021
## EGA Function to detect unidimensionality:
EGA <- function (data, n = NULL, uni.method = c("expand", "LE"),
                 corr = c("cor_auto", "pearson", "spearman"),
                 model = c("glasso", "TMFG"), model.args = list(),
                 algorithm = c("walktrap", "louvain"), algorithm.args = list(),
                 plot.EGA = TRUE, plot.type = c("GGally", "qgraph"),
                 plot.args = list(), verbose = TRUE,
                 ...) {

  # Get additional arguments
  add.args <- list(...)

  # Check if steps has been input as an argument
  if("steps" %in% names(add.args)){

    # Give deprecation warning
    warning(
      paste(
        "The 'steps' argument has been deprecated in all EGA functions.\n\nInstead use: algorithm.args = list(steps = ", add.args$steps, ")",
        sep = ""
      )
    )

    # Handle the number of steps appropriately
    algorithm.args$steps <- add.args$steps
  }
  
  # Check if uni has been input as an argument
  if("uni" %in% names(add.args)){
    
    # Give deprecation warning
    warning(
      "The 'uni' argument has been deprecated in all EGA functions."
    )
  }

  #### ARGUMENTS HANDLING ####
  
  if(missing(uni.method)){
    uni.method <- "LE"
  }else{uni.method <- match.arg(uni.method)}
  
  # Check if uni.method = "LE" has been used
  if(uni.method == "LE"){
    # Give change warning
    warning(
      paste(
        "Previous versions of EGAnet (<= 0.9.8) checked unidimensionality using",
        styletext('uni.method = "expand"', defaults = "underline"),
        "as the default"
      )
    )
  }else if(uni.method == "expand"){
    # Give change warning
    warning(
      paste(
        "Newer evidence suggests that",
        styletext('uni.method = "LE"', defaults = "underline"),
        'is more accurate than uni.method = "expand" (see Christensen, Garrido, & Golino, 2021 in references).',
        '\n\nIt\'s recommended to use uni.method = "LE"'
      )
    )
  }
  
  if(missing(corr)){
    corr <- "cor_auto"
  }else{corr <- match.arg(corr)}

  if(missing(model)){
    model <- "glasso"
  }else{model <- match.arg(model)}

  if(missing(algorithm)){
    algorithm <- "walktrap"
  }else if(!is.function(algorithm)){
    algorithm <- tolower(match.arg(algorithm))
  }

  if(missing(plot.type)){
    plot.type <- "GGally"
  }else{plot.type <- match.arg(plot.type)}

  if(plot.type == "GGally"){

    default.args <- formals(GGally::ggnet2)
    ega.default.args <- list(node.size = 6, edge.size = 6, alpha = 0.7, label.size = 5,
                             edge.alpha = 0.4, layout.exp = 0.2)
    default.args[names(ega.default.args)]  <- ega.default.args
    default.args <- default.args[-length(default.args)]


    if("vsize" %in% names(plot.args)){
      plot.args$size <- plot.args$vsize
      plot.args$vsize <- NULL
    }

    if("color.palette" %in% names(plot.args)){
      color.palette <- plot.args$color.palette
    }else{color.palette <- "polychrome"}

    if(any(names(plot.args) %in% names(default.args))){
      target.args <- plot.args[which(names(plot.args) %in% names(default.args))]
      default.args[names(target.args)] <- target.args
    }

    plot.args <- default.args

  }

  #### ARGUMENTS HANDLING ####

  # Check for correlation matrix or data
  if(nrow(data) == ncol(data)){ ## Correlation matrix

    # Check for column names
    if(is.null(colnames(data))){
      colnames(data) <- paste("V", 1:ncol(data), sep = "")
    }

    # Check for number of cases
    if(missing(n)){
      stop("There is no input for argument 'n'. Number of cases must be input when the matrix is square.")
    }

    # Multidimensional result
    ## Ensures proper partial correlations
    multi.res <- EGA.estimate(data = data, n = n,
                              model = model, model.args = model.args,
                              algorithm = algorithm, algorithm.args = algorithm.args,
                              verbose = verbose)

    # Unidimensional result
    if(uni.method == "expand"){
      
      # Check for Spinglass algorithm
      if(is.function(algorithm)){
        
        # spins argument is used to identify Spinglass algorithm
        if("spins" %in% methods::formalArgs(algorithm)){
          
          # Generate data
          uni.data <- MASS::mvrnorm(n = n, mu = rep(0, ncol(data)), Sigma = data)
          
          # Simulate data from unidimensional factor model
          sim.data <- sim.func(data = uni.data, nvar = 4, nfact = 1, load = .70)
          
        }else{
          
          # Expand correlation matrix
          sim.data <- expand.corr(data)
          
        }
        
      }else{# Do regular adjustment
        
        # Expand correlation matrix
        sim.data <- expand.corr(data)
        
      }
      
      # Estimate unidimensional EGA
      uni.res <- EGA.estimate(data = sim.data, n = n,
                              model = model, model.args = model.args,
                              algorithm = algorithm, algorithm.args = algorithm.args,
                              verbose = FALSE)
      
      # Set up results
      if(uni.res$n.dim <= 2){ ## If unidimensional
        
        n.dim <- uni.res$n.dim
        cor.data <- data
        estimated.network <- multi.res$network
        wc <- uni.res$wc[-c(1:4)]
        if(model == "glasso"){
          gamma <- uni.res$gamma
          lambda <- uni.res$lambda
        }
        
      }else{ ## If not
        
        n.dim <- multi.res$n.dim
        cor.data <- multi.res$cor.data
        estimated.network <- multi.res$network
        wc <- multi.res$wc
        if(model == "glasso"){
          gamma <- multi.res$gamma
          lambda <- multi.res$lambda
        }
        
      }
      
    }else if(uni.method == "LE"){
      
      # Leading eigenvalue approach for one and two dimensions
      wc <- igraph::cluster_leading_eigen(NetworkToolbox::convert2igraph(abs(data)))$membership
      names(wc) <- colnames(data)
      n.dim <- length(na.omit(unique(wc)))
      
      # Set up results
      if(n.dim == 1){ ## Leading eigenvalue
        
        cor.data <- data
        estimated.network <- multi.res$network
        if(model == "glasso"){
          gamma <- multi.res$gamma
          lambda <- multi.res$lambda
        }
        
      }else{ ## If not
        
        n.dim <- multi.res$n.dim
        cor.data <- multi.res$cor.data
        estimated.network <- multi.res$network
        wc <- multi.res$wc
        if(model == "glasso"){
          gamma <- multi.res$gamma
          lambda <- multi.res$lambda
        }
        
      }
      
    }
    
  }else{ ## Data

    # Check for column names
    if(is.null(colnames(data))){
      colnames(data) <- paste("V", 1:ncol(data), sep = "")
    }

    # Get number of cases
    n <- nrow(data)

    # Check for unidimensional structure
    if(uni.method == "expand"){
      
      # Check for Spinglass algorithm
      if(is.function(algorithm)){
        
        # spins argument is used to identify Spinglass algorithm
        if("spins" %in% methods::formalArgs(algorithm)){
          
          # Simulate data from unidimensional factor model
          sim.data <- sim.func(data = data, nvar = 4, nfact = 1, load = .70)
          
          ## Compute correlation matrix
          cor.data <- switch(corr,
                             "cor_auto" = qgraph::cor_auto(sim.data),
                             "pearson" = cor(sim.data, use = "pairwise.complete.obs"),
                             "spearman" = cor(sim.data, method = "spearman", use = "pairwise.complete.obs")
          )
          
        }else{
          
          ## Compute correlation matrix
          cor.data <- switch(corr,
                             "cor_auto" = qgraph::cor_auto(data),
                             "pearson" = cor(data, use = "pairwise.complete.obs"),
                             "spearman" = cor(data, method = "spearman", use = "pairwise.complete.obs")
          )
          
          ## Expand correlation matrix
          cor.data <- expand.corr(cor.data)
          
        }
        
      }else{# Do regular adjustment
        
        ## Compute correlation matrix
        cor.data <- switch(corr,
                           "cor_auto" = qgraph::cor_auto(data),
                           "pearson" = cor(data, use = "pairwise.complete.obs"),
                           "spearman" = cor(data, method = "spearman", use = "pairwise.complete.obs")
        )
        
        ## Expand correlation matrix
        cor.data <- expand.corr(cor.data)
        
      }
      
      # Unidimensional result
      uni.res <- EGA.estimate(data = cor.data, n = n,
                              model = model, model.args = model.args,
                              algorithm = algorithm, algorithm.args = algorithm.args,
                              verbose = verbose)
      
      ## Remove simulated data for multidimensional result
      cor.data <- cor.data[-c(1:4),-c(1:4)]
      
      # Multidimensional result
      multi.res <- EGA.estimate(cor.data, n = n,
                                model = model, model.args = model.args,
                                algorithm = algorithm, algorithm.args = algorithm.args,
                                verbose = FALSE)
      
      if(uni.res$n.dim <= 2 & !is.infinite(multi.res$n.dim)){
        
        n.dim <- uni.res$n.dim
        estimated.network <- multi.res$network
        wc <- uni.res$wc[-c(1:4)]
        if(model == "glasso"){
          gamma <- uni.res$gamma
          lambda <- uni.res$lambda
        }
        
      }else{
        
        n.dim <- multi.res$n.dim
        estimated.network <- multi.res$network
        wc <- multi.res$wc
        
        if(model == "glasso"){
          gamma <- multi.res$gamma
          lambda <- multi.res$lambda
        }
        
      }
      
    }else if(uni.method == "LE"){
      
      ## Compute correlation matrix
      cor.data <- switch(corr,
                         "cor_auto" = qgraph::cor_auto(data),
                         "pearson" = cor(data, use = "pairwise.complete.obs"),
                         "spearman" = cor(data, method = "spearman", use = "pairwise.complete.obs")
      )
      
      # Leading eigenvalue approach for one and two dimensions
      wc <- igraph::cluster_leading_eigen(NetworkToolbox::convert2igraph(abs(cor.data)))$membership
      names(wc) <- colnames(cor.data)
      n.dim <- length(na.omit(unique(wc)))
      
      # Multidimensional result
      multi.res <- EGA.estimate(cor.data, n = n,
                                model = model, model.args = model.args,
                                algorithm = algorithm, algorithm.args = algorithm.args,
                                verbose = FALSE)
      
      
      
      # Set up results
      if(n.dim == 1){ ## Leading eigenvalue

        estimated.network <- multi.res$network
        if(model == "glasso"){
          gamma <- multi.res$gamma
          lambda <- multi.res$lambda
        }
        
      }else{ ## If not
        
        n.dim <- multi.res$n.dim
        estimated.network <- multi.res$network
        wc <- multi.res$wc
        
        if(model == "glasso"){
          gamma <- multi.res$gamma
          lambda <- multi.res$lambda
        }
        
      }
      
    }

  }

  a <- list()
  # Returning only communities that have at least two items:
  if(length(unique(na.omit(wc)))>1){
    indices <- seq_along(wc)
    indices2 <- indices[wc %in% wc[duplicated(wc)]]
    wc[indices[-indices2]] <- NA
    a$n.dim <- length(unique(na.omit(wc)))
  }else{
    a$n.dim <- length(unique(na.omit(wc)))
  }

  a$correlation <- cor.data
  a$network <- estimated.network
  if(a$n.dim == 1){wc[1:length(wc)] <- 1}
  
  # Check for reordering
  if(any(is.na(wc))){
    
    # Get names
    reord <- sort(na.omit(unique(wc)))
    names(reord) <- 1:a$n.dim
    
    # Reorder
    for(i in 1:length(reord)){
      wc[wc == reord[i]] <- as.numeric(names(reord)[i])
    }
    
  }

  a$wc <- wc
  
  # check if data has column names
  if(is.null(colnames(data)))
  {
    dim.variables <- data.frame(items = paste("V", 1:ncol(data), sep = ""), dimension = a$wc)
  }else{dim.variables <- data.frame(items = colnames(data), dimension = a$wc)}
  dim.variables <- dim.variables[order(dim.variables[, 2]),]
  a$dim.variables <- dim.variables

  if (plot.EGA == TRUE) {
    if (plot.type == "qgraph"){
      if(a$n.dim < 2){

        if(a$n.dim != 0){
          ega.plot <- qgraph::qgraph(a$network, layout = "spring",
                                     vsize = plot.args$vsize, groups = as.factor(a$wc), label.prop = 1, legend = FALSE)
        }
      }else{
        ega.plot <- qgraph::qgraph(a$network, layout = "spring",
                                   vsize = plot.args$vsize, groups = as.factor(a$wc), label.prop = 1, legend = TRUE)
      }
    }else if(plot.type == "GGally"){
      
      # weighted  network
      network1 <- network::network(a$network,
                                   ignore.eval = FALSE,
                                   names.eval = "weights",
                                   directed = FALSE)
      network::set.vertex.attribute(network1, attrname= "Communities", value = a$wc)
      network::set.vertex.attribute(network1, attrname= "Names", value = network::network.vertex.names(network1))
      network::set.edge.attribute(network1, "color", ifelse(network::get.edge.value(network1, "weights") > 0, "darkgreen", "red"))
      network::set.edge.value(network1,attrname="AbsWeights",value=abs(a$network))
      network::set.edge.value(network1,attrname="ScaledWeights",
                              value=matrix(rescale.edges(a$network, plot.args$edge.size),
                                           nrow = nrow(a$network),
                                           ncol = ncol(a$network)))
      
      # Layout "Spring"
      graph1 <- NetworkToolbox::convert2igraph(a$network)
      edge.list <- igraph::as_edgelist(graph1)
      layout.spring <- qgraph::qgraph.layout.fruchtermanreingold(edgelist = edge.list,
                                                                 weights =
                                                                   abs(igraph::E(graph1)$weight/max(abs(igraph::E(graph1)$weight)))^2,
                                                                 vcount = ncol(a$network))
      
      set.seed(1234)
      plot.args$net <- network1
      plot.args$node.color <- "Communities"
      plot.args$node.alpha <- plot.args$alpha
      plot.args$node.shape <- plot.args$shape
      plot.args$edge.color <- "color"
      plot.args$edge.size <- "ScaledWeights"
      plot.args$color.palette <- NULL
      plot.args$palette <- NULL
      
      lower <- abs(a$network[lower.tri(a$network)])
      non.zero <- sqrt(lower[lower != 0])
      
      plot.args$edge.alpha <- non.zero
      plot.args$mode <- layout.spring
      plot.args$label <- colnames(a$network)
      plot.args$node.label <- plot.args$label
      if(plot.args$label.size == "max_size/2"){plot.args$label.size <- plot.args$node.size/2}
      if(plot.args$edge.label.size == "max_size/2"){plot.args$edge.label.size <- plot.args$node.size/2}
      
      ega.plot <- suppressMessages(
        do.call(GGally::ggnet2, plot.args) +
          ggplot2::theme(legend.title = ggplot2::element_blank()) +
          ggplot2::scale_color_manual(values = color_palette_EGA(color.palette, na.omit(a$wc)),
                                      breaks = sort(a$wc)) +
          ggplot2::guides(
            color = ggplot2::guide_legend(override.aes = list(
              size = plot.args$size,
              alpha = plot.args$alpha
            ))
          )
      )
      
      plot(ega.plot)
    }
    
  }else{ega.plot <- qgraph::qgraph(a$network, DoNotPlot = TRUE)}

  # check for variable labels in qgraph
  if(plot.type == "qgraph"){
    if(is.null(names(ega.plot$graphAttributes$Nodes$labels)))
    {names(ega.plot$graphAttributes$Nodes$labels) <- paste(1:ncol(data))}

    row.names(a$dim.variables) <- ega.plot$graphAttributes$Nodes$labels[match(a$dim.variables$items, names(ega.plot$graphAttributes$Nodes$labels))]
  }

  a$EGA.type <- ifelse(a$n.dim <= 2, "Unidimensional EGA", "Traditional EGA")
  if(exists("ega.plot")){
    a$Plot.EGA <- ega.plot
  }

  # Get arguments
  args <- list()

  ## Get model and algorithm arguments
  args$uni.method <- uni.method
  args$model <- model
  args$algorithm <- algorithm

  ## Check if glasso was used
  if(model == "glasso")
  {
    args$gamma <- gamma
    args$lambda <- lambda
  }

  ## Check if walktrap was used
  if(!is.function(algorithm)){

    if(algorithm == "walktrap"){

      if("steps" %in% names(algorithm.args)){
        args$steps <- algorithm.args$steps
      }else{args$steps <- 4}

    }

  }

  a$Methods <- args

  class(a) <- "EGA"

  # Change zero dimensions
  if(a$n.dim == 0){
    a$n.dim <- NA
  }

  set.seed(NULL)

  # Return estimates:
  return(a)
}
#----
