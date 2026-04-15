loc_colour()
G.ARGS.LOC_COLOURS.cmykl_c = HEX('14cff5')
G.ARGS.LOC_COLOURS.cmykl_m = HEX('f714d5')
G.ARGS.LOC_COLOURS.cmykl_y = HEX('ffda08')

cmykl.comy_quips_win = {
  "AIN'T NO DAMN WAY!",
  "Hooray. Now that's 5 dollars for the cameo.",
  "such a shame...",
  "how dare you actually win?!",
  "\"Time to go Endless?\" No, you're not getting naneinf on this.",
  "I'm getting you next time!",
  "my stickers..."
}

cmykl.comy_quips_lost = {
  "LMAO!!!! :joy::joy::joy:",
  "well that stinks.",
  "that's enough gambling for today.",
  "HAHAHAHAHAHAHAHAHAHAHADAIFHSIUBFSURGOGNKSHIF!!!",
  "ez ez ez",
  "I used to pray for times like this...",
  "you suck!"
}

for i = 1, #cmykl.comy_quips_win do
  SMODS.JimboQuip({
    key = "comy_quips_win_" .. i,
    type = "win",
    weight = math.huge,
    extra = {
      center = "j_cmykl_comykel",
	  particle_colours = { -- table of up to 3 colours for particles
		G.ARGS.LOC_COLOURS.cmykl_c,
		G.ARGS.LOC_COLOURS.cmykl_m,
		G.ARGS.LOC_COLOURS.cmykl_y
	},
	materialize_colours = { -- table of up to 3 colours for materialize effect
		G.ARGS.LOC_COLOURS.cmykl_c,
		G.ARGS.LOC_COLOURS.cmykl_m,
		G.ARGS.LOC_COLOURS.cmykl_y
	},
  times = 7,
  pitch = 1,
    }
  })
end
  
for i = 1, #cmykl.comy_quips_lost do
  SMODS.JimboQuip({
    key = "comy_quips_loss_" .. i,
    type = "loss",
    weight = math.huge,
    extra = {
      center = "j_cmykl_comykel",
	  particle_colours = { -- table of up to 3 colours for particles
		G.ARGS.LOC_COLOURS.cmykl_c,
		G.ARGS.LOC_COLOURS.cmykl_m,
		G.ARGS.LOC_COLOURS.cmykl_y
	},
	materialize_colours = { -- table of up to 3 colours for materialize effect
		G.ARGS.LOC_COLOURS.cmykl_c,
		G.ARGS.LOC_COLOURS.cmykl_m,
		G.ARGS.LOC_COLOURS.cmykl_y
	},
  times = 7,
  pitch = 1,
    }
  })
end
