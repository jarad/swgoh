test_that("correct columns",
          expect_identical(names(rewards), 
                           c(names(battles),names(rewards_raw)[-1]))
)

test_that("reward count is acceptable", {
          expect_true(all(rewards$count) >= 0)
          expect_true(all(rewards$count <= rewards$attempts))
})
          

