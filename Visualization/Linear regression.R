wd<- "/path/data"
setwd(wd)

library(ggplot2)
library(ggpubr)
aa <- read.csv('Shannon.csv')
fit_Haihe<-lm(Year~Shannon, data = subset(aa, River_systems == 'Haihe'))
summary(fit_Haihe)

fit_Huaihe<-lm(Year~Shannon, data = subset(aa, River_systems == 'Huaihe'))
summary(fit_Huaihe)

fit_Liaohe<-lm(Year~Shannon, data = subset(aa, River_systems == 'Liaohe'))
summary(fit_Liaohe)

fit_Pearl<-lm(Year~Shannon, data = subset(aa, River_systems == 'Pearl'))
summary(fit_Pearl)

fit_Songhua<-lm(Year~Shannon, data = subset(aa, River_systems == 'Songhua'))
summary(fit_Songhua)

fit_Yangtze<-lm(Year~Shannon, data = subset(aa, River_systems == 'Yangtze'))
summary(fit_Yangtze)

fit_Yellow<-lm(Year~Shannon, data = subset(aa, River_systems == 'Yellow'))
summary(fit_Yellow)

ggplot(aa,aes(x=aa$Year,y=aa$Richness))+
  geom_point(size=0.8,aes(color=aa$River_systems))+scale_color_manual(values=c("#1663A9",'#8E549E','#4e9595','#c0504d','#EBA716','#C07A92','#8481BA'))+
  geom_smooth(aes(color =River_systems), method = 'lm', se = TRUE) +
  theme_bw()+labs(y="Richness",x="Year")+
  theme(axis.text=element_text(colour='black',size=9))+
  annotate('text', label = 'R2=0.46; p<0.001', x =2014, y = 500, size =1.5,color="#1663A9")+ 
  annotate('text', label = 'R2=0.017; p<0.05', x = 2014, y = 480, size =1.5,color='#8E549E')+ 
  annotate('text', label = 'R2=-0.024; p>0.05', x =2014, y = 460, size =1.5,color='#4e9595')+
  annotate('text', label = 'R2=0.013; p<0.05', x =2014, y = 440, size =1.5,color='#c0504d')+
  annotate('text', label = 'R2=0.016; p>0.05', x =2014, y = 420, size =1.5,color='#EBA716')+
  annotate('text', label = 'R2=-0.00028; p>0.05', x =2014, y = 400, size =1.5,color='#C07A92')+
  annotate('text', label = 'R2=0.27; p<0.001', x =2014, y = 380, size =1.5,color='#8481BA')

ggplot(aa,aes(x=aa$Year,y=aa$Shannon))+
  geom_point(size=0.8,aes(color=aa$River_systems))+scale_color_manual(values=c("#1663A9",'#8E549E','#4e9595','#c0504d','#EBA716','#C07A92','#8481BA'),limits=c("Haihe","Huaihe",'Liaohe','Pearl','Songhua','Yangtze','Yellow'))+
  geom_smooth(aes(color =River_systems), method = 'lm', se = TRUE) +
  theme_bw()+labs(y="Shannon",x="Year")+
  theme(axis.text=element_text(colour='black',size=9))+
  annotate('text', label = 'R2=0.66; p<0.001', x =2014, y = 5.4, size =1.5,color="#1663A9")+
  annotate('text', label = 'R2=0.0058; p>0.05', x = 2014, y = 5.3, size =1.5,color='#8E549E')+
  annotate('text', label = 'R2=-0.010; p>0.05', x =2014, y = 5.2, size =1.5,color='#4e9595')+
  annotate('text', label = 'R2=0.021; p<0.05', x =2014, y = 5.1, size =1.5,color='#c0504d')+
  annotate('text', label = 'R2=0.26; p<0.001', x =2014, y = 5.0, size =1.5,color='#EBA716')+
  annotate('text', label = 'R2=0.0032; p<0.05', x =2014, y = 4.9, size =1.5,color='#C07A92')+
  annotate('text', label = 'R2=0.34; p<0.001', x =2014, y = 4.8, size =1.5,color='#8481BA')
