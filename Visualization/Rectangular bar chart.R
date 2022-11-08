# library
library(treemap)

# Create data
group <- c(rep("group-1",4),rep("group-2",2),rep("group-3",3))
subgroup <- paste("subgroup" , c(1,2,3,4,1,2,1,2,3), sep="-")
value <- c(13,5,22,12,11,7,3,1,23)
data <- data.frame(group,subgroup,value)

data <- read.delim('importance_Shannon.txt', row.names = 1, sep = '\t', stringsAsFactors = FALSE, check.names = FALSE)


# Custom labels:
treemap(data, index=c("Group","subgroup"), vSize="Value", 
        
        type="index",
        # How you color the treemap. type help(treemap) for more info
        palette = "Set3",                        # Select your color palette from the RColorBrewer presets or make your own.
        title="The importance of river brains",                      # Customize your title
        fontsize.title=12,                       # Size of the title
        
) 

treemap(data, index=c("Group","subgroup"),     vSize="Value", type="index",
        fontsize.labels=c(15,12),
        fontcolor.labels=c("white","orange"),
        fontface.labels=c(2,1),
        bg.labels=c("transparent"),              # Background color of labels
        align.labels=list(c("center", "center"), c("right", "bottom")), 
        overlap.labels=0.5, 
        inflate.labels=F, )
