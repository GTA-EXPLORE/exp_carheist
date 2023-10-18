LANGUAGE = 'en'

VEHICLE_EARNINGS = 30000 
MAX_DAMAGE_LOSS = 10000
POLICE_REQUIRED = 1
INTERVAL = 60*60000 -- 60 minutes

START_SCENE = {
    enable = true,
    ped = {
        model = "ig_fbisuit_01",
        coords = vector3(1125.25, -1241.59, 20.36),
        heading = 156.37
    }
}

DEALER_SCENE = {
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
    coords = vector3(-1109.446, -3081.029, 5.3891),
    heading = 60.1143,
    model = 'cargoplane'
}

GUARDS = {
    {
        coords = vector3(-1104.2, -3056.0, 14.7165),
        heading = 270.87,
        model = 's_m_m_highsec_02',
        weapon = "WEAPON_PISTOL"
    },
    {
        coords = vector3(-1084.5, -3067.2, 14.7166),
        heading = 354.93,
        model = 'ig_fbisuit_01',
        weapon = "WEAPON_PISTOL"
    },
    {
        coords = vector3(-1084.6, -3091.6, 13.9444),
        heading = 268.28,
        model = 's_m_m_highsec_02',
        weapon = "WEAPON_PISTOL"
    },
    {
        coords = vector3(-1094.9, -3102.7, 13.9444),
        heading = 268.3,
         model = 's_m_m_highsec_02',
         weapon = "WEAPON_PISTOL"
        },
    {
        coords = vector3(-1115.2, -3097.9, 13.9444),
        heading = 359.44,
        model = 'ig_fbisuit_01',
        weapon = "WEAPON_PISTOL"
    },
    {
        coords = vector3(-1099.8, -3024.3, 13.9449),
        heading = 174.77,
        model = 's_m_m_highsec_02',
        weapon = "WEAPON_PISTOL"
    },
    {
        coords = vector3(-1087.6, -3020.2, 13.9453),
        heading = 180.79,
        model = 'ig_fbisuit_01',
        weapon = "WEAPON_PISTOL"
    },
    {
        coords = vector3(-1067.8, -3034.7, 13.9457),
        heading = 180.79,
        model = 'ig_fbisuit_01',
        weapon = "WEAPON_PISTOL"
    },
    {
        coords = vector3(-1059.2, -3060.8, 13.9845),
        heading = 180.79,
        model = 's_m_m_highsec_02',
        weapon = "WEAPON_PISTOL"
    },
    {
        coords = vector3(-1051.6, -3081.5, 13.9376),
        heading = 180.79,
        model = 'ig_fbisuit_01',
        weapon = "WEAPON_PISTOL"
    },
    {
        coords = vector3(-1042.1, -3094.3, 13.9450),
        heading = 180.79,
        model = 's_m_m_highsec_02',
        weapon = "WEAPON_PISTOL"
    },
    {
        coords = vector3(-1043.0, -3109.2, 13.9444),
        heading = 180.79,
        model = 'ig_fbisuit_01',
        weapon = "WEAPON_PISTOL"
    },
    {
        coords = vector3(-1050.7, -3107.4, 13.9444),
        heading = 180.79,
        model = 's_m_m_highsec_02',
        weapon = "WEAPON_PISTOL"
    },
}