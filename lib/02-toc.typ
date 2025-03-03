#let toc(body) = {
	show outline.entry.where(level: 1): h => {
		v(14pt, weak: false)
		strong(delta: 300, h)
	}
	show outline.entry.where(level: 2): h => {
		strong(delta: 100, h)
	}

	//Heading level 1 does not have dotted lines
	show outline.entry.where(level: 1): set outline.entry(fill: none)

	//Replace the default dotted lines with slightly more subtle ones
	set outline.entry(fill: align(right, repeat(text(weight: 100, "."), gap: 1pt, justify: false)))

	outline()

	pagebreak()

	//Start page numbering
	counter(page).update(1)
	set page(
		numbering: "1 / 1",
		number-align: right,
	)

	//Start numbering headings from here on out
	set heading(numbering: "1.1.1   ")

	body
}
