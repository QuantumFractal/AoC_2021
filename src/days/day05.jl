module day05

using AoC_2021

function solve(input::String = getRawInput(5))

    return [part1(input), part2(input)]
end

function part1(input)
    chart = zeros(Int, 1000, 1000)
    lines = split(input, "\n")
    for line in lines
        pt1, pt2 = split(line, " -> ")

        # Indexes start at 1
        x1, y1 = parse.(Int, split(pt1, ",")) .+ 1
        x2, y2 = parse.(Int, split(pt2, ",")) .+ 1

        if y1 == y2
            # Iterate over x
            r = x1:x2
            if x1 > x2
                r = x2:x1
            end
            chart[r, y1] .+= 1
        elseif x1 == x2
            r = y1:y2
            if y1 > y2
                r = y2:y1
            end
            chart[x1, r] .+= 1 
        end
    end

    return length(filter(c -> c >= 2, chart))
end

function part2(input)
    chart = zeros(Int, 1000, 1000)
    lines = split(input, "\n")
    for line in lines
        pt1, pt2 = split(line, " -> ")

        # Indexes start at 1
        x1, y1 = parse.(Int, split(pt1, ",")) .+ 1
        x2, y2 = parse.(Int, split(pt2, ",")) .+ 1

        if y1 == y2
            # Iterate over x
            r = x1:x2
            if x1 > x2
                r = x2:x1
            end
            chart[r, y1] .+= 1
        elseif x1 == x2
            r = y1:y2
            if y1 > y2
                r = y2:y1
            end
            chart[x1, r] .+= 1 
        else
 
            rx = x1:x2
            if x2 < x1
                rx = x1:-1:x2
            end
        
            ry = y1:y2
            if y2 < y1
                ry = y1:-1:y2
            end

            for i in 1:length(rx)
                chart[rx[i], ry[i]] += 1
            end
        end
    end

    return length(filter(c -> c >= 2, chart))
end

end # module