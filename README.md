# Look! Another Advent of Code Repo!

This time written in Julia.

Well folks, it's that time of year again.
Time for the Advent of Code.

Each day has my _annotated_ solution for your enjoyment/education/horror!

I tried to make this Julia package _kind of_ easy to read, by no means best practices.
I'll _try_ to leave some comments explaining some of the fancier Julia stuff
and I might even try to finish all the challenges this year!

## Updates

Finished days (both stars): 1, 2, 3, 4, 5, 6

## Benchmarks


Using `BenchmarkTools.jl` solving both parts of each day:

Run on Julia 1.6.1 + Ryzen 9 5900X 12-Core (~4Ghz)
| Day | Time | Allocated memory |
|----:|-----:|-----------------:|
| 1 | 246.100 μs | 124.92 KiB |
| 2 | 470.100 μs | 290.09 KiB |
| 3 | 1.266 ms | 1.45 MiB |
| 4 | 2.769 ms | 2.68 MiB |
| 5 | 3.877 ms | 33.20 MiB |
| 6 | 95.300 μs | 107.92 KiB |

## Usage

```
echo "<your session token>" >> .session
julia --project=.
julia> using AoC2021
```
