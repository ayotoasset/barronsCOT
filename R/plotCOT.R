#' Plot Barron's COT data
#'
#' \code{plotCOT} returns a graphic with the trader's open position.
#' The graphic show:
#' - Total Open Position
#' - Long and short open position grouped by:
#' -- Large speculators
#' -- Commercial Hedger
#' -- Small Trader
#' - Total position grouped by:
#' -- Large speculators
#' -- Commercial Hedger
#' -- Small Trader
#'
#' @author Mario Pisa
#' @param cot A data.frame with COT
#' @return plot
#' @examples
#' plotCOT(COTsp)
#' plotCOT(COTspm)
#' plotCOT(COTgold)
#' @seealso \url{http://www.barrons.com/public/page/9_0210-traderscommitments.html}
#' @export
plotCOT <- function(cot) {
      # ordenarOP <- function(cot) {
      #       coth <- data.frame()
      #       for (i in 1:nrow(cot)) {
      #             coth <- rbind(coth, c(cot$id[i], cot$LS[i]))
      #             coth <- rbind(coth, c(cot$id[i], cot$CH[i]))
      #             coth <- rbind(coth, c(cot$id[i], cot$ST[i]))
      #       }
      #       coth$ind <- seq.int(nrow(coth))
      #       names(coth) <- c("id", "OP", "ind")
      #       coth
      # }
      cot$id <- seq.int(nrow(cot))
      cot$OPLS <- cot$largeSlong - cot$largeSshort
      cot$OPCH <- cot$commHlong - cot$commHshort
      cot$OPST <- cot$smallTlong - cot$smallTshort
      # ordenarOP(cot)
      par(mfrow = c(4, 1))
      barplot(cot$openPosition, names.arg = cot$date, border = TRUE, las = 2)
      grid()
      plot(x = cot$openPosition, xlab = "", ylab = "", type = "l", las = 1)
      grid()
      ylim <- range(cot$OPLS, cot$OPCH, cot$OPST)
      plot(x = cot$OPLS, xlab = "", ylab = "", type = "l", las = 1, col = "blue", ylim = ylim)
      lines(x = cot$OPCH, col = "red")
      lines(x = cot$OPST, col = "grey")
      abline(h = 0, col = "green")
      legend('topleft', c("Large speculator", "Commercial Hedger", "Small trader"), lty = 1, col = c('blue', 'red', 'grey'), bty = 'n', cex = 1)
      grid()
      ylim <- range(cot[, 2:7])
      plot(x = cot$largeSlong, xlab = "", ylab = "", type = "l", las = 1, ylim = ylim, col = "blue")
      lines(x = cot$largeSshort, col = "blue", lty = 2)
      lines(x = cot$commHlong, col = "red")
      lines(x = cot$commHshort, col = "red", lty = 2)
      lines(x = cot$smallTlong, col = "grey")
      lines(x = cot$smallTshort, col = "grey", lty = 2)
      legend('topleft', c("Long", "Short"), lty = c(1, 2), col = c('purple', 'purple'), bty = 'n', cex = 1)
      grid()
      title("\n\nBarron\'s COT\nOpen Position", outer = TRUE)
      par(mfrow = c(1, 1))
}
