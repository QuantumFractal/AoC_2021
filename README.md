# Look! Another Advent of Code Repo!

This time written in Julia.

Well folks, it's that time of year again.
Time for the Advent of Code.

I tried to make this Julia package _kind of_ easy to read, by no means best practices.
I'll _try_ to leave some comments explaining some of the fancier Julia stuff
and I might even try to finish all the challenges this year!

## Updates

Finished days (both stars): 1, 2, 3, 4, 5

## Benchmarks


Using `BenchmarkTools.jl` solving both parts of each day:

Run on Julia 1.6.1 + Ryzen 9 5900X 12-Core (~4Ghz)
| Day | Time | Allocated memory |
|----:|-----:|-----------------:|
| 1 | 243.800 μs | 124.92 KiB |
| 2 | 468.200 μs | 290.09 KiB |
| 3 | 1.300 ms | 1.45 MiB |
| 4 | 2.865 ms | 2.68 MiB |
| 5 | 4.413 ms | 33.20 MiB |

## Usage

```
echo "<your session token>" >> .session
julia --project=.
julia> using AoC2021
```
