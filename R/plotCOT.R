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
      cot$id <- seq.int(nrow(cot))
      cot$OPLS <- cot$largeSlong - cot$largeSshort
      cot$OPCH <- cot$commHlong - cot$commHshort
      cot$OPST <- cot$smallTlong - cot$smallTshort
      graphics::par(mfrow = c(4, 1))
      graphics::barplot(cot$openPosition, names.arg = cot$date, border = TRUE, las = 2)
      graphics::grid()
      graphics::plot(x = cot$openPosition, xlab = "", ylab = "", type = "l", las = 1)
      graphics::grid()
      ylim <- range(cot$OPLS, cot$OPCH, cot$OPST)
      graphics::plot(x = cot$OPLS, xlab = "", ylab = "", type = "l", las = 1, col = "blue", ylim = ylim)
      graphics::lines(x = cot$OPCH, col = "red")
      graphics::lines(x = cot$OPST, col = "grey")
      graphics::abline(h = 0, col = "green")
      graphics::legend('topleft', c("Large speculator", "Commercial Hedger", "Small trader"), lty = 1, col = c('blue', 'red', 'grey'), bty = 'n', cex = 1)
      graphics::grid()
      ylim <- range(cot[, 2:7])
      graphics::plot(x = cot$largeSlong, xlab = "", ylab = "", type = "l", las = 1, ylim = ylim, col = "blue")
      graphics::lines(x = cot$largeSshort, col = "blue", lty = 2)
      graphics::lines(x = cot$commHlong, col = "red")
      graphics::lines(x = cot$commHshort, col = "red", lty = 2)
      graphics::lines(x = cot$smallTlong, col = "grey")
      graphics::lines(x = cot$smallTshort, col = "grey", lty = 2)
      graphics::legend('topleft', c("Long", "Short"), lty = c(1, 2), col = c('purple', 'purple'), bty = 'n', cex = 1)
      graphics::grid()
      graphics::title("\n\nBarron\'s COT\nOpen Position", outer = TRUE)
      graphics::par(mfrow = c(1, 1))
}
