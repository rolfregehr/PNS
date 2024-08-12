# Análise de Interação entre duas variáveis 2019

# Y008 -  Qual é a sua orientação sexual?
# M01501 - Com quantos amigos próximos ___ pode contar em momentos bons ou ruins (Sem considerar os familiares ou parentes)?


var_interesse <- c('V0001', 'C006', 'C008', 'C009', 'Y008', 'M01501')

Orientacao_Sexual_vs_Rede_apoio <- get_pns(year=2019,
                                           savedir = './dados_ibge/',
                                           selected = T,
                                           vars=var_interesse)


tx_hetero <- svyratio(numerator=~(M01501=='Três ou mais'),
                       denominator=~(Y008=='Heterosexual'),
                       design=Orientacao_Sexual_vs_Rede_apoio,
                       na.rm=TRUE)


confint(tx_hetero)


tx_homo <- svyratio(numerator=~(M01501=='Três ou mais'),
                      denominator=~(Y008=='Homosexual'),
                      design=Orientacao_Sexual_vs_Rede_apoio,
                      na.rm=TRUE)


confint(tx_homo)


unique(Orientacao_Sexual_vs_Rede_apoio$variables$M01501)
unique(Orientacao_Sexual_vs_Rede_apoio$variables$Y008)



svymean(x=~Y008,
        design=subset(Orientacao_Sexual_vs_Rede_apoio, C006=="Mulher"),
         na.rm=TRUE)


svymean(x=~Y008,
        design=subset(Orientacao_Sexual_vs_Rede_apoio, C006=="Homem"),
        na.rm=TRUE)



svymean(x=~M01501,
        design=subset(Orientacao_Sexual_vs_Rede_apoio, C006=="Homem" & Y008 == 'Heterosexual'),
        na.rm=TRUE)
svymean(x=~M01501,
        design=subset(Orientacao_Sexual_vs_Rede_apoio, C006=="Mulher" & Y008 == 'Heterosexual'),
        na.rm=TRUE)




svymean(x=~M01501,
        design=subset(Orientacao_Sexual_vs_Rede_apoio, C006=="Homem" & Y008 == 'Homosexual'),
        na.rm=TRUE)





svymean(x=~M01501,
        design=subset(Orientacao_Sexual_vs_Rede_apoio, C006=="Homem" & Y008 == 'Homosexual' & C008 < 40),
        na.rm=TRUE)
svymean(x=~M01501,
        design=subset(Orientacao_Sexual_vs_Rede_apoio, C006=="Homem" & Y008 == 'Homosexual' & C008 >= 40),
        na.rm=TRUE)



confint(svymean(x=~M01501,
        design=subset(Orientacao_Sexual_vs_Rede_apoio, C006=="Homem" & Y008 == 'Homosexual' & C008 < 40),
        na.rm=TRUE))

confint(svymean(x=~M01501,
        design=subset(Orientacao_Sexual_vs_Rede_apoio, C006=="Homem" & Y008 == 'Homosexual' & C008 >= 40),
        na.rm=TRUE))



confint(svytotal(x=~M01501,
                design=subset(Orientacao_Sexual_vs_Rede_apoio, C006=="Homem" & (Y008 == 'Homosexual' | Y008 == 'Bissexual' )),
                na.rm=TRUE))

confint(svytotal(x=~M01501,
                design=subset(Orientacao_Sexual_vs_Rede_apoio, C006=="Homem" & Y008 == 'Heterosexual'),
                na.rm=TRUE))



svyby(formula = ~M01501,
      by =~Y008,
      design = Orientacao_Sexual_vs_Rede_apoio,
      FUN = svymean,
      na.rm = T)


temp <- confint(svyby(formula = ~M01501,
              by =~Y008,
              design = Orientacao_Sexual_vs_Rede_apoio,
              FUN = svymean,
              na.rm = T))


class(temp)


as_tibble(temp)
labels(temp)
