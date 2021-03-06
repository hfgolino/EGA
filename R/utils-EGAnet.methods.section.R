#' Sub-routine for EGA Methods section
#'
#' @noRd
# EGA Methods Section----
# Updated 27.12.2020
EGA.methods.section <- function (object, net.loads, net.scores)
{
  # Input arguments
  INPUT <- object$Methods
  
  # For EGA
  model <- INPUT$model
  algorithm <- INPUT$algorithm
  
  # References
  refs <- list()
  
  # Set up text
  ## Introduction
  intro.header <- "# Exploratory Graph Analysis"
  
  # Golino et al. (2020) ==> Golino, Shi, et al. (2020)
  if(net.loads || net.scores){
    
    intro.text <- paste("&emsp;Exploratory graph analysis (EGA) is a recently developed method to estimate ",
                        "the number of dimensions in multivariate data using undirected network models ",
                        "(Golino & Epskamp, 2017; Golino, Shi, et al., 2020). EGA first applies a network ",
                        "estimation method followed by a community detection algorithm for weighted ",
                        "networks (Fortunato, 2010). EGA has been shown to be as accurate or more accurate ",
                        "than more traditional factor analytic methods such as parallel analysis ",
                        "(Christensen & Golino, 2020a; Golino, Shi, et al., 2020).",
                        sep = "")
    
    refs$christensenD2020 <- paste("Christensen, A. P., & Golino, H. (2020a).",
                                   "Estimating factors with psychometric networks: A Monte Carlo simulation comparing community detection algorithms.",
                                   "<em>PsyArXiv</em>.",
                                   "https://doi.org/10.31234/osf.io/hz89e")
    
  }else{
    
    intro.text <- paste("&emsp;Exploratory graph analysis (EGA) is a recently developed method to estimate ",
                        "the number of dimensions in multivariate data using undirected network models ",
                        "(Golino & Epskamp, 2017; Golino et al., 2020). EGA first applies a network ",
                        "estimation method followed by a community detection algorithm for weighted ",
                        "networks (Fortunato, 2010). EGA has been shown to be as accurate or more accurate ",
                        "than more traditional factor analytic methods such as parallel analysis ",
                        "(Christensen & Golino, 2020; Golino et al., 2020).",
                        sep = "")
    
    refs$christensenD2020 <- paste("Christensen, A. P., & Golino, H. (2020).",
                                   "Estimating factors with psychometric networks: A Monte Carlo simulation comparing community detection algorithms.",
                                   "<em>PsyArXiv</em>.",
                                   "https://doi.org/10.31234/osf.io/hz89e")
    
  }
  
  refs$golinoB2017 <- paste("Golino, H., & Epskamp, S. (2017).",
                            "Exploratory Graph Analysis: A new approach for estimating the number of dimensions in psychological research.",
                            "<em>PloS ONE</em>, <em>12</em>, e0174035.",
                            "https://doi.org/10.1371/journal.pone.0174035")
  
  refs$golinoC2020 <- paste("Golino, H., Shi, D., Christensen, A. P., Garrido, L. E., Nieto, M. D., Sadana, R., ... Martinez-Molina, A. (2020).",
                            "Investigating the performance of Exploratory Graph Analysis and traditional techniques to identify the number of latent factors: A simulation and tutorial.",
                            "<em>Psychological Methods</em>, <em>25</em>, 292--320.",
                            "https://doi.org/10.1037/met0000255")
  
  refs$fortunato2009 <- paste("Fortunato, S. (2010).",
                              "Community detectionin graphs.",
                              "<em>Physics Reports</em>, <em>3--5</em>, 75--174.",
                              "https://doi.org/10.1037/met0000255")
  
  ## Description of network estimation method
  model.header <- "## Network Estimation Method"
  
  if(tolower(model) == "glasso")
  {
    
    lambda <- INPUT$lambda
    gamma <- INPUT$gamma
    
    model.text <- paste("&emsp;This study applied the graphical least absolute shrinkage and selection operator ",
                        "(GLASSO; Friedman, Haste, & Tibshirani, 2008, 2014), which estimates a Gaussian ",
                        "Graphical Model (GGM; Lauritzen, 1996) where nodes (circles) represent variables ",
                        "and edges (lines) represent the conditional dependence (or partial correlations) ",
                        "between nodes given all other nodes in the network. The least absolute shrinkage ",
                        "and selection operator (LASSO; Tibshirani, 1996) of the GLASSO is a regularization ",
                        "technique that reduces parameter estimates with some estimates becoming exactly zero. ",
                        "\n\n",
                        "&emsp;The LASSO uses a parameter called lambda ($\\lambda$), which controls the sparsity of the network. ",
                        "Lower values of $\\lambda$ remove fewer edges, increasing the possibility of including ",
                        "spurious correlations, while larger values of $\\lambda$ remove more edges, increasing ",
                        "the possibility of removing relevant edges. When $\\lambda$ = 0, then the estimates are ",
                        "equal to the ordinary least squares solution for the partial correlation matrix. ",
                        "In this study, the ratio of the minimum and maximum $\\lambda$ was set to ", lambda, ".",
                        "\n\n",
                        "&emsp;The popular approach in the network psychometrics literature is to compute models ",
                        "across several values of $\\lambda$ (usually 100) and to select the model that minimizes ",
                        "the extended Bayesian information criterion (EBIC; Chen & Chen, 2008; Epskamp & Fried, 2018). ",
                        "The EBIC model selection uses a hyperparameter gamma ($\\gamma$) to control how much it prefers simpler models ",
                        "(i.e., models with fewer edges; Foygel & Drton, 2010). Larger $\\gamma$ values lead to simpler models, ",
                        "while smaller $\\gamma$ values lead to denser models. When $\\gamma$ = 0, the EBIC is equal to the Bayesian ",
                        "information criterion. In this study, $\\gamma$ was set to ", gamma, ". In network psychometrics literature, ",
                        "this approach has been termed *EBICglasso* and is applied using the *qgraph* package (Epskamp et al., 2012) ",
                        "in R.",
                        sep = ""
    )
    
    refs$friedman2008 <- paste("Friedman, J., Hastie, T., & Tibshirani, R. (2008).",
                               "Sparse inverse covariance estimation with the graphical lasso.",
                               "<em>Biostatistics</em>, <em>9</em>, 432--441.",
                               "https://doi.org/10.1093/biostatistics/kxm045")
    
    refs$friedman2014 <- paste("Friedman, J., Hastie, T., & Tibshirani, R. (2014).",
                               "<em>glasso: Graphical lasso - estimation of Gaussian graphical models.</em>",
                               "Retrived from https://CRAN.R-project.org/package=glasso")
    
    refs$lauritzen1996 <- paste("Lauritzen, S. L. (1996).",
                                "<em>Graphical models.</em>",
                                "Oxford, UK: Clarendon Press.")
    
    refs$tibshirani1996 <- paste("Tibshirani, R. (1996).",
                                 "Regression shrinkage and selection via the lasso.",
                                 "<em>Journal of the Royal Statistical Society. Series B (Methodological)</em>, 267--288.",
                                 "https://doi.org/10.1111/j.2517-6161.1996.tb02080.x")
    
    refs$chen2008 <- paste("Chen, J., & Chen, Z. (2008).",
                           "Extended bayesian information criteria for model selection with large model spaces.",
                           "<em>Biometrika</em>, <em>95</em>, 759--771.",
                           "https://doi.org/10.1093/biomet/asn034")
    
    refs$epskampB2018 <- paste("Epskamp, S., & Fried, E. I. (2018).",
                               "A tutorial on regularized partial correlation networks.",
                               "<em>Psychological Methods</em>, <em>23</em>, 617--634.",
                               "https://doi.org/10.1037/met0000167")
    
    refs$foygel2010 <- paste("Foygel, R., & Drton, M. (2010).",
                             "Extended Bayesian information criteria for Gaussian graphical models.",
                             "In J. D. Lafferty, C. K. I. Williams, J. Shawe-Taylor, R. S., Zemel, & A. Culotta (Eds.),",
                             "<em>Advances in neural information processing systems</em> (pp. 604--612).",
                             "Retrieved from http://papers.nips.cc/paper/4087-extended-bayesianinformation-criteria-for-gaussian-graphical-models")
    
    refs$epskampA2012 <- paste("Epskamp, S., Cramer, A. O. J., Waldorp, L. J., Schmittmann, V. D., & Borsboom, D. (2012).",
                               "qgraph: Network visualizations of relationships in psychometric data.",
                               "<em>Journal of Statistical Software</em>, <em>48</em>, 1--18.",
                               "https://doi.org/10.18637/jss.v048.i04")
    
  }else if(model == "TMFG")
  {
    model.text <- paste("&emsp;This study applied the Triangulated Maximally Filtered Graph (TMFG; Christensen et al., 2018; Massara, Di Matteo, & Aste, 2016), ",
                        "which applies a structural constraint on the zero-order correlation matrix. This constraint ",
                        "restrains the network to retain a certain number of edges (3*n*--6, where *n* is the number ",
                        "of nodes). This network is comprised of three- and four-node cliques (i.e., sets of connected ",
                        "nodes; a triangle and tetrahedron, respectively).",
                        "\n\n",
                        "&emsp;Network estimation starts with a tetrahedron that is comprised of the four nodes ",
                        "that have the high sum of correlations that are greater than the average correlation in ",
                        "the correlation matrix. Next, the algorithm identifies a node that is not connected in the ",
                        "network and maximizes its sum of correlations to three nodes already in the network. This ",
                        "node is then connected to those three nodes. This process continues iteratively until ",
                        "every node is connected in the network.",
                        "\n\n",
                        "&emsp;The resulting network is a *planar* network or a network that *could* be drawn ",
                        "such that no edges are crossing (Tumminello, Aste, Di Matteo, & Mantegna, 2005). One ",
                        'property of these networks is that they form a "nested hierarchy" such that its constituent ',
                        "elements (3-node cliques) form sub-networks in the overall network (Song, Di Matteo, & Aste, 2012). ",
                        "The TMFG method was applied using the *NetworkToolbox* package (Christensen, 2018) in R.",
                        sep = ""
    )
    
    refs$christensenG2018 <- paste("Christensen, A. P., Kenett, Y. N., Aste, T., Silvia, P. J., & Kwapil, T. R. (2018).",
                                   "Network structure of the Wisconsin Schizotypy Scales-Short Forms: Examining psychometric network filtering approaches.",
                                   "<em>Behavior Research Methods</em>, <em>50</em>, 2531--2550.",
                                   "https://doi.org/10.3758/s13428-018-1032-9")
    
    refs$massara2016 <- paste("Massara, G. P., Di Matteo, T., & Aste, T. (2016).",
                              "Network filtering for big data: Triangulated maximally filtered graph.",
                              "<em>Journal of Complex Networks</em>, <em>5</em>, 161--178.",
                              "https://doi.org/10.1093/comnet/cnw015")
    
    refs$tumminello2005 <- paste("Tumminello, M., Aste, T., Di Matteo, T., & Mantegna, R. N. (2005).",
                                 "A tool for filtering information in complex systems.",
                                 "<em>Proceedings of the National Academy of Sciences</em>, <em>102</em>, 10421--10426.",
                                 "https://doi.org/10.1073/pnas.0500298102")
    
    refs$song2012 <- paste("Song, W.-M., Di Matteo, T., & Aste, T. (2012).",
                           "Hierarchical information clustering by means of topologically embedded graphs.",
                           "<em>PLoS ONE</em>, <em>7</em>, e31929.",
                           "https://doi.org/10.1371/journal.pone.0031929")
    
    refs$christensenA2018 <- paste("Christensen, A. P. (2018).",
                                   "NetworkToolbox: Methods and measures for brain, cognitive, and psychometric network analysis in R.",
                                   "<em>The R Journal</em>, <em>10</em>, 422--439.",
                                   "https://doi.org/10.32614/RJ-2018-065")
  }
  
  ## Description of community detection algorithm
  algorithm.header <- "## Community Detection Algorithm"
  
  if(tolower(algorithm) == "walktrap")
  {
    steps <- INPUT$steps
    
    algorithm.text <- paste("&emsp;The Walktrap algorithm (Pons & Latapy, 2006) is a commonly applied community detection algorithm in ",
                            "the psychometric network literature (Golino & Epskamp, 2017; Golino, Shi, et al., 2020). The algorithm begins ",
                            "by computing a transition matrix where each element represents the probability of one node traversing to ",
                            "another (based on node strength or the sum of the connections to each node). Random walks are then initiated ",
                            "for a certain number of steps (e.g., ", steps, ") using the transition matrix for probable destinations. Using ",
                            "Ward's agglomerative clustering approach (Ward, 1963), each node starts as its own cluster and merges ",
                            "with adjacent clusters (based on squared distances between each cluster) in a way that minimizes the sum of ",
                            "squared distances between other clusters. Modularity (Newman, 2006) is then used to determine the optimal ",
                            "partition of clusters (i.e., communities). The Walktrap algorithm was implemented using the *igraph* ",
                            "package (Csardi & Nepusz, 2006) in R.",
                            sep = ""
    )
    
    refs$pons2006 <- paste("Pons, P., & Latapy, M. (2006).",
                           "Computing communities in large networks using random walks.",
                           "<em>Journal of Graph Algorithms and Applications</em>, <em>10</em>, 191--218.",
                           "https://doi.org/10.7155/jgaa.00185")
    
    refs$ward1963 <- paste("Ward, J. H. (1963).",
                           "Hierarchical clustering to optimise an objective function.",
                           "<em>Journal of the American Statistical Association</em>, <em>58</em>, 238--244.")
    
    refs$newman2006 <- paste("Newman, M. E. J. (2006).",
                             "Modularity and community structure in networks.",
                             "<em>Proceedings of the National Academy of Sciences</em>, <em>103</em>, 8577--8582.",
                             "https://doi.org/10.1073/pnas.0601602103")
    
    refs$csardi2006 <- paste("Csardi, G., & Nepusz, T. (2006).",
                             "The igraph software package for complex network research.",
                             "<em>InterJournal, Complex Systems</em>, <em>1695</em>, 1--9.",
                             "Retrieved from https://pdfs.semanticscholar.org/1d27/44b83519657f5f2610698a8ddd177ced4f5c.pdf")
    
  }else if(algorithm == "louvain")
  {
    algorithm.text <- paste("&emsp;The Louvain algorithm (also referred to as Multi-level; Blondel, Guillaume, Lambiotte, & Lefebvre, 2008)",
                            "is one of the most commonly applied in network science (Gates, Henry, Steinley, & Fair, 2016). The algorithm",
                            "begins by randomly sorting nodes into communities with their neighbors and then uses",
                            "modularity (Newman, 2006) to iteratively optimize its community partitions by exchanging nodes between communities",
                            "and evaluating the change in modularity until it no longer improves.",
                            "Then, the algorithm collapses the communities into latent nodes and identifies edge weights with other observed and latent",
                            "nodes, which provides a multi-level structure (Gates et al., 2016). In this study, the",
                            "algorithm was not used to identify hierarchical community structures in the network.",
                            "The Louvain algorithm was implemented using the *igraph* package (Csardi & Nepusz, 2006) in R.",
                            "It's important to note that the algorithm implemented in *igraph* is deterministic;",
                            "however, other implementations are not (Gates et al., 2016)."
    )
    
    refs$blondel2008 <- paste("Blondel, V. D., Guillaume, J.-L., Lambiotte, R., & Lefebvre, E. (2008).",
                              "Fast unfolding of communities in large networks.",
                              "<em>Journal of Statistical Mechanics: Theory and Experiment</em>, <em>2008</em>, P10008.",
                              "https://doi.org/10.1088/1742-5468/2008/10/P10008")
    
    refs$gates2016 <- paste("Gates, K. M., Henry, T., Steinley, D., & Fair, D. A. (2016).",
                            "A Monte Carlo evaluation of weighted community detection algorithms.",
                            "<em>Frontiers in Neuroinformatics</em>, <em>10</em>, 45.",
                            "https://doi.org/10.3389/fninf.2016.00045")
    
    refs$newman2006 <- paste("Newman, M. E. J. (2006).",
                             "Modularity and community structure in networks.",
                             "<em>Proceedings of the National Academy of Sciences</em>, <em>103</em>, 8577--8582.",
                             "https://doi.org/10.1073/pnas.0601602103")
  }else{
    
    algorithm.text <- paste("&emsp;A default algorithm was not used in EGA. Write your own damn community detection algorithm section &#128540;")
    
  }
  
  if(net.loads || net.scores){
    
    ## Network Loadings
    nl.header <- "## Network Loadings"
    
    nl.text <- paste("&emsp;A recent simulation study by Hallquist, Wright, and Molenaar (2019) demonstrated that ",
                     "the network measure *node strength* or the absolute sum of a node's edge weights is related to ",
                     "confirmatory factor analysis loadings. In their simulation, they found that node strength represented ",
                     "a combination of dominant and cross-factor loadings. Christensen and Golino (2020b) recently proposed ",
                     'an adapted node strength measure that splits a node\'s "strength" between the dimensions between ',
                     "dimensions (e.g., ones found by EGA). They called this measure *network loadings* because it was ",
                     "demonstrated to be relatively equivalent to factor loadings when data were generated from a ",
                     "factor model.",
                     "\n\n",
                     "&emsp;Conceptually, network loadings are the standardized node's strength split between dimensions (see ",
                     "Christensen & Golino, 2020b for mathematical notation). As with factor loadings, the signs of the loadings ",
                     "are added after the loadings have been estimated (following the same procedure as factor loadings; ",
                     "Comrey & Lee, 2013). In contrast to factor loadings, the network loadings are computed after the ",
                     "number of dimensions have been estimated. In EGA, variables are deterministically assigned to ",
                     "dimensions via a community detection algorithm. Importantly, some variables in the network may not be ",
                     "connected to other variables in other dimensions. This means that some variables may have a loading of ",
                     "zero in some dimensions. This represents a loading structure that is between a confirmatory (CFA) and exploratory (EFA) ",
                     "factor analysis loading matrix (Christensen & Golino, 2020b).",
                     sep = "")
    
    refs$christensenE2020 <- paste("Christensen, A. P., & Golino, H. (2020b).",
                                   "On the equivalency of factor and network loadings.",
                                   "<em>Behavior Research Methods</em>.",
                                   "https://doi.org/10.3758/s13428-020-01500-6")
    
    refs$comrey2013 <- paste("Comrey, A. L., & Lee, H. B. (2013).",
                             "<em>A first course in factor analysis</em> (2nd ed.).",
                             "New York, NY: Psychology Press.")
  }
  
  if(net.scores){
    
    ## Network Scores
    ns.header <- "## Network Scores"
    
    ns.text <- paste("&emsp;Network loadings form the foundation for computing network scores. The structure of the network loading ",
                     "matrix captures cross-loading information that is often lost in typical CFA structures but only retains the ",
                     "most important cross-loadings of EFA (Golino, Christensen, Moulder, Kim, & Boker, 2020). Network scores are ",
                     "computed by first dividing the standardized network loadings of a dimension by the corresponding variable's standard deviations, ",
                     "forming weights. Relative weights are then obtained by dividing the weights by the sum of the weights in the dimension. ",
                     "These relative weights are then multiplied by their corresponding variables and summed to form a dimension score ",
                     "(see Golino, Christensen, et al., 2020 for mathematical notation). By means of simulation, Golino, Christensen, and colleagues (2020) demonstrate ",
                     "that these network scores are strongly correlated (&GreaterEqual;.90) with factor scores. ",
                     sep = "")
    
    refs$golinoA2020 <- paste("Golino, H., Christensen, A. P., Moulder, R., Kim, S., & Boker, S. (2020).",
                              "Modeling latent topics in social media using Dynamic Exploratory Graph Analysis: The case of the right-wing and left-wing trolls in the 2016 US elections.",
                              "<em>PsyArXiv</em>.",
                              "https://doi.org/10.31234/osf.io/tfs7c")
    
  }
  
  # Organize text output
  markobj <- paste(intro.header, intro.text,
                   model.header, model.text,
                   algorithm.header, algorithm.text,
                   sep = "\n")
  
  # Other statistics
  if(net.loads || net.scores){
    
    markobj <- paste(markobj, nl.header, nl.text, sep = "\n\n")
    
    if(net.scores){
      markobj <- paste(markobj, ns.header, ns.text, sep = "\n\n")
    }
    
  }
  
  # Return list
  res <- list()
  res$text <- markobj
  res$references <- refs
  
  return(res)
}

