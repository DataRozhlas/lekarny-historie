df <- read.csv("../upravena-data/lekarny.csv", encoding="UTF-8")

df_retezce <- df[df$rok == 2015 & df$ZNACKA != "",]

df_1999 <- df[df$rok == 1999,]
df_2007 <- df[df$rok == 2007,]
df_2015 <- df[df$rok == 2015,]

df_1999$rok <- 1999
df_2007$rok <- 2007
df_2015$rok <- 2015
df_retezce$rok <- 2015

for(i in 1:nrow(df_1999)) df_1999$ul[i] <- strsplit(as.character(df_1999$ULICE[i]), " ")[[1]][1]
for(i in 1:nrow(df_2007)) df_2007$ul[i] <- strsplit(as.character(df_2007$ULICE[i]), " ")[[1]][1]
for(i in 1:nrow(df_2015)) df_2015$ul[i] <- strsplit(as.character(df_2015$ULICE[i]), " ")[[1]][1]
for(i in 1:nrow(df_retezce)) df_retezce$ul[i] <- strsplit(as.character(df_retezce$ULICE[i]), " ")[[1]][1]

write.csv(df_retezce, file="../upravena-data/retezce.csv", row.names=F, fileEncoding="UTF-8")

df_podezrele <- df[0,]

for(i in 1:nrow(df_retezce)) {
  if((df_retezce$ul[i] %in% df_1999$ul) & (df_retezce$MESTO[i] %in% df_1999$MESTO)) {  # existuje shodná lékárna v obou letech
    ul <- as.character(df_retezce$ul[i])
    mesto <- as.character(df_retezce$MESTO[i])
    lekarna1 <- df_retezce[i,]
    lekarna2 <- df_1999[df_1999$ul == ul & df_1999$MESTO == mesto,]
    df_podezrele <- rbind(df_podezrele, lekarna1, lekarna2)  
    print(paste(i, ": ", lekarna1$ul, ", ", lekarna2$ul, sep=""))
  }
}

for(i in 1:nrow(df_retezce)) {
  if((df_retezce$ul[i] %in% df_2007$ul) & (df_retezce$MESTO[i] %in% df_2007$MESTO)) {  # existuje shodná lékárna v obou letech
    ul <- as.character(df_retezce$ul[i])
    mesto <- as.character(df_retezce$MESTO[i])
    lekarna1 <- df_retezce[i,]
    lekarna2 <- df_2007[df_2007$ul == ul & df_2007$MESTO == mesto,]
    df_podezrele <- rbind(df_podezrele, lekarna1, lekarna2)  
    print(paste(i, ": ", lekarna1$ul, ", ", lekarna2$ul, sep=""))
  }
}


# for(i in 1:nrow(df_1999)) {
#   if(df_1999$ULICE[i] %in% df_2015$ULICE) {  # existuje shodná lékárna v obou letech
#     ulice <- as.character(df_1999$ULICE[i])
#     lekarna1 <- df_1999[i,]
#     lekarna2 <- df_2015[df_2015$ULICE == ulice,]
#     df_podezrele <- rbind(df_podezrele, lekarna1, lekarna2)  
#     print(paste(i, ": ", lekarna1$ULICE, ", ", lekarna2$ULICE, sep=""))
#   }
# }
# 
# for(i in 1:nrow(df_1999)) {
#   if(df_1999$ULICE[i] %in% df_2007$ULICE) {  # existuje shodná lékárna v obou letech
#     ulice <- as.character(df_1999$ULICE[i])
#     lekarna1 <- df_1999[i,]
#     lekarna2 <- df_2007[df_2007$ULICE == ulice,]
#     df_podezrele <- rbind(df_podezrele, lekarna1, lekarna2)  
#     print(paste(i, ": ", lekarna1$ULICE, ", ", lekarna2$ULICE, sep=""))
#   }
# }
# 
# for(i in 1:nrow(df_2007)) {
#   if(df_2007$ULICE[i] %in% df_2015$ULICE) {  # existuje shodná lékárna v obou letech
#     ulice <- as.character(df_2007$ULICE[i])
#     lekarna1 <- df_2007[i,]
#     lekarna2 <- df_2015[df_2015$ULICE == ulice,]
#     df_podezrele <- rbind(df_podezrele, lekarna1, lekarna2)  
#     print(paste(i, ": ", lekarna1$ULICE, ", ", lekarna2$ULICE, sep=""))
#   }
# }

rm(lekarna1); rm(lekarna2); rm(i); rm(ul); rm(mesto)

write.csv(df_podezrele, file="../upravena-data/podezrele.csv", row.names=F, fileEncoding="UTF-8")

ulices <- levels(factor(df_podezrele$ULICE))

# df_prebarvene <- df[0,]
# 
# for(i in 1:length(ulices)) {
#   ulice <- ulices[i]
#   ntice <- df_podezrele[df_podezrele$ULICE == ulice,]
#   if((length(unique(ntice$ICO)) != 1) & !(NA %in% ntice$ICO)) {
#     df_prebarvene <- rbind(df_prebarvene, ntice)
#     print(paste(i, ": ", ntice$ULICE[1], ", ", ntice$ULICE[2], sep=""))
#   }
# }
#   
# rm(ntice); rm(ulice); rm(ulices); rm(i)
# 
# write.csv(df_prebarvene, file="../upravena-data/prebarvene.csv", row.names=F, fileEncoding="UTF-8")
