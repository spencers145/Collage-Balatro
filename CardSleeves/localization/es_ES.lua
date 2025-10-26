-- Spanish translation by Batolol and Yamper
return {
    descriptions = {
        Mod = {
            CardSleeves = {
                name = "Funda de Cartas",
                text = {
                    "{s:1.3}Añade {s:1.3,C:attention}15{} {s:1.3,E:1,C:dark_edition}Fundas{} {s:1.3}como modificadores de barajas.",
                    " ",
                    "Incluye una API para otros mods",
                    "para añadir sus propias fundas.",
                    " ",
                    "Programación e implementación por {C:blue}Larswijn{}.",
                    "Idea y arte original por {C:red}Sable{}.",
                    " ",
                    "{s:1.1}Vea https://github.com/larswijn/CardSleeves para mas información."
                }
            }
        },
        Sleeve = {
            sleeve_casl_none = {
                name = "Sin funda",
                text = { "Sin modificadores de funda" }
            },

            sleeve_locked = {
                name = "Bloqueada",
                text = {
                    "Gana una partida",
                    "{C:attention}#1#{} en",
                    "al menos {V:1}#2#{}"
                }
            },

            sleeve_casl_red = {
                name = "Funda Roja",
                text = G.localization.descriptions.Back["b_red"].text
            },
            sleeve_casl_red_alt = {
                name = "Funda Roja",
                text = {
                    "{C:red}+#1#{} descarte en cada ronda",
                    "",
                    "{C:blue}#2#{} mano en cada ronda"
                },
            },

            sleeve_casl_blue = {
                name = "Funda Azul",
                text = G.localization.descriptions.Back["b_blue"].text
            },
            sleeve_casl_blue_alt = {
                name = "Funda Azul",
                text = {
                    "{C:blue}+#1#{} mano en cada ronda",
                    "",
                    "{C:red}#2#{} descarte en cada ronda"
                },
            },

            sleeve_casl_yellow = {
                name = "Funda Amarilla",
                text = G.localization.descriptions.Back["b_yellow"].text
            },
            sleeve_casl_yellow_alt = {
                name = "Funda Amarilla",
                text = {
                    "Comienza la partida con el vale",
                    "{C:money,T:v_seed_money}#1#{}"
                },
            },

            sleeve_casl_green = {
                name = "Funda Verde",
                text = G.localization.descriptions.Back["b_green"].text
            },
            sleeve_casl_green_alt = {
                name = "Funda Verde",
                text = {
                    "Adquiere hasta",
                    "{C:red}-$#1#{} en deuda por",
                    "cada mano y descarte ",
                    "{C:inactive}(Currently {C:red}-$#2#{C:inactive})"
                }
            },

            sleeve_casl_black = {
                name = "Funda Negra",
                text = G.localization.descriptions.Back["b_black"].text
            },
            sleeve_casl_black_alt = {
                name = "Funda Negra",
                text = {
                    "{C:attention}+#1#{} Ranura de comodín",
                    "",
                    "{C:red}-#2#{} descartes",
                    "cada ronda"
                }
            },

            sleeve_casl_magic = {
                name = "Funda Mágica",
                text = G.localization.descriptions.Back["b_magic"].text
            },
            sleeve_casl_magic_alt = {
                name = "Funda Mágica",
                text = {
                    "Empieza la partida con",
                    "el vale {C:tarot,T:v_omen_globe}#1#{}",
                }
            },

            sleeve_casl_nebula = {
                name = "Funda Nébula",
                text = G.localization.descriptions.Back["b_nebula"].text
            },
            sleeve_casl_nebula_alt = {
                name = "Funda Nébula",
                text = {
                    "Comienza la partida con el",
                    "vale {C:planet,T:v_observatory}#1#{}",
                    }
            },

            sleeve_casl_ghost = {
                name = "Funda Fastasma",
                text = G.localization.descriptions.Back["b_ghost"].text
            },
            sleeve_casl_ghost_alt = {
                name = "Funda Fastasma",
                text = {
                    "la aparición de cartas {C:spectral}espectrales{}",
                    "en la tienda se dobla,",
                    "{C:spectral}paquetes espectrales{} tienen {C:attention}#1#{}",
                    "opciones extra para elegir",
                }
            },

            sleeve_casl_abandoned = {
                name = "Funda Abandonada",
                text = G.localization.descriptions.Back["b_abandoned"].text
            },
            sleeve_casl_abandoned_alt = {
                name = "Funda Abandonada",
                text = {
                    "Las cartas {C:attention}Figuras{} no",
                    "aparecerán durante la partida"
                }
            },

            sleeve_casl_checkered = {
                name = "Funda Cuadriculada",
                text = G.localization.descriptions.Back["b_checkered"].text
            },
            sleeve_casl_checkered_alt = {
                name = "Funda Cuadriculada",
                text = {
                    "Todas las cartas de {C:clubs}trébol{} serán",
                    "convertidas en {C:spades}pica{} y",
                    "todas las cartas de {C:diamonds}diamante{} serán",
                    "convenridas en {C:hearts}corazón{}",
                }
            },

            sleeve_casl_zodiac = {
                name = "Funda del Zodiaco",
                text = G.localization.descriptions.Back["b_zodiac"].text
            },
            sleeve_casl_zodiac_alt = {
                name = "Funda del Zodiaco",
                text = {
                    "Paquetes de {C:tarot}Tarot{} y {C:planet}Celestial{} tienen",
                    "{C:attention}#1#{} opciones extra para elegir",
                }
            },

            sleeve_casl_painted = {
                name = "Funda Pintada",
                text = G.localization.descriptions.Back["b_painted"].text
            },
            sleeve_casl_painted_alt = {
                name = "Funda Pintada",
                text = {
                    "{C:attention}+#1#{} Límite de selección de carta,",
                    "{C:red}#2#{} Ranuras de comodín",
                }
            },

            sleeve_casl_anaglyph = {
                name = "Funda Anaglifo",
                text = G.localization.descriptions.Back["b_anaglyph"].text
            },
            sleeve_casl_anaglyph_alt = {
                name = "Funda Anaglifo",
                text = {
                    "Despues de derrotar cada",
                    "{C:attention}Ciega Pequeña{} o {C:attention}Ciega Grande{} gana",
                    "1 {C:attention,T:tag_double}#1#"
                }
            },

            sleeve_casl_plasma = {
                name = "Funda Plasmática",
                text = G.localization.descriptions.Back["b_plasma"].text
            },
            sleeve_casl_plasma_alt = {
                name = "Funda Plasmática",
                text = {
                    "Equilibra el {C:money}precio{} de todos los objetos",
                    "en la {C:attention}tienda{}",
                }
            },

            sleeve_casl_erratic = {
                name = "Funda Errática",
                text = G.localization.descriptions.Back["b_erratic"].text
            },
            sleeve_casl_erratic_alt = {
                name = "Funda Errática",
                text = {
                    "La cantidad inicial de {C:blue}Manos{}, {C:red}descartes{},",
                    "{C:money}dinero{}, y {C:attention}ranuras de comodín{}",
                    "seran aleatorizadas entre {C:attention}#1#{} y {C:attention}#2#{}",
                }
            }
        }
    },
    misc = {
        dictionary = {
            k_sleeve = "Funda",
            k_sleeves = "Fundas",
            gald_sleeves = "Seleccionar Funda",
            gald_random_sleeve = "Funda Aleatoria",
            sleeve_unique_effect_desc = "Algunas fundas tienen efectos únicos cuando se combinan con barajas específicas",
            adjust_deck_alignment = "apilar baraja",
            adjust_deck_alignment_desc = {
                "Apilas las cartas en el mazo",
                "mas juntas durante una partida para",
                "preveer que la funda se estire (efecto visual)"
            },
            adjust_deck_alignment_options = {
                "Siempre apilar",
                "Cuando se usa una funda",
                "No apilar"
            },
            allow_any_sleeve_selection = "Desbloquear todas las Fundas",
            allow_any_sleeve_selection_desc = {
                "Permite que cualquier funda sea seleccionada",
                "en el menu de nueva partida, como si fuese desbloqueada"
            },
            sleeve_info_location = "Ubicacion de informacion de funda",
            sleeve_info_location_desc = {
                "En que menu el nombre y descripción",
                "de la funda actualmente usada debería mostrarse",
                "(solo visual)"
            },
            sleeve_info_location_options = {
                "Solo en la vista de baraja",
                "Solo en la información de partida",
                "En ambos",
                "Oculta la informacion de funda"
            },
            sleeve_not_found_error = "La funda no se pudo encontrar! Removiste su mod?"
        },
        v_text = {
            -- for challenges
            ch_m_sleeve = {
                "Empieza con {C:attention}#1#{}"
            }
        }
    }
}
