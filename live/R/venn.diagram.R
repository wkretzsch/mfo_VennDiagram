# The VennDiagram package is copyright (c) 2012 Ontario Institute for Cancer Research (OICR)
# This package and its accompanying libraries is free software; you can redistribute it and/or modify it under the terms of the GPL
# (either version 1, or at your option, any later version) or the Artistic License 2.0.  Refer to LICENSE for the full license text.
# OICR makes no representations whatsoever as to the SOFTWARE contained herein.  It is experimental in nature and is provided WITHOUT
# WARRANTY OF MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE OR ANY OTHER WARRANTY, EXPRESS OR IMPLIED. OICR MAKES NO REPRESENTATION
# OR WARRANTY THAT THE USE OF THIS SOFTWARE WILL NOT INFRINGE ANY PATENT OR OTHER PROPRIETARY RIGHT.
# By downloading this SOFTWARE, your Institution hereby indemnifies OICR against any loss, claim, damage or liability, of whatsoever kind or
# nature, which may arise from your Institution's respective use, handling or storage of the SOFTWARE.
# If publications result from research using this SOFTWARE, we ask that the Ontario Institute for Cancer Research be acknowledged and/or
# credit be given to OICR scientists, as scientifically appropriate.

### UMBRELLA FUNCTION TO DRAW VENN DIAGRAMS #######################################################
venn.diagram <- function(
	x,
	filename,
	height = 3000,
	width = 3000,
	resolution = 500,
	imagetype = 'tiff',
	units = 'px',
	compression = 'lzw',
	na = 'stop',
	main = NULL,
	sub = NULL,
	main.pos = c(0.5, 1.05),
	main.fontface = 'plain',
	main.fontfamily = 'serif',
	main.col = 'black',
	main.cex = 1,
	main.just = c(0.5, 1),
	sub.pos = c(0.5, 1.05),
	sub.fontface = 'plain',
	sub.fontfamily = 'serif',
	sub.col = 'black',
	sub.cex = 1,
	sub.just = c(0.5, 1),
	category.names = names(x),
	force.unique = TRUE,
	...
	) {

	if (force.unique) {
		for (i in 1:length(x)) {
			x[[i]] <- unique(x[[i]])
			}
		}

	# check for the presence of NAs in the input list
	if ('none' == na) {
		x <- x;
		}
	else if ('stop' == na) {
		for (i in 1:length(x)) {
			# stop if there are any NAs in this vector
			if (any(is.na(x[[i]]))) {
				stop('NAs in dataset', call. = FALSE);
				}
			}
		}
	else if ('remove' == na) {
		for (i in 1:length(x)) { x[[i]] <- x[[i]][!is.na(x[[i]])]; }
		}
	else {
		stop('Invalid na option: valid options are "none", "stop", and "remove"');
		}

	# check the length of the given list
	if (0 == length(x) | length(x) > 5) {
		stop('Incorrect number of elements.', call. = FALSE);
		}

	# draw a single-set Venn diagram
	if (1 == length(x)) {
		list.names <- category.names;
		if (is.null(list.names)) { list.names <- ''; }
		grob.list <- VennDiagram::draw.single.venn(
			area = length(x[[1]]),
			category = list.names,
			ind = FALSE,
			...
			);
		}

	# draw a pairwise Venn diagram
	else if (2 == length(x)) {
		grob.list <- VennDiagram::draw.pairwise.venn(
			area1 = length(x[[1]]),
			area2 = length(x[[2]]),
			cross.area = length(intersect(x[[1]],x[[2]])),
			category = category.names,
			ind = FALSE,
			...
			);
		}

	# draw a three-set Venn diagram
	else if (3 == length(x)) {
		A <- x[[1]];
		B <- x[[2]];
		C <- x[[3]];

		list.names <- category.names;

		nab <- intersect(A, B);
		nbc <- intersect(B, C);
		nac <- intersect(A, C);

		nabc <- intersect(nab, C);

		grob.list <- VennDiagram::draw.triple.venn(
			area1 = length(A),
			area2 = length(B),
			area3 = length(C),
			n12 = length(nab),
			n23 = length(nbc),
			n13 = length(nac),
			n123 = length(nabc),
			category = list.names,
			ind = FALSE,
			list.order = 1:3,
			...
			);
		}

	# draw a four-set Venn diagram
	else if (4 == length(x)) {
		A <- x[[1]];
		B <- x[[2]];
		C <- x[[3]];
		D <- x[[4]];

		list.names <- category.names;

		n12 <- intersect(A, B);
		n13 <- intersect(A, C);
		n14 <- intersect(A, D);
		n23 <- intersect(B, C);
		n24 <- intersect(B, D);
		n34 <- intersect(C, D);

		n123 <- intersect(n12, C);
		n124 <- intersect(n12, D);
		n134 <- intersect(n13, D);
		n234 <- intersect(n23, D);

		n1234 <- intersect(n123, D);

		grob.list <- VennDiagram::draw.quad.venn(
			area1 = length(A),
			area2 = length(B),
			area3 = length(C),
			area4 = length(D),
			n12 = length(n12),
			n13 = length(n13),
			n14 = length(n14),
			n23 = length(n23),
			n24 = length(n24),
			n34 = length(n34),
			n123 = length(n123),
			n124 = length(n124),
			n134 = length(n134),
			n234 = length(n234),
			n1234 = length(n1234),
			category = list.names,
			ind = FALSE,
			...
			);
		}

	# draw a five-set Venn diagram
	else if (5 == length(x)) {
		A <- x[[1]];
		B <- x[[2]];
		C <- x[[3]];
		D <- x[[4]];
		E <- x[[5]];

		list.names <- category.names;

		n12 <- intersect(A, B);
		n13 <- intersect(A, C);
		n14 <- intersect(A, D);
		n15 <- intersect(A, E);
		n23 <- intersect(B, C);
		n24 <- intersect(B, D);
		n25 <- intersect(B, E);
		n34 <- intersect(C, D);
		n35 <- intersect(C, E);
		n45 <- intersect(D, E);

		n123 <- intersect(n12, C);
		n124 <- intersect(n12, D);
		n125 <- intersect(n12, E);
		n134 <- intersect(n13, D);
		n135 <- intersect(n13, E);
		n145 <- intersect(n14, E);
		n234 <- intersect(n23, D);
		n235 <- intersect(n23, E);
		n245 <- intersect(n24, E);
		n345 <- intersect(n34, E);

		n1234 <- intersect(n123, D);
		n1235 <- intersect(n123, E);
		n1245 <- intersect(n124, E);
		n1345 <- intersect(n134, E);
		n2345 <- intersect(n234, E);

		n12345 <- intersect(n1234, E);

		grob.list <- VennDiagram::draw.quintuple.venn(
			area1 = length(A),
			area2 = length(B),
			area3 = length(C),
			area4 = length(D),
			area5 = length(E),
			n12 = length(n12),
			n13 = length(n13),
			n14 = length(n14),
			n15 = length(n15),
			n23 = length(n23),
			n24 = length(n24),
			n25 = length(n25),
			n34 = length(n34),
			n35 = length(n35),
			n45 = length(n45),
			n123 = length(n123),
			n124 = length(n124),
			n125 = length(n125),
			n134 = length(n134),
			n135 = length(n135),
			n145 = length(n145),
			n234 = length(n234),
			n235 = length(n235),
			n245 = length(n245),
			n345 = length(n345),
			n1234 = length(n1234),
			n1235 = length(n1235),
			n1245 = length(n1245),
			n1345 = length(n1345),
			n2345 = length(n2345),
			n12345 = length(n12345),
			category = list.names,
			ind = FALSE,
			...
			);
		}

	# this should never happen because of the previous check
	else {
		stop('Invalid size of input object');
		}

	# if requested, add a sub-title
	if (!is.null(sub)) {
		grob.list <- add.title(
			gList = grob.list,
			x = sub,
			pos = sub.pos,
			fontface = sub.fontface,
			fontfamily = sub.fontfamily,
			col = sub.col,
			cex = sub.cex
			);
		}

	# if requested, add a main-title
	if (!is.null(main)) {
		grob.list <- add.title(
			gList = grob.list,
			x = main,
			pos = main.pos,
			fontface = main.fontface,
			fontfamily = main.fontfamily,
			col = main.col,
			cex = main.cex
			);
		}

	# if a filename is given, write a desired image type, TIFF default
	if (!is.null(filename)) {

		# set the graphics driver
		current.type <- getOption('bitmapType');
		if (length(grep('Darwin', Sys.info()['sysname']))) {
			options(bitmapType = 'quartz');
			}
		else {
			options(bitmapType = 'cairo');
			}
		
		# TIFF image type specified
		if('tiff' == imagetype) {
			tiff(
				filename = filename,
				height = height,
				width = width,
				units = units,
				res = resolution,
				compression = compression
				);
			}
		
		# PNG image type specified
		else if('png' == imagetype) {
			png(
				filename = filename,
				height = height,
				width = width,
				units = units,
				res = resolution
				);
			}

		# SVG image type specified
   		else if('svg' == imagetype) {
			svg(
				filename = filename,
				height = height,
				width = width
   				);
			}
		
		# Invalid imagetype specified
		else {
			stop("You have misspelled your 'imagetype', please try again");
			}

		grid.draw(grob.list);
		dev.off();
		options(bitmapType = current.type);

		# return a success code
		return(1);
		}

	# if file creation was not requested return the plotting object
	return(grob.list);
	}
