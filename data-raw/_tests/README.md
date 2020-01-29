# Raw data testing

To test the raw data, navigate to this directory and perform the following in 
the R console:

    testthat::test_dir(".")
    
The file `md5sum.csv` is key in this testing procedure as it determines what
files will be tested. In particular, the rows where `passed` is TRUE contain
the files that will be tested. If you want to re-test files, set `passed` to
FALSE.

