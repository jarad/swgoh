test_that("users has correct columns",
          expect_identical(names(users), c("date","userID","level")))

test_that("userIDs in range",
          expect_true(all(users$userID %in% 1:4)))