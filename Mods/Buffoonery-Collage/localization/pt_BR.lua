return {
    descriptions = {
        Joker = {
			j_buf_abyssalp = {
				name = "Prisma Abissal",
				text = {"Quando {C:attention}obtiver{} este curinga, {C:attention}exile{}",
						"todos os outros. Um fica {C:dark_edition}Negativo{} a cada",
						"3 turnos. Venda para reobter os curingas",
						"{C:inactive}(#2#/3 Rodadas. #1# Curinga(s) negativo(s)){}",
						"{C:inactive,s:0.7}Deve ter espaço{}"
				}
			},
			j_buf_abyssalecho = { -- Special (Abyssal Prism)
				name = "Eco do Abismo",
				text = {"Dá {C:mult}+#2#{} Multi por",
						"cada Curinga dentro",
						"do {C:attention}Prisma Abissal{}",
						"{C:inactive}(No momento,{} {C:mult}+#1#{} {C:inactive}Multi){}",
						"{C:inactive,s:0.6}Destruído quando o Prisma é removido{}"
				},
				unlock = {"Adquira um",
						  "{C:attention}Prisma Abissal"
				}
			},
			j_buf_afan = {
				name = "Fã Adorador",
				text = {"{C:mult}+#1#{} Mult",
						"Perca {C:money}$6{} ao {C:attention}vender{} este Curinga",
						"{C:green}#2# de #3#{} chance de {C:attention}retornar{}",
						"depois de {C:attention}vendido{}",
						"{C:buf_spc,s:0.7}Sensível a rejeição{}"} 
			},
			j_buf_afan_spc = {
				name = "Ex-Fã Amargurado",  -- Special (Adoring Fan)
				text = {"Vira e embaralha todos os {C:attention}Curingas{}",
						"ou {C:attention}cartas de jogo{} a cada mão, aleatoriamente",
						"Custa {C:money}$25{} para ser vendido",
						"Em {C:attention}#1#{} rodadas, o preço de venda fica positivo",
				},
				unlock = {"Resolva o requerimento",
						"{E:1,C:buf_spc}especial{} do",
						"{C:attention}Fã Adorador"
				} 
			},
			j_buf_argument = {
				name = "Discussão Acalourada",
				text = {"Converte uma carta",
						"não-pontuada em uma",
						"das pontuadas, caso a",
						"{C:attention}mão de pôquer{} for {C:attention}Dois Pares{}"
				}  
			},
			j_buf_cashout = {
				name = "Voucher de Saque",
				text = {"Se a {C:attention}mão vencedora{} pontuar 3x",
						"mais que o {C:attention}Blind{}, ganhe 0.4% dele",
						"em {C:money}dinheiro{} e destrua este Curinga",
						"{C:inactive}(No máximo{} {C:money}$50{}{C:inactive}){}"
				}
			},
			j_buf_clays_alt = {
				name = "Tiro ao Prato",
				text = {"Ganhe {C:money}$#1#{} no",
						"fim da rodada",
						"se você vencer em",
						"exatamente {C:attention}#2#{} Mãos",
						"{C:inactive,s:0.7}Muda a cada rodada{}"
				}
			},
			j_buf_clays = {
				name = "Tiro ao Prato",
				text = {"Ganhe {C:money}$#1#{} no",
						"fim da rodada se",
						"você vencer em um",
						"número específico de Mãos",
						"{C:inactive,s:0.7}Muda a cada rodada{}"
				}
			},
			j_buf_clown = {
				name = "Palhaço",
				text = {"Ganha {C:chips}+#1#{} Fichas quando",
						"outro Curinga é adicionado",
						"{C:inactive}(No momento{} {C:chips}+#2#{} {C:inactive}Fichas){}",
						"{C:buf_spc,s:0.7}Prefere a própria companhia{}"
				}
			},
			j_buf_van_alt = {
				name = "Van", -- Special (Clown) [ALT]
				text = {"Ganha {C:chips}+#1#{} Fichas quando",
						"outro Curinga é adicionado",
						"{C:inactive}(No momento{} {C:chips}+#2#{} {C:inactive}Fichas){}",
						"{C:inactive,s:0.7}Comporta infinitos palhaços{}"
				}
			},
			j_buf_van = {
				name = "Van", -- Special (Clown)
				text = {"Este Curinga ganha {C:chips}Fichas{} quando",
						"outro Curinga é adicionado",
						"A quantidade depende de",
						"quantos {C:attention}Palhaços{} estão dentro",
				},
				unlock = {"Resolva o requerimento",
						"{E:1,C:buf_spc}especial{} do",
						"{C:attention}Palhaço"
				} 
			},
			j_buf_denial = {
				name = "Rejeição de Arstotzka",
				text = {"{C:mult}+5{} Multi ou {C:chips}+30{} Fichas por",
						"cada selo {C:red}Vermelho{} ou {C:blue}Azul{}",
						"{C:attention}respectivamente{}, no baralho completo",
						"{C:inactive}(No momento{} {C:mult}+#1#{} {C:inactive}Multi/{}{C:chips}+#2#{} {C:inactive}Fichas){}",
						}
			},
			j_buf_dorkshire = {
				name = "Chá Dorkshire",
				text = {"Todos os {C:attention}2{}, {C:attention}3{} e {C:attention}10{} jogados se",
						"tornam {C:attention}Cartas de Porcelana{}",
						"antes de pontuar, se a",
						"{C:attention}mão de pôquer{} for uma {C:attention}Trinca{}",
				}
			},
			j_buf_dorkshire_alt = {
				name = "Chá Dorkshire",
				text = {"Todos os {C:attention}2{}, {C:attention}3{}, {C:attention}10{}, {C:attention}12{}, {C:attention}13{}, {C:attention}21{} e {C:attention}25{} jogados",
						"se tornam {C:attention}Cartas de Porcelana{}",
						"antes de pontuar, se a",
						"{C:attention}mão de pôquer{} for uma {C:attention}Trinca{}",
				}
			},
			j_buf_dorkshire_g = {  -- Special (Dorkshire Tea) 
				name = "Dorkshire Gold",
				text = {"Todos os {C:attention}2{}, {C:attention}3{} e {C:attention}10{} jogados se",
						"tornam {C:attention}Cartas de Porcelana Real{}",
						"antes de pontuar, se a",
						"{C:attention}mão de pôquer{} for uma {C:attention}Trinca{}",
				},
				unlock = {"Comece uma tentativa",
						"com baralho e capa",
						"de {C:attention}Porcelana"
				}
			},
			j_buf_dorkshire_g_alt = { -- Special (Dorkshire Tea) [ALT]
				name = "Dorkshire Gold",
				text = {"Todos os {C:attention}2{}, {C:attention}3{}, {C:attention}10{}, {C:attention}12{}, {C:attention}13{}, {C:attention}21{} e {C:attention}25{} jogados",
						"se tornam {C:attention}Cartas de Porcelana Real{}",
						"antes de pontuar, se a",
						"{C:attention}mão de pôquer{} for uma {C:attention}Trinca{}",
				},
				unlock = {"Comece uma tentativa",
						"com baralho e capa",
						"de {C:attention}Porcelana"
				}
			},
			j_buf_fivefingers = {
				name = "Cinco Dedos",
				text = {"{X:mult,C:white}X#1#{} Multi se você tem",
						"um múltiplo de {C:attention}5 Curingas{}",
						"e a mão pontuada",
						"tem exatamente {C:attention}5 cartas{}"
				}
			},
			j_buf_gfondue = {
				name = "Fondue Dourado",
				text = {"Ganhe {C:money}#1#${} na",
						"{C:attention}primeira mão{} da",
						"rodada, {C:money}-#2#${} por",
						"rodada jogada",
				}
			},
			j_buf_camarosa = {
				name = "Camarosa",
				text = {"{X:expmult,C:white}^#1#{} Multi",
						"{C:green}#2# de #3#{} chance desta",
						"carta ser destruída",
						"no fim da rodada",
				}
			},
			j_buf_kerman = {
				name = "Jebediah Kerman",
				text = {"Ganha {C:mult}+#2#{} Multi sempre que",
						"uma carta de {C:planet}Planeta{} é usada",
						"{C:green}#4# de #3#{} chance de {C:attention}EXPLODIR{} no uso",
						"{C:inactive}(No momento{} {C:mult}+#1#{} {C:inactive}Multi){}",
						"{C:buf_spc,s:0.7}Tem medo de singularidades{}",
				}
			},
			j_buf_kerman_spc = { -- Special (Jebediah Kerman)
				name = "Jebediah Renascido",
				text = {"Ganha {C:mult}+#2#{} Multi sempre que",
						"uma carta de {C:planet}Planeta{} é usada",
						"{C:spectral}Buraco Negro{} dá {C:attention}#3#%{} do Multi total",
						"{C:inactive}(No momento{} {C:mult}+#1#{} {C:inactive}Multi){}",
				},
				unlock = {"Resolva o requerimento",
						"{E:1,C:buf_spc}especial{} do",
						"{C:attention}Jebediah Kerman"
				}
			},
			j_buf_jokergebra = {
				name = "JokerGebra",
				text = {"Dá {C:attention}cinco vezes{}",
						"o valor de {C:mult}Multi{}",
						"adicionado pelo Curinga",
						"à {C:attention}esquerda{} em {C:chips}Fichas{}",
						"{C:buf_spc,s:0.7}#1# XMulti!{}"
				}
			},
			j_buf_integral = { -- Special (JokerGebra)
				name = "Integral",
				text = {"Dá {X:expchips,C:white}^0.02{} Fichas",
						"por {X:mult,C:white}X1{} Multi",
						"pontuado antes deste",
						"Curinga cada mão",
				},
				unlock = {"Resolva o requerimento",
						"{E:1,C:buf_spc}especial{} do",
						"{C:attention}JokerGebra"
				}
			},
			j_buf_korny = {
				name = "Kornringa",
				text = {"{C:chips}+#1#{}, {C:chips}+#2#{} e {C:chips}+#3#{} Fichas durante",
						"{C:attention}Small Blind{}, {C:attention}Big Blind{} e {C:attention}Blind de Chefe{},",
						"respectivamente. Chance {C:green}desconhecida{}",
						"de morrer ao fim da rodada",
						"{C:inactive,s:0.7}You don't know the chances...{}"
				}
			},
			j_buf_laidback = { 
				name = "Curinga Folgado",
				text = {
					"{X:mult,C:white}X#1#{} Multi",
					"Ocupa 2 espaços",
				},
			},
			j_buf_lemmesolo = { 
				name = "Let Me Solo Her",
				text = {
					"{C:mult}+#1#{} Multi, {C:mult}desvantagem{} se não estiver só",
					"Quando um {C:attention}Blind de Chefe{} é derrotado,",
					"cria #2# Curingas aleatórios com ao",
					"menos #3# {C:mult}Raros{} e se autodestrói",
				},
			},
			j_buf_maggit = { 
				name = "Maggit",
				text = {
					"{X:expmult,C:white}^#1#{} Multi se você tem",
					"um Curinga do {C:dark_edition}Nu Metal{}",
					"Se não, {C:attention}só uma vez{}, crie um",
					"quando o {C:attention}Blind{} for escolhido",
					"{C:inactive,s:0.7}(Deve ter espaço){}",
				},
				unlock = {'{E:1,s:1.3}?????'}
			},
			j_buf_maggit_alt = { 
				name = "Maggit",
				text = {
					"{X:expmult,C:white}^#1#{} Multi se você tem",
					"um Curinga do {C:dark_edition}Nu Metal{}",
					"Se não, {C:attention}só uma vez{}, crie um",
					"quando o {C:attention}Blind{} for escolhido",
					"{C:inactive,s:0.7}(Já foi criado){}",
				},
			},
			j_buf_memcard = {
				name = "Memory Card",
				text = {"Memoriza a {C:attention}primeira{} carta pontuada a cada",  
						"{C:attention}rodada{} por {C:attention}8{} rodadas. Venda para converter uma",
						"carta na mão em uma memorizada, {C:attention}na ordem{}",
						"{C:inactive}Memorizadas: #1#. Última: #3#{}{C:inactive}#2#{}",
						}
			},
			j_buf_dxmemcard = { -- Special (Memory Card)
				name = "Memory Card Deluxe",
				text = {"Memoriza a {C:attention}primeira{} carta pontuada a cada",  
						"{C:buf_spc}mão{} por {C:buf_spc}16{} mãos. Venda para converter uma",
						"carta na mão em uma memorizada, {C:attention}na ordem{}",
						"{C:inactive}Memorizadas: #1#. Última: #3#{}{C:inactive}#2#{}",
				},
				unlock = {"Comece uma tentativa",
						"com baralho e capa",
						"do {C:attention}JimboStation"
				}
			},
			j_buf_patronizing = {
				name = "Curinga Intrometido",
				text = {"{X:chips,C:white}X#1#{} Fichas",
						"{C:attention}Obriga{} 5 cartas a sempre",
						"serem {C:attention}selecionadas{}",
						"{C:buf_spc,s:0.7}Quer jogar um(a) #2#{}"
				}
			},
			j_buf_supportive = { -- Special (Patronizing Joker)
				name = "Curinga Prestativo", 
				text = {"{X:chips,C:white}X#1#{} Fichas",
						"Revela as",
						"três primeiras",
						"cartas do baralho"
				},
				unlock = {"Resolva o requerimento",
						"{E:1,C:buf_spc}especial{} do",
						"{C:attention}Curinga Intrometido"
				}
			},
			j_buf_supportive_alt = { -- Special (Patronizing Joker)[ALT]
				name = "Curinga Prestativo", 
				text = {"{X:chips,C:white}X#7#{} Fichas",
						"{s:0.8}#1##4#{}",
						"{s:0.8}#2##5#{}",
						"{s:0.8}#3##6#{}",
				}
			},
			j_buf_porcelainj = {
				name = "Curinga de Porcelana",
				text = {"Dá {X:chips,C:white}X#2#{} Fichas por",
						"cada {C:attention}3 Cartas de Porcelana{}",
						"no seu {C:attention}baralho completo{}",
						"{C:inactive}(No momento,{} {X:chips,C:white}X#1#{} {C:inactive}Fichas){}"
				}
			},
			j_buf_rerollin = {
				name = "Rerollin'",
				text = {"Ganhe {C:money}$#1#{} na",          
						"sua quinta {C:green}atualização{}",
						"uma vez por loja",
						"{C:inactive}(Falta(m){} {C:green}#3#{} {C:inactive}atualizações){}"}
			},
			j_buf_roulette = {
				name = "Roleta Russa",
				text = {"Quando o {C:attention}Blind{} for selecionado, ganhe {C:money}$#3#{}",          
						"{C:green}#1# de #2#{} chance de {E:1,C:mult}perder o jogo{} ao invés",
						"disso. Se a chance chegar a {C:green}#1# de 2{} e você",
						"vencer, crie um Curinga {C:legendary}Lendário{} aleatório",
						"{C:inactive,s:0.7}(Chance e pagamento aumentam a cada rodada)"
				}
			},
			j_buf_sayajimbo = {
				name = "Sayajimbo",
				text = {"{C:chips}+#1#{} Fichas",
						"Pontue ao menos {C:attention}#2#{} em",
						"uma mão para {C:attention}transformar{}",
						"{C:inactive}(Próximo Nível: {C:mult}+20{C:inactive} Mult)",
				}
			},
			j_buf_sayajimbo_s1 = {
				name = "Super Sayajimbo",
				text = {"{C:mult}+#1#{} Multi",
						"Pontue ao menos {C:attention}#6#{} em uma",
						"mão #5# vezes para {C:attention}transformar{}",
						"{C:inactive}(#4#/#5#, Próx. Nível: {X:mult,C:white}X3{C:inactive} Multi)",
				}
			},
			j_buf_sayajimbo_s2 = {
				name = "Super Sayajimbo 2",
				text = {"{X:mult,C:white}X#2#{} Multi",
						"Pontue ao menos {C:attention}#6#{} em uma",
						"mão #5# vezes para {C:attention}transformar{}",
						"{C:inactive}(#4#/#5#, Próx. Nível: {X:expmult,C:white}^1.3{C:inactive} Multi)",
				}
			},
			j_buf_sayajimbo_s3 = {
				name = "Super Sayajimbo 3",
				text = {"{X:dark_edition,C:white}^#3#{} Multi",
						"{C:inactive}Contemple!"
				}
			},
			j_buf_tailored = {
				name = "Terno Sob Medida",
				text = {"Dá {X:mult,C:white}X#1#{} Multi multiplicado pela",
						"porcentagem de cartas do {C:attention}naipe{}",
						"{C:attention}predominante{} no seu {C:attention}baralho completo{}",
						"{C:inactive}(No momento #3#,{} {X:mult,C:white}X#2#{} {C:inactive}Multi){}",
				}
			},
			j_buf_whitepony = {
				name = "White Pony",
				text = {"{C:mult}+#1#{} Multi",
						"Dobra a", 
						"cada {C:attention}Aposta{}"
				}
			},
			j_buf_blackstallion = {  -- Special (White Pony)
				name = "Black Stallion",
				text = {"{C:mult}+#1#{} Multi",
						"Dobra a", 
						"cada {C:attention}Aposta{}"
				},
				unlock = {"Comece uma tentativa",
						"com o {C:attention}Baralho",
						"{C:attention}Galopeiro"
				}
			},
        },
        Back = {
			b_buf_jstation = {
				name = "Baralho do JimboStation",
				text = {"Comece com o Curinga",
						"{C:red,T:j_buf_memcard}#1#{}",
						"{C:attention}+1{} tamanho de mão"
				}
			},
			b_buf_galloping = {
				name = "Baralho Galopeiro",
				text = {"Comece com o Curinga",
						"{C:buf_spc,T:j_buf_blackstallion}#1#{}",
				},
				unlock = {"Alcance a Aposta",
						  "Nível {C:attention}10"
				}
			},
			b_buf_porcelain = {
				name = "Baralho de Porcelana",
				text = {"Comece com o Curinga",
						"{C:red,T:j_buf_dorkshire}#1#{}",
						"e 1 {C:attention}Naipe{} a",
						"menos no baralho"
				}
			},
			b_buf_sandstone = {
				name = "Baralho de Arenito",
				text = {"Vença na {C:attention}Aposta 6{}",
						"{C:red}X2{} tamanho base do Blind"
				}
			},
        },
        Tarot = {
			c_buf_nobility = {
				name = "Nobreza",
				text = {
					"Aprimora {C:attention}#1#{} carta selecionada",
					"para {C:attention}Carta de Pocelana{}",
					"ou {C:attention}Carta de Porcelana Real{}",
					"se você tiver ao menos {C:money}$#2#{}"
				}
			},
        },
        Stake = {
			stake_buf_palladium = {
                name = 'Aposta de Paládio',
                text = {
                    'Blinds de Chefe {C:attention}Finais{}',
                    'têm sua frequência {C:attention}dobrada{}',
					'{s:0.8}Aplica todas as apostas anteriores'
                }
            },
			stake_buf_spinel = {
                name = 'Aposta Espinela',
                text = {
                    'O jogo requer {C:attention}50% mais',
					'{C:attention}Apostas{} para ser vencido',
					'{s:0.8}Aplica todas as apostas anteriores'
                }
            },
        },
        Other = {
		-------- STICKERS --------
			buf_palladium_sticker = {
                name = 'Adesivo de Paládio',
                text= {
                    'Usou este Curinga',
                    'para vencer na dificuldade',
                    '{C:attention}Aposta de Paládio{}'
                }
            },
			buf_spinel_sticker = {
                name = 'Adesivo Espinela',
                text= {
                    'Usou este Curinga',
                    'para vencer na dificuldade',
                    '{C:attention}Aposta Platinada{}'
                }
            },
		-------- INFO QUEUE --------
            korny_info = {
                name = "Créditos",
                text = {
                    "Arte original",
                    "por {C:green}Snakey{}",
                }
            },
			maggit_info = {
				name = "Curingas do Nu Metal",
				text = {
					"Cinco Dedos, Kornringa,",
					"Rerollin', Palhaço",
					"e White Pony",
				}
			},
			special_info = {
				name = "Curinga Especial",
				text = {
					"Normalmente inacessível",
					"Dado sob condições",
					"{E:1,C:buf_spc}especiais{}"
				}
			},
			banish_info = {
				name = "Exílio",
				text = {
					"Curingas exilados são",
					"{C:attention}temporariamente{} removidos",
					"e mantêm suas melhorias",
					"Curingas {C:attention}Eternos{} podem ser exilados"
				}
			},
			porc_info = {
				name = "Carta de Porcelana",
				text = {
						"{X:chips,C:white}X1.75{} Fichas",
						"Destruída se a mão",
						"jogada contém mais", 
						"de {C:attention}3{} cartas",
				}
			},
			porcg_info = {
				name = "Porcelana Real",
				text = {
						"{X:chips,C:white}X2{} Fichas, {C:attention}realeza{}",
						"Destruída se a mão",
						"jogada contém mais", 
						"de {C:attention}3{} cartas",
				}
			},
        },
        Sleeve = {
			sleeve_buf_jstation = {
				name = "Capa do JimboStation",
				text = {"Comece com o Curinga",
						"{C:red,T:j_buf_memcard}#1#{}",
						"{C:attention}+1{} tamanho de mão"
				}
			},
			sleeve_buf_jstation_alt = {
				name = "Capa do JimboStation",
				text = {"Comece com o Curinga",
						"{C:buf_spc,T:j_buf_dxmemcard}#2#{}",
						"{C:attention}+1{} tamanho de mão"
				}
			},
			sleeve_buf_galloping = {
				name = "Capa Galopeira",
				text = {"Comece com o Curinga",
						"{C:buf_spc,T:j_buf_blackstallion}#1#{}",
				}
			},
			sleeve_buf_galloping_alt = {
				name = "Capa Galopeira",
				text = {"Comece com o Curinga",
						"{C:green,T:j_buf_whitepony}#2#{}",
						"{C:blue}-2{} mãos cada rodada"
				}
			},
			sleeve_buf_porcelain = {
				name = "Capa de Porcelana",
				text = {"Comece com o Curinga",
						"{C:red,T:j_buf_dorkshire}#1#{}",
						"e 1 {C:attention}Naipe{} a",
						"menos no baralho"
				}
			},
			sleeve_buf_porcelain_alt = {
				name = "Capa de Porcelana",
				text = {"Comece com o Curinga",
						"{C:buf_spc,T:j_buf_dorkshire_g}#2#{}",
						"e 1 {C:attention}Naipe{} a",
						"menos no baralho"
				}
			},
			sleeve_buf_sandstone = {
				name = "Capa de Arenito",
				text = {"Vença na {C:attention}Aposta 6{}",
						"{C:red}X2{} tamanho base do Blind"
				}
			},
			sleeve_buf_sandstone_alt = {
				name = "Capa de Arenito",
				text = {"Vença na {C:attention}Aposta 5{}",
						"{C:red}X2.5{} tamanho base do Blind"
				}
			},
        },
		Enhanced = {
			m_buf_porcelain = {
				name = "Carta de Porcelana",
				text = {"{X:chips,C:white}X#1#{} Fichas",
						"Destruída se a mão",
						"jogada contém mais", 
						"de {C:attention}#2#{} cartas",		
				}
			},
			m_buf_porcelain_g = {
				name = "Carta de Porcelana Real",
				text = {"{X:chips,C:white}X#1#{} Fichas, é carta de {C:attention}realeza{}",
						"Destruída se a mão",
						"jogada contém mais", 
						"de {C:attention}#2#{} cartas",
				}
			},
		},
    },
    misc = {
		dictionary = {
			-------- CONFIG --------
			buf_cf_info_info = {
				"Precisamente: créditos, informações sobre a",
				"raridade 'Especial' e a mecânica de 'Exílio'",
				"Reinício necessário para fazer efeito",
			},
			buf_cf_req_restart = {
				"3 Curingas e 1 Aprimoramento",
				"Reinício necessário para fazer efeito",
			},
			buf_cf_show_spc = "Mostrar cartas Especiais na Coleção",
			buf_cf_show_info = "Mostrar informações adicionais",
			-------- CREDITS --------
			buf_cr_artcode = "Arte & Código",
			buf_cr_localization = "Tradução",
			buf_cr_sfx = "Efeitos Sonoros",
			buf_cr_misc = "Miscelânea",
			-------- CARD MESSAGES --------
			buf_korny_ok = "De boa!",
			buf_korny_dd = "Morreu!",
			buf_prism_eor1 = "Tormento...",
			buf_prism_eor2 = "+1 Negativo",
			buf_prism_sck = "Sumam!",
			buf_memory = "Memorizada!",
			buf_memfull = "Memória Cheia!",
			buf_doubled = "Dobrou!",
			buf_convert = "Convertido!",
			buf_blowup = "C A B U M !",
			buf_ydead = "Você morreu...",
			buf_dry = "Sobreviveu!",
			buf_afan_annoy1 = "Mas... mas...",
			buf_afan_annoy2 = "Ah não...",
			buf_afan_annoy3 = "Tem certeza?",
			buf_afan_annoy4 = "Só mais uma",
			buf_afan_monologue1 = "Eu ERA seu fã!",
			buf_afan_monologue2 = "Te admirava!",
			buf_afan_monologue3 = "Tu ERA meu herói!",
			buf_tea = "Chá!",
			buf_gfondue_licked = "Lambeu!",
			buf_hit = "Acertou!",
			buf_miss = "Errrouuu!",
			buf_krakened = "Eu Renasci!",
			buf_supergrade = "GRANDE Melhoria!",
			buf_disilluison = "Desiludido!",
			buf_defeated = "Derrotado!",
			buf_hopin = "Entra aí!",
			buf_patspc = "Boaaaa!",
			-------- MEMCARD STUFF --------
			buf_ready = "Pronto",
			buf_Ace = "Ás",
			buf_Jack = "Valete",
			buf_Queen = "Dama",
			buf_King = "Rei",
			-- UnStable compat --
			buf_0 = "0",
			['buf_0.5'] = "Meio",
			buf_1 = "1",
			buf_r2 = "Raiz de 2",
			buf_e = "e",
			buf_Pi  = "Pi",
			buf_11 = "11",
			buf_12 = "12",
			buf_13 = "13",
			buf_21 = "21",
			buf_25 = "25",
			buf_161 = "161",
			["buf_???"] = "???",
			--------------------
			buf_of = " de ",			
			buf_Spades = "Espadas",
			buf_Hearts = "Copas",
			buf_Clubs = "Paus",
			buf_Diamonds = "Ouros",
			-- Bunco/Paperback compat --
			buf_Fleurons = "Florões",
			buf_Halberds = "Alabardas",
			buf_Crowns = "Coroas",
			buf_Stars = "Estrelas",
			-------- MISC --------
			k_buf_spc = "Especial",
			k_buf_notyet = "(Deve ter espaço)",
			buf_uniform = "uniforme",
		},
		v_dictionary = {
			a_buf_emult = "^#1# Multi",
			a_buf_xchips = "X#1# Fichas",
			a_buf_echips = "^#1# Fichas",
		},
    },
}