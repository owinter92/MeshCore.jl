using Test
@time @testset "MeshCore" begin
    #include("test_core.jl")
    include("attributes_tests.jl")
    include("shapedesc_tests.jl")
end
