return {
    descriptions = {
        Joker = {
            j_prism_exotic_card = {
                name = "Carta exótica",
                text = {"Reactiva todas las",
                    "cartas {C:attention}mejoradas{} jugadas"
                },
            },
            j_prism_razor_blade = {
                name = "Hoja de afeitar",
                text = {"{X:mult,C:white} X#1#{} Multi por cada",
                    "{C:attention}categoria{} que ya no esté presente",
                    "en tu {C:attention}baraja completa{}",
                    "{C:inactive}(Actual {X:mult,C:white}X#2# {C:inactive} Multi)"
                },
            },
            j_prism_harlequin = {
                name = "Arlequín",
                text = {"Este comodín obtiene {X:mult,C:white} X#1# {} Multi",
                    "cuando la primera carta jugada",
                    "de cada {C:attention}Palo{} anota",
                    "{C:inactive}(Actual {X:mult,C:white}X#2#{C:inactive} Multi)",
                },
                unlock= {
                "{E:1,s:1.3}?????",
                }
            },
            j_prism_rigoletto = {
                name = "Rigoletto",
                text = {"{C:attention}+1{} tamaño de mano esta ronda",
                    "luego de {C:attention}jugar{} o {C:attention}descartar",
                    "{C:inactive}(Actual {C:attention}+#2#{C:inactive} tamaño de mano)",
                },
                unlock= {
                "{E:1,s:1.3}?????",
                }
            },
            j_prism_medusa = {
                name = "Gorgon",
                text = {"Todas las cartas de {C:attention}figura{}",
                    "se vuelven cartas de {C:attention}Piedra{} ",
                    "cuando anotan",
                },
            },
            j_prism_rich_joker = {
                name = "Comodín rico",
                text = {"{C:green}#1# en #2#{} probabilidades de ganar",
                    "{C:money}$#3#{} por cada carta {C:attention}vendida{}",
                },
            },
            j_prism_air_balloon = {
                name = "Globo aerostático",
                text = {"Este comodín obtiene {C:red}+#2#{}",
                    "Multi por cada {C:attention}Carta mas alta{}",
                    "{C:attention}consecutiva{} jugada",
                    "{C:inactive}(Actual {C:red}+#1#{C:inactive} Multi)"
                },
            },
            j_prism_ghost = {
                name = "Ocultista",
                text = {"{C:chips}+#1#{} fichas por cada",
                    " carta {C:spectral}espectral{} usada",
                    "{C:inactive}(Actual {C:chips}+#2#{C:inactive} Fichas)",
                },
            },
            j_prism_prism = {
                name = "Prisma",
                text = {"Las cartas {C:attention}Numeradas{}",
                    "cuentan como cualquier palo"
                },
            },
            j_prism_minstrel = {
                name = "Trovador",
                text = {"Genera una carta de {C:myth_light}Mito{}",
                    "cuando se selecciona la {C:attention}ciega pequeña o grande{}",
                    "{C:inactive}(Debe haber espacio)",
                },
            },
            j_prism_happily = {
                name = "Felices por siempre",
                text = {"Crea una carta de {C:myth_light}mito{}",
                    "si la mano de poker jugada contiene",
                    "un {C:attention}Rey{} y una {C:attention}Reina{} que anoten"
                },
            },
            j_prism_geo_hammer = {
                name = "Martillo geólogo",
                text = {"Mejora una carta aleatoria en tu mano a",
                    "{C:attention}Cristal{} o {C:attention}Piedra{}",
                    "cuando comienza la ronda",
                    "{C:inactive}(No afecta a las cartas ya mejoradas)"
                },
            },
            j_prism_vaquero = {
                name = "Vaquero",
                text = {"Las {C:attention}cartas versátiles{}",
                    "otorgan {X:mult,C:white} X#1# {} Multi",
                    "cuando anotan"
                },
            },
            j_prism_promotion = {
                name = "Coronación",
                text = {"Si la {C:attention}primera mano{} de la ronda",
                    "tiene solo {C:attention}1{} carta,",
                    "la convierte en una{C:attention}Reina"
                },
            },
            j_prism_sculptor  = {
                name = "Escultor",
                text = {"Cada {C:attention}Carta de piedra jugada",
                    "obtiene permanentemente",
                    "{C:mult}+#1#{} Multi cuando anota"
                },
            },
            j_prism_motherboard = {
                name = "Placa madre",
                text = {"Este comodín obtiene {C:chips}+#1#{} fichas",
                    "cuando una carta jugada",
                    "sin {C:attention}mejora{},",
                    "{C:attention}Sello{} o {C:dark_edition}edición{} anota",
                    "{C:inactive}(Actual {C:chips}+#2#{C:inactive} fichas)",
                },
            },
            j_prism_reverse_card = {
                name = "Carta de reversa",
                text = {"Invierte",
                    "las {C:chips}Fichas{} y {C:mult}Multi{} actual"
                },
            },
            j_prism_vip_pass = {
                name = "Pase VIP",
                text = {"Los {C:attention}comodines{} {C:chips}Comunes",
                "no pueden aparecer",
                },
            },
            j_prism_plasma_lamp = {
                name = "Lámpara de plasma",
                text = {"Equilibra las {C:chips}Fichas{} y",
                    "{C:mult}Multi{} si la{C:attention} mano de póker jugada",
                    "es {C:attention}#1#{}",
                    "o {C:attention}#2#{}",
                    "{s:0.8}La mano de póker cambia cada ronda",
                    "{s:0.8}o luego de activarse"
                },
            },
            j_prism_hopscotch = {
                name = "Rayuela",
                text = {"Cuando un {C:attention}#3#{} anota",
                    "este comodín obtiene",
                    "{C:red}+#1#{} Multi y la categoría",
                    "requerida aumenta en {C:attention}1",
                    "{C:inactive}(Actual {C:red}+#2#{C:inactive} Multi)",
                },
            },
            j_prism_amethyst = {
                name = "Amatista",
                text = {"Este comodín obtiene {X:mult,C:white} X#2# {} Multi",
                    "por cada {C:attention}Carta de cristal{} en tu mano",
                    "al final de la ronda",
                    "{C:inactive}(Currently {X:mult,C:white}X#1# {C:inactive} Mult)",
                },
            },
            j_prism_aces_high = {
                name = "Aces High",
                text = {"Crea una {C:green}Etiqueta",
                    "{C:green}Inusual{} o {C:rare}Etiqueta Rara{} si",
                    "la mano de poker contiene un",
                    "{C:attention}As{} y una {C:attention}Escalera",
                },
            },
            j_prism_elf = {
                name = "Duendecillo",
                text = {"{X:mult,C:white} X#1# {} Multi si una carta de {C:myth_light}Mito{}",
                    "fue usada desde",
                    "la {C:attention}última ronda",
                },
            },
            j_prism_cookie = {
                name = "Galleta de la fortuna",
                text = {"Vende esta carta para que",
                    "todas las {C:green}probabilidades",
                    "sean {C:attention}guarantizadas{} por",
                    "esta ronda"
                },
            },
            j_prism_pie = {
                name = "math.pie",
                text = {"Cuando un {C:attention}#1#{} anota,",
                    "Otorga {X:mult,C:white}X#2#{} multi y",
                    "la categoría requerida cambia al",
                    "próximo número de {C:attention}Pi",
                    "{C:inactive}(Los próximos 5 números son: #3#)",
                },
            },
            j_prism_polydactyly = {
                name = "Polidactilia",
                text = {"Se puede jugar y",
                    "descartar hasta",
                    "{C:attention}6{} cartas"
                },
            },
            j_prism_solo_joker = {
                name = "Comodín aviador",
                text = {"Si la mano jugada",
                    "contiene solo {C:attention}1{} carta",
                    "reactivalá {C:attention}#1#{} veces"
                },
            },
            j_prism_economics = {
                name = "Economía 101",
                text = {"Cuando se selecciona la {C:attention}Ciega{}, pierde",
                    "todo tu dinero y este comodín obtiene",
                    "{X:mult,C:white}X#1#{} multi por cada {C:money}$#2#{} perdido",
                    "{C:inactive}(Actual {X:mult,C:white}X#3#{C:inactive} multi)"
                },
            },
            j_prism_whiskey = {
                name = "Whisky",
                text = {"Crea una {C:attention}Etiqueta doble{} gratis",
                    "luego de haber anotado",
                    "{C:attention}#1#{} Jotas",
                    "{C:inactive}(Actual {C:attention}#2#{C:inactive}/#1#)"
                },
            },
            j_prism_hit_record = {
                name = "Discazo",
                text = {"Las cartas jugadas",
                    "{C:attention}vuelven{} a tu baraja",
                    "luego de puntuar"
                },
            },
             j_prism_patch = {
                name = "Bendita estampa",
                text = {"Crea una {C:dark_edition}etiqueta",
                    "{C:dark_edition}negativa{} si la mano jugada",
                    "contiene {C:attention}3{} {C:attention}6s que anotan",
                },
            },
             j_prism_day = {
                name = "Día",
                text = {"Si la mano jugada contiene",
                    "solo {C:hearts}Corazones{} o {C:diamonds}Diamantes{},",
                    "reactiva todas las cartas jugadas",
                    "y este comodín se transforma en {C:attention}Noche"
                },
            },
             j_prism_night = {
                name = "Noche",
                text = {"Si la mano jugada contiene",
                    "solo {C:clubs}Tréboles{} o {C:spades}Espadas{},",
                    "reactiva todas las cartas jugadas",
                    "y este comodín se transforma en {C:attention}Día"
                },
            },
             j_prism_metalhead = {
                name = "Metalhead",
                text = {"Las {C:attention}cartas de piedra{} también son",
                    "consideradas como {C:attention}Cartas de acero"
                },
            },
            j_prism_shork = {
                name = "Tiburón de peluche",
                text = {"Todas las ediciones futuras {C:spectral}Ediciones{}",
                    "obtenidas por una carta o comodín",
                    "se convierten en {C:dark_edition}Policroma{}"
                },
            },
            j_prism_schrodinger = {
                name = "El gato de Schrödinger",
                text = {"Reactiva cada",
                    "{C:attention}Carta doble{} jugada una vez por cada",
                    "{C:attention}Carta doble{} consecutiva ",
                    "que anotó en esta mano"
                },
            },
             j_prism_hypercube = {
                name = "Hipercubo",
                text = {"{X:dark_edition,C:white}^#1#{} Multi si un",
                    "{C:attention}Póker{} se encuentra",
                    "en tu mano"
                },
            },
             j_prism_pizza_cap = {
                name = "Pizza Capricciosa",
                text = {"Las siguientes {C:attention}#2#{} cartas de",
                    "{C:spades}Espadas{} jugadas otorgan {C:chips}+#1#{} fichas",
                    "cuando anotan",
                    "{s:0.8}Mejora futuras pizzas",

                },
            },
            j_prism_pizza_mar = {
                name = "Pizza Margherita",
                text = {"Las siguientes {C:attention}#2#{} cartas de",
                    "{C:hearts}Corazones{} jugadas otorgan {X:red,C:white}X#1#{} multi",
                    "cuando anotan",
                    "{s:0.8}Mejora futuras pizzas",
                },
            },
            j_prism_pizza_for = {
                name = "Pizza Quattro Formaggi",
                text = {"Las siguientes {C:attention}#2#{} cartas de",
                    "{C:diamonds}Diamantes{} jugadas tienen {C:green}#3# en #4#{} probabilidades de",
                    "ganar {C:money}$#1#{} cuanto anotan",
                    "{s:0.8}Mejora futuras pizzas",

                },
            },
            j_prism_pizza_ruc = {
                name = "Pizza Rucola",
                text = {"Las siguientes {C:attention}#2#{} cartas de",
                    "{C:clubs}Tréboles{} jugadas otorgan {C:red}+#1#{} multi",
                    "cuanto anotan",
                    "{s:0.8}Mejora futuras pizzas",
                },
            },
            j_prism_pizza_haw = {
                name = "Pizza hawaiana",
                text = {"Las siguientes {C:attention}#3#{} cartas de",
                    "{C:paperback_crowns}Coronas{} jugadas ganan entre",
                    "{C:money}$#1#{} y {C:money}$#2#{} cuando anotan",
                    "{s:0.8}Mejora futuras pizzas",
                },
            },
            j_prism_pizza_det = {
                name = "Pizza de Detroit",
                text = {"Las siguientes {C:attention}#2#{} cartas de",
                    "{C:paperback_stars}Estrellas{} jugadas otorgan {X:chips,C:white}X#1#{} fichas",
                    "cuadno anotan",
                    "{s:0.8}Mejora futuras pizzas",
                },
            },
             j_prism_pizza_con = {
                name = "Pizza en cono",
                text = {"Las siguientes {C:attention}#2#{} cartas de {C:minty_3s}3s{}",
                    "jugadas tienen {C:green}#3# en #4#{} probabilidades de otorgar",
                    "{X:red,C:white}X#1#{} multi cuando anotan",
                    "{s:0.8}Mejora futuras pizzas",

                },
            },
            j_prism_murano = {
                name = "Comodín Murano",
                text = {"Las {C:attention}cartas de vidrio{} jugadas tienen",
                    "{C:green}#1# en #2#{} probabilidades de",
                    "obtener {C:dark_edition}Laminado{}, {C:dark_edition}Holográfica{}",
                    "o {C:dark_edition}Polícroma{}",

                },
            },
            j_prism_romantic = {
                name = "Guerrero romántico",
                text = {"Crea la {C:attention}última {C:myth_light}carta de mito{}",
                    "usada en esta partida",
                    "si la mano jugada contiene un",
                    "{C:hearts}Corazón{} y {C:spades}Espada{} que puntuén",
                },
            }
        },
        Back = {
             b_prism_purple = {
                name = "Baraja púrpura",
                text = {"Puedes usar {C:chips}manos{} y",
                    "{C:red}descartes{} de forma intercambiable",
                    "{C:inactive}(Puedes descartar usando manos si ya no",
                    "{C:inactive}quedan descartes y viceversa)"
                },
            },
            b_prism_ancient = {
                name = "Baraja antigua",
                text = {"Comienza la partida con",
                    "{C:myth_light,T:v_prism_myth_merchant}Mercader mítico{} y",
                    "{C:attention,T:v_prism_booster_box}Caja de potenciadores{}"
                },
            },
            b_prism_market = {
                name = "Baraja Sobreproductiva",
                text = {"Comienza la partida con",
                    "{C:attention,T:v_overstock_norm}Excedente{} y",
                    "{C:attention,T:v_reroll_surplus}Gula de renovaciones{}"
                },
            },
        },
         Sleeve = {
             sleeve_prism_purplesleeve = {
                name = "Manga púrpura",
                 text = {"Puedes usar {C:chips}manos{} y",
                    "{C:red}descartes{} de forma intercambiable",
                    "{C:inactive}(Puedes descartar usando manos si ya no",
                    "{C:inactive}quedan descartes y viceversa)"
                },  
            },
             sleeve_prism_purplesleeve_alt = {
                name = "Manga púrpura",
                text = {"{C:attention}+1{} de tamaño de mano",
                },
            },
            sleeve_prism_ancientsleeve = {
                name = "Manga antigua",
                text = {"Comienza la partida con",
                    "{C:myth_light,T:v_prism_myth_merchant}Mercader mítico{} y",
                    "{C:attention,T:v_prism_booster_box}Caja de potenciadores{}"
                },
            },
            sleeve_prism_ancientsleeve_alt = {
                name = "Manga antigua",
                text = {"La tienda siempre contiene",
                    "un {C:myth_light}Paquete legendario"
                },
            },
            sleeve_prism_marketsleeve = {
                name = "Manga Sobreproductiva",
                text = {"Comienza la partida con",
                    "{C:attention,T:v_overstock_norm}Excedente{} y",
                    "{C:attention,T:v_reroll_surplus}Gula de renovaciones{}"
                },
            },
            sleeve_prism_marketsleeve_alt = {
                name = "Manga Sobreproductiva",
                text = {"Comienza la partida con",
                    "{C:attention,T:v_prism_booster_box}Caja de potenciadores{}"
                },
            },
        },
        Enhanced = {
            m_prism_crystal = {
                name = "Carta de cristal",
                text = {"{X:mult,C:white} X#1#{} Mult",
                    "Obtiene {X:mult,C:white} X#2#{} Multi si la carta está",
                    "en tu mano al final de la ronda"
                }

            },
            m_prism_burnt = {
                name = "Carta quemada",
                text = {"Roba {C:attention}#1#{} cartas",
                    "mas luego de",
                    "{C:attention}descartar{} esta carta "
                }
            },
            m_prism_double = {
                name = "Carta doble",
                text = {"Puede transformarse en",
                    "{C:attention}#1#{}"
                }
            },
            m_prism_echo = {
                name = "Carta eco",
                text = {"{C:attention}Reactiva{} esta carta",
                    "por cada otra {C:attention}Carta",
                    "{C:attention}Eco{} jugada"
                }
            },
        },
         Edition = {
            e_prism_gold_foil = {
                name = "Laminado dorado",
                text = {
                    "Se activa {C:attention}2 veces{}"
                }
            }
        },
        Myth = {
            c_prism_myth_druid = {
                name = "Druida",
                text = {"Selecciona {C:attention}#1#{} cartas,",
                    "la carta {C:attention}izquierda{} obtiene las {C:enhanced}Mejoras{}, {C:dark_edition}Ediciones{} y",
                    "{C:attention}Sellos{} de la carta {C:attention}derecha{}"
                }

            },
            c_prism_myth_dwarf = {
                name = "Enano",
                text = {"Mejora {C:attention}#1#{}",
                    " cartas seleccionadas a",
                    "{C:attention}Cartas de cristal"
                }
            },
            c_prism_myth_siren = {
                name = "Sirena",
                text = {"Mejora {C:attention}#1#{}",
                    " cartas seleccionadas a",
                    "{C:attention}Cartas eco"
                }
            },
            c_prism_myth_dragon = {
                name = "Dragón",
                text = {"Mejora {C:attention}#1#{}",
                    " cartas seleccionadas a",
                    "{C:attention}Cartas quemadas"
                }
            },
            c_prism_myth_twin = {
                name = "Gemelo",
                text = {"Mejora {C:attention}#1#{}",
                    "cartas seleccionadas a",
                    "{C:attention}Cartas doble",
                    "{C:inactive}(Imitándose una a otra)"
                }
            },
            c_prism_myth_wizard = {
                name = "Hechicero",
                text = {"Convierte hasta {C:attention}#1#{}",
                    "cartas seleccionadas a",
                    "la {C:attention}categoría{} de la carta {C:attention}derecha"
                }
            },
            c_prism_myth_gnome = {
                name = "Gnomo",
                text = {"Crea una {C:attention}Etiqueta de inversión"
                }
            },
            c_prism_myth_mirror = {
                name = "Espejo",
                text = {"Agrega {C:dark_edition}Negativo{}",
                    "a {C:attention}1{} carta aleatoria",
                    "en tu mano"
                }
            },
            c_prism_myth_colossus = {
                name = "Coloso",
                text = {"Agrega un {C:moon}Sello lunar{}",
                    "a {C:attention}#1#{} carta seleccionada en tu mano"
                }
            },
            c_prism_myth_beast = {
                name = "Bestia aulladora",
                text = {"Genera una",
                    "carta {C:spectral}espectral{} aleatoria",
                    "{C:inactive}(Debe haber espacio)"
                }
            },
            c_prism_myth_ooze = {
                name = "Rezumar",
                text = {"Agrega un {C:green}Sello verde{}",
                    "a {C:attention}#1#{} carta seleccionada en tu mano"
                }
            },
            c_prism_myth_roc = {
                name = "Rocho",
                text = {"Crea una {C:attention}Etiqueta doble"
                }
            },
            c_prism_myth_kraken = {
                name = "Kraken",
                text = {"Crea una {C:attention}Etiqueta de malabar"
                }
            },
            c_prism_myth_treant = {
                name = "Treant",
                text = {"Convierte hasta {C:attention}#1#{}",
                    "cartas seleccionadas al",
                    "{C:attention}palo{} de la carta {C:attention}derecha{}"
                }
            },
             c_prism_myth_egg = {
                name = "Huevo dorado",
                text = {"Pierde {C:money}$#3#{}",
                    "{C:green}#1# en #2#{} probabilidades de",
                    "agregar la edición {C:dark_edition}Laminado dorado{}",
                    " a un {C:attention}comodín al azar",
                    "{C:inactive}(Debe ser compatible)"
                    
                }
            },
        },
        Spectral = {
            c_prism_spectral_djinn = {
                name = "Genio",
                text = {"Desea {C:dark_edition} cualquier",
                    "{C:attention}comodín{} para crear",
                    "{C:inactive}(Comodines legendarios",
                    "{C:inactive}excluidos)"
                }
            },
        },
        Voucher = {
            v_prism_myth_merchant = {
                name = "Mercader mítico",
                text = {
                    "Las cartas de {C:myth_light} Mito{} aparecen",
                    "{C:attention}2 X{} veces mas seguido",
                    "en la tienda",
                },
            },
            v_prism_myth_tycoon = {
                name = "Magnate de mitos",
                text = {
                   "Las cartas de {C:myth_light} Mito{} aparecen",
                    "{C:attention}4 X{} veces mas seguido",
                    "en la tienda",
                },
            },
            v_prism_booster_box = {
                name = "Caja de potenciadores",
                text = {
                    "{C:attention}+1{} paquete potenciador",
                    "disponible en la tienda",
                },
            },
            v_prism_bonus_packs = {
                name = "Paquetes bonus",
                text = {
                    "Puedes elegir",
                    "{C:attention}1{} carta extra en los",
                    "{C:attention}Paquetes potenciadores",
                },
            },

        },
        Tag = {
            tag_prism_myth = {
                name = "Etiqueta de canción",
                text = {
                    "Otorga gratis un",
                    "{C:myth_light}Paquete mítico mega",
                },
            },
              tag_prism_gold_foil = {
                name = "Etiqueta de laminado dorado",
                text = {
                    "El próximo comodín {C:attention}compatible{} de la tienda base",
                    "de la edición base es gratis y",
                    "se vuelve {C:dark_edition}laminado dorado"
                },
            },
        },
         Stake = {
            stake_prism_platinum = {
                name = "Pozo de platino",
                text = {
                    "Todos los precios aumentan",
                    "por {C:money}$1{} cada {C:attention}2 apuestas iniciales"
                }
            }
        },
        Other = {
            p_prism_small_myth_1 = {
                name = "Paquete legendario",
                text = {
                    "Elige {C:attention}#1#{} de hasta",
                    "cartas de {C:attention}#2#{C:myth_light} mito{}",
                },
            },
            p_prism_small_myth_2 = {
                name = "Paquete legendario",
                text = {
                    "Elige {C:attention}#1#{} de hasta",
                    "cartas de {C:attention}#2#{C:myth_light} mito{}",
                },
            },
            p_prism_mid_myth = {
                name = "Paquete legendario jumbo",
                text = {
                    "Elige {C:attention}#1#{} de hasta",
                    "cartas de {C:attention}#2#{C:myth_light} Mito{}",
                },
            },
            p_prism_large_myth = {
                name = "Paquete legendario mega",
                text = {
                   "Elige {C:attention}#1#{} de hasta",
                   "cartas de {C:attention}#2#{C:myth_light} Mito{}",
                },
            },
            prism_green_seal = {
                name = "Sello verde",
                text = {"{C:attention}Ignora{} el límite de selección de cartas",
                    "{C:green}#1# en #2#{} probabilidades de",
                    "destruir esta carta",
                },
            },
            prism_green_old_seal = {
                name = "Sello verde",
                text = {"{C:green}1 en #1#{} probabilidades",
                    "de aparecer en tu mano",
                    "al inicio de una ronda"
                },
            },
            prism_moon_seal = {
                name = "Sello lunar",
                text = {"{C:green}#1# en #2#{} probabilidades de",
                    "aumentar el nivel de la",
                    "{C:attention}mano de poker{} correspondiente cuando es",
                    "jugada y anota"
                },
            },
            card_extra_mult = {
                text={"{C:mult}+#1#{} extra multi"}
            },
            prism_platinum_sticker={
                name="Sticker de platino",
                text={
                    "Usaste este comodín",
                    "para ganar en la dificultad {C:attention}Pozo de",
                    "{C:attention}platino{}",
                },
            },
        },
        Blind = {
            bl_prism_rose_club = {
                name = "Club rosa",
                text = {
                    "Jugar un #1#",
                    "debilita todas las cartas jugadas"
                },
            },
            bl_prism_birch = {
                name = "El abedul",
                text = {
                    "Todas las cartas con categoría par",
                    "se debilitan"
                },
            },
            bl_prism_yew = {
                name = "El tejo",
                text = {
                    "Todas las cartas con categoría impar",
                    "se debilitan"
                },
            }
        },
    },
    misc = {
        challenge_names={
            c_prism_aerial_warfare = "Guerra aérea",
            c_prism_mvp = "MVP",
        },
        dictionary = {
             k_myth = "Carta de mito",
            b_myth_cards = "Cartas de mito",
            k_stone = "Petrificado",
            k_promoted = "Coronado!",
            k_prism_myth_pack = "Paquete legendario",
            k_uno_reverse = "Cambio de sentido",
            k_plus_uncommon = "Inusual",
            k_plus_rare = "Rara",
              k_plus_negative = "Negativo",
            prism_enter_card = "Ingrese una carta",
            prism_invalid_card = "Carta inválida!",
            k_inactive = "inactivo",
            k_inactive_ex = "Inactivo!",
            k_plus_double = "Etiqueta doble",
            k_another_card = "otra carta",
             k_of = "de",
             k_sunset = "Puesta de sol",
            k_sunrise = "Amanecer",
            prism_create = "Haz un deseo",
             prism_cancel = "Cancelar",
            prism_switch = "Switch",
            prism_jokers_enabled = "Activar comodines",
            prism_myth_enabled = "Activar cartas de mito",
            prism_blinds_enabled = "Activas ciegas jefes",
            prism_legacy_green = "Usar antiguo sello verde",
            prism_feature_enable = "Selecciona tus características:",
            prism_pizza_music = "Música de pizza",
            prism_requires_restart = "Requiere un reinicio!",
        },
        v_dictionary = {
            a_handsize_plus="+#1# tamaño de mano",
        },
        labels = {
            prism_green_seal = "Sello verde",
            prism_green_old_seal = "Sello verde",
            prism_moon_seal = "Sello lunar",
            prism_gold_foil = "Laminado dorado"
        }
    }
}

