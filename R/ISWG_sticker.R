library(hexSticker)
library(jpeg)
library(magick)
library(ggplot2)
library(ggimage)
imgurl <- "Data/ISWG.png"
ISWG = sticker(imgurl, package="ISWG", p_size=20, p_y = 1.65, s_x=1.03, s_y=0.85, s_width=0.75, p_color = "lightblue",
            filename="Outputs/ISWGlogo1.png", h_color = "lightblue", spotlight = TRUE, l_y = 1.7) +
  geom_hexagon(size = 1.2, fill = imgurl, color = "#87B13F")
plot(ISWG)
