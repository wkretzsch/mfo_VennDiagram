\name{draw.032}
\alias{draw.032}
\title{Draw a special Venn Diagram with Three Sets}
\description{Special case of draw.triple.venn: 032. Internal use only.}
\value{See draw.triple.venn}
\author{Hanbo Chen}
\examples{
venn.plot <- draw.triple.venn(
	area1 = 2,
	area2 = 1,
	area3 = 1,
	n12 = 1,
	n23 = 1,
	n13 = 1,
	n123 = 1,
	category = c('A', 'B', 'C'),
	fill = c('red', 'blue', 'green'),
	cat.col = c('red', 'blue', 'green'),
	cex = c(1/2,2/2,3/2,4/2,5/2,6/2,7/2),
	cat.cex = c(1,2,3),
	euler = TRUE,
	scaled = FALSE
	);
dev.off();
}
\keyword{ internal }
