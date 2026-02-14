# Charts

Vista ships canvas-based chart helpers that generate Draw blocks. Import `vista.art` and pass chart blocks into `canvas`.

## Quick Start

```arturo
import "vista.art"!

series: [12 18 9 22 30 28 35]

view [
    canvas .width: 600 .height: 180 (chart_line series #[
        xLabel: "Days"
        yLabel: "Sales"
    ])
]
```

## Supported Charts

- `chart_line` (series, opts)
- `chart_area` (series, opts)
- `chart_bar` (series, opts)
- `chart_stacked_bar` (series, opts)
- `chart_histogram` (series, opts)
- `chart_scatter` (series, opts)
- `chart_funnel` (series, opts)
- `chart_heatmap` (series, opts)
- `chart_cohort` (series, opts)
- `chart_donut` (series, opts)

## Data Shapes

- Line/Area/Histogram
  - `series: [12 18 9 22]`
  - or `series: [[x y] [x y] ...]`
- Bar
  - `series: [["A" 12] ["B" 9]]`
- Stacked Bar
  - `series: [["A" [5 7]] ["B" [3 6]]]`
- Scatter
  - `series: [[x y] [x y] ...]`
- Funnel
  - `series: [["Visit" 120] ["Signup" 80] ...]`
- Heatmap/Cohort
  - `series: [[x y value] ...]` (x/y are category identifiers)
- Donut
  - `series: [["A" 40] ["B" 25] ["C" 35]]`

## Options

All charts accept an `opts` dictionary. Common options:

- `w`, `h` (defaults 600x180)
- `padding` (default 16)
- `grid` (default true)
- `gridLines` (default 4)
- `gridColor` (default `#e6eaf0`)
- `axes` (default true)
- `axisColor` (default `#cfd8e3`)
- `labels` (default true)
- `labelOffset` (default 12)
- `xLabel`, `yLabel` (default null)
- `font` (default `12px sans-serif`)
- `textColor` (default `#5b6472`)

Chart-specific:

- Line/Area: `lineWidth`, `areaColor`
- Bar: `barGap`
- Stacked Bar: `stackGap`
- Scatter: `pointRadius`
- Histogram: `bins`
- Donut: `donutThickness`, `centerLabel`
- Heatmap/Cohort: `heatmapPadding`, `heatmapPalette`
- Any: `palette` (array of colors)

## Examples

```arturo
import "vista.art"!

lineData: [12 18 9 22 30 28 35]
barData: [["A" 12] ["B" 9] ["C" 18]]
stackedData: [["A" [5 7]] ["B" [3 6]] ["C" [4 2]]]
scatterData: [[1 12] [2 9] [3 18] [4 16]]
funnelData: [["Visit" 120] ["Signup" 80] ["Pay" 35]]
heatData: [[0 0 2] [1 0 5] [0 1 8] [1 1 3]]
donutData: [["A" 40] ["B" 25] ["C" 35]]

view [
  canvas .width: 600 .height: 180 (chart_line lineData #[])
  canvas .width: 600 .height: 180 (chart_bar barData #[])
  canvas .width: 600 .height: 180 (chart_stacked_bar stackedData #[])
  canvas .width: 600 .height: 180 (chart_scatter scatterData #[])
  canvas .width: 600 .height: 180 (chart_funnel funnelData #[])
  canvas .width: 600 .height: 180 (chart_heatmap heatData #[])
  canvas .width: 220 .height: 220 (chart_donut donutData #[
      centerLabel: "Total"
  ])
]
```
