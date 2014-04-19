using Grid
using Base.Test

x = -1.0:0.1:1.0
z = sin(x)

cg = CoordInterpGrid(x,z,BCnil,InterpQuadratic)

@test abs(cg[0.0] - sin(0.0)) < 100*eps()
@test abs(cg[0.3] - sin(0.3)) < 100*eps()

v,g = valgrad(cg,0.0)
@test abs(g - cos(0.0)) < 0.001

v,g = valgrad(cg,0.3)
@test abs(g - cos(0.3)) < 0.001



y = -2.0:0.1:2.0
z = Array(Float64,length(x),length(y))

for i = 1:length(x)
    for j = 1:length(y)
        z[i,j] = sin(x[i]+y[j])
    end
end

cg = CoordInterpGrid((x,y),z,BCnil,InterpQuadratic)

@test abs(cg[0.0,0.0] - sin(0.0)) < 0.0001
@test abs(cg[0.0,0.3] - sin(0.3)) < 0.0001
@test abs(cg[0.3,0.0] - sin(0.3)) < 0.0001

v,g = valgrad(cg,0.0,0.0)
@test abs(g[1] - cos(0.0)) < 0.001
@test abs(g[2] - cos(0.0)) < 0.001

v = valgrad(g,cg,0.3,0.0)
@test abs(g[1] - cos(0.3)) < 0.001
@test abs(g[2] - cos(0.3)) < 0.001