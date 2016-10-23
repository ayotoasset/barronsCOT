#' Retrieve Barron's COT weekly data
#'
#' \code{getBarronsCOT} returns a data.frame with the traders open position.
#'
#' @author Mario Pisa
#' @param
#' @return data.frame with Barron's COT table
#' @examples
#' \dontrun{getBarronsCOT()}
#' barronsCOT <- getBarronsCOT()
#' @seealso \url{http://www.barrons.com/public/page/9_0210-traderscommitments.html}
#' @export
getBarronsCOT <- function() {
      url <- "http://www.barrons.com/public/page/9_0210-traderscommitments.html"
      barrons.table <- readHTMLTable(url, header = T, which = 1, stringsAsFactors = F)
      #View(barrons.table)
      BCOTS <- barrons.table[c(6, 27:30, 35:42), ]
      #minisp <- barrons.table[39:42, ]
      for (i in 2:5) {
            BCOTS[, i] <- type.convert(gsub("\\,", "", BCOTS[, i]), na.strings = "NA", as.is = FALSE, dec = ".",
                                     numerals = c("allow.loss", "warn.loss", "no.loss"))
      }
      if (file.exists("data/COT.rda")) {
            COT <- load("data/COT.rda")
      } else {
            COT <- data.frame(stringsAsFactors = FALSE)
      }
      gold <- as.data.frame(c(BCOTS[3, c(2, 4)], BCOTS[4, c(2, 4)], BCOTS[5, c(2, 4)], BCOTS[[3, 2]] + BCOTS[[4, 2]] + BCOTS[[5, 2]]))
      sp <- as.data.frame(c(BCOTS[7, c(2, 4)], BCOTS[8, c(2, 4)], BCOTS[9, c(2, 4)], BCOTS[[7, 2]] + BCOTS[[8, 2]] + BCOTS[[9, 2]]))
      spm <- as.data.frame(c(BCOTS[11, c(2, 4)], BCOTS[12, c(2, 4)], BCOTS[13, c(2, 4)], BCOTS[[11, 2]] + BCOTS[[12, 2]] + BCOTS[[13, 2]]))
      weeklyCOT <- cbind(BCOTS[1, 1], BCOTS[1, 1], sp, spm, gold)
      COT <- rbind(COT, setNames(weeklyCOT, names(COT)))
      save(COT, file = "data/COT.rda")

      # write.table(BCOTS[, c(1:2, 4)], "mydata.csv", sep = ";")
      print(paste("Barron's COT date: ", BCOTS[1, 1]))
      print("Data stored at mydata.csv")
      COT
}
