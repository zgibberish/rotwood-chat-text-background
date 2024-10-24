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

configuration_options = {
    {
		name = "bg_opacity",
		label = "Background Opacity",
		hover = "Adjusts how opaque/transparent the chat background looks.",
		options =	
		{
			{description = "0%", data = 1},
			{description = "10%", data = 2},
			{description = "20%", data = 3},
			{description = "30%", data = 4},
			{description = "40%", data = 5},
            {description = "50%", data = 6},
            {description = "60%", data = 7},
            {description = "70%", data = 8},
            {description = "80%", data = 9},
            {description = "90%", data = 10},
            {description = "100%", data = 11},
		},
		default = 5,
	},
}
