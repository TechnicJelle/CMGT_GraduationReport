#import "../3rd/typst-diagbox/diagbox.typ": bdiagbox

#let api_compat_table = {
	//Everything is centered by default, due to being in a figure
	//But we don't want the Platform column to be centered
	show table.cell.where(x: 0): it => {table.cell(align: start, it)}

	//Make Platform & API column text slightly bold, but not _too_ bold
	set strong(delta: 100)

	//Counter for the custom footnotes
	let steps_foot(i, foots, body) = {
		(i + 1, foots + ([#i: #body],), text(weight: 300, super[#i]))
	}
	let i = 1
	let foots = ()

	//Footnote definitions
	let (i, foots, dxvk) = steps_foot(i, foots)[Possible with #link("https://github.com/doitsujin/dxvk")[DXVK] and #link("https://gitlab.winehq.org/wine/vkd3d")[vkd3d]]
	let (i, foots, mvk) = steps_foot(i, foots)[Possible with #link("https://github.com/KhronosGroup/MoltenVK")[MoltenVK]]

	//The actual table
	table(
		columns: 6,
		//Top-Left "title" cell
		table.cell(
			fill: luma(200),
			bdiagbox(
				strong(delta: 200)[*Platform*],
				strong(delta: 200)[*API*],
			),
		),
		/*Platform \ APIs*/  [*Vulkan*], [*DirectX*], [*Metal*], [*NVN*], [*GNM(X)*],
		[*Windows (x64)*],   [✅],       [✅],        [❌],      [❌],    [❌],
		[*Xbox*],            [❌],       [✅],        [❌],      [❌],    [❌],
		[*Linux (x64)*],     [✅],       [🔶#dxvk],   [❌],      [❌],    [❌],
		[*Android*],         [✅],       [❌],        [❌],      [❌],    [❌],
		[*PlayStation*],     [❌],       [❌],        [❌],      [❌],    [✅],
		[*Nintendo Switch*], [✅],       [❌],        [❌],      [✅],    [❌],
		[*macOS*],           [🔶#mvk],   [❌],        [✅],      [❌],    [❌],
		[*iPhone*],          [🔶#mvk],   [❌],        [✅],      [❌],    [❌],
	)

	//Footnotes text
	text(
		weight: 300,
		size: 0.8em,
		foots.join("\n")
	)
}
