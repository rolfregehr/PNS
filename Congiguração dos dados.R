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
  
# Configurando o ambiente
rm(list=ls())
options(scipen=999) #exclui a notificação científica 
options(dplyr.show_progress = F) # exclui info 
options(dplyr.summarise.inform = FALSE) # exclui resumo
options(message=FALSE, warning=FALSE) # exclui mensagens e alertas

  


# Coleta os dados COMPLETOS a partir do pacote PNSIBGE e salva na pasta indicada
dadosPNS_13 <- get_pns(year=2013, savedir = './dados_ibge/', selected = T) # design = T (padrão) / Morador selecionado
dadosPNS_19 <- get_pns(year=2019, savedir = './dados_ibge/', selected = T) # design = T (padrão) / Morador selecionado




