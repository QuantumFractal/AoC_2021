# Look! Another Advent of Code Repo!

This time written in Julia.

Well folks, it's that time of year again.
Time for the Advent of Code.

I tried to make this Julia package _kind of_ easy to read, by no means best practices.
I'll _try_ to leave some comments explaining some of the fancier Julia stuff
and I might even try to finish all the challenges this year!

## Updates

Finished days: 1, 2, 3, 4

## Benchmarks


Using `BenchmarkTools.jl` solving both parts of each day:

Run on Julia 1.6.1 + Ryzen 9 5900X 12-Core (~4Ghz)
| Day | Time | Allocated memory |
|----:|-----:|-----------------:|
| 1 | 245.600 μs | 124.92 KiB |  
| 2 | 473.700 μs | 290.09 KiB |  
| 3 | 1.307 ms | 1.45 MiB |      
| 4 | 2.861 ms | 2.68 MiB |

## Usage

```
echo "<your session token>" >> .session
julia --project=.
julia> using AoC2021
```
