#let front_page(body) = {
	set page(
		margin: (x: 0mm, y: 25mm)
	)

	align(center)[
		#text(weight: 900, size: 17pt)[Another Vulkan Abstraction] \
		#text(weight: 300, size: 14pt)[Graduation Report]
	]

	v(54pt)

	//Allow overriding my name with the $TYPST_NAME environment variable (see compile.sh)
	let default_name = "TechnicJelle"
	let input_name = sys.inputs.at("NAME", default: default_name)
	let name = if input_name.len() > 0 {
		input_name
	} else {
		default_name
	}

	let image_height = 150pt
	grid(
		columns: (1fr, 1fr, 1fr),
		align(center)[
			*Student & Author* \
			#name \
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
				#image("../Images/Branding/rythe_icon_for_light_bg.png", fit: "contain", height: image_height)
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

