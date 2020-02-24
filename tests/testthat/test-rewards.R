test_that("rewards has correct columns",
          expect_identical(names(rewards), c("battleID","reward","count")))

