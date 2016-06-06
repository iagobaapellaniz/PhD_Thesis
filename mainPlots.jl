using HDF5, PyPlot

using PyCall
@pyimport matplotlib.patches as patch

L_FSIZE = 18
T_FSIZE = 14
CMAP = "viridis"
CMAP_R = "viridis_r"
HG = 3.5 #inches
WD = 5 #inches
LWD = 1.5; #points
BAR_BLUE = (0.4,0.6,0.8)
BG_GREY = "0.95"

include("plotsBG.jl")
include("plotsVD.jl")
include("plotsLT.jl")
include("plotsGM.jl")

plotLT_dickeEdge()

plotLT_dicke7900asymp()
