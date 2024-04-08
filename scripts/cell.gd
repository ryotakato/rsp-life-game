extends RefCounted

class_name Cell

signal hp_changed(hp:int)
signal influenced(k:Common.Kind, damage:int, heal:int)
signal cell_changed(old_kind:Common.Kind, new_kind:Common.Kind)

const MAX_HP:int = 100
const ROCK_HP:int = 100
const NONE_HP:int = 10
var hp:int
var damage:int
var heal:int
var kind:Common.Kind
var next_kind:Common.Kind

func _init(k: Common.Kind):
	self.kind = k
	self.next_kind = Common.Kind.NONE
	self.hp = ConfigManager.get_config_value("hp", k)
	self.damage = ConfigManager.get_config_value("damage", k)
	self.heal = ConfigManager.get_config_value("heal", k)

func add_hp(amount:int):
	self.hp += amount
	#毎回emitさせるのは無駄か？とりあえずrefresh_hpに任せる
	#hp_changed.emit(self.hp)

func reset_hp(hp:int):
	self.hp = hp
	#毎回emitさせるのは無駄か？とりあえずrefresh_hpに任せる
	#hp_changed.emit(self.hp)

func refresh_hp():
	hp_changed.emit(self.hp)

func influence():
	influenced.emit(self.kind, self.damage, self.heal)

func is_influenced(influencer_kind:Common.Kind, damage:int, heal:int):
	if self.kind == influencer_kind:
		self.add_hp(heal)
	elif self.is_weaker_than(influencer_kind):
		self.add_hp(-damage)

func is_weaker_than(target_kind: Common.Kind) -> bool:
	if target_kind == Common.Kind.NONE:
		return false
	elif self.kind == Common.Kind.NONE:
		self.next_kind = target_kind
		return true
	elif (target_kind == Common.Kind.ROCK and self.kind == Common.Kind.SCISSORS):
		return true
	elif (target_kind == Common.Kind.SCISSORS and self.kind == Common.Kind.PAPER):
		return true
	elif (target_kind == Common.Kind.PAPER and self.kind == Common.Kind.ROCK):
		return true
	
	return false

func change() -> void:
	if self.hp <= 0:
		
		# 死亡の場合のみ
		var old_kind = self.kind
		# 種族の変更
		match self.kind:
			Common.Kind.NONE:
				self.kind = self.next_kind
				self.next_kind = Common.Kind.NONE
			Common.Kind.ROCK:
				self.kind = Common.Kind.PAPER
			Common.Kind.SCISSORS:
				self.kind = Common.Kind.ROCK
			Common.Kind.PAPER:
				self.kind = Common.Kind.SCISSORS
		# HPのリセット
		self.reset_hp(ConfigManager.get_config_value("hp", self.kind))
		# damageの設定
		self.damage = ConfigManager.get_config_value("damage", self.kind)
		# healの設定
		self.heal = ConfigManager.get_config_value("heal", self.kind)
		
		cell_changed.emit(old_kind, self.kind)
		


