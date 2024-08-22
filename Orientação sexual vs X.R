# Fontes:

# 1 - https://rpubs.com/gabriel-assuncao-ibge/pns
# 2 - https://github.com/sopeso/PNS2019-analise-desigualdade/blob/main/analise_R.R

# Instala pacotes 
loadpackages <- function(packages){
  for(pkg in packages){
    if(!require(pkg, character.only = TRUE)){
      install.packages(pkg, dependencies = TRUE)
      library(pkg, character.only = TRUE)
    }
  }
}

# Pacotes necessários para análise e visualização
loadpackages(c('PNSIBGE', 'survey', 'tidyverse'))






# vs. UF ####

# Ajusta variável específica 


dadosPNS_19$variables$sexualidades <-  case_when(dadosPNS_19$variables$Y008 == 'Heterosexual' ~ 'Heterosexual',
                                                 dadosPNS_19$variables$Y008 %in% c('Homosexual', 'Bissexual', 'Outra orientação') ~ 'Sexualidade diversa',
                                                 T ~ 'NI')

vs.UF <- as.data.frame(svyby(formula = ~V00201,
                             by =~C009+Y008+C006,
                             design = dadosPNS_19,
                             FUN = svymean,
                             na.rm = T))





# Nos últimos doze meses, alguém: Te ofendeu, humilhou ou ridicularizou na frente de outras pessoas?



  vs.UF |> 
  mutate(superior = V00201Sim + 1.96*`se.V00201Sim`, #calcula intervalos de confiança
         inferior = V00201Sim - 1.96*`se.V00201Sim`, #calcula intervalos de confiança
         `Sexo biológico` = C006) |> 
  ggplot(aes(x = Y008 , y = V00201Sim, fill = `Sexo biológico`)) +
  scale_fill_manual(values=c('#486185', '#D89936'))+
  geom_bar(stat = "identity", position = "dodge") +
  geom_errorbar(aes(ymin = inferior, ymax = superior), width = 0.5, position = position_dodge(1)) + 
  facet_grid(~C009)+
  labs(title = 'Nos últimos doze meses, alguém: Te ofendeu, humilhou ou ridicularizou na frente de outras pessoas?',
       subtitle = 'Por cor/raça',
       x = 'Nas duas últimas semanas, deixou de realizar quaisquer de suas atividades habituais?',
       y = 'Proporção média')+
  theme(panel.background = element_blank(),
        strip.background = element_rect(fill="#00000003"))+
    coord_flip()
  
  
  