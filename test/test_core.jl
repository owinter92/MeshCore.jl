module mmesh1
using MeshCore: P1, L2
using Test
function test()
    @test P1.manifdim == 0
    @test L2.nfacets == 2
    true
end
end
using .mmesh1
mmesh1.test()

module mmesh2
using StaticArrays
using MeshCore: Vertices, nvertices, coordinates
using Test
function test()
    xyz = [0.0 0.0; 633.3333333333334 0.0; 1266.6666666666667 0.0; 1900.0 0.0; 0.0 400.0; 633.3333333333334 400.0; 1266.6666666666667 400.0; 1900.0 400.0; 0.0 800.0; 633.3333333333334 800.0; 1266.6666666666667 800.0; 1900.0 800.0]
    v =  Vertices(xyz)
    @test nvertices(v) == 12
    x = coordinates(v, SVector{2}([2, 4]))
    @test x[1] == SVector{2}([633.3333333333334 0.0])
    true
end
end
using .mmesh2
mmesh2.test()

module mmesh3
using StaticArrays
using MeshCore: L2, Q4, ShapeCollection, connectivity, manifdim, nnodes, nfacets, facetdesc, nshapes
using Test
function test()
    shapedesc = Q4
    c = [(1, 2, 6, 5), (5, 6, 10, 9), (2, 3, 7, 6), (6, 7, 11, 10), (3, 4, 8, 7), (7, 8, 12, 11)]
    cc = [SVector{shapedesc.nnodes}(c[idx]) for idx in 1:length(c)]
    shapes = ShapeCollection(shapedesc, cc)
    @test connectivity(shapes, 3)[3] == 7
    @test connectivity(shapes, SVector{2}([2, 4]))[1][4] == 9
    @test manifdim(shapes) == 2
    @test nnodes(shapes) == 4
    @test facetdesc(shapes) == L2
    @test nfacets(shapes) == 4
    @test nshapes(shapes) == 6
    true
end
end
using .mmesh3
mmesh3.test()

module mmesh4
using StaticArrays
using MeshCore: L2, Q4, ShapeCollection, connectivity, manifdim, nnodes, nfacets, facetdesc, nshapes, facetconnectivity
using MeshCore: hyperfacecontainer, addhyperface!
using Test
function test()
    shapedesc = Q4
    c = [(1, 2, 6, 5), (5, 6, 10, 9), (2, 3, 7, 6), (6, 7, 11, 10), (3, 4, 8, 7), (7, 8, 12, 11)]
    cc = [SVector{shapedesc.nnodes}(c[idx]) for idx in 1:length(c)]
    shapes = ShapeCollection(shapedesc, cc)
    @test connectivity(shapes, 3)[3] == 7
    @test connectivity(shapes, SVector{2}([2, 4]))[1][4] == 9
    @test manifdim(shapes) == 2
    @test nnodes(shapes) == 4
    @test facetdesc(shapes) == L2
    @test nfacets(shapes) == 4

    hfc = hyperfacecontainer()
    for i in 1:nshapes(shapes)
        for j in 1:nfacets(shapes)
            fc = facetconnectivity(shapes, i, j)
            addhyperface!(hfc, fc)
        end
    end

    c = SVector{facetdesc(shapes).nnodes, Int64}[]
    for a in values(hfc)
        for h in a
            push!(c, SVector{facetdesc(shapes).nnodes}(h.oc))
        end
    end
    @test length(c) == 17
    skel1shapes = ShapeCollection(facetdesc(shapes), c)
    @test nshapes(skel1shapes) == 17
    true
end
end
using .mmesh4
mmesh4.test()

module mmesh5
using StaticArrays
using MeshCore: L2, Q4, ShapeCollection, connectivity, manifdim, nnodes, nfacets, facetdesc, nshapes, facetconnectivity
using MeshCore: skeleton
using Test
function test()
    shapedesc = Q4
    c = [(1, 2, 6, 5), (5, 6, 10, 9), (2, 3, 7, 6), (6, 7, 11, 10), (3, 4, 8, 7), (7, 8, 12, 11)]
    cc = [SVector{shapedesc.nnodes}(c[idx]) for idx in 1:length(c)]
    shapes = ShapeCollection(shapedesc, cc)
    @test connectivity(shapes, 3)[3] == 7
    @test connectivity(shapes, SVector{2}([2, 4]))[1][4] == 9
    @test manifdim(shapes) == 2
    @test nnodes(shapes) == 4
    @test facetdesc(shapes) == L2
    @test nfacets(shapes) == 4

    skel1shapes = skeleton(shapes)
    @test nshapes(skel1shapes) == 17
    true
end
end
using .mmesh5
mmesh5.test()

module mmesh6
using StaticArrays
using MeshCore: Vertices, coordinates
using MeshCore: L2, Q4, ShapeCollection, connectivity, manifdim, nnodes, nfacets, facetdesc, nshapes, facetconnectivity
using MeshCore: skeleton
using Test
function test()
    shapedesc = Q4
    xyz = [0.0 0.0; 633.3333333333334 0.0; 1266.6666666666667 0.0; 1900.0 0.0; 0.0 400.0; 633.3333333333334 400.0; 1266.6666666666667 400.0; 1900.0 400.0; 0.0 800.0; 633.3333333333334 800.0; 1266.6666666666667 800.0; 1900.0 800.0]
    v =  Vertices(xyz)
    c = [(1, 2, 6, 5), (5, 6, 10, 9), (2, 3, 7, 6), (6, 7, 11, 10), (3, 4, 8, 7), (7, 8, 12, 11)]
    cc = [SVector{shapedesc.nnodes}(c[idx]) for idx in 1:length(c)]
    shapes = ShapeCollection(shapedesc, cc)
    @test connectivity(shapes, 3)[3] == 7
    @test connectivity(shapes, SVector{2}([2, 4]))[1][4] == 9
    @test manifdim(shapes) == 2
    @test nnodes(shapes) == 4
    @test facetdesc(shapes) == L2
    @test nfacets(shapes) == 4

    skel1shapes = skeleton(shapes)
    @test nshapes(skel1shapes) == 17
    for i in 1:nshapes(skel1shapes)
        x = coordinates(v, connectivity(skel1shapes, i))
    end #
    true
end
end
using .mmesh6
mmesh6.test()
