#let style(body) = {
	set page(
		paper: "a4",
		margin: (x: 20mm, y: 25mm),
	)
	set text(
		font: "Roboto",
		weight: 400,
		size: 11pt,
		lang: "en",
	)
	set par(
		justify: true,
	)
	show link: name => underline(text(rgb("#0000AA"), name))
	show ref: r => text(style: "italic", r)

	//Boldens the first part of figure captions
	show figure: it => {
		show figure.caption: it => {
			show regex(`^.+\s+\d+:`.text): set text(weight: 500)
			it
		}
		it
	}

	//Do not show Heading Level 4 in the table of contents
	show heading.where(level: 4): set heading(outlined: false)

	//Make Heading Level 4 less thick and italic
	show heading.where(level: 4): it => {
		set text(weight: 500, style: "italic")
		it
	}

	body
}
