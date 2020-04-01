test_that("users has correct columns",
          expect_identical(names(users), c("date","userID","level","power")))

test_that("userIDs in range",
          expect_true(all(users$userID %in% 1:4)))

test_that("date in range", {
  expect_true(all(users$date >= as.Date("2019-12-03")))
  expect_true(all(users$date <= Sys.Date()))
})

test_that("level in range", {
  expect_true(all(users$level >= 1))
  expect_true(all(users$level <= 85))
})

test_that("power in range", {
  expect_true(all(users$power >=  0, na.rm = TRUE))
  expect_true(all(users$power < 1e7, na.rm = TRUE))
})