#' Sub-routine for EGA.fit Methods section
#'
#' @noRd
# EGA.fit Methods Section----
# Updated 28.12.2020
EGA.fit.methods.section <- function (object)
{
  # Not ready yet
  stop("EGA.fit Methods section is still being developed")
  
}

#' Sub-routine for bootEGA Methods section
#'
#' @noRd
# bootEGA Methods Section----
# Updated 28.12.2020
bootEGA.methods.section <- function (object, dim.stability, item.stability)
{
  # Input arguments
  INPUT <- object
  
  # For bootEGA
  iterations <- INPUT$iter
  type <- INPUT$type
  
  # References
  refs <- list()
  
  # Set up text
  ## Introduction
  intro.header <- "# Bootstrap Exploratory Graph Analysis"
  intro.text <- paste("&emsp;Bootstrap exploratory graph analysis (bootEGA) is a recently developed method to estimate ",
                      "and evaluate the dimensional structure estimated using EGA (Christensen & Golino, 2019). ",
                      "The general approach of bootEGA is generate *X* number of bootstrap samples and apply EGA to each ",
                      "replicate sample, forming a sampling distribution of EGA results.",
                      sep = "")
  
  refs$christensenC2019 <- paste("Christensen, A. P., & Golino, H. (2019).",
                                 "Estimating the stability of the number of factors via Bootstrap Exploratory Graph Analysis: A tutorial.",
                                 "<em>PsyArXiv</em>.",
                                 "https://doi.org/10.31234/osf.io/9deay")
  
  ## Type of bootstrap
  if(type == "parametric"){
    
    type.text <- paste("&emsp;The parametric bootstrap procedure was implemented in this study. This procedure begins by ",
                       "estimating a network using EGA and then generating new replicate data from a multivariate ",
                       "normal distribution (with the same number of cases as the original data). EGA is then applied ",
                       "to the replicate data, continuing iteratively until the desired number of samples is achieved ",
                       "(e.g., ", iterations, "). The result is a sampling distribution of EGA networks.",
                       sep = "")
    
  }else{
    
    type.text <- paste("&emsp;The non-parametric (resampling) procedure was implemented in this study. This procedure works by ",
                       "resampling from the original data with replacement (with the same number of cases as the original data). ",
                       "The resampling procedure allows some cases to be represented more than once in a replicate sample, while ",
                       "other cases may not be included. EGA is then applied to the replicate data, continuing iteratively until ",
                       "the desired number of samples is achieved (e.g., ", iterations, "). The result is a sampling distribution of EGA networks.",
                       sep = "")
    
  }
  
  ## General statistics
  gen.stats <- paste(
                      "&emsp;From this sampling distribution, several statistics ",
                      "can be obtained. Descriptive statistics---median number of dimensions, 95% confidence intervals ",
                      "around the median, and the number of times a certain number of dimensions replicates---were ",
                      "obtained. In addition, a median (or typical) network structure was estimated by computing the ",
                      "median value of each edge across the replicate networks, resulting in a single network. ",
                      'Such a network represents the "typical" network structure of the sampling distribution. ',
                      "The community detection algorithm was then applied, resulting in dimensions that would be ",
                      "expected for a typical network from the EGA sampling distribution.",
                      sep = "")
  
  if(dim.stability || item.stability){
    
    ## Structural consistency
    sc.header <- "## Structural Consistency"
    
    sc.text <- paste("&emsp;To evaluate the stability of the dimensions estimated from EGA, *structural consistency* ",
                     "or the proportion of times that each empirically derived dimension (i.e., the result from the ",
                     "initial EGA) was *exactly* recovered (i.e., identical item composition) from the replicate bootstrap ",
                     "samples was computed. Structural consistency is defined as the extent to which a dimension is ",
                     "interrelated (internal consistency) *and* homogeneous (test homogeneity) in the precense of other ",
                     "related dimensions (Christensen, Golino, & Silvia, 2020). Such a measure provides an alternative ",
                     "yet complementary approach to internal consistency measures in the factor analysic framework.", 
                     sep = "")
    
    sc.ender <- paste('&emsp;For structural consistency, values of what are "acceptable" have not been established, ',
                      "and general rules of thumb are subject to the scale developer's intent (Christensen et al., 2020). ",
                      "In our case, the goal [was to hae separate but related constructs that were interrelated.] This means ",
                      "that we expected that some dimensions may be less stable than others due to some of their interrelations. ",
                      "Because of this, we set a value of **[.75]** or higher (i.e., a dimension replicating exactly across **[75%]** ",
                      "of the bootstrap samples) as our benchmark for acceptable.",
                      sep = "")
    
    refs$christensenF2020 <- paste("Christensen, A. P., Golino, H., & Silvia, P. J. (2020).",
                                   "A psychometric network perspective on the validity and validation of personality trait questionnaires.",
                                   "<em>European Journal of Personality</em>, <em>34</em>, 1095--1108.",
                                   "https://doi.org/10.1002/per.2265")
    
    message(
      paste("Make sure to REPLACE text in",
            styletext("[brackets]", defaults = "bold"),
            "(see Structural Consistency section)!")
      )
  }
  
  if(item.stability){
    
    is.text <- paste("&emsp; Another metric of stuctural consistency is *item stability* or the robustness of each item's placement within ",
                     "each empirically derived dimension. Item stability is estimated by computing the proportion of times each item is ",
                     "placed in each dimension. This metric provides information about which items are leading to structural consistency ", 
                     "(replicating often in their empirically derived dimension) or inconsistency (replicating in often in other dimensions).",
                     sep = "")
    
    sc.ender <- paste(sc.ender,
                      " We set a similar benchmark for the item stabilitiy where items were expected to replicate at least **[75%]** of the time ",
                      "in their empirically derived dimension (i.e., EGA).",
                      sep = "")
    
  }
  
  # Organize text output
  markobj <- paste(intro.header, intro.text, type.text, gen.stats, sep = "\n\n")
  
  # Other statistics
  if(dim.stability || item.stability){
    markobj <- paste(markobj, sc.header, sc.text, sep = "\n\n")
    
    if(item.stability){
      markobj <- paste(markobj, is.text, sc.ender, sep = "\n\n")
    }else{
      markobj <- paste(markobj, sc.ender, sep = "\n\n")
    }
    
  }
  
  # Return list
  res <- list()
  res$text <- markobj
  res$references <- refs
  
  return(res)
}

