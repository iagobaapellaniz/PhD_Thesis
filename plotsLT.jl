function plotLT_spsq2d()

  dataFile = h5open("plotsData.h5")
  dataGroup = g_open(dataFile,"OptimalBound/SpinSqueezing")

  precision = read(dataGroup["precision"]);
  x_sql = read(dataGroup["x_sql_bound"])
  y_sql = read(dataGroup["y_sql_bound"])

  x_bound = read(dataGroup["x_bound"])
  y_bound = read(dataGroup["y_bound"])

  XLim = read(attrs(dataGroup)["XLim"]);
  YLim = read(attrs(dataGroup)["YLim"]);

  figure(figsize=(6,3.5))

  xlabel(L"\langle J_x \rangle",fontsize=L_FSIZE)
  ylabel(L"(\Delta J_y)^2",fontsize=L_FSIZE)

  im = imshow(precision, cmap=CMAP_R ,aspect=1/2*4/5, extent=[0,2,0,4])
  sql_line = plot(x_sql, y_sql, "k--", LineWidth = LWD)
  boundary_line = plot(x_bound, y_bound, "k", LineWidth =1.25)

  cb = colorbar(im, ticks=Array(linspace(0,1,4)))
  cb[:ax][:set_yticklabels](vcat(map(string, Array(0:3))))

  savefig("pdf/LT_spsq2d_4.pdf", bbox_inches="tight")
  close(dataFile)

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
