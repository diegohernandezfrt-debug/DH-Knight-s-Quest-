extends Node

@onready var music = AudioStreamPlayer.new()

var sfx_container := Node.new()

var music1 = preload("res://Assets/Audio/MusicaFondo.mp3")
var music2 = preload("res://Assets/Audio/MusicaFondo2.mp3")

var menu_music = preload("res://Assets/Audio/MenuMusic.mp3")
var game_over_music = preload("res://Assets/Audio/GameOver.mp3")
var victory_music = preload("res://Assets/Audio/NivelCompletado.mp3")
var checkpoint_sound = preload("res://Assets/Audio/CheckPointSound.mp3")

var jump_sound = preload("res://Assets/Audio/JumpPLayer.mp3")
var player_sword_sound = preload("res://Assets/Audio/SwordSoundPlayer.mp3")
var hurt_player = preload("res://Assets/Audio/RecibirDaño.mp3")

var boss_sword_sound = preload("res://Assets/Audio/SwordSoundBoss.mp3")
var dark_wave_sound = preload("res://Assets/Audio/DarckWaveEffect.mp3")
var dark_knight_death = preload("res://Assets/Audio/DarckFire.mp3")

var coin_sound = preload("res://Assets/Audio/Monedas.mp3")
var chest_sound_open = preload("res://Assets/Audio/OpenChest.mp3")
var bonus_heart = preload("res://Assets/Audio/BonusHeart.mp3")

var mimic_chest = preload("res://Assets/Audio/MimicSound.mp3")
var skeleton_death_sound = preload("res://Assets/Audio/SkeletonDeath.mp3")
var goblin_death_sound = preload("res://Assets/Audio/GoblinDeath.mp3")
var bow_sound = preload("res://Assets/Audio/tensar-arco.mp3")
var arrow_sound = preload("res://Assets/Audio/Flecha.mp3")

var level_complete_sound = preload("res://Assets/Audio/NivelCompletado.mp3")
var game_over_sound = preload("res://Assets/Audio/GameOver.mp3")
var campaign_complete_sound = preload("res://Assets/Audio/CampañaCompletada.mp3")

var music_list = []
var current_music = 0

func _ready():
	add_child(music)
	add_child(sfx_container)

	sfx_container.process_mode = Node.PROCESS_MODE_ALWAYS
	music.process_mode = Node.PROCESS_MODE_ALWAYS
	music.finished.connect(_on_music_finished)

func start_game_music():
	if music.stream == music1 or music.stream == music2:
		return

	play_music([
		music1,
		music2
	])

func play_music(list):
	if list.is_empty():
		return

	music_list = list
	current_music = 0

	music.stream = music_list[current_music]
	music.play()

func play_menu_music():
	music.stop()
	music.stream = menu_music
	music.volume_db = 0
	music.play()

func play_game_over_music():
	music.stop()
	music.stream = game_over_music
	music.volume_db = -4
	music.play()

func play_victory_music():
	music.stop()
	music.stream = victory_music
	music.volume_db = -4
	music.play()

func _on_music_finished():
	if music_list.is_empty():
		return

	current_music += 1

	if current_music >= music_list.size():
		current_music = 0

	music.stream = music_list[current_music]
	if current_music == 0:
		music.volume_db = 0
	else:
		music.volume_db = -6
	music.play()

func play_sound(sound):
	if sound == null:
		return

	var player := AudioStreamPlayer.new()

	player.stream = sound

	sfx_container.add_child(player)

	player.finished.connect(
		func():
			player.queue_free()
	)

	player.play()

func stop_music():
	music.stop()


