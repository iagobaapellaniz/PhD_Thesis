"""
Plot the histogram for the example of the 18 trees' heights measures
"""
function plotBG_histogram_bin1()

    dist = h5read("statistics.h5","histogram/treesheigths")

    x_histo, y_histo = hist(dist,9)

    fig = figure(figsize=[5,3.5])

    plt = bar(Array(x_histo)[2:end].-0.5, y_histo, width=1, facecolor= BAR_BLUE, edgecolor = BG_GREY)
    axis(xmin = 0, xmax = 12, ymax = 10);
    axes = fig[:axes][1]
    axes[:set_axis_bgcolor](BG_GREY)
    axes[:set_axisbelow](true)
    grid()
    xlabel("Height (m)")
    xlabel("Height (m)")
    ylabel("Counts #")
    xticks([0,1,2,3,4,5,6,7,8,9,10,11,12]);
    savefig("pdf/BG_hist_bin_1.pdf", bbox_inches="tight")

    show(fig)

end

function plotBG_histogram_bin2()

    dist = h5read("statistics.h5","histogram/treesheigths")

    x_histo, y_histo = hist(dist,5)

    fig = figure(figsize=[5,3.5])
    plt = bar(Array(x_histo)[2:end].-1.5, y_histo, width=2, facecolor= BAR_BLUE, edgecolor = BG_GREY)
    axis(xmin = 0, xmax = 13, ymax = 10);
    axes = fig[:axes][1]
    axes[:set_axis_bgcolor](BG_GREY)
    axes[:set_axisbelow](true)
    grid()
    xlabel("Height (m)")
    xlabel("Height (m)")
    ylabel("Counts #")
    xticks([1.5,3.5,5.5,7.5,9.5,11.5]);
    savefig("pdf/BG_hist_bin_2.pdf", bbox_inches="tight")

end
