#' Read COT data saved in Rdata file
#'
#' \code{readCOT} returns a data.frame with the traders open position.
#' Can be selected the asset [all | sp | spmini | gold]
#'
#' @author Mario Pisa
#' @param
#' @return data.frame with Barron's COT table
#' @examples
#' \dontrun{readCOT()}
#' spcot <- readCOT("sp")
#' spmcot <- readCOT("spmini")
#' goldcot <- readCOT("gold")
#' @seealso \url{http://www.barrons.com/public/page/9_0210-traderscommitments.html}
#' @export
readCOT <- function(commtt = "all") {
      COT <- readRDS("data/barronsCOT.Rdata")
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
