library(hexSticker)
library(jpeg)
library(png)
library(magick)
library(ggplot2)
library(ggimage)
library(raster)
library(rgdal)
library(sf)

# load hexagon background image
img1 = readJPEG("Data/rainbow.jpg")

# crop photo to be a hexagon with transparent background
ggplot_rasterdf <- function(color_matrix, bottom = 0, top = 1, left = 0, right = 1) {
  require("dplyr")
  require("tidyr")
  
  if (dim(color_matrix)[3] > 3) hasalpha <- T else hasalpha <- F
  
  outMatrix <- matrix("#00000000", nrow = dim(color_matrix)[1], ncol = dim(color_matrix)[2])
  
  for (i in 1:dim(color_matrix)[1])
    for (j in 1:dim(color_matrix)[2]) 
      outMatrix[i, j] <- rgb(color_matrix[i,j,1], color_matrix[i,j,2], color_matrix[i,j,3], ifelse(hasalpha, color_matrix[i,j,4], 1))
  
  colnames(outMatrix) <- seq(1, ncol(outMatrix))
  rownames(outMatrix) <- seq(1, nrow(outMatrix))
  as.data.frame(outMatrix) %>% mutate(Y = nrow(outMatrix):1) %>% gather(X, color, -Y) %>% 
    mutate(X = left + as.integer(as.character(X))*(right-left)/ncol(outMatrix), Y = bottom + Y*(top-bottom)/nrow(outMatrix))
}

# vertices for hexagon
df = data.frame(x = c(-0.866025, 0, 0.866025, 0.866025, 0, -0.866025), y = c(0.5, 1, 0.5, -0.5, -1, -0.5), group = "A")

# plot image as a raster
new_rainbow <- 
  ggplot_rasterdf(img1, 
                  left = min(df$x), 
                  right = max(df$x),
                  bottom = min(df$y),
                  top = max(df$y) )

# assign vertices to image
groupA <- 
  new_rainbow[point.in.polygon(new_rainbow$X, new_rainbow$Y, 
                               df$x, 
                               df$y ) %>% as.logical,]

# plot hexagon using ggplot
par(bg = NA)
p <- ggplot(data = df) + 
  geom_polygon(data=df, aes(x=x, y=y,colour=group, fill=group), alpha=0.1, size=1, linetype=1)+ 
  geom_tile(data = groupA, aes(x = X, y = Y), fill = groupA$color) +
  theme(axis.line=element_blank(),axis.text.x=element_blank(),
        axis.text.y=element_blank(),axis.ticks=element_blank(),
        axis.title.x=element_blank(),
        axis.title.y=element_blank(),legend.position="none",
        panel.background=element_rect(fill = "transparent",colour = NA),panel.border=element_blank(),panel.grid.major=element_blank(),
        panel.grid.minor=element_blank(),plot.background=element_rect(fill = "transparent",colour = NA))
ggsave("rainbowhex.png", p, bg = "transparent", width = 18.1, height = 20.9)

# reload background image after being cropped to hexagon shape
img1 = "Data/rainbowhex.png"
# load overlay image
img2 = "Data/ds9(2).png"
p <- ggplot(data.frame(x=1,y=1,image="rainbowhex.png"), aes(x,y)) +
  geom_image(aes(image=img1), size=1) + theme_void() +
  geom_image(aes(image=img2), size=0.8) + theme_void()

# generate sticker
ds9_hex = sticker(p, package="", p_size=20, p_y = 1, s_x=1, s_y=1, s_width=1.95, s_height = 1.95, p_color = "white", filename="Outputs/rainbowds9.png", h_color = "black")
plot(ds9_hex)
