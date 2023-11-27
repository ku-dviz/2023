setwd('/Users/jacobcurran-sebastian/Documents/Teaching/DataViz/Networks')
library(igraph)
library(dplyr)
library(ggplot2)
library(dagitty)

edges <- read.csv('quakers_edgelist.csv')
nodes <- read.csv('quakers_nodelist.csv')

g <- graph_from_data_frame(edges)
g <- as.undirected(g, mode = "collapse")

node_labels <- V(g)

set_vertex_attr(g, 'role', index = nodes$Name, nodes$Historical.Significance)



reorder <- match(nodes$Name, V(g)$name)
nodes <- arrange(nodes, reorder)
V(g)$role <- nodes$Historical.Significance

V(g)$gender <- nodes$Gender
V(g)$birthdate <- nodes$Birthdate
V(g)$deathdate <- nodes$Deathdate

nodes$degree <- degree(g)
nodes$agegroup <- as.integer((nodes$Birthdate - 1550)/50)
V(g)$color <-  ifelse(nodes$Gender == "male", "dodgerblue2", "seagreen3") #as.numeric(as.factor(nodes$Gender))
V(g)$color <-  ifelse(grepl('founder|leader|preacher', nodes$Historical.Significance), "dodgerblue2", "seagreen3")
nodes$leader <- ifelse(grepl('founder|leader|preacher', nodes$Historical.Significance), "leader", "follower")
layout <- layout_components(g)
layout <- layout_components(g)
layout <- layout_components(g)
layout <- layout_components(g)
layout <- layout_components(g)
layout <- layout_components(g)
p <- plot(g, layout = layout, vertex.label = NA, vertex.size = sqrt(degree(g))+2)
legend('bottomright', c("Leaders","Followers"), pch=16, col= c("dodgerblue2", "seagreen3"))





degree_df <- data.frame(degree(g))
colnames(degree_df) = "degree"
degree_hist <- ggplot(nodes, aes(x = degree, fill = leader)) + 
  geom_density(alpha = 0.7) + xlab("Node Degree") + 
  ggtitle("Most people are connected to under 5 people")
degree_hist
