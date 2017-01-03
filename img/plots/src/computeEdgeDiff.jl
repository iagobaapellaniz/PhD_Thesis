workspace()
using PyPlot, HDF5;
include("../Packages/QuIn/src/fastquin.jl");

function getPoints(n::Int)

  d = n + 1;

  jz = Core.j_z(d);
  jx = Core.j_x(d);
  jy = Core.j_y(d);

  points = 100;
  target_jyₙ = linspace(0,n/2,points);
  function search4lambda(target_jy, prev_λ, init_step)
    state = eigvecs(jx^2-prev_λ*jy)[:,1]
    jy_val = real(Core.expect_vector(state, jy))
    loops = 0
    while jy_val < target_jy
      loops += 1
      if loops == 6 # Each 5 cycles, change the order
        loops = 0
        init_step *= 10 # Change the order of magnitude
      end
      prev_λ += init_step
      state = eigvecs(jx^2-prev_λ*jy)[:,1]
      jy_val = real(Core.expect_vector(state, jy))
    end
    prev_λ, init_step, state, jy_val
  end
  jyₙ = Array(Float64, points);
  qfiₙ = copy(jyₙ);
  smerziₙ = copy(qfiₙ);

  λ, init_step = 0., 0.00001
  for i = 1:points-1
    λ, init_step, state, jyₙ[i] = search4lambda(target_jyₙ[i], λ, init_step)
    qfiₙ[i] = Core.qfi(state, jz)
    smerziₙ[i] = jyₙ[i]^2/real(Core.expect_vector(state, jx^2))
  end
  smerziₙ[1] = n*(n+2)/2
  smerziₙ[end] = n
  qfiₙ[end] = n
  jyₙ[end] = n/2

  jyₙ, qfiₙ, smerziₙ
end

x4, y4, yy4 = getPoints(4);
x6, y6, yy6 = getPoints(6);
x10, y10, yy10 = getPoints(10);
x20, y20, yy20 = getPoints(20);
x1000, y1000, yy1000 = getPoints(1000);

function fig1()
  fig = figure(figsize=(5,3.5));
  hold(true)
  ylim([0,0.03]);
  xlim([0,1])
  plot(2*x4/4, map(/,y4-yy4,y4));
  plot(2*x6/6, map(/,y6-yy6,y6));
  plot(2*x10/10, map(/,y10-yy10,y10));
  plot(2*x20/20, map(/,y20-yy20,y20));
  plot(2*x1000/1000, map(/,y1000-yy1000,y1000));
  savefig("edge.normQFI.pdf", bbox_inches="tight");
end

fig1();

function fig2()
  fig = figure(figsize=(5,3.5));
  ylim([0,0.03]);
  xlim([0,1])
  plot(2*x4/4, map(/,y4-yy4,yy4));
  plot(2*x6/6, map(/,y6-yy6,yy6));
  plot(2*x10/10, map(/,y10-yy10,yy10));
  plot(2*x20/20, map(/,y20-yy20,yy20));
  plot(2*x1000/1000, map(/,y1000-yy1000,yy1000));
  savefig("edge.normSP.pdf", bbox_inches="tight")
end

fig1();
fig2();

h5write("plotsData.h5", "/LT/edgeDifference/jz4", 2*x4/4)
h5write("plotsData.h5", "/LT/edgeDifference/jz6", 2*x6/6)
h5write("plotsData.h5", "/LT/edgeDifference/jz10", 2*x10/10)
h5write("plotsData.h5", "/LT/edgeDifference/jz20", 2*x20/20)
h5write("plotsData.h5", "/LT/edgeDifference/jz1000", 2*x1000/1000)
h5write("plotsData.h5", "/LT/edgeDifference/diff4", map(/,y4-yy4,yy4))
h5write("plotsData.h5", "/LT/edgeDifference/diff6", map(/,y6-yy6,yy6))
h5write("plotsData.h5", "/LT/edgeDifference/diff10", map(/,y10-yy10,yy10))
h5write("plotsData.h5", "/LT/edgeDifference/diff20", map(/,y20-yy20,yy20))
h5write("plotsData.h5", "/LT/edgeDifference/diff1000", map(/,y1000-yy1000,yy1000))
