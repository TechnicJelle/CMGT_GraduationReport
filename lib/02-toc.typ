#let toc(body) = {
	show outline.entry.where(level: 1): h => {
		v(14pt, weak: false)
		strong(delta: 300, h)
	}
	show outline.entry.where(level: 2): h => {
		strong(delta: 100, h)
	}

	//TODO: When Typst 0.13 releases, this will work to hide the dots of the first indentation level
	//#show outline.entry.where(level: 1): set outline.entry(fill: none)

	outline(
		indent: auto,
		fill: align(right, repeat(text(weight: 100, "."), gap: 10pt, justify: false)),
	)

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
