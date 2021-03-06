#anaphora -- functions that do "something" with a (complex expression)
#input without repeating the complex expression
context("anaphora")

`%is%` <- expect_equal

test_that("Modification assignment", {
  x <- 'a'
  x %<~% toupper
  x %is% 'A'
  x %<~% paste0('BB')
  x %is% 'ABB'
  x %<~% rep(3)
  x %is% c('ABB', 'ABB', 'ABB')
  x %<~% .[2:3]
  x %is% c('ABB', 'ABB')
})

test_that("put() changes a subset to a value", {
  x <- 1:10
  z <- put(1:10, names, letters[1:10])
  y <- put(x, it[1], 4)
  expect_equal(z, structure(1:10, names=letters[1:10]))
  expect_equal(y, c(4, 2:10))
  expect_equal(x, 1:10)
})

test_that("two argument put()", {
  x <- 1:10
  z <- put(names(x), letters[1:10])
  y <- put(x[1], 4)
  expect_equal(z, structure(1:10, names=letters[1:10]))
  expect_equal(y, c(4, 2:10))
  expect_equal(x, 1:10)
})

test_that("alter() sets a sebset to the chain of the subset", {
  x <- structure(1:5, names=letters[1:5])
  y <- alter(x, names(it)[5], toupper)
  z <- alter(x, names, toupper)
  w <- alter(x, names[3], toupper)
  ww <- alter(x, names[2], toupper, paste0("XX"))
  expect_equal(x, c(a=1, b=2, c=3, d=4, e=5))
  expect_equal(y, c(a=1, b=2, c=3, d=4, E=5))
  expect_equal(z, c(A=1, B=2, C=3, D=4, E=5))
  expect_equal(w, c(a=1, b=2, C=3, d=4, e=5))
  expect_equal(ww, c(a=1, BXX=2, c=3, d=4, e=5))
})

test_that("inject() sets a subset of a value to the chain of the value", {
  x <- inject(1:10, names, letters[.], rev)
  expect_equal(x, c(j=1, i=2, h=3, g=4, f=5, e=6, d=7, c=8, b=9, a=10))
})

test_that("Put function environment weirdness", {
  # the symptom was that using put(f, environment, envir)
  # to set the env of a function --
  # where the env was a lazily evaluated parent.frame() argument whose env
  # had fallen off the stack -- did wrong things. Not actually a problem in
  # put(), but needs to go in the "why parent.frame() is evil" vignette
})

## test_that("with_attrs is a list of a thing and its attributes", {
## })

## test_that(paste("rebind() is a functional equiv. of bind(), "
##                 "outputting a list/data frame of the same class?"), {  
## })

## test_that("via<-(x), sets x to chain of its arguments", {
##   x <- 1:5
##   via(names[x[5]], toupper) <- letters[5]
##   expect_equal(x, c(1,2,3,4,E=5))
## })

## test_that("check() chains a value through conditions and throws errors", {
##   structure(1:5, names=letters(1:5))
## })

## test_that("checked<-() asserts that the provided value passes a chain with TRUE", {
##   check(x, names, !any(.="")) <- structure(1:5, names=letters(1:5))
##   expect_equal(x, structure(1:5, names=letters(1:5)))
##   expect_error( check(x, .>0, all) <- c(1, -1) )
## })

## test_that("default<- lets you provide a default value from bind[]", {
##   local({
##     bind[a = default(a, 5), default(b, 5)] <- list(a=4, b=3)
##     expect_equal(a, 4)
##     expect_equal(b, 3)
##   })
##   local({
##     bind[a = default(a, 5), default(b, 5)] <-
##         list(a=missing_value(), b=missing_value())
##     expect_equal(a, 5)
##     expect_equal(b, 5)
##   })
##   local({
##     bind[default(a, 5), b] <- list(missing_value(), 4)
##     expect_equal(a, 5)
##     expect_equal(b, 4)
##   })
## })

## test_that("default<- allows there to be missing matches as well", {
##   local({
##     expect_error({
##       bind(a, b) <- list(a=4)
##     })
##   })
##   local({
##     bind(a, b=2) <- list(a=4)
##   })
##   local({
##     bind[a = default(a, 5), default(b, 2)] <- list(b=3)
##     expect_equal(a, 5)
##     expect_equal(b, 3)
##   })
## })
