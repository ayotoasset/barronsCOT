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
#' @param
#' @return plot
#' @examples
#' ggplotCOT(barronsCOTsp)
#' ggplotCOT(barronsCOTspm)
#' ggplotCOT(barronsCOTgold)
#' @seealso \url{http://www.barrons.com/public/page/9_0210-traderscommitments.html}
#' @export
ggplotCOT <- function(cot) {
      ordenarOP <- function(cot) {
            coth <- data.frame()
            for (i in 1:nrow(cot)) {
                  coth <- rbind(coth, c(cot$id[i], cot$LS[i]))
                  coth <- rbind(coth, c(cot$id[i], cot$CH[i]))
                  coth <- rbind(coth, c(cot$id[i], cot$ST[i]))
            }
            coth$ind <- seq.int(nrow(coth))
            names(coth) <- c("id", "OP", "ind")
            coth
      }
      cot$id <- seq.int(nrow(cot))
      cot$OPLS <- cot$largeSlong - cot$largeSshort
      cot$OPCH <- cot$commHlong - cot$commHshort
      cot$OPST <- cot$smallTlong - cot$smallTshort
      p1 <- ggplot(cot, aes(x = id)) + geom_line(aes(y = OPLS), colour = "blue") +
            geom_line(aes(y = OPCH), colour = "red") + geom_line(aes(y = OPST), colour = "grey") + geom_hline(yintercept = 0, colour = "green") +
            ylab(label = "Contratos") + xlab("Semanal") + labs(title = "Commitments of Traders - Open Position")  +
            theme_bw() + theme(axis.text.x = element_text(angle = 90))
      p2 <- ggplot(cot, aes(x = id)) + geom_bar(stat = "identity", aes(y = openPosition)) + theme_bw() + theme(axis.text.x = element_text(angle = 90))
      p3 <- ggplot(cot, aes(x = id)) + geom_line(aes(y = openPosition), colour = "black") + theme_bw() + theme(axis.text.x = element_text(angle = 90))
      # p4 <- ggplot(cot, aes(x = id)) + geom_line(aes(y = LS), colour = "red") + geom_hline(yintercept = 0, colour = "green") +
      #   theme_bw() + theme(axis.text.x = element_text(angle = 90))
      # p5 <- ggplot(cot, aes(x = id)) + geom_line(aes(y = CH), colour = "blue") + geom_hline(yintercept = 0, colour = "green") +
      #   theme_bw() + theme(axis.text.x = element_text(angle = 90))
      # p6 <- ggplot(cot, aes(x = id)) + geom_line(aes(y = ST), colour = "grey") + geom_hline(yintercept = 0, colour = "green") +
      #   theme_bw() + theme(axis.text.x = element_text(angle = 90))
      p7 <- ggplot(cot, aes(x = id)) + geom_line(aes(y = largeSlong), colour = "blue") + geom_line(aes(y = largeSshort), colour = "blue", linetype = "dotted") +
            geom_line(aes(y = commHlong), colour = "red") + geom_line(aes(y = commHshort), colour = "red", linetype = "dotted") + geom_line(aes(y = smallTlong), colour = "grey") +
            geom_line(aes(y = smallTshort), colour = "grey", linetype = "dotted") + theme_bw() + theme(axis.text.x = element_text(angle = 90))
      grid.newpage()
      pushViewport(viewport(layout = grid.layout(4, 2)))
      print(p1, vp = viewport(layout.pos.row = 4, layout.pos.col = 1:2))
      print(p2, vp = viewport(layout.pos.row = 1, layout.pos.col = 1:2))
      print(p3, vp = viewport(layout.pos.row = 2, layout.pos.col = 1:2))
      # print(p4, vp = viewport(layout.pos.row = 3, layout.pos.col = 1:2))
      # print(p5, vp = viewport(layout.pos.row = 4, layout.pos.col = 1:2))
      # print(p6, vp = viewport(layout.pos.row = 5, layout.pos.col = 1:2))
      print(p7, vp = viewport(layout.pos.row = 3, layout.pos.col = 1:2))
      ordenarOP(cot)
}
