using MeshCore: H8, L2, L3, NoSuchShape, P1, Q4, Q8, T3, T4, T6
using MeshCore: manifdim, nvertices, nfacets, nridges, n1storderv, nshifts, nfeatofdim
using MeshCore: SHAPE_DESC

function _is_not_tested(testset,test)
    tested = filter!(x -> x != "NoSuchShape", [keys(testset)...])
    all = [keys(SHAPE_DESC)...]
    not_tested = filter(x -> !(x in tested), all)
    @error "$(test): Missing test for $(not_tested)."
end

@testset "manifdim" begin
    MD = Dict(
        "H8" => 3,
        "L2" => 1,
        "L3" => 1,
        "NoSuchShape" => 0,
        "P1" => 0,
        "Q4" => 2,
        "Q8" => 2,
        "T3" => 2,
        "T4" => 3,
        "T6" => 2
    )
    if length(keys(SHAPE_DESC)) != length(keys(MD))
        _is_not_tested(MD, "manifdim")
    end
    for (shape, v) in MD
        r = @test manifdim(SHAPE_DESC[shape]) == v
        if r.value == "false"
            @error "Error in manifdim($(shape))"
        end
    end
end

@testset "nvertices" begin
    NV = Dict(
        "H8" => 8,
        "L2" => 2,
        "L3" => 3,
        "NoSuchShape" => 0,
        "P1" => 1,
        "Q4" => 4,
        "Q8" => 8,
        "T3" => 3,
        "T4" => 4,
        "T6" => 6
    )
    if length(keys(SHAPE_DESC)) != length(keys(NV))
        _is_not_tested(NV, "nvertices")
    end
    for (shape, v) in NV
        r = @test nvertices(SHAPE_DESC[shape]) == v
        if r.value == "false"
            @error "Error in nvertices($(shape))"
        end
    end
end

@testset "nfacets" begin
    NF = Dict(
        "H8" => 6,
        "L2" => 2,
        "L3" => 2,
        "NoSuchShape" => 0,
        "P1" => 0,
        "Q4" => 4,
        "Q8" => 4,
        "T3" => 3,
        "T4" => 4,
        "T6" => 3
    )
    if length(keys(SHAPE_DESC)) != length(keys(NF))
        _is_not_tested(NF, "nfacets")
    end
    for (shape, v) in NF
        r = @test nfacets(SHAPE_DESC[shape]) == v
        if r.value == "false"
            @error "Error in nfacets($(shape))"
        end
    end
end

@testset "nridges" begin
    NR = Dict(
        "H8" => 12,
        "L2" => 0,
        "L3" => 0,
        "NoSuchShape" => 0,
        "P1" => 0,
        "Q4" => 4,
        "Q8" => 4,
        "T3" => 3,
        "T4" => 6,
        "T6" => 3
    )
    if length(keys(SHAPE_DESC)) != length(keys(NR))
        _is_not_tested(NR, "nridges")
    end
    for (shape, v) in NR
        r = @test nridges(SHAPE_DESC[shape]) == v
        if r.value == "false"
            @error "Error in nridges($(shape))"
        end
    end
end

@testset "n1storderv" begin
    NFOV = Dict(
        "H8" => 8,
        "L2" => 2,
        "L3" => 2,
        "NoSuchShape" => 0,
        "P1" => 1,
        "Q4" => 4,
        "Q8" => 4,
        "T3" => 3,
        "T4" => 4,
        "T6" => 3
    )
    if length(keys(SHAPE_DESC)) != length(keys(NFOV))
        _is_not_tested(NFOV, "n1storderv")
    end
    for (shape, v) in NFOV
        r = @test n1storderv(SHAPE_DESC[shape]) == v
        if r.value == "false"
            @error "Error in n1storderv($(shape))"
        end
    end
end

@testset "nshifts" begin
    NSHIFTS = Dict(
        "H8" => 0,
        "L2" => 0,
        "L3" => 0,
        "NoSuchShape" => 0,
        "P1" => 0,
        "Q4" => 4,
        "Q8" => 4,
        "T3" => 3,
        "T4" => 0,
        "T6" => 3
    )
    if length(keys(SHAPE_DESC)) != length(keys(NSHIFTS))
        _is_not_tested(NSHIFTS, "nshifts")
    end
    for (shape, v) in NSHIFTS
        r = @test nshifts(SHAPE_DESC[shape]) == v
        if r.value == "false"
            @error "Error in nshifts($(shape))"
        end
    end
end

#FD TODO
#RD TODO

@testset "nfeatofdim" begin
    NFOD = Dict(
        "H8" => [8, 12, 6, 1],
        "L2" => [2, 1, 0, 0],
        "L3" => [3, 1, 0, 0],
        "NoSuchShape" => [1, 0, 0, 0],
        "P1" => [1, 0, 0, 0],
        "Q4" => [4, 4, 1, 0],
        "Q8" => [8, 4, 1, 0],
        "T3" => [3, 3, 1, 0],
        "T4" => [4, 6, 4, 1],
        "T6" => [6, 3, 1, 0]
    )
    if length(keys(SHAPE_DESC)) != length(keys(NFOD))
        _is_not_tested(NFOD, "nshifts")
    end
    for (shape, v) in NFOD
        for d in 0:3
            r = @test nfeatofdim(SHAPE_DESC[shape], d) == v[d+1]
            if r.value == "false"
                @error "Error in nfeatofdim($(shape),$(d))"
            end
        end
    end
end
