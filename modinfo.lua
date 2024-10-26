name = "Chat Text Background"
description = "Adds a transparent dark background behind chat text for better readability."
author = "gibberish"
version = "2.0"
api_version = 10

dst_compatible = false
forge_compatible = false
gorge_compatible = false
dont_starve_compatible = false
reign_of_giants_compatible = false
shipwrecked_compatible = false
rotwood_compatible = true

client_only_mod = true
all_clients_require_mod = false

icon_atlas = "modicon.png"
icon = "modicon.png"

configuration_options = {
    {
		name = "bg_opacity",
		label = "Background Opacity",
		hover = "Adjusts how opaque/transparent the chat background looks.",
		options =	
		{
			{description = "0%", data = 0},
			{description = "10%", data = 0.1},
			{description = "20%", data = 0.2},
			{description = "30%", data = 0.3},
			{description = "40%", data = 0.4},
            {description = "50%", data = 0.5},
            {description = "60%", data = 0.6},
            {description = "70%", data = 0.7},
            {description = "80%", data = 0.8},
            {description = "90%", data = 0.9},
            {description = "100%", data = 1},
		},
		default = 0.4,
	},
}
