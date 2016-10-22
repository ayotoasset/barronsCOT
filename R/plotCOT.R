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
# USAR: plotCOT(getCOT("sp"))
plotCOT <- function(cot) {
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
      cot$date <- paste(cot$Mont, cot$day)
      cot$id <- seq.int(nrow(cot))
      cot$LS <- cot$LSl - cot$LSs
      cot$CH <- cot$CHl - cot$CHs
      cot$ST <- cot$STl - cot$STs
      p1 <- ggplot(cot, aes(x = id)) + geom_line(aes(y = LS), colour = "blue") +
            geom_line(aes(y = CH), colour = "red") + geom_line(aes(y = ST), colour = "grey") + geom_hline(yintercept = 0, colour = "green") +
            ylab(label = "Contratos") + xlab("Semanal") + labs(title = "Commitments of Traders - Open Position")  +
            theme_bw() + theme(axis.text.x = element_text(angle = 90))
      p2 <- ggplot(cot, aes(x = id)) + geom_bar(stat = "identity", aes(y = OP)) + theme_bw() + theme(axis.text.x = element_text(angle = 90))
      p3 <- ggplot(cot, aes(x = id)) + geom_line(aes(y = OP), colour = "black") + theme_bw() + theme(axis.text.x = element_text(angle = 90))
      # p4 <- ggplot(cot, aes(x = id)) + geom_line(aes(y = LS), colour = "red") + geom_hline(yintercept = 0, colour = "green") +
      #   theme_bw() + theme(axis.text.x = element_text(angle = 90))
      # p5 <- ggplot(cot, aes(x = id)) + geom_line(aes(y = CH), colour = "blue") + geom_hline(yintercept = 0, colour = "green") +
      #   theme_bw() + theme(axis.text.x = element_text(angle = 90))
      # p6 <- ggplot(cot, aes(x = id)) + geom_line(aes(y = ST), colour = "grey") + geom_hline(yintercept = 0, colour = "green") +
      #   theme_bw() + theme(axis.text.x = element_text(angle = 90))
      p7 <- ggplot(cot, aes(x = id)) + geom_line(aes(y = LSl), colour = "blue") + geom_line(aes(y = LSs), colour = "blue", linetype = "dotted") +
            geom_line(aes(y = CHl), colour = "red") + geom_line(aes(y = CHs), colour = "red", linetype = "dotted") + geom_line(aes(y = STl), colour = "grey") +
            geom_line(aes(y = STs), colour = "grey", linetype = "dotted") + theme_bw() + theme(axis.text.x = element_text(angle = 90))
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
