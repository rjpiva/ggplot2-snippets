library(ggplot2)

#Import datasets
dataset <- read.csv('prices.csv')
brand_products <- read.csv('brand-products.csv')

#Chart functions
chart1 <- function() {
  
  df <- subset(dataset, 
               Channel != "Channel 7" & 
               Brand   != "Brand 7"   &
               Prod.Type %in% c("Prod. Type 1", "Prod. Type 2", "Prod. Type 3",
                                "Prod. Type 4", "Prod. Type 5", "Prod. Type 6")
               )
  
  df <- (aggregate(df$Price, by=list(Brand = df$Brand, Date = df$Date), 
                           FUN=mean, na.rm=TRUE))
  
  colnames(df) <- c("Brand", "Date", "AvgPrice")
  
  p <- ggplot(df, aes(x=Date, y=AvgPrice, group=Brand, color=Brand)) + 
    geom_line(size=1, linetype="dashed") +
    geom_point() +
    ggtitle("Average price time series by brand") + ylab("Average Price") + xlab("")
  
  return(p)
}

chart2 <- function() {
  
  df <- subset(dataset, 
               Channel != "Channel 7" & 
               Brand   != "Brand 7"   &
               Prod.Type %in% c("Prod. Type 1", "Prod. Type 2", "Prod. Type 3",
                                "Prod. Type 4", "Prod. Type 5", "Prod. Type 6")
  )
  
  df <- (aggregate(df$Price, by=list(Brand = df$Brand, Date = df$Date, Type = df$Prod.Type), 
                   FUN=mean, na.rm=TRUE))
  
  colnames(df) <- c("Brand", "Date", "Type", "AvgPrice")
  
  p <- ggplot(df, aes(x=Date, y=AvgPrice, group=Brand, color=Brand)) + 
    geom_line(size=1, linetype="dashed") +
    geom_point() +
    ggtitle("Average price time series by brand and product type") + ylab("Average Price") + xlab("") +
    scale_x_discrete(limits=c("Date1","Date2","Date3", "Date4")) +
    facet_wrap(~Type, scale="free")

  return(p)
}

chart3 <- function() {
  
  df <- subset(dataset, 
               Date == "Date4" & 
               City %in% c("City 5", "City 4", "City 1") & 
               Prod.Type %in% c("Prod. Type 2", "Prod. Type 3", "Prod. Type 5", 
                                "Prod. Type 6")
               )

  df$Brand[df$Brand=="Brand 1"] <- "B1"
  df$Brand[df$Brand=="Brand 2"] <- "B2"
  df$Brand[df$Brand=="Brand 3"] <- "B3"
  df$Brand[df$Brand=="Brand 4"] <- "B4"
  df$Brand[df$Brand=="Brand 5"] <- "B5"
  df$Brand[df$Brand=="Brand 6"] <- "B6"
  
  df$Product <- NULL
  df$Channel <- NULL
  df$Date <- NULL
  
  colnames(df) <- c("City", "Price", "Brand", "Type")
  
  p <- ggplot(df, aes(x=Brand, y=Price, color=Brand)) +
    geom_boxplot() +
    facet_grid(~City~Type, scale = "free")
  
  return(p)
}

chart4 <- function() {
  
  df <- subset(dataset, 
               Date == "Date4" &  
               Channel != "Channel 7" & 
               Brand   != "Brand 7"   &
               Prod.Type %in% c("Prod. Type 1", "Prod. Type 2", "Prod. Type 3", 
                                "Prod. Type 4", "Prod. Type 5", "Prod. Type 6.") &
               !is.na(Price)
        )
  
  p <- 
    ggplot(df, aes(y = City, x = Brand, color = Brand)) +
    ggtitle("Brand presence - number of products/prices registered (n) by location") +
    theme(axis.title.x=element_blank(), axis.title.y=element_blank()) +
    geom_count(aes(size = stat(n))) +
    scale_size_area(max_size = 20) +
    theme(axis.text.x = element_text(angle = 40, hjust = 1)) +
    coord_flip()
  
  p <- p + geom_text(data = ggplot_build(p)$data[[1]], 
                aes(x, y, label = n), color = "#ffffff")
  
  return(p)  
  
}

chart5 <- function() {
  
  df <- subset(dataset, 
               Date == "Date4" &  
               Channel != "Channel 7" & 
               Brand   != "Brand 7"   &
               Prod.Type %in% c("Prod. Type 2", "Prod. Type 3", "Prod. Type 5", 
                                "Prod. Type 6") &
              !is.na(Price)
  )
  
  df$Channel <-  NULL
  df$Date <-  NULL
  colnames(df) <- c("Product", "City", "Price", "Brand", "Type")
  
  p <- ggplot(df, aes(y = City, x = Brand, color = Brand)) +
    ggtitle("Brand presence - number of products/prices registered (n) by location") +
    theme(axis.title.x=element_blank(), axis.title.y=element_blank()) +
    geom_count(aes(size = stat(n))) +
    scale_size_area(max_size = 10) +
    theme(axis.text.x = element_text(angle = 40, hjust = 1)) +
    geom_bar(data = brand_products, aes(x = Brand, y = Num.Products, fill = Brand),width =0.7,  alpha = 0.4, stat = "identity") +
    facet_wrap(~Type) +
    coord_flip()  
  
  return(p)
  
}

chart6 <- function() {
  
  df <- subset(dataset, 
                 Date == "Date4" &  
                 Channel != "Channel 7" & 
                 Brand   != "Brand 7"   &
                 Prod.Type %in% c("Prod. Type 2", "Prod. Type 3", "Prod. Type 4", 
                                  "Prod. Type 6") &
                 !is.na(Price)
  )
  
  df$Channel <-  NULL
  df$Date <-  NULL
  colnames(df) <- c("Product", "City", "Price", "Brand", "Type")
  
  p <-  ggplot(df, aes(Price, colour=Type, fill=Type)) + 
        ggtitle("Price distribution by product type") +
        geom_density(alpha=0.55)
  
  return(p)
}

chart7 <- function() {
  
  df <- subset(dataset, 
                 Date == "Date4" &  
                 Channel != "Channel 7" & 
                 Brand   != "Brand 7"   &
                 Prod.Type %in% c("Prod. Type 1", "Prod. Type 2", "Prod. Type 3", 
                                  "Prod. Type 4", "Prod. Type 5", "Prod. Type 6") &
                 !is.na(Price)
  )
  
  df$Channel <-  NULL
  df$Date <-  NULL
  colnames(df) <- c("Product", "City", "Price", "Brand", "Type")
  
  p <-  ggplot(df, aes(Price, colour=Type, fill=Type)) + 
        ggtitle("Price distribution by product type and brand") +
        geom_density(alpha=0.55) +
        theme(panel.background = element_rect(fill = 'white')) +
        theme(strip.background =element_rect(color="black", fill="white", linetype="solid" )) +
        facet_grid(~Brand~Type)
  
  return(p)
}

#Plot rendering
p <- chart1()
p <- chart2()
p <- chart3()
p <- chart4()
p <- chart5()
p <- chart6()
p <- chart7()

p
