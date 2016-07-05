function plotLT_spsq2d()

  path = "LT/spinSqueezing/"
  precision = h5read("plotsData.h5", path*"precision");
  x_sql = h5read("plotsData.h5", path*"x_sql_bound");
  y_sql = h5read("plotsData.h5", path*"y_sql_bound");

  x_bound = h5read("plotsData.h5", path*"x_bound");
  y_bound = h5read("plotsData.h5", path*"y_bound");

  attr = h5readattr("plotsData.h5", path);
  XLim = attr["XLim"]
  YLim = attr["YLim"]

  figure(figsize=(6,3.5))

  xlabel(L"\langle J_y \rangle",fontsize=L_FSIZE)
  ylabel(L"(\Delta J_x)^2",fontsize=L_FSIZE)

  im = imshow(precision, cmap=CMAP_R ,aspect=1/2*4/5, extent=[0,2,0,4])
  sql_line = plot(x_sql, y_sql, "k--", LineWidth = LWD)
  boundary_line = plot(x_bound, y_bound, "k", LineWidth =1.25)

  cb = colorbar(im, ticks=Array(linspace(0,1,4)))
  cb[:ax][:set_yticklabels](vcat(map(string, Array(0:3))))
  cb[:set_label](L"\mathcal{B}_{\mathcal{F}}/N", fontsize=L_FSIZE)

  savefig("pdf/LT_spsq2d_4.pdf", bbox_inches="tight")

end

function plotLT_dickeEdge()

  x = h5read("plotsData.h5", "LT/dickeEdge/jx2_relative")
  y = h5read("plotsData.h5", "LT/dickeEdge/qfi_normalized")

  fig = figure(figsize=(5,3.5))

  ax = axis(xmin=0, xmax=1, ymin=0, ymax=4)

  bar(0,1,1,0, color="0.9",
      edgecolor="0.7",linewidth=0)
  plot([0,1],
      [1,1], color="0.7", linewidth=LWD, linestyle="dotted")

  xlabel(L"\langle J_x^2 \rangle/(N^2/4)",fontsize=L_FSIZE)
  ylabel(L"\mathcal{B}_{\mathcal{F}}/N",fontsize=L_FSIZE)

  plot(x,y, linewidth=LWD)

  savefig("pdf/LT_dicke_edge.pdf", bbox_inches="tight")

end

function plotLT_dicke7900asymp()

  x = h5read("plotsData.h5", "LT/dickeScaling/n_subsys")
  y = h5read("plotsData.h5", "LT/dickeScaling/qfi_scaledNormalized")

  fig = figure(figsize=(5,3.5))

  ax = axis(xmin=0, xmax=1010, ymin=0, ymax=3)

  bar(0,1,1050,0, color="0.9",
      edgecolor="0.7",linewidth=0)
  plot([0,1010],
      [1,1], color="0.7", linewidth=LWD, linestyle="dotted")

  xlabel(L"N'",fontsize=L_FSIZE)
  ylabel(L"\mathcal{B}_{\mathcal{F}}/N",fontsize=L_FSIZE)

  plot(x,y, linewidth=LWD, "-o")

  savefig("pdf/LT_dicke_7900_asymp.pdf", bbox_inches="tight")

end

function plotLT_fidGHZ()

  x = h5read("plotsData.h5", "LT/fidGHZ/fid")
  y = h5read("plostData.h5", "LT/fidGHZ/bound")

  fig = figure(figsize=(5,3.5))

  ax = axis(xmin=0, xmax=1, ymin=0, ymax=1)

  # bar(0,1,1050,0, color="0.9",
  #     edgecolor="0.7",linewidth=0)
  # plot([0,1010],
  #     [1,1], color="0.7", linewidth=LWD, linestyle="dotted")

  xlabel(L"F_{\rm GHZ}",fontsize=L_FSIZE)
  ylabel(L"\mathcal{B}_{\mathcal{F}}/N^2",fontsize=L_FSIZE)

  xticks([0,.25,.5,.75,1])

  plot(x,y, linewidth=LWD, "-")

  savefig("pdf/LT_fidGHZ.pdf", bbox_inches="tight")

end

