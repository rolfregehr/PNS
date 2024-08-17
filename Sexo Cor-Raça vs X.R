# Sexo     - C006
# Cor/Raça - C009


# J00101 - Considerando saúde como um estado de bem-estar físico e mental, e não
# somente a ausência de doenças, como é o estado de saúde de _____________? 


library(scales)


estado_saude <- as.data.frame(svyby(formula = ~J001,
                    by =~C006+C009,
                    design = dadosPNS_19,
                    FUN = svymean,
                    na.rm = T))

(estado_saude)

estado_saude |> 
  mutate(superior = `J001Muito bom` + 1.96*`se.J001Muito bom`,
         inferior = `J001Muito bom` - 1.96*`se.J001Muito bom`) |> 
  ggplot(aes(x = C009 , y = `J001Muito bom`, fill = C006)) +
     geom_bar(stat = "identity", position = "dodge") +
     geom_errorbar(aes(ymin = inferior, ymax = superior), width = 0.2, position = position_dodge(0.9)) 


# J01101 - Quando ____ consultou um médico pela última vez?


ultima_consulta <- as.data.frame(svyby(formula = ~J01101,
                                    by =~C006+C009+J002,
                                    design = dadosPNS_19,
                                    FUN = svymean,
                                    na.rm = T))


ultima_consulta |> 
  mutate(superior = `J01101Até 1 ano` + 1.96*`se.J01101Até 1 ano`,
         inferior = `J01101Até 1 ano` - 1.96*`se.J01101Até 1 ano`,
         `Sexo biológico` = C006) |> 
  ggplot(aes(x = J002 , y = `J01101Até 1 ano`, fill = `Sexo biológico`)) +
  scale_fill_manual(values=c('#486185', '#D89936'))+
  geom_bar(stat = "identity", position = "dodge") +
  geom_errorbar(aes(ymin = inferior, ymax = superior), width = 0.5, position = position_dodge(1)) + 
  facet_grid(~C009)+
  labs(title = 'Consultou médico em até um ano?',
       subtitle = 'Por cor/raça',
       x = 'Nas duas últimas semanas, deixou de realizar quaisquer de suas atividades habituais?',
       y = 'Proporção média')+
  theme(panel.background = element_blank(),
        strip.background = element_rect(fill="#00000003"))

