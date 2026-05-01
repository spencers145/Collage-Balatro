return {
    descriptions = {
        Joker = {
            j_prism_exotic_card = {
                name = "Carte Exotique",
                text = {"Déclenche a nouveau toutes les",
                    "cartes jouées {C:attention}améliorées{}"
                },
            },
            j_prism_razor_blade = {
                name = "Lame de rasoir",
                text = {"{X:mult,C:white} x#1#{} Multi. pour chaque",
                    "{C:attention}valeur{} qui n'est plus présente",
                    "dans votre jeu complet",
                    "{C:inactive}(Actuellement {X:mult,C:white}x#2# {C:inactive} Multi.)"
                },
            },
            j_prism_harlequin = {
                name = "Arlequin",
                text = {"Ce Joker octroie Multi. {X:mult,C:white}x#1#{}",
                    "quand la première carte jouée de",
                    "chaque {C:attention}couleur{} marque des points",
                    "{C:inactive}(Actuellement {X:mult,C:white}x#2#{C:inactive} Multi.)",
                },
                unlock= {
                "{E:1,s:1.3}?????",
                }
            },
            j_prism_rigoletto = {
                name = "Rigoletto",
                text = {"{C:attention}+1{} à la taille de la main dans cette",
                    "manche après {C:attention}jouer{} ou {C:attention}défausser",
                    "{C:inactive}(Actuellement {C:attention}+#2#{C:inactive} à la taille de la main)",
                },
                unlock= {
                "{E:1,s:1.3}?????",
                }
            },
            j_prism_medusa = {
                name = "Gorgone",
                text = {"Toutes les cartes {C:attention}figures{} jouées",
                    "deviennent des cartes {C:attention}Pierres{}",
                    "en marquant des points",
                },
            },
            j_prism_rich_joker = {
                name = "Joker riche",
                text = {"{C:green}#1# chance(s) sur #2#{} de gagner",
                    "{C:money}$#3#{} pour chaque carte {C:attention}vendue{}",
                },
            },
            j_prism_air_balloon = {
                name = "Montgolfière",
                text = {"Ce Joker octroie {C:red}+#2#{}",
                    "Multi. par {C:attention}Haute Carte",
                    "{C:attention}consécutive{} jouée",
                    "{C:inactive}(Actuellement{C:red} +#1#{C:inactive} Multi.)"
                },
            },
            j_prism_ghost = {
                name = "Occultiste",
                text = {"Ce Joker octroie {C:chips}+#1# Jetons{} chaque",
                    "fois qu'une {C:spectral}Carte Spectrale{} est utilisée",
                    "{C:inactive}(Actuellement {C:chips}+#2#{C:inactive} Jetons)",
                },
            },
            j_prism_prism = {
                name = "Prisme",
                text = {"Les cartes {C:attention}numérotées{}",
                    "comptent comme chaque {C:attention}couleur{}"
                },
            },
            j_prism_minstrel = {
                name = "Ménétrier",
                text = {"Crée une carte {C:myth_light}Mythe{} lorsque",
                    "la {C:attention}petite blinde{} ou la {C:attention}grosse{}",
                    "{C:attention}blinde{} est sélectionnée",
                    "{C:inactive}(Selon la place disponible)",
                },
            },
            j_prism_happily = {
                name = "Heureux pour toujours",
                text = {"Crée une carte {C:myth_light}Mythe{} si",
                    "la main jouée contient {C:attention}un Roi{}",
                    "et {C:attention}une Dame{} marquants",
                    "{C:inactive}(Selon la place disponible)",
                },
            },
            j_prism_geo_hammer = {
                name = "Marteau de géologue",
                text = {"Lorsque la {C:attention}Blinde{} est choisie, améliore",
                    "une carte aléatoire dans la main en",
                    "carte {C:attention}Cristal{} ou {C:attention}Pierre{}",
                    "{C:inactive}(Ignore les cartes améliorées)"
                },
            },
            j_prism_vaquero = {
                name = "Vaquero",
                text = {"Les {C:attention}Cartes Sauvages{}",
                    "octroient {X:mult,C:white}x#1#{} Multi.",
                    "lorsqu'elles marquent des points"
                },
            },
            j_prism_promotion = {
                name = "Promotion",
                text = {"Si la {C:attention}première main{} de la manche",
                    "ne contient qu'{C:attention}une{} carte,",
                    "améliorez-la en {C:attention}Dame{}"
                },
            },
            j_prism_sculptor  = {
                name = "Sculpteur",
                text = {"Chaque {C:attention}Carte Pierre{} jouée",
                    "octroie {C:attention}définitivement{} {C:mult}+#1#{} Multi.",
                    "lorsqu'elle marque des points"
                },
            },
            j_prism_motherboard = {
                name = "Carte mère",
                text = {"Lorsqu'une carte est marquée,",
                    "ce Joker octroie {C:chips}+#1#{} Jetons",
                    "s'elle n'a aucune {C:attention}Amélioration{}, ni",
                    "{C:attention}Sceau{} ni {C:dark_edition}Édition{}, {C:chips}-#1#{} Jetons sinon",
                    "{C:inactive}(Actuellement {C:chips}+#2#{C:inactive} Jetons)",
                },
            },
            j_prism_reverse_card = {
                name = "Carte inversion",
                text = {"Échangez les {C:chips}Jetons{}",
                    "et {C:mult}Multi.{} actuels"
                },
            },
            j_prism_vip_pass = {
                name = "Passe VIP",
                text = {"Les {C:attention}Jokers{} {C:chips}Communs{}",
                "ne peuvent pas apparaître",
                },
            },
            j_prism_plasma_lamp = {
                name = "Lampe à plasma",
                text = {"Équilibre {C:chips}Jetons{} et",
                    "{C:mult}Multi.{} si la {C:attention}main de poker",
                    "est {C:attention}#1#{}",
                    "ou {C:attention}#2#{}",
                    "{s:0.8}La main de poker change chaque",
                    "{s:0.8}manche et après chaque déclenchement"
                },
            },
            j_prism_hopscotch = {
                name = "Marelle",
                text = {"Lorsqu'un.e {C:attention}#3#{} joué.e",
                    "est marqué.e, ce Joker octroie",
                    "{C:red}+#1# Multi.{} et la valeur",
                    "nécessaire s'augmente de {C:attention}1",
                    "{C:inactive}(Actuellement {C:red}+#2#{C:inactive} Multi.)",
                },
            },
            j_prism_amethyst = {
                name = "Améthyste",
                text = {"Ce Joker octroie {X:mult,C:white}x#2#{} Multi.",
                    "pour chaque {C:attention}Carte Cristal{} tenue",
                    "en main à la fin de la manche",
                    "{C:inactive}(Actuellement {X:mult,C:white}x#1# {C:inactive} Multi.)",
                },
            },
            j_prism_aces_high = {
                name = "Vierge de fer",
                text = {"Crée un {C:green}Badge peu",
                    "{C:green}commun{} ou un {C:rare}Badge rare{}",
                    "si la main de poker contient",
                    "un {C:attention}As{} et une {C:attention}Suite",
                },
            },
            j_prism_elf = {
                name = "Elfe",
                text = {"{X:mult,C:white}x#1#{} Multi. si une {C:myth_light}Carte{}",
                    "{C:myth_light}Mythe{} est utilisée depuis",
                    "la fin de {C:attention}la dernière manche",
                },
            },
            j_prism_cookie = {
                name = "Biscuit chinois",
                text = {"Vendez cette carte pour {C:attention}garantir{}",
                    "toutes les {C:green}probabilités{}",
                    "pour cette manche",
                },
            },
            j_prism_pie = {
                name = "math.pie",
                text = {"Lorsqu'un {C:attention}#1#{} joué marque des",
                    "points, il octroie {X:mult,C:white}x#2#{} Multi. et",
                    "la {C:attention}valeur{} nécessaire change",
                    "au prochain chiffre de {C:attention}Pi",
                    "{C:inactive}(Les 5 prochains chiffres sont: #3#)",
                    "{C:inactive}(1 = As, 0 = 10)",
                },
            },
            j_prism_polydactyly = {
                name = "Polydactylie",
                text = {"Peut jouer et défausser",
                    "jusqu'à {C:attention}6{} cartes",
                },
            },
            j_prism_solo_joker = {
                name = "Aviateur solitaire",
                text = {"Si la main jouée ne",
                    "contient qu'{C:attention}une{} carte,",
                    "déclenchez-la à nouveau {C:attention}#1#{} fois"
                },
            },
            j_prism_economics = {
                name = "L'Économie B-A-ba",
                text = {"Lorsqu'une {C:attention}Blinde{} est sélectionnée,",
                    "perdez tout votre argent et ce Joker",
                    "octroie {X:mult,C:white}x#1#{} Multi. pour chaque {C:money}$#2#{} perdu",
                    "{C:inactive}(Actuellement {X:mult,C:white}X#3#{C:inactive} Multi.)"
                },
            },
            j_prism_whiskey = {
                name = "Bourbon",
                text = {"Crée un {C:attention}Badge double{} après que",
                    "{C:attention}#1# Valets{} marquent des points",
                    "{C:inactive}(Actuallement {C:attention}#2#{C:inactive}/#1#)",
                    "{C:inactive}(Seulement une fois par manche)"
                },
            },
            j_prism_hit_record = {
                name = "Tube",
                text = {"Les cartes jouées",
                    "{C:attention}reviennent{} au jeu",
                    "après être marquées"
                },
            },
            j_prism_patch = {
                name = "Écusson en fer",
                text = {"Crée un {C:dark_edition}Badge négatif",
                    "si la main jouée contient",
                    "exactement {C:attention}3 6s{} marquants",
                },
            },
            j_prism_day = {
                name = "Journée",
                text = {"Si la main jouée contient seulement",
                    "{C:hearts}Cœurs{} ou {C:diamonds}Carreaux{}, déclenchez à",
                    "nouveau toutes les cartes jouées",
                    "et {C:attention}le crépuscule du soir{} se passe"
                },
            },
            j_prism_night = {
                name = "Nuit",
                text = {"Si la main jouée contient seulement",
                    "{C:clubs}Trèfles{} ou {C:spades}Piques{}, déclenchez à",
                    "nouveau toutes les cartes jouées",
                    "et {C:attention}le soleil cruel frappe{}"
                },
            },
            j_prism_metalhead = {
                name = "Métalleux",
                text = {"{C:attention}Les cartes Pierres{} sont aussi",
                    "considérées comme les {C:attention}cartes Acier"
                },
            },
            j_prism_shork = {
                name = "Requine mignonne",
                text = {"Toutes les {C:spectral}Éditions{} futures",
                    "deviennent {C:dark_edition}Polychrome"
                },
            },
            j_prism_schrodinger = {
                name = "Le chat de Schrödinger",
                text = {"Retrigger each played",
                    "{C:attention}Double Card{} once for each",
                    "consecutive {C:attention}Double Card{}",
                    "scored this hand"
                },
            },
            j_prism_hypercube = {
                name = "Hypercube",
                text = {"{X:dark_edition,C:white}^#1#{} Multi. si un",
                    "{C:attention}Carré{} reste en main",
                },
            },
            j_prism_pizza_cap = {
                name = "Pizza Capricciosa",
                text = {"Les prochains {C:attention}#2#{} {C:spades}Piques{}",
                    "joués octroient {C:chips}+#1#{} Jetons",
                    "en marquant des points",
                    "{s:0.8} Promeut les pizzas futures",

                },
            },
            j_prism_pizza_mar = {
                name = "Pizza Margherita",
                text = {"Les prochains {C:attention}#2#{} {C:hearts}Cœurs{}",
                    "joués octroient {X:red,C:white}x#1#{} Multi.",
                    "en marquant des points",
                    "{s:0.8} Promeut les pizzas futures",
                },
            },
            j_prism_pizza_for = {
                name = "Pizza Quattro Formaggi",
                text = {"Les prochains {C:attention}#2#{} {C:diamonds}Carreaux{}",
                    "joués ont {C:green}#3# sur #4# chance(s){} de",
                    "gagner {C:money}$#1#{} en marquant des points",
                    "{s:0.8} Promeut les pizzas futures",

                },
            },
            j_prism_pizza_ruc = {
                name = "Pizza Rucola",
                text = {"Les prochains {C:attention}#2#{} {C:clubs}Trèfles{}",
                    "joués octroient {C:red}+#1#{} Multi.",
                    "en marquant des points",
                    "{s:0.8} Promeut les pizzas futures",
                },
            },
            j_prism_pizza_haw = {
                name = "Pizza hawaïenne",
                text = {"Les prochaines {C:attention}#3#{} {C:paperback_crowns}Couronnes{}",
                    "jouées octroient entre {C:money}$#1#{}",
                    "et {C:money}$#2#{} en marquant des points",
                    "{s:0.8} Promeut les pizzas futures",
                },
            },
            j_prism_pizza_det = {
                name = "Pizza de Detroit",
                text = {"Les prochaines {C:attention}#2#{} {C:paperback_stars}Étoiles{}",
                    "jouées donnent {X:chips,C:white}x#1#{} Jetons",
                    "en marquant des points",
                    "{s:0.8} Promeut les pizzas futures",
                },
            },
            j_prism_pizza_con = {
                name = "Pizza en cornet",
                text = {"Les prochains {C:attention}#2#{} {C:minty_3s}3s{} joués",
                    "ont {C:green}#3# sur #4# chance(s){} de gagner",
                    "{X:red,C:white}x#1#{} Multi.",
                    "en marquant des points",
                    "{s:0.8} Promeut les pizzas futures",
                },
            },
            j_prism_murano = {
                name = "Joker de Murano",
                text = {"Les {C:attention}Cartes Verres{} jouées ont",
                    "{C:green}#1# chance(s) sur #2#{} d'obtenir ",
                    "{C:dark_edition}Brillant{}, {C:dark_edition}Holographique{} ou {C:dark_edition}Polychrome{}",
                },
            },
            j_prism_romantic = {
                name = "Guerrier romantique",
                text = {"Crée la {C:attention}dernière{} {C:myth_light}Carte{}",
                    "{C:myth_light}Mythe{} utilisée dans cette",
                    "partie si la main jouée contient",
                    "un {C:hearts}Cœur{} et {C:spades}Pique{} marquants",
                },
            },
            j_prism_swiss = {
                name = "Couteau suisse",
                text = {"{C:green}#4# chance(s) sur #5#{} d'ajouter",
                "définitivement {C:chips}+#1#{} Jetons, {C:mult}+#2#{} Multi.",
                "ou {X:red,C:white}x#3#{} Multi. {C:attention}au hasard{} à cartes",
                "jouées en marquant des points"
                },
            },
            j_prism_racecar = {
                name = "Voiture de course",
                text = {"Ce Joker octroie {C:chips}+#1#{} Jetons",
                "et {C:red}+#2#{} Multi. pour chaque {C:attention}main{}",
                "{C:attention}inutilisé{} à la fin de la manche",
                "{C:inactive}(Actuellement {C:chips}+#3#{C:inactive} Jetons et {C:red}+#4#{C:inactive} Multi.)"
                },
            },
            j_prism_floppy = {
                name = "Disquette",
                text = {"Vendez cette carte pour",
                    "{C:attention}dupliquer{} les cartes dans la",
                    "{C:attention}dernière main{} jouée pendant que",
                    "vous avez ce Joker à la {C:attention}main"
                },
            },
            j_prism_whale = {
                name = "Vol interplanétaire",
                text = {"Quand la {C:attention}Blinde Boss{} est battue,",
                    "augmente le niveau de votre {C:attention}main{}",
                    "{C:attention}de poker{} la plus jouée par {C:planet}planète",
                    "{C:attention}unique{} utilisée dans cette mise",
                    "{C:inactive}(Actuellement {C:attention}#1#{C:inactive} planètes jouées)"
                },
            },
	    j_prism_monkey_paw = {
                name = "Patte de Singe",
                text = {"Après avoir battu {C:attention}la Blinde Boss{},",
                    "souhaitez créer {C:dark_edition}n'importe quelle{}",
                    "{C:spectral}Carte Spectrale{}",
		    "Taille de la main {C:red}-#1#{} {C:attention}irréparablement{}",
                    "{C:inactive}(Selon la place disponible)"
                },
            },
            j_prism_scale = {
                name = "Balance",
                text = {"{C:chips}+#1#{} Jetons par Joker à {C:attention}droite",
                    "{C:red}+#2#{} Multi. par Joker à {C:attention}gauche",
                    "{C:inactive}(Actuellement {C:chips}+#3#{C:inactive}Jetons et {C:red}+#4#{C:inactive} Multi.)"
                },
            },
        },
        Back = {
            b_prism_purple = {
                name = "Jeu Violet",
                text = {"Vous pouvez utiliser les {C:chips}Mains{} et",
                    "les {C:red}Défaussses{} de façon interchangeable",
                    "{C:inactive}(Vous pouvez défausser avec les mains s'il",
                    "{C:inactive}n'y a pas de défausses et vice versa)"
                },
            },
            b_prism_ancient = {
                name = "Jeu Antique",
                text = {"Commencez la partie avec",
                    "{C:myth_light,T:v_prism_myth_merchant}Marchand de cartes Mythe{}",
                    "et {C:attention,T:v_prism_booster_box}Coupon de display{}"
                },
            },
            b_prism_market = {
                name = "Jeu de Surproduction",
                text = {"Commencez la partie",
                    "avec {C:attention,T:v_overstock_norm}Excédent{} et",
                    "{C:attention,T:v_reroll_surplus}Renouvellement en pagaille{}"
                },
            },
	    b_prism_alchemy = {
                name = "Jeu d'Alchimiste",
                text = {"Chaque {C:money}magasin{} contient un",
                    "{C:myth_light,T:c_prism_myth_opus}Grand Œuvre{} {C:attention}supplémentaire{}",
                },
            },
        },
        Sleeve = {
            sleeve_prism_purplesleeve = {
                name = "Chemise Violette",
                text = {"Vous pouvez utiliser les {C:chips}Mains{} et",
                    "les {C:red}Défaussses{} de façon interchangeable",
                    "{C:inactive}(Vous pouvez défausser avec les mains s'il",
                    "{C:inactive}n'y a pas de défausses et vice versa)"
                },
            },
            sleeve_prism_purplesleeve_alt = {
                name = "Chemise Violette",
                text = {"{C:attention}+1{} à la taille de la main",
                },
            },
            sleeve_prism_ancientsleeve = {
                name = "Chemise Antique",
                text = {"Commencez la partie avec",
                    "{C:myth_light,T:v_prism_myth_merchant}Marchand de cartes Mythe{} et",
                    "{C:attention,T:v_prism_booster_box}Coupon de display{}"
                },
            },
            sleeve_prism_ancientsleeve_alt = {
                name = "Chemise Antique",
                text = {"Le magasin contient toujours",
                    "un {C:myth_light}Paquet Légende"
                },
            },
            sleeve_prism_marketsleeve = {
                name = "Chemise de Surproduction",
                text = {"Commencez la partie avec",
                    "{C:attention,T:v_overstock_norm}Excédent{} et",
                    "{C:attention,T:v_reroll_surplus}Renouvellement en pagaille{}"
                },
            },
            sleeve_prism_marketsleeve_alt = {
                name = "Chemise de Surproduction",
                text = {"Commencez la partie avec",
                    "{C:attention,T:v_prism_booster_box}Coupon de display{}"
                },
            },
            sleeve_prism_alchemysleeve = {
                name = "Chemise d'Alchimiste",
                text = {"Chaque {C:money}magasin{} contient un",
                    "{C:myth_light,T:c_prism_myth_opus}Grand Œuvre{} {C:attention}supplémentaire{}",
                },
            },
            sleeve_prism_alchemysleeve_alt = {
                name = "Chemise d'Alchimiste",
                text = {"Commencez la partie avec",
                    "{C:tarot,T:v_crystal_ball}Boule de cristal{}"
                },
            },
        },
        Enhanced = {
            m_prism_crystal = {
                name = "Carte Cristal",
                text = {"{X:mult,C:white} x#1#{} Multi.",
                    "Ce carte octroie Multi. {X:mult,C:white} x#2#{} si cette carte",
                    "reste en main à la fin de la manche"
                }

            },
            m_prism_burnt = {
                name = "Carte Brûlée",
                text = {"Tirez {C:attention}#1#{} plus de",
                    "cartes lorsque cette",
                    "carte est {C:attention}défaussée"
                }
            },
            m_prism_ice = {
                name = "Carte Glace",
                text = {"{C:chips}+#1#{} Jetons par carte",
                    "jouée dans cette manche",
                    "{C:inactive}(Actuellement {C:chips}+#2#{C:inactive})"
                }
            },
            m_prism_double = {
                name = "Double Card",
                text = {"Can turn into",
                    "{C:attention}#1#{}"
                }
            },
            m_prism_echo = {
                name = "Carte Écho",
                text = {"Déclenchez à nouveau cette",
                    "carte pour chaque autre",
                    "{C:attention}Carte Écho{} jouée"
                }
            },
        },
        Edition = {
            e_prism_gold_foil = {
                name = "Brillante d'Or",
                text = {
                    "Déclenche {C:attention}deux fois{}"
                }
            }
        },
        Myth = {
            c_prism_myth_druid = {
                name = "Druide",
                text = {"Sélectionnez {C:attention}#1#{} cartes,",
                    "ajoute l'{C:enhanced}Amélioration{}, l'{C:dark_edition}Édition{}",
                    "et le {C:attention}Sceau{} de la carte de",
                    "{C:attention}droite{} à la carte de {C:attention}gauche{}"
                }

            },
            c_prism_myth_dwarf = {
                name = "Nain",
                text = {"Améliore {C:attention}#1#{}",
                    "cartes sélectionnées",
                    "en {C:attention}Cartes Cristal"
                }
            },
            c_prism_myth_siren = {
                name = "Sirène",
                text = {"Améliore {C:attention}#1#{}",
                    "cartes sélectionnées",
                    "en {C:attention}Cartes Écho"
                }
            },
            c_prism_myth_yeti = {
                name = "Yéti",
                text = {"Améliore {C:attention}#1#{}",
                    "cartes sélectionnées",
                    "en {C:attention}Cartes Glace"
                }
            },
            c_prism_myth_dragon = {
                name = "Le Dragon !",
                text = {"Améliore {C:attention}#1#{}",
                    "cartes sélectionnées",
                    "en {C:attention}Cartes Brûlées"
                }
            },
            c_prism_myth_ghoul = {
                name = "Goule",
                text={
                    "Détruit {C:attention}#1#{} carte sélectionée",
                    "et ajoute {C:attention}#2# fois",
                    "sa valeur aux {C:chips}Jetons",
                    "des cartes adjacentes"
                },
            },
            c_prism_myth_wizard = {
                name = "Sorcière",
                text = {"Convertit jusqu'à {C:attention}#1#{}",
                    "cartes sélectionnées à la",
                    "{C:attention}valeur{} de la carte de {C:attention}droite{}"
                }
            },
            c_prism_myth_gnome = {
                name = "Gnome",
                text = {"Crée un {C:attention}Badge d'épargne"
                }
            },
            c_prism_myth_mirror = {
                name = "Miroir",
                text = {"Ajoute {C:dark_edition}Negatif{}",
                    "à {C:attention}1{} carte",
                    "aléatoire dans la main"
                }
            },
            c_prism_myth_colossus = {
                name = "Colosse",
                text = {"Ajoute un {C:moon}Sceau de lune{}",
                    "à {C:attention}#1#{} carte",
                    "sélectionnée dans la main"
                }
            },
            c_prism_myth_beast = {
                name = "Beste Glatisant",
                text = {"Crée une carte",
                    "{C:spectral}Spectrale{} aléatoire",
                    "{C:inactive}(Selon la place disponible)"
                }
            },
            c_prism_myth_ooze = {
                name = "Vase",
                text = {"Ajoute un {C:green}Sceau vert{}",
                    "à {C:attention}#1#{} carte",
                    "sélectionnée dans la main"
                }
            },
            c_prism_myth_roc = {
                name = "Rokh",
                text = {"Crée un {C:attention}Badge double"
                }
            },
            c_prism_myth_kraken = {
                name = "Kraken",
                text = {"Crée un {C:attention}Badge de jongleur"
                }
            },
            c_prism_myth_treant = {
                name = "Tréant",
                text = {"Convertit jusqu'à {C:attention}#1#{}",
                    "cartes sélectionnées à la",
                    "{C:attention}couleur{} de la carte de {C:attention}droite{}"
                }
            },
	    c_prism_myth_fae = {
                name = "Fée",
                text = {"Gagnez {C:money}$#1#{} par niveau",
                    "de la {C:attention}main de poker{}",
                    "le plus haut {C:inactive}({}{C:money}$#2#{C:inactive} au maximum){}",
                    "{C:inactive}(Actuellement {C:money}$#3#{C:inactive})",
                }
            },
            c_prism_myth_opus = {
                name = "Grand Œuvre",
                text = {"Améliore {C:attention}#1#{} carte",
                    "selectionée à l'{C:enhanced}Amélioration{}",
                    "{C:attention}le plus fréquent{} dans votre jeu complet"
                }
            },
            c_prism_myth_egg = {
                name = "Œuf d'Or", 
                text = {"Perdez {C:money}$#3#{} et",
                    "{C:green}#1# chance(s) sur #2#{}",
                    "d'ajouter édition {C:dark_edition}Brillante d'Or{}",
                    "à un {C:attention}Joker au hasard{}",
                    "{C:inactive}(Selon la compatibilité)"
                    
                }
            },
        },
        Spectral = {
            c_prism_spectral_djinn = {
                name = "Djinni",
                text = {"Souhaitez créer",
                    "{C:dark_edition}n'importe quel{} {C:attention}Joker{}",
                    "{C:inactive}(Jokers Légendaires",
                    "{C:inactive}exclus)"
                }
            },
        },
        Voucher = {
            v_prism_myth_merchant = {
                name = "Marchand de cartes Mythe",
                text = {
                    "Les cartes {C:myth_light}Mythe{} apparaissent",
                    "{C:attention}2x{} plus fréquemment",
                    "dans le magasin"
                },
            },
            v_prism_myth_tycoon = {
                name = "Magnat de cartes Mythe",
                text = {
                    "Les cartes {C:myth_light}Mythe{} apparaissent",
                    "{C:attention}4x{} plus fréquemment",
                    "dans le magasin"
                },
            },
            v_prism_booster_box = {
                name = "Coupon de display",
                text = {
                    "{C:attention}+1{} emplacement de paquet",
                    "disponible dans le magasin"
                },
            },
            v_prism_bonus_packs = {
                name = "Embarras du choix",
                text = {
                    "Vous pouvez choisir {C:attention}1{}",
                    "carte supplémentaire des",
                    "{C:attention}Paquets Booster",
                },
            },

        },
        Tag = {
            tag_prism_myth = {
                name = "Badge Chanson",
                text = {
                    "Octroie un",
                    "{C:myth_light}Paquet Méga-Légende",
                },
            },
            tag_prism_gold_foil = {
                name = "Badge brillant d'or",
                text = {
                    "Le prochain Joker en édition de base",
                    "{C:attention}compatible{} du magasin sera gratuit",
                    "et obtiendra le statut {C:dark_edition}Brillant d'or"
                },
            },
            tag_prism_gnome = {
                name = "Badge d'épargne",
                text={
                    "Après avoir battu",
                    "la Blinde Boss,",
                    "gagnez {C:money}$#1#",
                },
            },
        },
        Stake = {
            stake_prism_platinum = {
                name = "Mise de platine",
                text = {
                    "Toutes les prix s'augmentent",
                    "de {C:money}$1{} toutes les {C:attention}2 mises",
                    "{s:0.8}Applique toutes les mises précédentes"
                }
            }
        },
        Partner={
            pnr_prism_blahaj={
                name = "Blåhaj :3",
                text = {"Crée un {C:dark_edition,T:tag_foil}Badge brillant",
                    "{C:dark_edition,T:tag_holo}Badge holographique{} ou",
                    "{C:dark_edition,T:tag_polychrome}Badge polychrome{} après",
                    "avoir battu la {C:attention}Blinde Boss",
                },
                unlock={
                    "Utilisez {C:attention}Requine mignonne",
                    "pour gagner la difficulté",
                    "{C:attention}Mise d'Or{}",
                },
            },
            pnr_prism_blahaj_1={
                name = "Blåhaj",
                text = {"Crée un {C:dark_edition,T:tag_foil}Badge brillant",
                    "{C:dark_edition,T:tag_holo}Badge holographique{} ou",
                    "{C:dark_edition,T:tag_polychrome}Badge polychrome{} après",
                    "avoir battu une {C:attention}Blinde",
                },
                unlock={
                    "Utilisez {C:attention}Requine mignonne",
                    "pour gagner la difficulté",
                    "{C:attention}Mise d'Or{}",
                },
            },
            pnr_prism_scopa={
                name = "Scopa",
                text = {"Les cartes {C:attention}améliorées{}",
                    "jouées octroient {C:red}+#1#{} Multi.",
                    "en marquant des points"
                },
                unlock={
                    "Utilisez {C:attention}Carte Exotique",
                    "pour gagner la difficulté",
                    "{C:attention}Mise d'Or{}",
                },
            },
        },
        Other = {
            p_prism_small_myth_1 = {
                name = "Paquet Légende",
                text = {
                    "Choisssez {C:attention}#1#{} parmi",
                    "{C:attention}#2# cartes de{}{C:myth_light} Mythe{}",
                },
            },
            p_prism_small_myth_2 = {
                name = "Paquet Légende",
                text = {
                    "Choisssez {C:attention}#1#{} parmi",
                    "{C:attention}#2# cartes de{}{C:myth_light} Mythe{}",
                },
            },
            p_prism_mid_myth = {
                name = "Paquet Jumbo Légende",
                text = {
                    "Choisssez {C:attention}#1#{} parmi",
                    "{C:attention}#2# cartes de{}{C:myth_light} Mythe{}",
                },
            },
            p_prism_large_myth = {
                name = "Paquet Méga-Légende",
                text = {
                    "Choisssez {C:attention}#1#{} parmi",
                    "{C:attention}#2# cartes de{}{C:myth_light} Mythe{}",
                },
            },
            prism_green_seal = {
                name = "Sceau vert",
                text = {"{C:attention}Retournez{} à la main après",
                    "être jouée pour la {C:attention}première",
                    "{C:attention}fois{} chaque manche"
                }, 
            },
            prism_green_old_seal = {
                name = "Sceau vert",
                text = {"{C:green}1 chance(s) sur 2{}",
                    "d'être tirée dans la",
                    "première main de la manche"
                },
            },
            prism_moon_seal = {
                name = "Sceau de lune",
                text = {"{C:green}#1# chance(s) sur #2#{}",
                    "d'augmenter le niveau de la",
                    "{C:attention}main de poker{} jouée lorsque cette",
                    "carte est jouée et marque des points"
                },
            },

            prism_platinum_sticker={
                name="Autocollant de platine",
                text={
                    "Joker utilisé pour",
                    "gagner en difficulté",
                    "{C:attention}Mise de platine{}",
                },
            },
            undiscovered_myth = {
                name = 'Non découvert',
                text = {
                    'Achetez ou utilisez cette',
                    'carte dans un partie sans',
                    'seed pour connaître son effet',
                }
            },
            remove_negative={
                name="n",
                text={
                    "{C:inactive,s:0.9}(Supprime {C:dark_edition,s:0.9}Négative{C:inactive,s:0.9} et {C:dark_edition,s:0.9}Brillante d'Or{C:inactive,s:0.9} de la copie)",
                },
            },
        },
        Blind = {
            bl_prism_rose_club = {
                name = "Massue Rose",
                text = {
                    "Si vous jouez #1#, toutes les",
                    "cartes jouées perdent leurs bonus"
                },
            },
            bl_prism_birch = {
                name = "Le bouleau",
                text = {
                    "Toutes les cartes de",
                    "valeur paire perdent leurs bonus"
                },
            },
            bl_prism_yew = {
                name = "L'if",
                text = {
                    "Toutes les cartes de",
                    "valeur impaire perdent leurs bonus"
                },
            }
        },
    },
    misc = {
        challenge_names={
            c_prism_aerial_warfare = "Guerre aérienne",
            c_prism_mvp = "Meilleure joueuse",
        },
        dictionary = {
            k_myth = "Carte de mythe",
            b_myth_cards = "Cartes de mythe",
            k_stone_ex = "Pétrifié !",
            k_edition_ex = "Édition",
            k_promoted = "Promu !",
            k_prism_myth_pack = "Paquet légende",
            k_uno_reverse = "Inversion",
            k_plus_uncommon = "Peu commun",
            k_plus_rare = "Rare",
            k_plus_double = "Badge double",
            k_plus_negative = "Negatif",
            k_inactive = "inactif",
            k_inactive_ex = "Inactif !",
            k_another_card = "une autre carte",
            k_of = "de",
            k_sunset = "Crépuscule",
            k_sunrise = "Aube",
            k_blahaj = "Badge :3c",
            prism_create = "Votre vœu",
            prism_cancel = "Annuler",
            prism_enter_card = "Entrer Carte",
            prism_invalid_card = "Carte Nulle !",
            prism_jokers_enabled = "Activer Jokers",
            prism_myth_enabled = "Activer Cartes Mythe",
            prism_blinds_enabled = "Activer les Blindes Boss",
            prism_legacy_green = "Utiliser Sceau Vert Vieux",
            prism_feature_enable = "Selectionner les options :",
            prism_pizza_music = "Musique de Pizza",
            prism_requires_restart = "Nécessaire de redémarrer !",
            b_open_link = "S'ouvre dans le navigateur",
        },
        v_dictionary = {
            a_handsize_plus="+#1# à la taille",
            a_prism_chips="+#1# Jetons",
            a_prism_chips_minus="-#1# Jetons",
        },
        labels = {
            prism_green_seal = "Sceau vert",
            prism_green_old_seal = "Sceau vert",
            prism_moon_seal = "Sceau de lune",
            prism_gold_foil = "Brillante d'Or"
        },
        quips = {
            --blahaj
            pnr_prism_blahaj_1={
                "On peut l'faire,",
                "amie :3"
            },
            pnr_prism_blahaj_2={
                "aouizaoui cette mise",
                "est si gros!! Mais, on peut",
                "le faire ensemble!!!! :3"
            },
            pnr_prism_blahaj_3={
                ">33: bonne chance"
            },

            --scopa
            pnr_prism_scopa_1={
                "Ce compare, che",
                "so' ste carte?!"
            },
            pnr_prism_scopa_2={
                "Briscola a mazze",
                "per sta partita"
            },
            pnr_prism_scopa_3={
                "Ce l'hai un",
                "carico? Se no",
                "va di liscio qui!"
            },
            pnr_prism_scopa_4={
                "Questa e vinta,",
                "ch'abbiamo il settoro"
            },
        }
    },
}

