function q_density(ρ::Vector,j_z::Matrix,j_y::Matrix,ϕ,θ)
    
    up_state = zeros(length(ρ))
    up_state[length(ρ)] = 1
                
    rot_state = expm(im*j_z*ϕ)*expm(-im*j_y*θ)*up_state
            

    abs2((ρ'*rot_state)[1])
end

function q_density(ρ::Matrix,j_z::Matrix,j_y::Matrix,ϕ,θ)
    
    up_state = zeros(length(ρ))
    up_state[length(ρ)] = 1
                
    rot_state = expm(im*j_z*ϕ)*expm(-im*j_y*θ)*up_state
            
    real((rot_state'*ρ*rot_state)[1])
end;

function generateMap(ρ::Vector,j_z::Matrix,j_y::Matrix,points::Int)
    
    output = zeros(points, 2*points)
    ϕ_vec = linspace(2*pi/(4*points),2*pi-2*pi/(4*points),2*points)
    θ_vec = linspace(pi/(2*points),pi-pi/(2*points),points)
    
        for i in 1:points
            for j in 1:2*points
                
            output[i,j] = q_density(ρ,j_z,j_y,ϕ_vec[j],θ_vec[i])
                
            end
        end
    output
end
   
function generateMap(ρ::Matrix,j_z::Matrix,j_y::Matrix,points::Int)
  
    output = zeros(points, 2*points)
    ϕ_vec = linspace(0,2*pi-(pi/points),2*points)
    θ_vec = linspace(0,pi,points)
    
    for i in 1:points
        for j in 1:(2*points)
            output[i,j]=q_density(ρ,j_z,j_y,ϕ_vec[j],θ_vec[i]) 
        end 
    end    
end;