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
# leer COT desde STA.xlsx y eliminar NAs
# commtt = sp, spmini, gold
getCOT <- function(commtt = "all") {
      COT <- read.xlsx("../Business/STA.xlsx", sheetName = "Weekly Indicator", colIndex = c(1:2, 29:49),
                       as.data.frame = TRUE, stringsAsFactors = FALSE)
      COT[, 3:23] <- sapply(COT[, 3:23], as.numeric)
      COT[, 1][is.na(COT[, 1])] <- "-"
      COT <- na.omit(COT)
      names(COT) <- c("Month", "day", "LSl", "LSs", "CHl", "CHs", "STl", "STs", "OP", "LSl", "LSs",
                      "CHl", "CHs", "STl", "STs", "OP", "LSl", "LSs", "CHl", "CHs", "STl", "STs", "OP")
      if (commtt == "all") {
            COT
      }
      else if (commtt == "sp") {
            COTsp <- COT[, c(1:2, 3:9)]
            COTsp
      }
      else if (commtt == "spmini") {
            COTspmini <- COT[c(1:2, 10:16)]
            COTspmini
      }
      else if (commtt == "gold") {
            COTgold <- COT[c(1:2, 17:23)]
            COTgold
      }
      else {
            print("ERROR> Valor de entrada: sp, spmini, gold o por defecto all")
      }
}
