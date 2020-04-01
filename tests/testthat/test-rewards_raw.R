test_that("rewards has correct columns",
          expect_identical(names(rewards_raw), c("battleID","reward","count")))

test_that("counts are positive",
          expect_true(all(rewards_raw$count > 0)))

