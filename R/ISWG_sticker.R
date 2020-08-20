library(hexSticker)
library(jpeg)
library(magick)
imgurl <- "ISWG3.png"
ISWG = sticker(imgurl, package="ISWG", p_size=20, p_y = 1.65, s_x=1, s_y=0.85, s_width=0.7, p_color = "lightblue",
            filename="Outputs/ISWGlogo1.png", h_color = "lightblue")
plot(ISWG)
