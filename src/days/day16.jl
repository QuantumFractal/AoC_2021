module day16

using AoC_2021
using Base.Iterators

to_bits(hex_str) = reverse(digits(parse(Int, hex_str, base = 16), base=2))


# I gave up and wrote an absolutely horrific python version of this script. I'll come back and make it more "julian" later.

function solve(input::String = getRawInput(16))
    bits = to_bits(input)

    version = parse(Int, join(bits[1:3]), base=2)
    type = parse(Int, join(bits[3:6]), base=2)
    println("type $type, version $version")
    
    for bit in bits
        print(bit)
    end

    if type == 4
        cidx = 0
        chunk = []
        literal_bits = []
        scan = true
        while scan
            chunk = bits[7+5*cidx:7+5*(cidx+1)-1]
            println(chunk)
            scan = Bool(chunk[1])

            literal_bits = vcat(literal_bits, chunk[2:end])
            cidx += 1
        end

        println(literal_bits)
        return parse(Int, join(literal_bits), base=2)
    elseif type == 0
        println("Got Op type 0")
        t_length = bits[7:7+15]
        println(t_length)
    elseif type == 1
        println("Got op tpye 1")

    end
end

end # module
# what do you get if you add up the version numbers in all packets?