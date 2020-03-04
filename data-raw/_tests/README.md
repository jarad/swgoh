# Raw data testing

To test the raw data, navigate to this directory and set the `dates` in 
[files.R](files.R) to the desired dates for testing. For nightly testing,

    dates <- Sys.Date()

can be used. Then perform the following in 
the R console:

    testthat::test_dir(".")