#' Sub-routine for dynEGA Methods section
#'
#' @noRd
# dynEGA Methods Section----
# Updated 28.12.2020
dynEGA.methods.section <- function (object)
{
  # Not ready yet
  stop("dynEGA Methods section is still being developed")

}

#' Sub-routine for UVA Methods section
#'
#' @noRd
# UVA Methods Section----
# Updated 14.01.2021
UVA.methods.section <- function (object)
{
  # Not ready yet
  stop("UVA Methods section is still being developed")
  
  # Input arguments
  INPUT <- object$Methods
  
  # For UVA
  method <- INPUT$method
  type <- INPUT$type
  sig <- INPUT$sig
  reduce <- INPUT$reduce
  if(reduce){
    
    reduce.method <- INPUT$reduce.method
    
    if(reduce.method == "latent"){lavaan.args <- lavaan.args}
    
  }
  adhoc <- INPUT$adhoc
  
  # Association description
  assoc <- switch(method,
                  "cor" = "zero-order correlations between all variables were computed. ",
                  "pcor" = "partial correlations between two variables given all others were computed. ",
                  "wto" = "weighted topological overlap (Nowick, Gernat, Almaas, & Stubbs, 2009; Zhang & Horvath, 2005) was computed. Weighted topological overlap is a network measure that determines the extent to which items in a network \"overlap\" by quantifying the similarity between a pair of variables' shared connections (e.g., weights, signs, quantity; see Christensen, Garrido, & Golino, 2020 for more details). "
  )
  
  # References
  refs <- list()
  
  # Set up text
  ## Introduction
  intro.header <- "# Unique Variable Analysis"
  intro.text <- paste("&emsp;Unique Variable Analysis (UVA) is a recently developed technique ",
                      "to determine whether redundant variables exist in a dataset ",
                      "(Christensen, Garrido, & Golino, 2020). UVA follows one of two approaches that ",
                      "are based on a pairwise association measure. In this study, ", assoc,
                      "The first approach is to estimate an empirical distribution from the absolute ",
                      "non-zero association values; the second approach is to simply apply a threshold. ",
                      "In this study, ", ifelse(type == "threshold",
                                                "a thresold was used.",
                                                "an empirical distribution was estimated. "),
                      sep = "")
  
  
  refs$christensenB2020 <- paste("Christensen, A. P., Garrido, L. E., & Golino, H. (2020).",
                                 "Unique Variable Analysis: A novel approach for detecting redundant variables in multivariate data.",
                                 "<em>PsyArXiv</em>.",
                                 "https://doi.org/10.31234/osf.io/4kra2")
  
  
  # Organize text output
  markobj <- paste(intro.header, intro.text,
                   sep = "\n")
  
  # Return list
  res <- list()
  res$text <- markobj
  res$references <- refs
  
  return(res)
}