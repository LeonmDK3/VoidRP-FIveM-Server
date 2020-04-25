Config                            = {}
Config.DrawDistance               = 100.0
Config.MarkerType                 = 1
Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 1.0 }
Config.MarkerColor                = { r = 50, g = 50, b = 204 }
Config.EnablePlayerManagement     = true
Config.EnableArmoryManagement     = false
Config.EnableESXIdentity          = true -- only turn this on if you are using esx_identity
Config.EnableNonFreemodePeds      = false -- turn this on if you want custom peds
Config.EnableSocietyOwnedVehicles = false
Config.EnableLicenses             = true
Config.MaxInService               = -1
Config.Locale                     = 'fr'

Config.StateStations = {

	State = {

		Blip = {
			Pos     = { x = 140.067, y = -768.393, z = 45.0 },
			Sprite  = 419,
			Display = 4,
			Scale   = 1.2,
	        -- Colour  = 29,
		},
		-- https://wiki.fivem.net/wiki/Weapons
		AuthorizedWeapons = {
			{ name = 'WEAPON_NIGHTSTICK',       price = 200 },
			{ name = 'WEAPON_COMBATPISTOL',     price = 300 },
			{ name = 'WEAPON_ASSAULTSMG',       price = 1250 },
			{ name = 'WEAPON_CARBINERIFLE',     price = 1500 },
			{ name = 'WEAPON_PUMPSHOTGUN',      price = 600 },
			{ name = 'WEAPON_STUNGUN',          price = 500 },
			{ name = 'WEAPON_FLASHLIGHT',       price = 80 },
			{ name = 'WEAPON_FLAREGUN',         price = 60 },
			{ name = 'GADGET_PARACHUTE',        price = 300 },
		},

		Cloakrooms = {
			      { x = 147.188, y = -738.033, z = 241.0 }
		},

		Armories = {
			{ x = 151.858, y = -736.181, z = 241.0 }
		},

		Vehicles = {
			{
				Spawner    = { x = 156.115, y = -681.325, z = 32.0 },
				SpawnPoint = { x = 162.236, y = -690.283, z = 32.5 },
				Heading    = 245.0,
			}
		},

		Helicopters = {
			{
				Spawner    = { x = 140.847, y = -735.739, z = 262.0 },
				SpawnPoint = { x = 122.824, y = -744.070, z = 262.0 },
				Heading    = 160.0,
			}
		},

		VehicleDeleters = {
			{ x = 144.150, y = -698.661, z = 32.0 },
		},

		BossActions = {
			{ x = 149.341, y = -759.047, z = 241.0 },
		},

	},

}

-- https://wiki.fivem.net/wiki/Vehicles
Config.AuthorizedVehicles = {
	Shared = {
	
	},

	recrue = {

	},

	garde = {
		
	},

	vicepresident = {
		
	},

	boss = {
	
	}
}


-- CHECK SKINCHANGER CLIENT MAIN.LUA for matching elements

Config.Uniforms = {
    
  cadet_wear = {
    male = {
        ['tshirt_1'] = 22,  ['tshirt_2'] = 4,
        ['torso_1'] = 21,   ['torso_2'] = 0,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 1,
        ['pants_1'] = 25,   ['pants_2'] = 5,
        ['shoes_1'] = 10,   ['shoes_2'] = 0,
        ['helmet_1'] = -1,   ['helmet_2'] = 0,
        ['chain_1'] = 0,    ['chain_2'] = 0,
        ['ears_1'] = 0,     ['ears_2'] = 0,
        ['ears_1'] = 0,     ['ears_2'] = 0
    },
    female = {
        ['tshirt_1'] = 36,  ['tshirt_2'] = 1,
        ['torso_1'] = 48,   ['torso_2'] = 0,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 44,
        ['pants_1'] = 34,   ['pants_2'] = 0,
        ['shoes_1'] = 27,   ['shoes_2'] = 0,
        ['helmet_1'] = 45,  ['helmet_2'] = 0,
        ['chain_1'] = 0,    ['chain_2'] = 0,
        ['ears_1'] = 2,     ['ears_2'] = 0
    }
  },
  sergeant_wear = {
    male = {
        ['tshirt_1'] = 21,  ['tshirt_2'] = 0,
        ['torso_1'] = 29,   ['torso_2'] = 0,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 1,
        ['pants_1'] = 35,   ['pants_2'] = 0,
        ['shoes_1'] = 10,   ['shoes_2'] = 0,
        ['helmet_1'] = -1,  ['helmet_2'] = 0,
        ['chain_1'] = 0,    ['chain_2'] = 0,
        ['ears_1'] = 0,     ['ears_2'] = 0
    },
    female = {
        ['tshirt_1'] = 35,  ['tshirt_2'] = 0,
        ['torso_1'] = 48,   ['torso_2'] = 0,
        ['decals_1'] = 7,   ['decals_2'] = 1,
        ['arms'] = 44,
        ['pants_1'] = 34,   ['pants_2'] = 0,
        ['shoes_1'] = 27,   ['shoes_2'] = 0,
        ['helmet_1'] = -1,  ['helmet_2'] = 0,
        ['chain_1'] = 0,    ['chain_2'] = 0,
        ['ears_1'] = 2,     ['ears_2'] = 0
    }
  },
  lieutenant_wear = {
    male = {
        ['tshirt_1'] = 33,  ['tshirt_2'] = 1,
        ['torso_1'] = 29,   ['torso_2'] = 1,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 1,
        ['pants_1'] = 35,   ['pants_2'] = 0,
        ['shoes_1'] = 10,   ['shoes_2'] = 0,
        ['helmet_1'] = -1,  ['helmet_2'] = 0,
        ['chain_1'] = 29,    ['chain_2'] = 13,
        ['ears_1'] = 0,     ['ears_2'] = 0
    },
    female = {
        ['tshirt_1'] = 35,  ['tshirt_2'] = 0,
        ['torso_1'] = 48,   ['torso_2'] = 0,
        ['decals_1'] = 7,   ['decals_2'] = 2,
        ['arms'] = 44,
        ['pants_1'] = 34,   ['pants_2'] = 0,
        ['shoes_1'] = 27,   ['shoes_2'] = 0,
        ['helmet_1'] = -1,  ['helmet_2'] = 0,
        ['chain_1'] = 0,    ['chain_2'] = 0,
        ['ears_1'] = 2,     ['ears_2'] = 0
    }
  },
  commandant_wear = {
    male = {
        ['tshirt_1'] = 33,  ['tshirt_2'] = 2,
        ['torso_1'] = 29,   ['torso_2'] = 2,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 1,
        ['pants_1'] = 35,   ['pants_2'] = 0,
        ['shoes_1'] = 10,   ['shoes_2'] = 0,
        ['helmet_1'] = -1,  ['helmet_2'] = 0,
        ['chain_1'] = 29,    ['chain_2'] = 4,
        ['ears_1'] = 0,     ['ears_2'] = 0
    },
    female = {
        ['tshirt_1'] = 35,  ['tshirt_2'] = 0,
        ['torso_1'] = 48,   ['torso_2'] = 0,
        ['decals_1'] = 7,   ['decals_2'] = 3,
        ['arms'] = 44,
        ['pants_1'] = 34,   ['pants_2'] = 0,
        ['shoes_1'] = 27,   ['shoes_2'] = 0,
        ['helmet_1'] = -1,  ['helmet_2'] = 0,
        ['chain_1'] = 0,    ['chain_2'] = 0,
        ['ears_1'] = 2,     ['ears_2'] = 0
    }
  },
  bullet_wear = {
    male = {
        ['bproof_1'] = 11,  ['bproof_2'] = 1
    },
    female = {
        ['bproof_1'] = 13,  ['bproof_2'] = 1
    }
  },
  gilet_wear = {
    male = {
        ['tshirt_1'] = 59,  ['tshirt_2'] = 1
    },
    female = {
        ['tshirt_1'] = 36,  ['tshirt_2'] = 1
    }
  }

}

