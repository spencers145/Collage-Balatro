return {
    descriptions = {
        Joker = {
			j_buf_abyssalp = {
				name = "深渊棱镜",
				text = {"{C:attention}获得{}这张小丑牌时",
						"生成一个{C:buf_spc}回响{}并{C:attention}放逐{}所有其他小丑",
						"每三回合为一个小丑添加{C:dark_edition}负片{}",
						"出售此小丑将还原其他小丑",
						"{C:inactive}(#2#/3回合，#1#负片小丑){}",
						"{C:inactive,s:0.7}需要空间{}"
				}
			},
			j_buf_abyssalecho = { -- Special (Abyssal Prism)
				name = "深渊回响",
				text = {"{C:attention}深渊棱镜{}中的",
						"每张小丑牌",
						"给予{C:mult}+#2#{}倍率",
						"{C:inactive}(当前{} {C:mult}+#1#{} {C:inactive}倍率){}",
						"{C:inactive,s:0.6}深渊棱镜被移除时自毁{}"
				},
				unlock = {"获得一张",
						"{C:attention}深渊棱镜",
				}
			},
			j_buf_afan = {
				name = "狂热粉丝",
				text = {"{C:mult}+#1#{}倍率",
						"{C:attention}出售{}时扣除{C:money}$6{}",
						"有{C:green}#2#/#3#{}几率",
						"{C:attention}出售失败{}",
						"{C:buf_spc,s:0.7}对被拒敏感{}"
				}
			},
			j_buf_afan_spc = {
				name = "小黑子",  -- Special (Adoring Fan)
				text = {"每次出牌随机翻转并打乱",
						"所有{C:attention}小丑牌{}或{C:attention}手牌{}",
						"售出时扣除{C:money}$25{}",
						"{C:attention}#1#{}回合之后售价反转",
				},
				unlock = {"满足{C:attention}狂热粉丝",
						"的{E:1,C:buf_spc}特殊{}条件以解锁"
				}  
			},
			j_buf_argument = {
				name = "针锋相对",
				text = {"如果打出的牌中包含{C:attention}两对{}",
						"则将一张不计分的牌",
						"转换为记分牌中的一张"
				}
			},
			j_buf_cashout = {
				name = "支付条码",
				text = {"如果{C:attention}取胜{}的那次出牌得分超过",
					"盲注{C:attention}要求{}的三倍，获得得分0.4%的",
					"{C:money}赏金{}并摧毁这张小丑牌",
					"{C:inactive}(最高{}{C:money}$50{}{C:inactive}){}"
				}
			},
			j_buf_clays_alt = {
				name = "飞碟射击",
				text = {"如果正好出了",
						"{C:attention}#2#{}次牌获胜",
						"回合结束",
						"获得{C:money}$#1#{}",
						"{C:inactive,s:0.7}每回合改变{}"
				}
			},
			j_buf_clays = {
				name = "飞碟射击",
				text = {"如果正好出了",
						"一定次数的牌获胜",
						"回合结束",
						"获得{C:money}$#1#{}",
						"{C:inactive,s:0.7}每回合改变{}"
				}
			},
			j_buf_clown = {
				name = "面具小丑",
				text = {"添加其他小丑牌时",
						"这个小丑获得{C:chips}+#1#{}筹码",
						"{C:inactive}(当前{} {C:chips}+#2#{} {C:inactive}筹码){}",
						"{C:buf_spc,s:0.7}极度自恋{}"
				}
			},
			j_buf_van_alt = {
				name = "货车", -- Special (Clown) [ALT]
				text = {"添加其他小丑牌时",
						"这个小丑获得{C:chips}+#1#{}筹码",
						"{C:inactive}(当前{} {C:chips}+#2#{} {C:inactive}筹码){}",
						"{C:inactive,s:0.7}能装下无限的小丑{}"
				}
			},
			j_buf_van = {
				name = "货车", -- Special (Clown)
				text = {"添加其他小丑牌时",
						"这个小丑获得{C:chips}筹码",
						"数值由车内",
						"{C:attention}小丑{}数量决定",
				},
				unlock = {"满足{C:attention}面具小丑",
						"的{E:1,C:buf_spc}特殊{}条件以解锁"
				}
			},
			j_buf_denial = {
				name = "拒绝入境",
				text = {"牌组中每个{C:red}红色{}和{C:blue}蓝色{}蜡封",
						"分别提供{C:mult}+5{}倍率和{C:chips}+30{}筹码",
						"{C:inactive}(当前{} {C:mult}+#1#{} {C:inactive}倍率 /{} {C:chips}+#2#{} {C:inactive}筹码){}"
				}
			},
			j_buf_dorkshire = {
				name = "呆克郡茶",
				text = {"如果打出的牌是{C:attention}三条{}",
						"所有的{C:attention}2{}、{C:attention}3{}和{C:attention}10{}",
						"在计分前变为{C:attention}瓷器牌{}"
				}
			},
			j_buf_dorkshire_alt = {
				name = "呆克郡茶",
				text = {"如果打出的牌是{C:attention}三条{}",
						"所有的{C:attention}2{}、{C:attention}3{}、{C:attention}10{}、{C:attention}12{}、{C:attention}13{}、{C:attention}21{}和{C:attention}25{}",
						"在计分前变为{C:attention}瓷器牌{}"
				}
			},
			j_buf_dorkshire_g = { -- Special (Dorkshire Tea) 
				name = "呆克郡金茶",
				text = {"如果打出的牌是{C:attention}三条{}",
						"所有的{C:attention}2{}、{C:attention}3{}和{C:attention}10{}",
						"在计分前变为{C:attention}皇家瓷器牌{}"
				},
				unlock = {"以{C:attention}瓷器牌组",
						"和{C:attention}瓷器卡套",
						"开局"
				}
			},
			j_buf_dorkshire_g_alt = { -- Special (Dorkshire Tea) [ALT]
				name = "呆克郡金茶",
				text = {"如果打出的牌型是{C:attention}三条{}",
						"所有的{C:attention}2{}、{C:attention}3{}、{C:attention}10{}、{C:attention}12{}、{C:attention}13{}、{C:attention}21{}和{C:attention}25{}",
						"在计分前变为{C:attention}皇家瓷器牌{}"
				},
				unlock = {"以{C:attention}瓷器牌组",
						"和{C:attention}瓷器卡套",
						"开局"
				}
			},
			j_buf_fivefingers = {
				name = "五指",
				text = {"如果拥有的小丑数",
						"和本次出的牌数",
						"都是{C:attention}5的倍数{}",
						"则{X:mult,C:white}X#1#{}倍率"
				}
			},
			j_buf_gfondue = {
				name = "芝士火锅",
				text = {"回合的{C:attention}第一次出牌{}",
						"获得{C:money}#1#${}",
						"每回合{C:money}-#2#${}"
				}
			},
			j_buf_camarosa = {
				name = "卡麦罗莎",
				text = {"{X:expmult,C:white}^#1#{}倍率",
						"回合结束有{C:green}#2#/#3#{}概率",
						"摧毁这张小丑牌"
				}
			},
			j_buf_kerman = {
				name = "Jebediah Kerman",
				text = {"使用{C:planet}星球牌{}时",
						"获得{C:mult}+#2#{}倍率",
						"但有{C:green}#4#/#3#{}几率{C:attention}爆炸{}",
						"{C:inactive}(当前{} {C:mult}+#1#{} {C:inactive}倍率){}",
						"{C:buf_spc,s:0.7}害怕奇点{}"
				}
			},
			j_buf_kerman_spc = { -- Special (Jebediah Kerman)
				name = "Jebediah 重生",
				text = {"使用{C:planet}星球牌{}时",
						"获得{C:mult}+#2#{}倍率",
						"{C:spectral}黑洞{}给予总倍率的{C:attention}#3#%{}",
						"{C:inactive}(当前{} {C:mult}+#1#{} {C:inactive}倍率){}",
				},
				unlock = {"满足{C:attention}Jebediah Kerman",
						"的{E:1,C:buf_spc}特殊{}条件以解锁"
				}
			},
			j_buf_jokergebra = {
				name = "代数小丑",
				text = {"给予这张小丑牌",
						"{C:attention}左侧{}的小丑牌",
						"{C:mult}倍率{}{C:attention}五倍{}的{C:chips}筹码{}",
						"{C:buf_spc,s:0.7}#1# ×倍率！{}"
				}
			},
			j_buf_integral = { -- Special (JokerGebra)
				name = "积分",
				text = {"每次出牌",
						"这张小丑牌触发之前",
						"计算的每{X:mult,C:white}X1{}乘算倍率",
						"使这张小丑牌给予{X:expchips,C:white}^0.02{}筹码"
				},
				unlock = {"满足{C:attention}代数小丑",
						"的{E:1,C:buf_spc}特殊{}条件以解锁"
				}
			},
			j_buf_korny = {
				name = "科恩小丑",
				text = {"在{C:attention}小盲注{}、{C:attention}大盲注{}",
						"和{C:attention}Boss盲注{}各提供",
						"{C:chips}+#1#{}、{C:chips}+#2#{}和{C:chips}+#3#{}筹码",
						"回合结束有{C:green}未知{}概率自毁",
						"{C:inactive,s:0.7}你不知道概率...{}"
				}
			},
			j_buf_laidback = { 
				name = "悠闲小丑",
				text = {
					"{X:mult,C:white}X#1#{}倍率",
					"占用两个小丑槽",
				}
			},
			j_buf_lemmesolo = { 
				name = "壶头哥",
				text = {"{C:mult}+#1#{}倍率",
					"若拥有其他小丑牌则{C:mult}被削弱{}",
					"当{C:attention}Boss盲注{}被击败时",
					"随机创造#2#张小丑牌",
					"其中至少#3#张为{C:mult}稀有{}",
					"之后自毁"
				},
			},
			j_buf_maggit = { 
				name = "发酒疯",
				text = {"如果拥有{C:dark_edition}新金属{}小丑",
					"{X:expmult,C:white}^#1#{}倍率",
					"否则在选择{C:attention}盲注{}时创造一张",
					"（仅触发{C:attention}一次{}）",
					"{C:inactive,s:0.7}(需要空间){}"
				},
				unlock = {'{E:1,s:1.3}?????'}
			},
			j_buf_maggit_alt = { 
				name = "发酒疯",
				text = {"如果拥有{C:dark_edition}新金属{}小丑",
					"{X:expmult,C:white}^#1#{}倍率",
					"否则在选择{C:attention}盲注{}时创造一张",
					"（仅触发{C:attention}一次{}）",
					"{C:inactive,s:0.7}(已创造){}"
				}
			},
			j_buf_memcard = {
				name = "存储卡",
				text = {"记忆{C:attention}每回合{}的{C:attention}第一张{}计分牌",  
						"至多记忆{C:attention}8{}张。卖掉这张卡",
						"将手牌{C:attention}按顺序{}转换为记忆的牌",
						"{C:inactive}已记忆#1#张。上一张：#2#{}{C:inactive}#3#{}"
				}
			},
			j_buf_dxmemcard = { -- Special (Memory Card)
				name = "扩容存储卡",
				text = {"记忆{C:attention}每回合{}的{C:attention}第一张{}计分牌",  
						"至多记忆{C:attention}16{}张。卖掉这张卡",
						"将手牌{C:attention}按顺序{}转换为记忆的牌",
						"{C:inactive}已记忆#1#张。上一张：#2#{}{C:inactive}#3#{}"
				},
				unlock = {"以{C:attention}JimboStation牌组",
						"和{C:attention}JimboStation卡套",
						"开局"
				}
			},
			j_buf_patronizing = {
				name = "指导癖小丑",
				text = {"{X:chips,C:white}X#1#{}筹码",
						"{C:attention}强制选中{}5张牌",
						"{C:buf_spc,s:0.7}想让你打#2#{}"
				}
			},
			j_buf_supportive = { -- Special (Patronizing Joker)
				name = "支持性小丑", 
				text = {"{X:chips,C:white}X#1#{}筹码",
						"告诉你本回合",
						"牌堆顶的3张牌"
				},
				unlock = {"满足{C:attention}指导癖小丑",
						"的{E:1,C:buf_spc}特殊{}条件以解锁"
				}
			},
			j_buf_supportive_alt = { -- Special (Patronizing Joker)[ALT]
				name = "支持性小丑", 
				text = {"{X:chips,C:white}X#7#{}筹码",
						"{s:0.8}#1##4#{}",
						"{s:0.8}#2##5#{}",
						"{s:0.8}#3##6#{}",
				}
			},
			j_buf_porcelainj = {
				name = "瓷器小丑",
				text = {"你的{C:attention}完整牌组{}中",
						"每有{C:attention}3{}张{C:attention}瓷器牌{}",
						"给予{X:chips,C:white}X#2#{}筹码",
						"{C:inactive}(当前{} {X:chips,C:white}X#1#{} {C:inactive}筹码){}"
				}
			},
			j_buf_rerollin = {
				name = "重（金属）掷",
				text = {"第五次{C:green}重掷{}",          
						"获得{C:money}$#1#{}",
						"每个商店限一次",
						"{C:inactive}(剩余{}{C:green}#3#{}{C:inactive}次){}"
				}
			},
			j_buf_roulette = {
				name = "俄罗斯转盘",
				text = {"选择{C:attention}盲注{}时获得{C:money}$#3#{}",          
						"有{C:green}#1#/#2#{}几率直接{E:1,C:mult}输掉本局游戏{}",
						"如果此几率达到{C:green}1/2{}仍未触发",
						"创造一个随机的{C:legendary}传奇{}小丑",
						"{C:inactive,s:0.7}(每回合概率增加)"
				}
			},
			j_buf_sayajimbo = {
				name = "赛亚小丑",
				text = {"{C:chips}+#1#{}筹码",
						"单次出牌得分",
						"超过{C:attention}#2#{}",
						"即可{C:attention}变身{}",
						"{C:inactive}(下级：{C:mult}+20{C:inactive}倍率)",
				}
			},
			j_buf_sayajimbo_s1 = {
				name = "超级赛亚小丑",
				text = {"{C:mult}+#1#{}倍率",
						"单次出牌得分",
						"超过{C:attention}#6#{}共#5#次",
						"即可{C:attention}变身{}",
						"{C:inactive}(#4#/#5#，下级：{X:mult,C:white}X3{C:inactive}倍率)",
				}
			},
			j_buf_sayajimbo_s2 = {
				name = "超级赛亚小丑2",
				text = {"{X:mult,C:white}X#2#{}倍率",
						"单次出牌得分",
						"超过{C:attention}#6#{}共#5#次",
						"即可{C:attention}变身{}",
						"{C:inactive}(#4#/#5#，下级：{X:expmult,C:white}^1.3{C:inactive}倍率)",
				}
			},
			j_buf_sayajimbo_s3 = {
				name = "超级赛亚小丑3",
				text = {"{X:expmult,C:white}^#3#{}倍率",
						"{C:inactive}看吧！"
				}
			},
			j_buf_tailored = {
				name = "量身定制",
				text = {"给予{X:mult,C:white}X#1#{}倍率乘上",
						"你的{C:attention}完整牌组{}内",
						"占比最高的{C:attention}花色{}的百分比",
						"{C:inactive}(当前#3#,{} {X:mult,C:white}X#2#{} {C:inactive}倍率){}",
				}
			},
			j_buf_whitepony = {
				name = "白马",
				text = {"{C:mult}+#1#{}倍率",
						"每{C:attention}底注{}",
						"翻倍"
				}
			},
			j_buf_blackstallion = { -- Special (White Pony)
				name = "黑马",
				text = {"{C:mult}+#1#{}倍率",
						"每{C:attention}底注{}",
						"翻倍"
				},
				unlock = {"以{C:attention}跃马牌组",
						"开局"
				}
			},
        },
        Back = {
			b_buf_jstation = {
				name = "JimboStation牌组",
				text = {"开局时拥有",
						"{C:red}存储卡{}",
						"{C:attention}+1{}手牌上限"
				}
			},
			b_buf_galloping = {
				name = "跃马牌组",
				text = {"开局时拥有",
						"{C:buf_spc}黑马{}",
				},
				unlock = {"达到",
						  "底注{C:attention}10"
				}
			},
			b_buf_porcelain = {
				name = "瓷器牌组",
				text = {"开局时拥有",
						"{C:red}呆克郡茶{}",
						"并且缺失",
						"一种{C:attention}花色{}"
				}
			},
			b_buf_sandstone = {
				name = "沙石牌组",
				text = {"达到{C:attention}底注6{}",
						"即可获胜",
						"基础盲注大小x2"
				}
			},
        },
        Tarot = {
			c_buf_nobility = {
				name = "贵族",
				text = {
					"增强{C:attention}#1#{}张选定",
					"卡牌成为{C:attention}瓷器牌{}",
					"如果你拥有至少{C:money}$#2#{}",
					"则增强为{C:attention}皇家瓷器牌{}"
				}
			},
        },
        Stake = {
			stake_buf_palladium = {
                name = '钯注',
                text = {
                    '{C:attention}关底{}Boss盲注',
                    '出现频率{C:attention}加倍{}',
					'{s:0.8}之前所有赌注也都起效'
                }
            },
			stake_buf_spinel = {
                name = '尖晶石注',
                text = {
                    '获胜所需{C:attention}底注{}',
					'增加{C:attention}50%',
					'{s:0.8}之前所有赌注也都起效'
                }
            },
        },
        Other = {
		-------- STICKERS --------
			buf_palladium_sticker = {
                name = '钯标贴',
                text= {
                    '使用这张小丑牌',
                    '在{C:attention}钯注',
                    '难度下获胜'
                }
            },
			buf_spinel_sticker = {
                name = '尖晶石标贴',
                text= {
                    '使用这张小丑牌',
                    '在{C:attention}尖晶石注',
                    '难度下获胜'
                }
            },
		-------- INFO QUEUE --------
            korny_info = {
                name = "致谢",
                text = {
                    "美工：",
                    "{C:green}Snakey{}",
                }
            },
			maggit_info = {
				name = "新金属小丑",
				text = {
					"面具小丑，五指",
					"科恩小丑，白马",
					"重（金属）掷"
				}
			},
			special_info = {
				name = "特殊小丑",
				text = {
					"无法通过常规途径获取",
					"仅在{E:1,C:buf_spc}特殊{}情况下",
					"才能获取"
				}
			},
			banish_info = {
				name = "放逐",
				text = {
					"被放逐的小丑",
					"会还原到它们的",
					"{C:attention}基础{}版本"
				}
			},
			porc_info = {
				name = "瓷器牌",
				text = {
						"{X:chips,C:white}X1.75{}筹码",
						"如果打出的牌",
						"超过{C:attention}3{}张", 
						"自毁"
				}
			},
			porcg_info = {
				name = "皇家瓷器牌",
				text = {
						"{X:chips,C:white}X2{}筹码，视为{C:attention}人头牌{}",
						"如果打出的牌",
						"超过{C:attention}3{}张", 
						"自毁"
				}
			},
        },
        Sleeve = {
			sleeve_buf_jstation = {
				name = "JimboStation卡套",
				text = {"开局时拥有",
						"{C:red}存储卡{}",
						"{C:attention}+1{}手牌上限"
				}
			},
			sleeve_buf_jstation_alt = {
				name = "JimboStation卡套",
				text = {"你的{C:red}存储卡{}",
						"是{E:1,C:buf_spc}特殊{}的",
						"{C:attention}+1{}手牌上限"
				}
			},
			sleeve_buf_galloping = {
				name = "跃马卡套",
				text = {"开局时拥有",
						"{C:buf_spc}黑马{}"
				}
			},
			sleeve_buf_galloping_alt = {
				name = "跃马卡套",
				text = {"开局时拥有",
						"{C:green}白马{}",
						"{C:blue}-2{}出牌"
				}
			},
			sleeve_buf_porcelain = {
				name = "瓷器卡套",
				text = {"开局时拥有",
						"{C:red}呆克郡茶{}",
						"并且缺失",
						"一种{C:attention}花色{}"
				}
			},
			sleeve_buf_porcelain_alt = {
				name = "瓷器卡套",
				text = {"开局时拥有",
						"{C:buf_spc}呆克郡金茶{}",
						"并且缺失",
						"一种{C:attention}花色{}"
				}
			},
			sleeve_buf_sandstone = {
				name = "沙石卡套",
				text = {"达到{C:attention}底注6{}",
						"即可获胜",
						"基础盲注大小x2"
				}
			},
			sleeve_buf_sandstone_alt = {
				name = "沙石卡套",
				text = {"达到{C:attention}底注5{}",
						"即可获胜",
						"基础盲注大小x2.5"
				}
			},
        },
		Enhanced = {
			m_buf_porcelain = {
				name = "瓷器牌",
				text = {"{X:chips,C:white}X#1#{}筹码",
						"如果打出的牌",
						"超过{C:attention}#2#{}张", 
						"自毁"
				}
			},
			m_buf_porcelain_g = {
				name = "皇家瓷器牌",
				text = {"{X:chips,C:white}X#1#{}筹码，视为{C:attention}人头牌{}",
						"如果打出的牌",
						"超过{C:attention}#2#{}张", 
						"自毁"
				}
			},
		},
    },
    misc = {
		dictionary = {
			-------- CONFIG --------
			buf_cf_info_info = {
				"具体内容：美工致谢，特殊稀有度",
				"工具提示以及“放逐”机制解释",
				"需要重启生效",
			},
			buf_cf_req_restart = {
				"3个小丑和1个增强",
				"需要重启生效",
			},
			buf_cf_show_spc = "在收藏中显示特殊卡牌",
			buf_cf_show_info = "显示额外工具信息",
			-------- CREDITS --------
			buf_cr_artcode = "美工与编程",
			buf_cr_localization = "本地化",
			buf_cr_sfx = "音效",
			buf_cr_misc = "杂项",
			-------- CARD MESSAGES --------
			buf_korny_ok = "他没事！",
			buf_korny_dd = "死了！",
			buf_prism_eor1 = "折磨...",
			buf_prism_eor2 = "+1负片！",
			buf_prism_sck = "见鬼去吧！",
			buf_memory = "保存！",
			buf_memfull = "空间不足！",
			buf_doubled = "翻倍！",
			buf_convert = "转换！",
			buf_blowup = "轰！",
			buf_ydead = "你死了...",
			buf_dry = "空枪！",	
			buf_afan_annoy1 = "可，可是...",
			buf_afan_annoy2 = "哎，啧...",
			buf_afan_annoy3 = "你确定？",
			buf_afan_annoy4 = "求你了，别！",
			buf_afan_monologue1 = "我本是你的粉丝！",
			buf_afan_monologue2 = "我喜欢过你！",
			buf_afan_monologue3 = "你曾是我的英雄！",
			buf_tea = "茶！",
			buf_gfondue_licked = "舔干净了！",
			buf_hit = "中了！",
			buf_miss = "没中！",
			buf_krakened = "我重生了！",
			buf_supergrade = "超赞升级！",
			buf_disilluison = "幻灭！",
			buf_defeated = "击败！",
			buf_hopin = "上来！",
			buf_patspc = "妙手！",
			-------- MEMCARD STUFF --------
			buf_ready = "就绪",
			buf_Ace = "A",
			buf_Jack = "J",
			buf_Queen = "Q",
			buf_King = "K",
			-- UnStable compat --
			buf_0 = "0",
			['buf_0.5'] = "0.5",
			buf_1 = "1",
			buf_r2 = "√2",
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
			buf_of = " ",
			buf_Spades = "黑桃",
			buf_Hearts = "红桃",
			buf_Clubs = "梅花",
			buf_Diamonds = "方片",
			-- Bunco/Paperback compat --
			buf_Fleurons = "花饰",
			buf_Halberds = "长戟",
			buf_Crowns = "皇冠",
			buf_Stars = "银星",
			-------- MISC --------
			k_buf_spc = "特殊",
			k_buf_notyet = "(需要空间)",
			buf_uniform = "统一",
		},
		v_dictionary = {
			a_buf_emult = "^#1#倍率",
			a_buf_xchips = "X#1#筹码",
			a_buf_echips = "^#1#筹码",
		},
    },
}