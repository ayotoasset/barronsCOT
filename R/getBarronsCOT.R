#' Retrieve Barron's COT weekly data
#'
#' \code{readCMCreport} returns a data.frame with the operations one by one and
#' to add useful information and statistics calculations.
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
      COT <- barrons.table[c(6, 27:30, 35:42), ]
      #minisp <- barrons.table[39:42, ]
      for (i in 2:5) {
            COT[, i] <- type.convert(gsub("\\,", "", COT[, i]), na.strings = "NA", as.is = FALSE, dec = ".",
                                     numerals = c("allow.loss", "warn.loss", "no.loss"))
      }
      write.table(COT[, c(1:2, 4)], "mydata.csv", sep = ";")
      print(paste("Barron's COT date: ", COT[1, 1]))
      print("Data stored at mydata.csv")
      COT
}