Config.PublicZones = {

  EnterBuilding = {
    Pos       = { x = 140.067, y = -768.393, z = 44.8 },
    Size      = { x = 2.0, y = 2.0, z = 1.0 },
    Color     = { r = 64, g = 0, b = 74 },
    Marker    = 25,
    Blip      = true,
    Name      = "Le Maclerait Libéré",
    Type      = "teleport",
    Hint      = "Appuyez sur ~INPUT_PICKUP~ pour entrer dans l'immeuble.",
    Teleport  = { x = 135.5, y =  -766.783, z = 241.0 }
  },

  ExitBuilding = {
    Pos       = { x = 135.5, y =  -763.368, z = 241.2 },
    Size      = { x = 2.0, y = 2.0, z = 1.0 },
    Color     = { r = 64, g = 0, b = 74 },
    Marker    = 25,
    Blip      = true,
    Name      = "Le Maclerait Libéré",
    Type      = "teleport",
    Hint      = "Appuyez sur ~INPUT_PICKUP~ pour aller à l'entrée de l'immeuble.",
    Teleport  = { x = 140.067, y = -768.393, z = 45.0 },
  },
  
  
  
    EnterRoof = {
    Pos       = { x = 138.371, y = -764.507, z = 241.2 },
    Size      = { x = 2.0, y = 2.0, z = 1.0 },
    Color     = { r = 64, g = 0, b = 74 },
    Marker    = 25,
    Blip      = true,
    Name      = "Le Maclerait Libéré",
    Type      = "teleport",
    Hint      = "Appuyez sur ~INPUT_PICKUP~ pour sortir sur le toit.",
    Teleport  = { x = 157.445, y =  -764.785, z = 257.2 }
  },

  ExitRoof = {
    Pos       = { x = 157.445, y =  -764.785, z = 257.2 },
    Size      = { x = 2.0, y = 2.0, z = 1.0 },
    Color     = { r = 64, g = 0, b = 74 },
    Marker    = 25,
    Blip      = true,
    Name      = "Le Maclerait Libéré",
    Type      = "teleport",
    Hint      = "Appuyez sur ~INPUT_PICKUP~ pour entrer dans l'immeuble.",
    Teleport  = { x = 135.5, y =  -766.783, z = 241.0 },
  },
  
  EnterGarage = {
    Pos       = { x = 131.191, y =  -762.076, z = 44.8 },
    Size      = { x = 2.0, y = 2.0, z = 1.0 },
    Color     = { r = 64, g = 0, b = 74 },
    Marker    = 25,
    Blip      = true,
    Name      = "Le Maclerait Libéré",
    Type      = "teleport",
    Hint      = "Appuyez sur ~INPUT_PICKUP~ pour entrer dans le garage.",
    Teleport  = { x = 147.81, y =  -687.7223, z = 32.0 },
  },
  
  ExitGarage = {
    Pos       = { x = 144.975, y =  -689.155, z = 32.2 },
    Size      = { x = 2.0, y = 2.0, z = 1.0 },
    Color     = { r = 64, g = 0, b = 74 },
    Marker    = 25,
    Blip      = true,
    Name      = "Le Maclerait Libéré",
    Type      = "teleport",
    Hint      = "Appuyez sur ~INPUT_PICKUP~ pour sortir du garage.",
    Teleport  = { x = 129.371, y =  -764.312, z = 45.0 },
  },
  
}