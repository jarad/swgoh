test_that("correct columns",
          expect_identical(names(rewards_complete), 
                           c(names(battles),names(rewards)[-1]))
)

test_that("reward count is acceptable",
          expect_true(all(rewards_complete$count <= rewards_complete$attempts))
)
          

