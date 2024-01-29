LANGUAGE = 'en'

VEHICLE_EARNINGS = 30000 
MAX_DAMAGE_LOSS = 10000
POLICE_REQUIRED = 0
INTERVAL = 60*60000 -- 60 minutes

HACK_ITEM = 'laptop' -- Remove this line if hacking doesn't require any item.

START_SCENE = {
    enable = true,
    ped = {
        model = "ig_fbisuit_01",
        coords = vector3(1125.25, -1241.59, 20.36),
        heading = 156.37
    }
}

SELLER_SCENE = {
    start = {
        coords = vector3(256.72, 2601.34, 44.04)
    },
    cam = {
        coords = vector3(261.1, 2597.59, 49.17),
        rotation = vector3(-46.08, 0.03, 71.94)
    },
    finish = vector3(257.95, 2591.9, 44.14)
}

CARS = {
    {
        offset = vector3(-0.086389, 16.570745, -3.7),
        heading = 293.29,
        model = 'clique'
    },
    {
        offset = vector3(-0.031478, 1.933760, -3.65),
        heading = 289.92,
        model = 'coquette3'
    },
    {
        offset = vector3(-0.053241, -14.735330, -3.844955),
        heading = 285.45,
        model = 'casco'
    },
}

PLANE = {
    coords = vector3(-1235.61, -2267.13, 13.94),
    heading = 60.11,
    model = 'cargoplane'
}

GUARDS = {
    models = {
        "s_m_m_highsec_02",
        "ig_fbisuit_01"
    },
    amount = 20,
    spawn_range = 75.0,
    weapons = {
        "WEAPON_PISTOL"
    },
    armour = 50,
    accuracy = 50
}