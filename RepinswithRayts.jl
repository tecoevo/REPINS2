using DifferentialEquations
using Plots
using DataFrames
using CSV

δ = 10^-3
γ = 0.95
λ = 10^-2
α = 10^-2#0.0
ω = 0.985
ϵ = 0.0

kmax = ceil(Int,(1/(δ * γ)))
println(kmax)

lmax = 3

function benefit(r)
    return α * (1-ω^r)/(1-ω)
end

function growth(r,u,l)
    return 1 - sum(u) + benefit(r) -  (r*γ)*(if (l == 1) 0.0 elseif (l == 2) δ else 2*δ end)
end

function amplify(r,l)
#    if (r >= 1 && r < (kmax-1))
        return r * (λ  + (if (l == 1) 0.0 elseif (l == 2) δ else 2*δ end) * (1-γ))
    # else
    #     return 0
    # end
end

function deletion(r)
    if r < 1
        return 0
    else
        return r * λ
    end
end

function addition(k,u,l)
    part1 = 0
    part2 = 0
    if k >= 2
        part1 = amplify(k-2,l) * u[k-1]
    end
    if k <= kmax-1
        part2 = deletion(k) * u[k+1]
    end
    return part1+part2
end

function F(k,u,l)
    return growth(k-1,u[:,l],l)* u[k,l] + addition(k,u[:,l],l) - u[k,l] * (deletion(k-1) + amplify(k-1,l))
end

function lorenz!(du,u,p,t)
    for i in 1:kmax
        du[i,1] = F(i,u,1) + ϵ*(u[i,2]-u[i,1])
        du[i,2] = F(i,u,2) + ϵ*(u[i,1]+u[i,3]) - 2*ϵ*u[i,2]
        du[i,3] = F(i,u,3) + ϵ*u[i,2] - ϵ*u[i,3]
    end
end


## Solving for the first initial condition
A = zeros(kmax,3)
for i in trunc(Int,(0.75* kmax)):kmax
         A[i,2] = 0.01
     end
u0 = A
tspan = (0.0,1000.0)
prob = ODEProblem(lorenz!,u0,tspan)
sol2 = solve(prob,Tsit5(), abstol=1e-10, dense=false,saveat=10)

# pl2 = plot(sol2,vars=[(0,kmax),(0,trunc(Int,(0.75* kmax))),(0,2*kmax),(0,kmax+trunc(Int,(0.75* kmax))),(0,3*kmax),(0,2*kmax+trunc(Int,(0.75* kmax)))],title = "Bacterial density when starting with REPINS close to kmax", label = ["No Rayts at k = kmax" "No rayts at 0.75*kmax" "One Rayts Starting at k = kmax" "One rayts Starting at 0.75*kmax" "Two Rayts at k = kmax" "Two rayts at 0.75*kmax"], lw = 3)
#
# savefig(pl2,"fig2fromRayts.pdf")

#CSV.write("Raytssol2_withRAYTS.csv",DataFrame(sol2))
CSV.write("Raytssol2_withbenefits.csv",DataFrame(sol2))
#CSV.write("Raytssol2_withoutbenefits.csv",DataFrame(sol2))


## Solving for the second initial condition
A = zeros(kmax,3)
for i in 1:trunc(Int,(0.25* kmax))
         A[i,2] = 0.01
       end
u0 = A
tspan = (0.0,1000.0)
prob = ODEProblem(lorenz!,u0,tspan)
sol3 = solve(prob,Tsit5(), abstol=1e-10, dense=false,saveat=10)

# pl3 = plot(sol3,vars=[(0,kmax),(0,trunc(Int,(0.75* kmax))),(0,2*kmax),(0,kmax+trunc(Int,(0.75* kmax))),(0,3*kmax),(0,2*kmax+trunc(Int,(0.75* kmax)))],title = "Bacterial density when starting with REPINS close to kmax", label = ["No Rayts at k = kmax" "No rayts at 0.75*kmax" "One Rayts Starting at k = kmax" "One rayts Starting at 0.75*kmax" "Two Rayts at k = kmax" "Two rayts at 0.75*kmax"], lw = 3)

# savefig(pl3,"fig3fromRayts.pdf")


#CSV.write("Raytssol3_withRAYTS.csv",DataFrame(sol3))
CSV.write("Raytssol3_withbenefits.csv",DataFrame(sol3))
#CSV.write("Raytssol3_withoutbenefits.csv",DataFrame(sol3))
