function plotVD_evolution_example()

    filenames = h5read("plotsData.h5","VicinityDicke/EvolutionExample/bloch_filename_array")
    states = h5read("plotsData.h5","VicinityDicke/EvolutionExample/dicke_x_N16_state_array")

    (fig, axarr) = subplots(2, 5)

    fig[:set_size_inches](11,4)

    for i in 1:2
        for j in 1:5
            if i == 1

                axarr[i,j][:imshow](imread(filenames[j]),interpolation="bilinear")
                axarr[i,j][:set_axis_off]()

                axarr[i,j][:get_xaxis]()[:set_visible](false)
                axarr[i,j][:get_yaxis]()[:set_visible](false)

            else

                axarr[i,j][:bar](Array(-8:8)-0.5, real(map(abs2, states[:,j])),
                    width=1, facecolor= BAR_BLUE, edgecolor = BG_GREY)
                axarr[i,j][:set_ylim]([0.,1.1])
                axarr[i,j][:set_xlim]([-9,9])
                axarr[i,j][:set_xticks]([-8,-4,0,4,8])
                if j != 1
                    setp(axarr[i,j][:get_yticklabels](),visible=false)
                else
                    axarr[i,j][:set_xlabel](L"|m\rangle_{x}")
                end
                axarr[i,j][:set_axis_bgcolor](BG_GREY)
                axarr[i,j][:set_axisbelow](true)
                axarr[i,j][:grid]()

            end
        end
    end

    fig[:subplots_adjust](wspace=0.02, hspace=0)

    savefig("pdf/VD_evolution_of_dicke.pdf", bbox_inches="tight")
end

function plotVD_precisionOnTheta()

    # Open data group of the plot
    group = g_open(h5open("plotsData.h5"),"VicinityDicke/PrecisionOverTheta")

    theta = d_read(group,"theta")
    precision = d_read(group, "precision")

    theta_max = a_read(group,"theta_max")
    precision_max = a_read(group,"precision_max")

    fig = figure(figsize=(5,3.5))
    xl = xlabel(L"$\Theta$ [A.U.]", fontsize=L_FSIZE)
    yl = ylabel(L"$(\Delta \Theta)^{-2}/N$", fontsize=L_FSIZE)
    xticks(rotation=45)

    ax = axis(xmin=minimum(theta), xmax=maximum(theta))

    # SN thresold
    bar(minimum(theta),1,maximum(theta),0, color="0.9",
        edgecolor="0.7",linewidth=0)
    plot([minimum(theta),maximum(theta)],
        [1,1], color="0.7", linewidth=LWD, linestyle="dotted")

    plot([theta_max,theta_max],[0,precision_max],
        "--r", linewidth=LWD)
    plt = plot(theta,precision,linewidth=LWD)


    savefig("pdf/VD_precision_theta.pdf", bbox_inches="tight")

end

function plotVD_againstSPSQ()

    # Open data group of the plot
    parameter = h5read("plotsData.h5","VD/comparison/spsq_parameter")
    quantumFI = h5read("plotsData.h5","VD/comparison/spsq_qfi")
    precision = h5read("plotsData.h5","VD/comparison/spsq_opt_prec_old")

    fig = figure(figsize=(5,3.5))
    xl = xlabel(L"$\lambda$ [A.U.]", fontsize=L_FSIZE)
    yl = ylabel(L"(\Delta \Theta)^{-2}/N", fontsize=L_FSIZE)
    xticks([0,0.1,0.2,0.3,0.4])

    ax = axis(xmin=0, xmax=maximum(parameter), ymin=0, ymax=140)

    plot(parameter,quantumFI,"--r", linewidth=LWD,label=L"\mathcal{F}\,[\rho_\lambda,J_z]/N")
    plot(parameter,precision,linewidth=LWD,label=L"(\Delta \Theta)^{-2}/N")
    legend(frameon=false)

    savefig("pdf/VD_against_spsq.pdf", bbox_inches="tight")
end

function plotVD_againstTherm()

    # Open data group of the plot
    group = g_open(h5open("plotsData.h5"),"VicinityDicke/Comparison")

    parameter = d_read(group,"therm_parameter")
    quantumFI = d_read(group,"therm_qfi")
    precision = d_read(group,"therm_opt_prec")

    fig = figure(figsize=(5,3.5))
    xl = xlabel(L"$T$ [A.U.]", fontsize=L_FSIZE)
    yl = ylabel(L"(\Delta \Theta)^{-2}/N", fontsize=L_FSIZE)

    ax = axis(xmin=0, xmax=maximum(parameter))

    plot(parameter,quantumFI,"--r", linewidth=LWD,label=L"\mathcal{F}\,[\rho_T,J_z]/N")
    plot(parameter,precision,linewidth=LWD,label=L"(\Delta \Theta)^{-2}/N")
    legend(frameon=false)

    savefig("pdf/VD_against_therm.pdf", bbox_inches="tight")

