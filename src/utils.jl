using HTTP

""" Fetch new days, caching to disk
    Trying to be kind to the AoC folk's servers
"""
function getRawInput(day)
    # YOU BET I'M MAKING A CACHE FOR THIS THING
    cache_dir = joinpath(@__DIR__, ".cache")
    isdir(cache_dir) || mkdir(cache_dir)

    cache_file = joinpath(cache_dir, @sprintf("day%02d.input", day))
    if isfile(cache_file)
        return open(f -> read(f, String), cache_file)
    else
        # Cache miss, go fetch the input.
        url = "https://adventofcode.com/2021/day/$day/input"
        session = open(f -> read(f, String), ".session")
        cookies = Dict{String, String}()
        push!(cookies, "session" => session)

        r = HTTP.request("GET", url, cookies = cookies)

        # Trim last newline to make splitting easier
        # Save to cache, and return.
        input = String(r.body)[1:end-1]
        open(cache_file, "w") do f
            write(f, input)
        end
        return input
    end
end