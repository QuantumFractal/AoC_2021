module day12

using AoC_2021

const END = "end"
const START = "start"

function solve(input::String = getRawInput(12))
    small_test = """start-A
    start-b
    A-c
    A-b
    b-d
    A-end
    b-end"""

    starts = []
    graph = Dict()
    for line in split(input, "\n")
        from, to = split(line, "-")

        if from == START || to == START
            push!(starts, from == START ? to : from)
            continue
        end

        if from ∉ keys(graph)
            push!(graph, from => [to])
        else
            push!(graph[from], to)
        end

        if to ∉ keys(graph)
            push!(graph, to => [from])
        else
            push!(graph[to], from)
        end
    end

    delete!(graph, END)
    push!(graph, START => starts)

    visited = Dict(node => false for node in keys(graph))
    push!(visited, "start" => false)
    push!(visited, "end" => false)

    path = ["start"]
    paths = Dict()
    dfs(graph, visited, false, path, paths)
    #sort!(paths)
    return graph, length(keys(paths))

end

function dfs(graph, visited, single, path, paths)
    node = path[end]
    if node == "end"
        str_path = join(path, ",")
        if str_path ∉ keys(paths)
            push!(paths, (str_path => false))
        end
        return
    end

    for adj in graph[node]
        if !visited[adj]
            if is_big(adj)
                push!(path, adj)
                dfs(graph, visited, single, path, paths)
                pop!(path)
            else
                push!(path, adj)
                visited[adj] = true
                dfs(graph, visited, single, path, paths)
                visited[adj] = false
                pop!(path)

                if single == false
                    push!(path, adj)
                    dfs(graph, visited, true, path, paths)
                    pop!(path)
                end
            end
        end
    end
end

is_big(node) = length(filter(c -> Int(Char(c)) < 97, node)) == length(node)


function part1(mat)


end


function part2(mat)

end

end # module