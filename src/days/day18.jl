module day18

using AoC_2021
using Base.Iterators


struct Snail
    left::Union{Int, Snail}
    right::Union{Int, Snail}
end

Base.show(io::IO, s::Snail) = print(io, "[$(s.left),$(s.right)]")

Snail(str::AbstractString) = Snail(eval(Meta.parse(str))...)
Snail(left::Vector, right::Vector) = Snail(Snail(left...), Snail(right...))
Snail(left::Int, right::Vector) = Snail(left, Snail(right...))
Snail(left::Vector, right::Int) = Snail(Snail(left...), right)

add(left::Snail, right::Snail) = Snail(left, right)
add(left::Int, right::Int) = left + right
add(n::Int, s::Snail) = Snail(add(n, s.left), s.right)
add(s::Snail, n::Int) = Snail(s.left, add(s.right, n))


explode(s::Int, d::Int) = (false, s, 0, 0)

function explode(s::Snail, d::Int=0)
    if typeof(s.left) <: Int && typeof(s.right) <: Int
        return d >= 4 ? (true, 0, s.left, s.right) : (false, s, 0, 0)
    end

    did_left,  l, l_left, l_right = explode(s.left, d+1)
    did_right, r, r_left, r_right = explode(s.right, d+1)

    if did_left
        return (true, Snail(l, add(l_right, s.right)), l_left, 0)
    elseif did_right
        return (true, Snail(add(s.left, r_left), r), 0, r_right)
    else
        return (false, s, 0, 0)
    end
end

function split(n::Int)
    n < 10 ? (false, n) : (true, Snail(n ÷ 2, (n+1) ÷ 2))
end

function split(s::Snail)
    did_left, left = split(s.left)
    did_right, right = split(s.right)

    if did_left
        return (true, Snail(left, s.right))
    elseif did_right
        return (true, Snail(s.left, right))
    else
        return (false, s)
    end
end

function normalize(s::Snail)
    did_explode, exploded, _, _ = explode(s)
    did_split, splitted = split(s)

    if did_explode
        return normalize(exploded)
    elseif did_split
        return normalize(splitted)
    end
    return s
end

magnitude(n::Int) = n
magnitude(s::Snail) = 3 * magnitude(s.left) + 2 * magnitude(s.right)

function solve(input::String = getRawInput(18))
    snails = Snail.(Base.split(input, "\n"))
    return [part1(snails), part2(snails)]
end

function part1(snails::Vector{Snail})
    return magnitude(reduce((a,b) -> normalize(add(a, b)), snails))
end

function part2(snails::Vector{Snail})
    return max(magnitude.(map(((a, b),) -> normalize(add(a,b)), Iterators.product(snails, snails)))...)
end




end # module