# knox 1.0.1 (fork fdzul/knox)

* Removed the dependency on rgdal, which was retired from CRAN in 2023.
  `writeSHP()` now writes the shapefile with sf (suggested package).
* Removed sp and rgdal from `LinkingTo` and updated `src/Makevars` for current
  versions of Rcpp and RcppArmadillo.
