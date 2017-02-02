context("resources")

test_that("A query returns a dataset", {
    s <- search_query("nati")
    expect_s3_class(s, "data.frame")
    expect_equal(length(s), 43)
    expect_equal(nrow(s), 13)

    expect_equal(nrow(search_query("comuni")), 43)
    expect_error(search_query(""))

    expect_equal(nrow(search_query("a", row = 200)), 200)
})

test_that("A full search function", {
    dat <- ask_tod("nati", pack_sel = 1, res_sel = 1)
    expect_s3_class(dat, "data.frame")
    expect_equal_to_reference(nrow(dat), "natirows.rds", 6790)
    expect_equal_to_reference(nrow(dat), "nati.rds", 10)

    dat <- ask_tod("dipendenti", pack_sel = 24, res_sel = 2)
    expect_s3_class(dat, "data.frame")
    expect_equal_to_reference(nrow(dat), "dipendentirows.rds", 10)
    # expect_equal_to_reference(dat, 'dipendenti.rds')

    dat <- ask_tod("dipendenti", pack_sel = 24, res_sel = 1)
    expect_type(dat, "list")
})
