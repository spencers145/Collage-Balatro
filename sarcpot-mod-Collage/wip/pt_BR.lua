return {
    misc = {
        dictionary = {
           sarc_combat_roll_ex = "Jogada de Batalha!",
           sarc_plus_one_discard = "+1 Descarte!",
           sarc_stolen = "Roubado!",
           sarc_yoink = "Peguei!",
           sarc_lucky6 = "6 da sorte!",
           sarc_focus = "Foco!",
           sarc_scrapped = "Reciclado!",
           sarc_throw = 'Arremesso!',
           sarc_snap = 'Estalo!',
           sarc_collapse = 'Colapso!',
            sarc_exhausted = 'Exaurido...',
            sarc_chips = 'Fichas',
            sarc_mult = 'Multi',
            sarc_common = 'Comum',
            sarc_uncommon = 'Incomum',
            sarc_rare = 'Raro',
            sarc_2_random_hands = "2 Mãos Aleatórias",
            sarc_plus_rerolls = '+3 Atualizações',
            sarc_minus_ante = "-1 Ante"
        }


    },
    descriptions = {
        --Back={},
        --Blind={},
        --Edition={},
        --Enhanced={},
         Back = {
        b_sarc_travelling = {
        name = "Travelling Deck",
        text = {
          "Start run with {C:attention,T:v_sarc_compass}#1#{} Voucher",
        }
      },
    },
        travel = {
            c_sarc_brittle_hollow = {
                name = 'Cartão Desgastado',
                text = {
                    "Aprimore {C:attention}#1#{} mãos aleatórias",
                    "Após {C:attention}#3#{} usos, {C:purple}Colapse{}",
                    "{C:inactive}(No Momento #2#/#3#){}"
                }
            },
            c_sarc_celeste = {
                name = 'Cartão Postal de Mt.Celeste',
                text = {
                    "Aprimora {C:attention}#1#{} cartas ",
                    "selecionadas para {C:red}Cartas de Morango{}",
                    "{s:0.8,C:inactive}Cartas de Morango recarregam se{}",
                    "{s:0.8,C:inactive}não forem jogadas por uma rodada{}"
                }
            },
            c_sarc_chicory = {
                name = 'Coloring Card',
                text = {
                    "Converta até {C:attention}#1#{}",
                    "cartas selecionadas em",
                    "naipes {C:attention}distintos{}",
                    "Ganhe {C:money}#2#${} por carta convertida"
                }
            },
            c_sarc_deaths_door = {
                name = 'Lembrança Acinzentada',
                text = {
                   "Crie {C:attention}#1{} cartas aleatórias com",
                    "o seu {C:attention}naipe mais popular{}"
                }
            },
            c_sarc_going_under = {
                name = 'Marketing Sem Alma',
                text = {
                    "Crie uma {C:attention}Marca de Cupom{}",
                    "Ganhe {C:money}+#1#${}"
                  
                }
            },
            c_sarc_greenpath = {
                name = '"Vista de Caminho Verde"',
                text = {
                    "Crie uma {C:uncommon}Marca Incomum{}",
                  
                }
            },
            c_sarc_haven= {
                name = 'Pôster Enferrujado',
                text = {
                    "Aprimora {C:attention}#1#{}",
                    "cartas selecionadas para",
                    "{C:blue}Cartas de Fluxo{}"
                }
            },
            c_sarc_isaac = {
                name = "Desenho de Criança",
                text = {
                    "{C:green}+#1#{} Atualizações grátis"
                }
            },
            c_sarc_kingdom = {
                name = "Fundos do Monarca",
                text = {
                    "Ganhe {C:money}+#1#${} por ante",
                    "{C:inactive}(Máximo de {C:money}#2#${}){}"
                }
            },
            c_sarc_loop_hero = {
                name = 'Memória de uma Estrada',
                text = {
                    "Destrói até{C:attention}#1#{}",
                    "cartas aleatórias na mão.",
                    "Compre o número de",
                    "cartas destruídas"
                }
            },
            c_sarc_magic_survival = {
                name = 'Registros Devastados',
                text = {
                    "Aprimora até {C:attention}#2#{}",
                    "carta(s) aleatórias na mão com",
                    "aprimoramentos aleatórios",
                    "Número aumenta a cada ante",
                    "{C:inactive}(Máximo de #1#){}"
                }
            },
            c_sarc_obra_dinn = {
                name = 'Relógio de Bolso Mórbido',
                text = {
                    "Crie {C:attention}#1{} carta aprimorada com",
                    "a sua {C:attention}classe mais popular{}"
                }
            },
            c_sarc_plort = {
                name = 'Plort',
                text = {
                    "{C:money}+#1#${} ao usar"
                }
            },
            c_sarc_slay_the_spire = {
                name = '"Top Dicas para Conquistar o Pináculo!"',
                text = {
                    "Cria até {C:attention}#1#{} {V:1}Cartas de Viagem{}",
                    "{C:inactive}(Deve ter espaço){}"
                }
            },
            c_sarc_slime_rancher = {
                name = 'Brochura Colorida',
                text = {
                    "Aprimora {C:attention}#1#{}",
                    "cartas selecionadas para",
                    "{C:red}Cartas de Slime{}"
                }
            },
            c_sarc_ultrakill = {
                name = 'Intervenção Divina',
                text = {
                    "Destrua {C:attention}#1#{} carta selecionada," ,
                    "Se possuir um {C:attention}Selo{}, dê o à",
                    "{C:attention}#2#{} cartas aleatórias em mão"
                }
            },
            c_sarc_undertale = {
                name = "...It's Still You",
                text = {
                    "Após {C:attention}#3#{} usos, {C:attention}-1 Ante{}",
                    "{C:inactive}(No momento #1#/#3#){}",
                    "{C:inactive}(Usos necessários aumentam em {C:attention}#2#{}",
                    "{C:inactive}ao ativar){}"
                }
            },
            c_sarc_wildfrost = {
                name = 'Diário Congelado',
                text = {
                    "Aprimora {C:attention}#1#{}",
                    "cartas selecionadas para",
                    "{C:blue}Cartas Geluminadas{}"
                }
            },
            
            
        },
        Enhanced={
            m_sarc_flow= {
                name = 'Carta de Fluxo',
                text = {
                    "{X:chips,C:white}X1.2{} Fichas, mais {X:chips,C:white}X0.1{} por ",
                    "{C:blue}Carta de Fluxo{} pontuada"
                }
            },
            m_sarc_luminice= {
                name = 'Carta Geluminada',
                text = {
                    "Sempre pontua, sem naipe e classe",
                    "Dá {C:mult}+#1#{} Multi e",
                    "{C:chips}+#2#{} Fichas à cartas pontuadas"
                }
            },
            m_sarc_slime= {
                name = 'Carta de Slime',
                text = {
                    "Crie um {C:attention}Plort{}",
                    "quando pontuada"
                }
            },
            m_sarc_strawberry = {
                name = 'Carta de Morango',
                text = {
                    "Reativa {C:attention}#1#{} vezes",
                    "Quando pontuada na {C:attention}mão{}",
                    "Precisa recarregar",
                    "depois de ser usada",
                }
            }
        },
        Joker = {
            j_sarc_garlic_bread = {
                name = "Pão de Alho",
                text = {
                    "Se a primeira mão da rodada",
                    "é {C:attention}Carta Alta{}, converta",
                    "cartas pontuadas em {C:attention}Áses{}",
                    "Chance de{C:green}#1# em #2#{} de ser",
                    "consumido no fim da rodada",
                    
                }

            },
            j_sarc_artemis = {
                name = 'Ártemis',
                text = {
                    "Cartas de {C:hearts}Copas{}",
                    "recebem {C:attention}desvantagem{},",
                    "Dá {X:mult,C:white}X#1#{} Multi por cada carta",
                    "com desvantagem",
                    "{C:inactive}(No momento {X:mult,C:white}X#2#{} {C:inactive}Mult)"
                }
            },
            j_sarc_cracked_egg = {
                name = 'Ovo Rachado',
                text = {
                    "Quando vendido, transforme",
                    "Curinga à direita em um",
                    "Curinga {C:attention}#1#{}",
                    "Raridade aumenta à cada",
                    "{C:attention}Chefe{} derrrotado",
                    "{C:inactive}(No momento {C:attention}#2#{C:inactive}/2)"
                }
            },
            j_sarc_crash_message = {
                name = 'Mensagem de Erro',
                text = {
                    "Dá #1# Multi igual ao número de",
                    "Cartas {C:attention}Sem Classe{} no seu baralho",
                    "{C:inactive}No momento {C:mult}+#2#{} {C:inactive}Multi){}"
                }
            },
            j_sarc_diversity = {
                name = 'Diversidade',
                text = {
                    "{C:mult}+#1#{} Multi por naipe com",
                    "{C:attention}#2#{} cartas ou mais no baralho",
                    "{C:inactive}No momento {C:mult}+#3#{} {C:inactive}Multi){}",
                }
            },
            j_sarc_double_crescent = {
                name = 'Luas Duplas',
                text = {
                    "Se sua mão contém um {C:attention}Par{},",
                    "chance de {C:green}#1# em #2#{}",
                    "de criar uma carta de {C:planet}Planeta{}",
                }
            },
            j_sarc_green_carnation = {
                name = 'Cravo Verde',
                text = {
                    "Reis pontuados dão",
                    "{C:chips}+#1#{} Fichas para cada",
                    "Rei previamente pontuado"
                }
            },
            j_sarc_jester_dice = {
                name = 'Dado Bufão',
                text = {
                   
                    "Chance de {C:green}#1# em #2#{} de ganhar",
                    "{C:blue}+1{} mão quando jogando ou",
                    "descartando cartas com",
                    "a {C:attention}mesma classe{}"
                }
            },
            j_sarc_inventor_dice = {
                name = 'Dado Inventor',
                text = {
                   
                    "Destrua um consumível ao sair",
                    "da loja para criar uma",
                    "carta de {C:tarot}Tarô{}, {C:planet}Planeta{} ou {V:1}Viagem{}",
                    "Chance de {C:green}#1# em #2#{} de ganhar uma",
                    "carta {C:spectral}Espectral{} ao invés",
                }
            },
            j_sarc_labrys = {
                name = 'Lábris',
                text = {
                    "Rainhas pontuadas dão",
                    "{C:mult}+#1#{} Multi para cada Rainha",
                    "previamente pontuada"
                }
            },
            j_sarc_none_of_the_above = {
                name = 'Nenhuma das Alternativas',
                text = {
                    "{C:attention}Cartas Naipe Curinga{}",
                    "tem uma chance de {C:green}#1# em #2#{}",
                    "de dar: {C:mult}+#3#{} Multi",
                    "{C:chips}+#4#{} Fichas, {C:money}+#5#${} ou {X:mult,C:white}X#6#{} Multi",
                    "{C:inactive}(Vários efeitos podem ativar)"
                }
            },
            j_sarc_orchid = {
                name = 'Orquídea',
                text = {
                    "Este Curinga ganha {C:mult}+#1#{} Multi",
                    "por mão jogada com um",
                    "{C:attention}Valete{} pontuante",
                    "{C:inactive}(No momenti {C:mult}+#2#{}{C:inactive} Multi){}"
                }
            },
            j_sarc_pancake = {
                name = 'Panqueca',
                text = {
                    "Depois de jogar as próximas {C:attention}#2#{} mãos,",
                    "converta todas as cartas jogadas",
                    "em {C:attention}Cartas Naipe Curinga{}",
                    "{C:inactive}(No momento {C:attention}#1#{C:inactive}/#2#)"
                }
            },
            j_sarc_robot_dice = {
                name = 'Dado Robô',
                text = {
                   
                    "Este Curinga ganha {C:mult}#5#{} Multi quando",
                    "o valor da {C:attention}mão jogada{} totaliza {C:attention}#3#{}",
                    "Chance de {C:green}#1# em #2#{} de aumentar multi",
                    "em {C:attention}6{} vezes mais",
                    "{C:inactive}(No momento {C:mult}#4#{} {C:inactive}Multi,",
                    "{C:inactive}Valor muda a cada mão)"
                }
            },
            j_sarc_rocky_geode = {
                name = 'Geodo Rochoso',
                text = {
                    "Dá Multi igual ao número de",
                    "cartas de {C:hearts}Copas{} e de {C:attention}Pedra{} em seu baralho",
                    "{C:inactive}(No momento {C:mult}+#2#{} {C:inactive}Multi){}"
                }
            },
            j_sarc_strange_fluid = {
                name = "Fluido Estranho",
                text = {
                    "{C:chips}#1#{} #2# {C:mult}#3#{} #4#",
                    "Efeito muda dependendo",
                    "se você possui mais",
                    "{C:blue}Mãos{} ou {C:red}Descartes",
                  
                }
            },
            j_sarc_stray_pixel = {
                name = "Pixel Desviado",
                text = {
                    "Quando obtido, ganha",
                    "edição {C:dark_edition}Policromática{}",
                    "se não possui uma edição",
                }
            },
            j_sarc_thief_dice = {
                name = 'Dado Ladrão',
                text = {
                   
                    "Chance de {C:green}#1# em #2#{} de ganhar um",
                    "Curinga {C:dark_edition}comum negativo perecível{}",
                    "ou um {C:attention}consumível{} aleatório",
                    "ao sair da loja",
                    "{C:inactive}(Vários efeitos podem ativar)"
                }
            },
            j_sarc_warrior_dice = {
                name = 'Dado Guerreiro',
                text = {
                   
                    "Chance de {C:green}#1# em #2#{} de",
                    "ganhar uma {C:green}atualização grátis{}",
                    "quando {C:attention}descartando{}",
                    "Chance de {C:green}#1# em #2#{} de",
                    "ganhar um {C:attention}descarte temporário{}",
                    "quando {C:green}atualizando{} a loja"
                }
            },
            j_sarc_watermelon_candy = {
                name = 'Doce de Melancia',
                text = {
                    "{C:mult}+#1#{} Multi",
                    "Consumido depois de {C:attention}#2#{} rodada(s)"
                    
                }
            },
            j_sarc_witch_dice = {
                name = 'Dado Bruxo',
                text = {
                   
                   "Chance de {C:green}#1# em #2#{} de adicionar",
                    "as {C:chips}Fichas{} de cartas",
                    " jogadas e descartadas",
                    "à este curinga",
                    "{C:inactive}(No momento {C:chips}#3#{} {C:inactive}Fichas{})"
                }
            },
        },
        Tag = {
            tag_sarc_cardinal = {
                name = "Marca Cardinal",
                text = {
                    "Dá um {V:1}Pacote de Viagem Mega{}"
                }
            }
        },
        Voucher = {
            v_sarc_advantage = {
                name = 'Vantagem',
                text = {
                    "{C:attention}X2{} à todas as probabilidades listadas"
                },
            },
            v_sarc_nat_20 = {
                name = '20 Natural!',
                text = {
                    "{C:attention}X1.5{} à todas as probabilidades listadas"
                },
            },
            v_sarc_compass = {
                name = 'Bússola',
                text = {
                    "Crie uma {V:1}Marca Cardinal{} depois de",
                    "derrotar o {C:attention}Boss Blind{}"
                },
            },
            v_sarc_journey= {
                name = 'Jornada',
                text = {
                    "Cartas de {V:1}Viagem{} aparecem",
                    "na loja"
                },
            },
        },
        Other = {
            sarc_strawberry_deactivated = {
                name = "Desativada",
                text = {
                    "Não jogue esta carta",
                    "por {C:attention}1{} rodada para",
                    "recarregá-la"
                },
            },
            sarc_collapse_tip = {
                name = "Colapsando...",
                text = {
                    "Se destrói e cria",
                    "um {C:spectral}Buraco Negro{}"
                },
            },
            p_sarc_travel_small = {
                name = "Pacote de Viagem",
                text = {
                  "Escolha {C:attention}#1#{} de {C:attention}#2#",
                  "{C:G.SP.C.travel_1}Cartas de Viagem{} para usar",  
                },
            },
                p_sarc_travel_mega= {
                    name = "Pacote de Viagem Mega",
                    text = {
                      "Escolha {C:attention}#1#{} de {C:attention}#2#",
                      "{C:G.SP.C.travel_1}Cartas de Viagem{} para usar",
                      
                    }
                }
            }
              },
        --Planet={},
        --Spectral={},
        --Stake={},
        --Tag={},
        --Tarot={},
        
    }


    --achievement_descriptions={},
    -- achievement_names={},
    --blind_states={},
    -- challenge_names={},
    -- collabs={},
    --dictionary={},
    --high_scores={},
    -- labels={},
    -- poker_hand_descriptions={},
    --  poker_hands={},
    --  quips={},
    --  ranks={},
    -- suits_plural={},
    -- suits_singular={},
    --  v_dictionary={},
    -- v_text={},