end

function plotVD_exper_area()

    dataFile = h5open("plotsData.h5")
    dataGroup = g_open(dataFile, "VicinityDicke/Experimental")

    # Read all atributes
    n = a_read(dataGroup, "N")
    ex_jx2  = a_read(dataGroup, "Jx^2")
    ex_jy2  = a_read(dataGroup, "Jy^2")/(n*(n+2)/8)
    err_jx2 = a_read(dataGroup, "Jx^2 error")
    err_jy2 = a_read(dataGroup, "Jy^2 error")/(n*(n+2)/8)

    # Read data for the plot & apply normalizations
    y = d_read(dataGroup, "area_jx2")
    x = d_read(dataGroup, "area_jy2")/(n*(n+2)/8)
    z = d_read(dataGroup, "area_precs").^(-1)/n
    z[1:end,1] = zeros(1,length(x))

    ln = 15
    map!(z -> if z > ln || isnan(z) 15 else z end,z);

    fig = figure(figsize=(6,3.5))

    ylabel(L"$\langle J_x^2\rangle$", fontsize=L_FSIZE)
    xlabel(L"$\langle J_y^2\rangle / J_{\rm max}$", fontsize=L_FSIZE)

    im = imshow(z, cmap="viridis_r", interpolation="bilinear",
    origin="lower", extent=[0,1,0,400], aspect=1/400*4/5)

    c = contour(x,y,z,ln-1,colors="k")
    clabel(c, fmt="%1.0f", manual=[(0.7,250),(0.9,250),(0.6,60),(0.95,130),(0.92,90)])
    cb = colorbar(im, ticks=Array(0:ln))
    cb[:ax][:set_yticklabels](vcat(map(string, Array(0:ln-1)),">$ln"))

    plot([ex_jy2,ex_jy2],[0, maximum(y)], "k--", lw=LWD)

    plot([ex_jy2], [ex_jx2], "k+", markersize=12, mew=LWD)

    e = patch.Ellipse([ex_jy2,ex_jx2], 2*err_jy2, 2*err_jx2,
    fc=BAR_BLUE, ec="k", ls=":", lw=LWD, alpha=0.8)

    fig[:axes][1][:add_patch](e)

    savefig("pdf/VD_exper_contour.pdf", bbox_inches="tight")
    close(dataFile)
end

function plotVD_exper_slice()

    dataFile = h5open("plotsData.h5")
    dataGroup = g_open(dataFile, "VicinityDicke/Experimental")

    # Read all atributes
    n = a_read(dataGroup, "N")
    ex_jx2  = a_read(dataGroup, "Jx^2")
    ex_jy2  = a_read(dataGroup, "Jy^2")/(n*(n+2)/8)
    ex_precs= a_read(dataGroup, "Precision")
    err_jx2 = a_read(dataGroup, "Jx^2 error")
    err_jy2 = a_read(dataGroup, "Jy^2 error")/(n*(n+2)/8)
    ellipse_precs = a_read(dataGroup, "Error-ellipse's precision (Vector)")

    # Read data for the plot & apply normalizations
    x = d_read(dataGroup, "slice_jx2")
    y = d_read(dataGroup, "slice_precs").^(-1)/n

    fig = figure(figsize=(5,3.5))
    xl = xlabel(L"\langle J_x^2 \rangle", fontsize=L_FSIZE)
    yl = ylabel(L"$(\Delta \Theta)^{-2}/N$", fontsize=L_FSIZE)

    axis(xmin=0, xmax=maximum(x), ymin=0.1, ymax=3500)

    # Set Logarithmic Y and grid
    ax = fig[:get_axes]()[1]
    ax[:set_yscale]("log")
    ax[:set_yticks]([1,3,10,100,1000,3000])
    ax[:set_yticklabels]([1,3,10,100,1000,3000])
    ax[:yaxis][:grid](true)

    # SN thresold
    bar(minimum(x),0.9,maximum(x),0.1, color="0.9",
        edgecolor="0.7",linewidth=0)
    plot([minimum(x),maximum(x)],
        [1,1], color="0.7", linewidth=LWD, linestyle=":")

    # Optimal precision
    plt = plot(x,y,linewidth=LWD)

    # Experimental data
    hlines(ex_precs^(-1)/n, ex_jx2-err_jx2,ex_jx2+err_jx2,lw=1.25)
    hlines(1/maximum(ellipse_precs)/n, ex_jx2-4,ex_jx2+4,lw=1.25)
    hlines(1/minimum(ellipse_precs)/n, ex_jx2-4,ex_jx2+4,lw=1.25)
    vlines(ex_jx2, 1/maximum(ellipse_precs)/n, 1/minimum(ellipse_precs)/n, lw=1.25)
    vlines(ex_jx2-err_jx2, ex_precs^(-1)/n-0.45,ex_precs^(-1)/n+0.57,lw=1.25)
    vlines(ex_jx2+err_jx2, ex_precs^(-1)/n-0.45,ex_precs^(-1)/n+0.57,lw=1.25)
    plot(ex_jx2,ex_precs^(-1)/n, "wo", markersize=8, mew=LWD)

    savefig("pdf/VD_exper_slice.pdf", bbox_inches="tight")

    close(dataFile)
