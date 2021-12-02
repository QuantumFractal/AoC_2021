module day02

using AoC_2021

function solve(input::String = getRawInput(2))
    values = split(input, "\n")
    return [part1(values), part2(values)]
end

function part1(values::Vector{SubString{String}})
    depth = 0
    horizontal = 0

    commands = Dict(
        "forward" => x -> horizontal += x,
        "down" => x -> depth += x,
        "up" => x -> depth -= x
    )

    for command in values
        tokens = split(command)
        direction, magnitude = tokens[1], parse(Int, tokens[2])
        commands[direction](magnitude)
    end

    return depth * horizontal
end


function part2(values::Vector{SubString{String}})
    depth = 0
    horizontal = 0
    aim = 0

    commands = Dict(
        "forward" => x -> begin 
            horizontal += x
            depth += aim * x
        end,
        "down" => x -> aim += x,
        "up" => x -> aim -= x
    )

    for command in values
        tokens = split(command)
        direction, magnitude = tokens[1], parse(Int, tokens[2])
        commands[direction](magnitude)
    end

    return depth * horizontal
end

end # module