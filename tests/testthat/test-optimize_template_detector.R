

test_that("1 template", {
  data(lbh1, package = "ohun")
  data(lbh2, package = "ohun")
  tuneR::writeWave(lbh1, file.path(tempdir(),  "lbh1.wav"), extensible = FALSE) #save sound files
  tuneR::writeWave(lbh2, file.path(tempdir(),  "lbh2.wav"), extensible = FALSE) #save sound files

  data("lbh_reference", "lbh1")

  # template for the fourth sound file in 'lbh_reference'
  # generate template correlations
  tc <-
    template_correlator(templates = lbh_reference[11,], path = tempdir())

  # using 2 threshold
  otp <-
    optimize_template_detector(
      template.correlations = tc,
      reference = lbh_reference,
      threshold = c(0.2, 0.5, 0.6)
    )

  expect_true(is.data.frame(otp))

  expect_true(nrow(otp) == 3)

  expect_true(all(otp$f1.score > 0.68))
})


test_that("2 templates", {
  data(lbh1, package = "ohun")
  data(lbh2, package = "ohun")
  tuneR::writeWave(lbh1, file.path(tempdir(),  "lbh1.wav"), extensible = FALSE) #save sound files
  tuneR::writeWave(lbh2, file.path(tempdir(),  "lbh2.wav"), extensible = FALSE) #save sound files

  data("lbh_reference", "lbh1")

  # template for the fourth sound file in 'lbh_reference'
  # generate template correlations
  tc <-
    template_correlator(templates = lbh_reference[c(1, 11),], path = tempdir())

  # using 2 threshold
  otp <-
    optimize_template_detector(
      template.correlations = tc,
      reference = lbh_reference,
      threshold = c(0.2, 0.5, 0.6)
    )

  unlink(
    list.files(
      path = tempdir(),
      pattern = "\\.wav$|\\.flac$|\\.mp3$|\\.wac$",
      ignore.case = T,
      full.names = TRUE
    )
  )

  expect_true(is.data.frame(otp))

  expect_true(nrow(otp) == 6)

  expect_true(all(otp$f1.score > 0.64))
})
