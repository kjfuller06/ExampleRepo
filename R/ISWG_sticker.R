library(hexSticker)
library(jpeg)
library(magick)
imgurl <- "Data/ISWG.jpg"
ISWG = sticker(imgurl, package="ISWG", p_size=20, s_x=1, s_y=1, s_width=2, p_color = "darkorchid4",
            filename="inst/figures/imgfile.png", h_color = "darkorchid4")
plot(ISWG)
