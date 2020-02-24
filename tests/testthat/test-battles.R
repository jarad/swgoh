test_that("correct columns",
          expect_identical(names(battles), 
                           c("date","battleID","userID","battle",
                             "attempts","simulated"))
          # ,
          # expect_named(battles, c("date","battleID","userID","battle",
          #                         "attempts","simulated"))
          )

# test_that("columns are the correct type",
#           expect_type(battles$date, "Date"))

test_that("userIDs in 1:4",
          expect_true(all(battles$userID %in% 1:4))
          )

test_that("battles are known",
          expect_true(all(battles$battle %in% battle_rewards$battle))
          )

test_that("attempts is appropriate", {
          expect_true(all(battles$attempts >= 1))
          expect_true(all(battles$attempts <= 20))
          expect_true(all(battles$attempts[grepl("Hard",battles$battle)] <= 5))
          })
          


# test_that("userIDs in range")