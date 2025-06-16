import pathlib
import re

import matplotlib.pyplot as plt
import numpy as np

plt.rcParams.update({
	"font.family": "Roboto",
	"axes.facecolor": "#FFFFFF11",
	"savefig.facecolor": "#00000000",
	"savefig.edgecolor": "#00000000",
})

dataDir = pathlib.Path("Data")
outputDir = pathlib.Path("Output")
outputDir.mkdir(parents=True, exist_ok=True)
alpha = 0.9
figSize = (8, 5)

tableTemplate = """
#let table{att} = [
#columns(2)[
*SDL3 GPU*

Average: {a0} µs/frame\\
Standard Deviation: {b0} µs/frame

#table(
	columns: 3,
	[], [Highs], [Lows],
	[1%], [{a1}], [{a2}],
	[0.1%], [{b1}], [{b2}],
	[0.01%], [{c1}], [{c2}],
)

#colbreak()

*Vulkan Helpers*

Average: {d0} µs/frame\\
Standard Deviation: {e0} µs/frame

#table(
	columns: 3,
	[], [Highs], [Lows],
	[1%], [{d1}], [{d2}],
	[0.1%], [{e1}], [{e2}],
	[0.01%], [{f1}], [{f2}],
)
]
]
"""

for attemptDir in dataDir.iterdir():
	if attemptDir.is_dir() and attemptDir.name.startswith("Attempt"):
		# Variables
		attemptNumber = re.match(r"Attempt (\d+).*", attemptDir.name).group(1)
		attemptOutputDir = outputDir / attemptDir.name
		attemptOutputDir.mkdir(parents=True, exist_ok=True)

		# Data
		sdl3_gpu__data = np.loadtxt(attemptDir / "LLRI2_Experiments_SDL3_GPU_frameTimes.txt") / 1000  # Convert to microseconds
		vulkan_helpers__data = np.loadtxt(attemptDir / "LLRI2_Experiments_Vulkan_Helpers_frameTimes.txt") / 1000  # Convert to microseconds

		# Histogram
		plt.figure(figsize=figSize)
		bins = np.logspace(np.log10(75), np.log10(2000), 500)
		sdl3_gpu__plot = plt.hist(sdl3_gpu__data[sdl3_gpu__data < 4000], bins=bins, label='SDL3 GPU', alpha=alpha)
		vulkan_helpers__plot = plt.hist(vulkan_helpers__data, bins=bins, label='Vulkan Helpers', alpha=alpha)

		sdl3_gpu__max = sdl3_gpu__plot[1][np.argmax(sdl3_gpu__plot[0])]
		vulkan_helpers__max = vulkan_helpers__plot[1][np.argmax(vulkan_helpers__plot[0])]

		plt.axvline(vulkan_helpers__max, ls='--', alpha=0.3, color='black')
		plt.axvline(sdl3_gpu__max, ls='--', alpha=0.3, color='black')

		plt.annotate(f'Peak SDL3\n{sdl3_gpu__max:.1f} µs',
					 xy=(sdl3_gpu__max, max(sdl3_gpu__plot[0]) * 0.95),
					 xytext=(25, -15),
					 textcoords='offset points',
					 arrowprops=dict(arrowstyle='->', lw=0.5),
					 fontsize=9,
					 ha='left')

		plt.annotate(f'Peak Vulkan\n{vulkan_helpers__max:.1f} µs',
					 xy=(vulkan_helpers__max, max(vulkan_helpers__plot[0]) * 0.95),
					 xytext=(-10, -30),
					 textcoords='offset points',
					 arrowprops=dict(arrowstyle='->', lw=0.5),
					 fontsize=9,
					 ha='right')

		legend = plt.legend(labelcolor="linecolor")
		legend.get_frame().set_alpha(None)
		plt.xlabel("µs/frame")
		plt.ylabel("occurrences")

		plt.xscale("log")
		plt.yscale("log")
		plt.title("Frametimes: Histogram (More to the left is better)")
		plt.tight_layout()
		plt.savefig(attemptOutputDir / "hist.svg")
		plt.close()

		# Line plot
		plt.figure(figsize=figSize)
		linewidth = 0.1
		plt.plot(sdl3_gpu__data, linewidth=linewidth, label="SDL3 GPU", alpha=alpha)
		plt.plot(vulkan_helpers__data, linewidth=linewidth, label="Vulkan Helpers", alpha=alpha)
		legend = plt.legend(labelcolor="linecolor")
		legend.get_frame().set_alpha(None)
		plt.xlabel("frame")
		plt.ylabel("µs/frame")

		# set the linewidth of each legend handle
		for handle in legend.legend_handles:
			handle.set_linewidth(4)

		plt.yscale("log")
		plt.title("Frametimes: Line Plot (Lower is better)")
		plt.tight_layout()
		plt.savefig(attemptOutputDir / "plot.svg")
		plt.close()

		# Generate table data
		sdl3_gpu__average = np.average(sdl3_gpu__data).astype(int)
		vulkan_helpers__average = np.average(vulkan_helpers__data).astype(int)
		sdl3_gpu__standard_deviation = np.std(sdl3_gpu__data).astype(int)
		vulkan_helpers__standard_deviation = np.std(vulkan_helpers__data).astype(int)
		sdl3_gpu__highs = np.percentile(sdl3_gpu__data, [99, 99.9, 99.99]).astype(int)
		sdl3_gpu__lows = np.percentile(sdl3_gpu__data, [1, 0.1, 0.01]).astype(int)
		vulkan_helpers__highs = np.percentile(vulkan_helpers__data, [99, 99.9, 99.99]).astype(int)
		vulkan_helpers__lows = np.percentile(vulkan_helpers__data, [1, 0.1, 0.01]).astype(int)

		table = tableTemplate.format(
			att=attemptNumber,
			a0=sdl3_gpu__average, d0=vulkan_helpers__average,
			b0=sdl3_gpu__standard_deviation, e0=vulkan_helpers__standard_deviation,
			a1=sdl3_gpu__highs[0], a2=vulkan_helpers__highs[0],
			b1=sdl3_gpu__highs[1], b2=vulkan_helpers__highs[1],
			c1=sdl3_gpu__highs[2], c2=vulkan_helpers__highs[2],
			d1=sdl3_gpu__lows[0], d2=vulkan_helpers__lows[0],
			e1=sdl3_gpu__lows[1], e2=vulkan_helpers__lows[1],
			f1=sdl3_gpu__lows[2], f2=vulkan_helpers__lows[2]
		)
		with open(attemptOutputDir / "table.typ", "w") as f:
			f.write(table)
