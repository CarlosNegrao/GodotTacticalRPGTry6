extends Stats

enum Type{WEAPON, ARMOR, SHOES}
enum WeaponType{NOT_WEAPON, SHORT_RANGE, LONG_RANGE}

@export var type : Type
@export var weapon_type : WeaponType
@export var weapon_range : int
