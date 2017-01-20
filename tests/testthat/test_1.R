context("resources")

test_that("A query returns a dataset", {
    s <- search_query("nati")
    expect_s3_class(s, "data.frame")
    expect_equal(length(s), 38)
    expect_equal(nrow(s), 13)
    
    expect_equal(nrow(search_query("comuni")), 46)
    expect_error(search_query(""))

    expect_equal(nrow(search_query("a", row = 200)), 200)
})

test_that("A full search function", {
    dat <- trentino("nati", pack_sel = 1, res_sel = 1)
    expect_s3_class(dat, "data.frame")
    expect_equal(nrow(dat), 6790)
    
    dat <- trentino("dipendenti", pack_sel = 24, res_sel = 2)
    expect_s3_class(dat, "data.frame")
    expect_equal(nrow(dat), 10)
    
    dat <- trentino("dipendenti", pack_sel = 24, res_sel = 1)
    expect_type(dat, "list")
})
