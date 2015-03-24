library(ggplot2)
getwd()
setwd("/Users/kedarpatil/Documents/St-4701 - Data Visualization/kedar.github.io/blog_assignment")

bric_data <- read.csv("Bric_data.csv")

bric_data$Unemployment_Rate <- bric_data$Unemployment_Rate/100

#MATRIX SCATTER PLOT
pairs(bric_data[2:7], col=bric_data$Country)


ggplot(bric_data, aes(x = Population_Million, y = GDP_Trillion)) +
  geom_point(data=bric_data,aes(x=Population_Million, y=GDP_Trillion, size=1, colour = Country), alpha=1)
  scale_size(range = c(0,5)) +
  ylim(0,max("GDP_Trillion"))
  scale_y(limits = c(1, 20))+
  scale_x_continous(breaks =1:4 , labels=c("Location A","Location B","Location C","Location D"), limits = c(1,2,3,4))+ 
  geom_text(data=bric_data,aes(x=JitCoOr, y=JitCoOrPow,label=Model)) + 
  theme_bw()

install.packages("ggpairs")

library(ggpairs)
plotmatrix(bric_data,colour="gray")


# another option
makePairs <- function(data) 
{
  grid <- expand.grid(x = 2:ncol(data), y = 2:ncol(data))
  grid <- subset(grid, x != y)
  all <- do.call("rbind", lapply(1:nrow(grid), function(i) {
    xcol <- grid[i, "x"]
    ycol <- grid[i, "y"]
    data.frame(xvar = names(data)[ycol], yvar = names(data)[xcol], 
               x = data[, xcol], y = data[, ycol], data)
  }))
  all$xvar <- factor(all$xvar, levels = names(data))
  all$yvar <- factor(all$yvar, levels = names(data))
  densities <- do.call("rbind", lapply(2:ncol(data), function(i) {
    data.frame(xvar = names(data)[i], yvar = names(data)[i], x = data[, i])
  }))
  list(all=all, densities=densities)
#list(all=all)
}

# expand iris data frame for pairs plot
gg1 = makePairs(bric_data[1:6])

# new data frame mega iris
mega_bric = data.frame(gg1$all, Countries=rep(bric_data$Country, length=nrow(gg1$all)))

# pairs plot
ggplot(mega_bric, aes_string(x = "x", y = "y")) + 
  facet_grid(xvar ~ yvar, scales = "free") + 
  geom_point(aes(colour=Countries, size=1), na.rm = TRUE, alpha=0.8) + 
  stat_density(aes(x = x, y = ..scaled.. * diff(range(x)) + min(x)), 
               data = gg1$densities, position = "identity", 
               colour = "grey20", geom = "bar")


tmp <- data.frame(gg1$densities,Countries=rep(bric_data$Country, length=nrow(gg1$densities)))

ggplot(tmp, aes(x=Countries, y=x, fill=Countries)) + 
  facet_grid(xvar ~ ., scales = "free") + 
  geom_bar(stat="identity") + 
  geom_text(aes(label=x), vjust=1.5, size=3)


ggplot() + 
  geom_point(mega_bric, aes(x = "x", y = "y", colour=Countries), na.rm = TRUE, alpha=0.8) + 
  geom_bar(tmp, aes(x=Countries, y=x, fill=Countries),stat="identity")
facet_grid(xvar ~ yvar, scales = "free") + 
  