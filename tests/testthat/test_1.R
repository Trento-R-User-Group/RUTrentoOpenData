context("resources")

test_that("A query returns a dataset", {
    expect_type(search_query("nati"), "list")
    expect_equal(length(search_query("nati")), 38)
    expect_equal(nrow(search_query("nati")), 13)
    expect_equal(nrow(search_query("comuni")), 46)
    expect_equal(nrow(search_query("")), 100)
    #expect_warning(search_query(), "There are probably more datasets than showed, use the row parameter to increase the limit")
    expect_equal(nrow(search_query("", row = 200)), 200)
})
