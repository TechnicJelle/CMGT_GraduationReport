
#let table001 = [
#columns(2)[
*SDL3 GPU*

Average: 160 µs/frame\
Standard Deviation: 179 µs/frame\
Average frame-to-frame deviation: 29 µs/frame

#table(
	columns: 3,
	[], [Highs], [Lows],
	[1%], [337], [100],
	[0.1%], [1137], [89],
	[0.01%], [1791], [85],
)

#colbreak()

*Vulkan Helpers*

Average: 590 µs/frame\
Standard Deviation: 112 µs/frame\
Average frame-to-frame deviation: 74 µs/frame

#table(
	columns: 3,
	[], [Highs], [Lows],
	[1%], [828], [454],
	[0.1%], [1628], [442],
	[0.01%], [3718], [437],
)
]
]
