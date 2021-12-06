## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----example------------------------------------------------------------------
# Population df with column for size
pop <- data.frame(
  orig_id = letters[1:10],
  size = c(100, 200, 50, 100, 500, 50, 100, 100, 50, 500)
)

# Supply df with column for capacity
sup <- data.frame(
  dest_id = as.character(1:3),
  capacity = c(1000, 200, 500)
)

# Distance matrix with travel times from 0 to 30
D <- matrix(
  runif(30, min = 0, max = 30),
  ncol = 10, nrow = 3, byrow = TRUE,
  dimnames = list(c(1:3), c(letters[1:10]))
)
D

## ----preprocess---------------------------------------------------------------
library(fca)

# Normalize distances
W <- dist_normalize(
  D,
  d_max = 20,
  imp_function = "gaussian", function_d_max = 0.01
)

# Ensure order of ids
pop <- pop[order(pop$orig_id), ]
sup <- sup[order(sup$dest_id), ]

# Named vectors
(p <- setNames(pop$size, as.character(pop$orig_id)))
(s <- setNames(sup$capacity, as.character(sup$dest_id)))

## ----fca----------------------------------------------------------------------
(spai <- spai_3sfca(p, s, W))

