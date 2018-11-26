@testset "Property interface" begin
    nt = (a=1,b=2.0,c=false)
    @test @inferred(getproperty(:b)(nt)) === 2.0

    @test @inferred(TypedTables.getproperties(:b)(nt)) === (b = 2.0,)

    c1 = @calc($b)
    @test c1 isa TypedTables.GetProperty
    @test @inferred(c1(nt)) === 2.0

    c2 = @calc(2*$b)
    @test @inferred(c2(nt)) === 4.0

    c3 = @calc($a + 2*$b)
    @test @inferred(c3(nt)) === 5.0

    s1 = @select(a)
    @test s1 isa TypedTables.GetProperties
    @test @inferred(s1(nt)) === (a = 1,)

    s2 = @select(c,b,a)
    @test s1 isa TypedTables.GetProperties
    @test @inferred(s2(nt)) === (c = false, b = 2.0, a = 1)

    s3 = @select(a, c = $c, d = $a + 2*$b)
    @test @inferred(s3(nt)) === (a = 1, c = false, d = 5.0)
end