end

plotVD_exper_slice()

function plotVD_simulation()

  theta = h5read("plotsData.h5", "VD/simulation/times")
    ana_precision = h5read("plotsData.h5", "VD/simulation/ana_precision")
    sim_precision = h5read("plotsData.h5", "VD/simulation/sim_precision")

  fig, plt1 = subplots()
    fig[:set_size_inches](5,3.5)
    plt2 = fig[:add_axes]([0.56,0.72,0.28,0.12])
    plt1[:set_xlabel](L"$\Theta$", fontsize=L_FSIZE)
    plt1[:set_ylabel](L"$(\Delta Θ)^{-2}/N$", fontsize=L_FSIZE)
    plt2[:set_title]("Square error", fontsize=10)

  plt1[:bar](minimum(theta),1,maximum(theta),0, color="0.9",
      edgecolor="0.7",linewidth=0)
  plt1[:plot]([minimum(theta),maximum(theta)],
      [1,1], color="0.7", linewidth=LWD, linestyle="dotted")

  p1, = plt1[:plot](theta[1:end-1],ana_precision,linewidth=LWD)
  p2, = plt2[:plot](theta[1:end-1],(ana_precision-sim_precision).^2, "r")

  plt1[:set_xlim]([0,pi])
    plt1[:set_xticks]([0,pi/4,pi/2,3*pi/4,pi])
    plt1[:set_xticklabels](["0",L"$\pi$/4",L"$\pi$/2",L"3$\pi$/4",L"\pi"])
    plt1[:set_ylim]([0,2])
    # plt1[:spines]["top"][:set_visible](false)
    plt1[:xaxis][:set_ticks_position]("bottom")
    # plt2[:xaxis][:tick_top]()
    plt2[:set_ylim]([0,0.0004])
    plt2[:set_xlim]([0,pi])
    plt2[:set_xticks]([0,pi/2,pi])
    plt2[:set_xticklabels](["0",L"$\pi$/2",L"\pi"], fontsize=10)
    plt2[:set_yticks]([0,2e-4,4e-4])
    plt2[:set_yticklabels](["0e-4","2e-4","4e-4"], fontsize=10)
  # SN thresold

  savefig("pdf/VD_simulation.pdf", bbox_inches="tight")
end

plotVD_simulation()

function plotVD_parity_simulation()

  theta = h5read("plotsData.h5", "VD/parity_simulation/time")
  second = h5read("plotsData.h5", "VD/parity_simulation/secondmoment")
  fourth = h5read("plotsData.h5", "VD/parity_simulation/fourthmoment")

  fig = figure(figsize=(5,3.5))
  plt1 = plot(theta,second,linewidth=LWD, label=L"\langle J_x^2 \rangle")
  plot(theta,fourth,linewidth=LWD, "r--", label=L"\langle J_x^4 \rangle")

  ax = plt1[1][:axes]
  ax[:set_xlim]([-pi,pi])
  ax[:set_ylim]([0,80])
  ax[:set_xlabel](L"$\Theta$", fontsize=L_FSIZE)

  ax[:set_ylabel]("[A.U.]", fontsize=L_FSIZE)

  legend()

  savefig("pdf/VD_parity_simulation.pdf", bbox_inches="tight")
end

plotVD_parity_simulation()
