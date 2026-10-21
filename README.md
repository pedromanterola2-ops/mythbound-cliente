# Mythbound · cliente

Cliente del servidor **Mythbound** (Tibia 10.98), basado en [OTClient Redemption](https://github.com/opentibiabr/otclient) (`README.otclient.md`).

Hay **dos clientes** y salen del mismo código. Cambia solo cómo se compila y cómo se entrega:

| | **Mythbound para Mac** | **Mythbound para Windows** |
|---|---|---|
| Para quién | Mac con chip Apple (M1 o posterior) | Windows 10 u 11 de 64 bits |
| Se compila | En la Mac de Pedro, con `2-compilar-cliente.sh` / `4-recompilar-cliente.sh` | En GitHub, con la acción **Mythbound para Windows** |
| Archivo que se juega | `Mythbound para Mac.app` | `Mythbound para Windows\Mythbound.exe` |
| Dónde queda listo | `~/My Games/ot-server-mac/clientes/Mac/` | `~/My Games/ot-server-mac/clientes/Windows/Mythbound para Windows.zip` |
| Ícono | El de Mythbound (`data/images/clienticon.png`) | El mismo, convertido a `cmake/icon/otcicon.ico` |

## Compilar la versión de Windows

1. Sube los cambios a `main` (o entra a **Actions → Mythbound para Windows → Run workflow**).
2. La primera vez tarda entre 40 y 90 minutos, porque compila todas las librerías. Las siguientes son mucho más rápidas.
3. Al terminar, descarga el artefacto **Mythbound-para-Windows-sin-sprites** (un `.zip`) en la Mac.
4. En la Mac, corre `./8-empaquetar-windows.sh`. Agrega los sprites (`Tibia.spr`, `Tibia.dat`, `Tibia.otfi`) y deja el `.zip` final en `clientes/Windows/`.

Los sprites no se guardan en este repositorio: `Tibia.spr` pesa unos 400 MB (GitHub acepta 100 MB por archivo) y son archivos de CipSoft.

## A qué servidor se conecta

En `init.lua` (`Servers_init`). Hoy apunta a `127.0.0.1:7171`, que solo sirve en la misma computadora del servidor. Para que otras personas jueguen, cambia esa dirección por la del VPS o la IP pública antes de compilar.

## Qué es de Mythbound

- `src/client/protocolgameparse.cpp`: protocolo de Mythbound (lista de personajes, loot category, opcodes 0x60/0x54, skills de oficio, market).
- `modules/`: autoloot, HUD, comercio con NPC, minimapa, tienda, interfaz.
- `data/minimap_mythbound.otmm`: minimapa del mundo completo.
