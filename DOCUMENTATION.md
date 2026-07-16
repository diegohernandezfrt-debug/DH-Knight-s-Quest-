# ⚔️ DH Knight's Quest - Technical Documentation

<img width="373" height="182" alt="Logo" src="https://github.com/user-attachments/assets/26bd6778-e5c3-42f3-b297-cfc4cf4f2dfe" />

**Version:** 1.0  
**Motor:** Godot Engine 4.2.2  
**Lenguaje:** GDScript  
**Autor:** Diego Francisco Hernández Ramírez  
**Date:** Julio 2026

---

## Table of Contents
1. [Project Overview](#1-project-overview)
2. [Gameplay](#2-gameplay)
3. [Controls](#3-controls)
4. [Game Features](#4-game-features)
5. [Project Architecture](#5-project-architecture)
6. [Save System](#6-save-system)
7. [Enemy AI](#7-enemy-ia)
8. [Boss Mechanics](#8-boss-mechanics)
9. [Installation and Execution](#9-installation-and-execution)
10. [Lessons Learned](#10-lessons-learned)
11. [Future Improvements](#11-future-improvements)
12. [Screenshots](#12-screenshots)
13. [Repository Structure](#13-repository-structure)
14. [Technologies Used](#14-technologies-used)

---

## 1. Project Overview

**DH Knight's Quest** es un **action-platformer 2D** de temática medieval desarrollado en Godot Engine 4.2.2. El proyecto fue creado como pieza central de portafolio para demostrar habilidades sólidas en:

- Programación de gameplay
- Arquitectura escalable de escenas
- IA de enemigos
- Sistemas de persistencia
- UI/UX y manejo de audio

---

2. Gameplay

Explore five handcrafted levels.
Defeat enemies.
Collect coins.
Reach checkpoints.
Fight the Dark Knight.
Complete the campaign.

---

3. Controls

| Acción          | Teclado / Ratón      |
|-----------------|----------------------|
| Moverse         | A / D o Flechas      |
| Saltar          | Space                |
| Atacar          | Click Izquierdo      |
| Pausa / Menú    | ESC                  |

---

4. Game Features

### Player
- Movement
- Jump
- Attack
- Health System
- Knockback
- Respawn
- Enemies

### Enemys

- **Goblin**:
Patrol
Chase
Melee attack

- **Skeleton Archer**:
Detect player
Shoot arrows
Flip towards player

- **Dark Knight Boss**:
Chase player
Sword attack
DarkWave attack
Cooldown system
Death animation
Collectibles

Coins
Increase total coins
Bonus Chest
Restores one heart
Checkpoint

Saves progress
HUD
Heart System
Coins Counter
Menus
Main Menu
Pause
Game Over
Victory
Level Selection
Audio

Background Music

Gameplay playlist
Menu music
Victory music
Game Over music

Sound Effects

Player
Enemies
Boss
Chests
Coins
Checkpoints

---

## 5. Project Architecture

### Scenes
│
├── Levels
├── Player
├── Enemies
├── UI
├── Managers
├── Objects
└── Effects

### Managers

GameManager
SaveManager
SceneManager
AudioManager
PauseManager

---

## 6. Save System

Coins
Player Health
Current Level
Checkpoint Position

Formato:
**JSON**

---

## 7. Enemy AI

**Goblin**
Idle
↓
Detect Player
↓
Chase
↓
Attack
↓
Take Damage
↓
Death

---

## 8. Boss Mechanics

Detection Area
Chase
Slash Attack
DarkWave
Cooldown
Death
Victory

---

## 9. Installation and Execution

git clone https://github.com/diegohernandezfrt-debug/DH-Knight-s-Quest-.git

# Open with Godot:
# 1. Open Godot Engine 4.2.2
# 2. The project matters
# 3. Press F5 to run

---

## 10. Lessons Learned

During the development of DH Knight's Quest I improved my understanding of:

Scene architecture
Object-Oriented Programming
State Machines
Enemy AI
Save Systems
UI Design
Audio Management
Debugging
Project Organization

---

## 11. Future Improvements

Second boss phase
Settings Menu
Difficulty modes
More enemy types
Controller support
Steam achievements
More levels
New weapons

---

## 12. Screenshots

**Main Menu**
<img width="1151" height="677" alt="Menu" src="https://github.com/user-attachments/assets/2f1f126b-83dd-4521-8091-f39a9197e6bc" />

**Gameplay**
<img width="1149" height="677" alt="Level01" src="https://github.com/user-attachments/assets/a70fd415-72cd-428f-a2e5-8f5b26095f6a" />

**Boss**
<img width="814" height="477" alt="Boss" src="https://github.com/user-attachments/assets/be4097bb-d105-4827-b010-f8e42fa36355" />

**Victory**
<img width="1154" height="682" alt="Victory" src="https://github.com/user-attachments/assets/ea95148c-af50-4b53-add2-0a7028a1fe8d" />

**Level Select**
<img width="1152" height="682" alt="Levels" src="https://github.com/user-attachments/assets/b2680425-8fe8-4b56-8fed-f3c7ef83268a" />

---

## 13. Repository Structure

Assets/
Scenes/
Scripts/
Audio/
UI/
Managers/
Save/
Exports/

---

## 14. Technologies

Godot 4.2.2
GDScript
JSON
Git
GitHub

---