function plotLT_fidDicke()

  x = h5read("plotsData.h5", "LT/fidDicke/fid_new")
  y1 = h5read("plotsData.h5", "LT/fidDicke/bound4")/16
  y2 = h5read("plotsData.h5", "LT/fidDicke/bound8")/64

  fig = figure(figsize=(5,3.5))

  ax = axis(xmin=0, xmax=1, ymin=0, ymax=1)

  # bar(0,1,1050,0, color="0.9",
  #     edgecolor="0.7",linewidth=0)
  # plot([0,1010],
  #     [1,1], color="0.7", linewidth=LWD, linestyle="dotted")

  xlabel(L"F_{\rm Dicke}",fontsize=L_FSIZE)
  ylabel(L"\mathcal{B}_{\mathcal{F}}/N^2",fontsize=L_FSIZE)

  xticks([0,.25,.5,.75,1])

  plot(x,y1, linewidth=LWD, "-")
  plot(x,y2, linewidth=LWD, "r--")

  savefig("pdf/LT_fidDicke.pdf", bbox_inches="tight")
end

function plotLT_legendre()

  x = Array(linspace(-1,4,200));
  y = map((x) -> (x-3)*(x+0.1)+x, x);
  yy = x

  ind_opt = indmax(yy-y)
  x_opt   = x[ind_opt]
  y_opt   = y[ind_opt]
  yy_opt  = yy[ind_opt]

  fig = figure(figsize=(5,3.5))

  plot([0,0],[-4,6], "k", linewidth=1., hold=false)
  plot([-1,4], [0,0], "k", linewidth=1.)

  plot(x,y, "b-", linewidth=LWD);
  plot(x,yy, "r--", linewidth=LWD)
  plot([x_opt,x_opt],[-4, yy_opt], "k:", linewidth=LWD)

  text(x_opt+0.05, -2.7, L"x_{\rm opt}", fontsize=T_FSIZE)
  text(2, 1.25, L"f(x)", color="blue", fontsize=T_FSIZE)
  text(x_opt-0.5, x_opt, L"rx", color="red", fontsize=T_FSIZE)
  text(x_opt+0.09, y_opt-0.5, L"a", fontsize=T_FSIZE)
  text(x_opt+0.09, yy_opt-0.5, L"b", fontsize=T_FSIZE)

  text(0.25, 3, L"\hat{f}(r) = b_y-a_y", fontsize=T_FSIZE)

  scatter([x_opt, x_opt], [y_opt, yy_opt], color="k")

  xlim([-0.5,3.5])
  ylim([-3,5])
  xlabel(L"$x$", fontsize=L_FSIZE)
  ylabel(L"$y$", fontsize=L_FSIZE)

  savefig("pdf/LT_legendre.pdf", bbox_inches="tight")
end
plotLT_legendre();

function plotLT_edgeDiff()
  x4    = h5read("plotsData.h5", "/LT/edgeDifference/jz4")
  x6    = h5read("plotsData.h5", "/LT/edgeDifference/jz6")
  x10   = h5read("plotsData.h5", "/LT/edgeDifference/jz10")
  x20   = h5read("plotsData.h5", "/LT/edgeDifference/jz20")
  x1000 = h5read("plotsData.h5", "/LT/edgeDifference/jz1000")
  y4    = h5read("plotsData.h5", "/LT/edgeDifference/diff4")
  y6    = h5read("plotsData.h5", "/LT/edgeDifference/diff6")
  y10   = h5read("plotsData.h5", "/LT/edgeDifference/diff10")
  y20   = h5read("plotsData.h5", "/LT/edgeDifference/diff20")
  y1000 = h5read("plotsData.h5", "/LT/edgeDifference/diff1000")

  # For 5 plots choose 5 viridis colors
  color_viridis_array = PyPlot.ColorMap("viridis")[:colors]
  step= 50

  fig = figure(figsize=(5,3.5))

  xlim([0,1])
  ylim([0,3])

  xlabel(L"\langle J_y\rangle/(N/2)", fontsize=L_FSIZE)
  ylabel(L"$\Delta_{\mathcal{B}}/\mathcal{B}_{\mathcal{F}}$ [%]", fontsize=L_FSIZE)

  plot(x1000,100*y1000, linewidth=LWD, color=color_viridis_array[1+4*step,:])
  plot(x20,100*y20, "--", linewidth=LWD, color=color_viridis_array[1+3*step,:])
  plot(x10,100*y10, "-.", linewidth=LWD, color=color_viridis_array[1+2*step,:])
  plot(x6,100*y6, ":", linewidth=LWD, color=color_viridis_array[1+step,:])
  plot(x4,100*y4, "-",linewidth=LWD, color=color_viridis_array[1,:])

  savefig("pdf/LT_edge_diff.pdf", bbox_inches="tight")
end
plotLT_edgeDiff();
