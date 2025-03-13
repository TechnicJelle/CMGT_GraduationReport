#let api_compat_table = {
	//Everything is centered by default, due to being in a figure
	//But we don't want the Platform column to be centered
	show table.cell.where(x: 1): it => {table.cell(align: start, it)}

	//Background colour for the outer descriptions
	let myGrey = luma(200)

	//Counter for the custom footnotes
	let steps_foot(i, foots, body) = {
		(i + 1, foots + ([#i: #body],), text(weight: 300, super[#i]))
	}

	let i = 1
	let foots = ()

	let (i, foots, dxvk) = steps_foot(i, foots)[Possible with #link("https://github.com/doitsujin/dxvk")[DXVK] and #link("https://gitlab.winehq.org/wine/vkd3d")[vkd3d]]
	let (i, foots, mvk) = steps_foot(i, foots)[Possible with #link("https://github.com/KhronosGroup/MoltenVK")[MoltenVK]]

	table(
		columns: 7,
		//Top-Left empty cell
		table.cell(
			colspan: 2,
			rowspan: 2,
			stroke: none,
			[],
		),
		//API Header
		table.cell(
			colspan: 5,
			align: center,
			fill: myGrey,
			[*API*],
		),
		//APIs
		[*Vulkan*], [*DirectX*], [*Metal*], [*NVN*], [*GNM(X)*],
		//Platform header
		table.cell(
			rowspan: 8,
			align: horizon,
			fill: myGrey,
			rotate(-90deg, reflow: true)[*Platform*],
		),
		//Platform        | Vulkan | DirectX  |   Metal | NVN | GNM(X)
		[*Windows (x64)*],   [✅],     [✅],      [❌],  [❌],  [❌],
		[*Xbox*],            [❌],     [✅],      [❌],  [❌],  [❌],
		[*Linux (x64)*],     [✅],     [🔶#dxvk], [❌],  [❌],  [❌],
		[*Android*],         [✅],     [❌],      [❌],  [❌],  [❌],
		[*PlayStation*],     [❌],     [❌],      [❌],  [❌],  [✅],
		[*Nintendo Switch*], [✅],     [❌],      [❌],  [✅],  [❌],
		[*macOS*],           [🔶#mvk], [❌],      [✅],  [❌],  [❌],
		[*iPhone*],          [🔶#mvk], [❌],      [✅],  [❌],  [❌],
	)

	text(
		weight: 300,
		size: 0.8em,
		foots.join("\n")
	)
}
