# 🎮 Csyon SubMenu V9.4 Legacy 1.73 Edition Español



---

## 🧩 Qué es

**Csyon SubMenu V9.4 Legacy 1.73 Edition Español** es un **script Lua para YimMenu** (menú de mods para GTA V) que añade un submenú personalizado con funciones avanzadas de **conducción, estética y heists**. Está traducido al español y adaptado a la versión **1.73** del juego.



---

## ⚙️ Qué hace exactamente

El script registra una pestaña llamada `**CSYON SubMenu 1.73**` dentro de YimMenu y añade dos grandes bloques de funcionalidades:

### 🚗 1. Vehicle Options (Opciones de Vehículo)

Todo esto se activa cuando el jugador está dentro de un vehículo:

| 🎛️ Opción | 📝 Qué hace |
|---|---|
| 🏎️ **Activate Drift Mode** | Reduce el agarre del coche. Mantén `[Left Shift]` para derrapar. Slider de intensidad (0-3). |
| 🛞 **Equip Drift Tires** | Equipa neumáticos de drift temporalmente al pulsar `[Left Shift]`; se restauran al soltar. |
| 🚀 **Launch Control** | Con el coche parado, mantén `[Acelerar] + [Freno]` 3 segundos y suelta el freno para un lanzamiento perfecto. |
| 💨 **NOS** | Simula nitro: más potencia y velocidad máxima al pulsar `[Left Shift]`. Subopción **VFX** (efecto visual en pantalla). |
| 🔥 **NOS Purge** | Purga de NOS estilo *Fast & Furious* con `[X]` (teclado) o `[A]` (mando). |
| 💥 **Pops & Bangs** | Petardeo del escape al soltar el acelerador a altas RPM. Subopción **Louder Pops** para hacerlo mucho más ruidoso. |
| 🔊 **Big Subwoofer** | Hace que la radio del vehículo suene más fuerte desde fuera. |
| 💡 **High Beams on Horn** | Enciende las luces largas al tocar el claxon. |
| 🛑 **Auto Brake Lights** | Enciende automáticamente las luces de freno cuando el coche está parado. |
| 🔑 **Keep Engine On** | Estilo GTA IV: mantener `[F]` para apagar el motor antes de salir, o pulsar normal para salir dejándolo encendido. |
| 🛡️ **Can't Touch This!** | Evita que NPCs o jugadores te roben el coche. |
| 🌈 **RGB Headlights** | Faros Xenon con colores RGB animados. Slider de velocidad (1-3). |
| 🎵 **Change Engine Sound** | Abre una ventana con buscador para cambiar el sonido del motor por el de cualquier vehículo del juego. |
| 🔧 **Fix / Destroy Engine** | Repara o destruye el motor del vehículo. |

### 🧍 2. Self Options (Opciones de Jugador)

- 📊 **Stats Updater**: bucle que actualiza en tiempo real tu **nivel, RP y nivel de crew**.
- 🧠 **MPX() / SPX()**: funciones auxiliares para detectar si estás en MP (Online) o SP (Historia) y qué personaje usas.
- ♂️♀️ **Detección de sexo del personaje**: variable `is_player_male`.

### 🏦 3. Constantes para Heists (no usadas en la vista visible)

El script define muchísimas **direcciones de memoria (globals/locals)** para los heists:

- 🏠 **Apartment Heist** (Fleeca, Prison Break, Humane Labs, Series A, Pacific Standard)
- 🎰 **Diamond Casino Heist** (fingerprint hack, keypad hack, drill vault, cuts de jugadores)
- 🏝️ **Cayo Perico Heist** (fingerprint, plasma cutter, drainage pipe, cuts)
- ☢️ **Doomsday Heist**

> ⚠️ Estas constantes están preparadas para futuras funciones del menú (cortes de heist, instant finish, skips de checkpoints, etc.), pero **no tienen interfaz visible** en esta versión.

### 🌐 4. Parches para `appinternet`

Registra **3 `scr_patch`** sobre el script `appinternet` (el navegador del juego) para desbloquear/alterar la TV (`TVPB`, `HTVB`, `ABTV`). Se desactivan automáticamente cuando los scripts se recargan.

---

## 🎯 Para qué se usa

- 🖥️ **Servidores privados o uso personal en GTA V** con YimMenu instalado.
- 🏁 **Drifting y tuning**: es su función más pulida (modo drift, drift tires, launch control, pops & bangs, NOS, purge, RGB).
- 🎧 **Inmersión**: keep engine on, high beams on horn, big subwoofer.
- 🏦 **Preparación de heists**: las constantes de memoria están listas para añadir atajos a misiones.
- 🎨 **Personalización**: cambiar sonido del motor, faros RGB, etc.

---

## 📋 Requisitos

- ✅ **YimMenu** instalado y funcionando (Game Build **3889.0**).
- 📁 Colocar el archivo `.lua` en la carpeta de **scripts** de YimMenu.
- 🎮 **GTA V** (Online o Historia).

---

## ⚠️ Notas importantes

- 🚫 El script **no es un menú de trampas genérico** (no spawna dinero, no mata jugadores, etc.). Está centrado en **conducción, estética y heists**.
- 🧩 Muchas constantes de heist están definidas pero **no tienen interfaz visible** en esta versión; probablemente se usen en versiones posteriores o en otros scripts del mismo autor.
- 🛠️ El código usa la API de **YimMenu** (`gui`, `script.register_looped`, `PAD`, `VEHICLE`, `ENTITY`, `PLAYER`, etc.).
- 💬 El mensaje `"Csyon Script loaded successfully!"` aparece al cargar.
- 📈 La pestaña principal muestra tu **nivel, RP y nivel de crew** en tiempo real.

---

## 🗂️ Estructura del archivo

```
📄 Csyon SubMenu V9.4 Legacy 1.73 Edition Español.lua
│
├── 🎨 Cabecera ASCII art + créditos
├── 🧮 Funciones auxiliares (MPX, SPX, is_player_male)
├── 📊 Stats Updater (bucle)
├── 📜 Constantes de scripts (FMC, FMMCL, HIP...)
├── 🏦 Direcciones de memoria para heists (Apartment, Casino, Cayo, Doomsday)
├── 🌍 Variables globales (driftMode, speedBoost, nosPurge, etc.)
├── 🚗 Lista de vehículos del juego (gta_vehicles)
├── 📐 Offsets de vehículos (vehOffsets)
├── 🧰 Funciones de utilidad (filterVehNames, displayVehNames, helpmarker...)
├── 🌐 Parches appinternet
├── 🆕 Creación de pestaña CSYON
├── 🚘 Pestaña Vehicle Options (toda la lógica)
└── 🔁 Bucles registrados:
    ├── 🎮 game input
    ├── 🏎️ TDFT (drift, NOS, luces, keep engine)
    ├── 🚀 LCTRL (launch control)
    ├── 🛑 Auto Brake Lights
    ├── 💨 NOS ptfx
    ├── 🔥 2-step
    ├── 🔊 LCTRL SFX
    ├── 💥 pops&bangs
    ├── 🌫️ Purge
    └── 🌈 rgbheadlights
```

---

## 🧠 Resumen en una frase

> 🏁 **Csyon SubMenu V9.4 Legacy 1.73 Edition Español** es un submenú para YimMenu centrado en **drift, NOS, efectos de escape, luces RGB y personalización de vehículos**, con constantes preparadas para heists y traducido al español para GTA V 1.73. 🎮💨


