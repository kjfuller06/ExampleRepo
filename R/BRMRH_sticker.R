library(hexSticker)
library(jpeg)
library(magick)
imgurl <- "BRMRH.png"
BRMRH = sticker(imgurl, package= "", p_size=10, h_fill = rgb(0.74, 0.2, 0.15, 1), p_y = 1, s_x=1, s_y=1, s_width=0.8, p_color = "white",
            filename="Outputs/ISWGlogo1.png", h_color = rgb(0.74, 0.2, 0.15, 1))
plot(ISWG)
