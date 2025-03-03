#let front_page(body) = {
	set page(
		margin: (x: 0mm, y: 25mm)
	)

	align(center)[
		#text(weight: 900, size: 17pt)[Another Vulkan Abstraction] \
		#text(weight: 300, size: 14pt)[Graduation Report]
	]

	v(54pt)

	show link: name => underline(text(rgb("#0000AA"), [#name]))
	let image_height = 150pt
	grid(
		columns: (1fr, 1fr, 1fr),
		align(center)[
			*Student & Author* \
			TechnicJelle \
			510576 \
			Saxion University of Applied Sciences \
			Creative Media and Game Technologies \
			#link("https://technicjelle.com")[
				technicjelle.com
				#image("../Images/Branding/TechnicJelle.png", fit: "contain", height: image_height)
			]
		],
		align(center)[
			*Company Coach* \
			Glyn Leine \
			Rythe Interactive \
			\
			\
			#link("https://rythe-interactive.com/")[
				rythe-interactive.com
				#image("../Images/Branding/rythe_logo_for_dark_bg-shadow.png", fit: "contain", height: image_height)
			]
		],
		align(center)[
			*Internship Coach* \
			Yiwei Jiang \
			Saxion University of Applied Sciences \
			Creative Media and Game Technologies \
			#link("https://www.saxion.edu/programmes/bachelor/creative-media-and-game-technologies")[
				saxion.edu/programmes/bachelor/creative-media-and-game-technologies
				#image("../Images/Branding/saxion_cmgt_logo.jpg", fit: "contain", height: image_height)
			]
		],
	)

	align(center)[
		#text(weight: 200, size: 10pt)[#datetime.today().display("Date: [day] [month repr:long], [year]")]
	]

	pagebreak()

	import "00-setup.typ": style
	show: style
	body
}

