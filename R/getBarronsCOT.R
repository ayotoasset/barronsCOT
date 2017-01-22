#' Retrieve Barron's COT weekly data
#'
#' \code{getBarronsCOT} returns a data.frame with the traders open position.
#'
#' @author Mario Pisa
#' @param
#' @return data.frame with Barron's COT table
#' @examples
#' \dontrun{getBarronsCOT()}
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
      insertCOT <- function(COT) {
            calcOpenPosition <- function(COT) {
                  openPosition <- COT[1, 2] + COT[1, 4] + COT[1, 6]
                  openPosition
            }
            COTgold <- get("COTgold")
            if (COT[1, 1] != COTgold[nrow(COTgold), 1]) {
                  BCOTgold <- data.frame(date = COT[1, 1])
                  BCOTgold$largeSlong <- COT[3, 2]
                  BCOTgold$largeSshort <- COT[3, 4]
                  BCOTgold$commHlong <- COT[4, 2]
                  BCOTgold$commHshort <- COT[4, 4]
                  BCOTgold$smallTlong <- COT[5, 2]
                  BCOTgold$smallTshort <- COT[5, 4]
                  BCOTgold$openPosition <- calcOpenPosition(BCOTgold)
                  COTgold <<- rbind(COTgold, BCOTgold)

                  COTsp <- get("COTsp")
                  BCOTsp <- data.frame(date = COT[1, 1])
                  BCOTsp$largeSlong <- COT[7, 2]
                  BCOTsp$largeSshort <- COT[7, 4]
                  BCOTsp$commHlong <- COT[8, 2]
                  BCOTsp$commHshort <- COT[8, 4]
                  BCOTsp$smallTlong <- COT[9, 2]
                  BCOTsp$smallTshort <- COT[9, 4]
                  BCOTsp$openPosition <- calcOpenPosition(BCOTsp)
                  COTsp <<- rbind(COTsp, BCOTsp)


                  COTspm <- get("COTspm")
                  BCOTspm <- data.frame(date = COT[1, 1])
                  BCOTspm$largeSlong <- COT[11, 2]
                  BCOTspm$largeSshort <- COT[11, 4]
                  BCOTspm$commHlong <- COT[12, 2]
                  BCOTspm$commHshort <- COT[12, 4]
                  BCOTspm$smallTlong <- COT[13, 2]
                  BCOTspm$smallTshort <- COT[13, 4]
                  BCOTspm$openPosition <- calcOpenPosition(BCOTspm)
                  COTspm <<- rbind(COTspm, BCOTspm)

                  print(paste("Values added with date: ", BCOTgold[nrow(BCOTgold), 1]))
            }
            else {
                  print(paste(COTgold[nrow(COTgold), 1], "Values are already embedded"))
            }
      }
      insertCOT(BCOTS)
}
