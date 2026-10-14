# Ori Multiplayer

A ready-to-install multiplayer mod package for **Ori and the Will of the Wisps** on Windows x64.

**Author:** Wang Lin  
**Team:** DevSoftWare  
**Release:** 2026.10.14-credits  
**Network protocol:** 34

This repository contains compiled mod binaries, launch scripts, configuration examples, and third-party licenses. The base game and the mod source code are not included.

## Requirements

- Windows x64.
- Your own installation of the **April 2020 version** of [Ori and the Will of the Wisps](https://store.steampowered.com/app/1057090/Ori_and_the_Will_of_the_Wisps/).
- Install [Microsoft Visual C++ Redistributable x64 — official Microsoft installer](https://aka.ms/vc14/vc_redist.x64.exe). This package installs the required runtime libraries; you do not need to download individual DLL files. See [Microsoft documentation](https://learn.microsoft.com/en-us/cpp/windows/latest-supported-vc-redist) for details.
- The same mod package and a compatible game version on both computers.

## Installation

1. Close the game and back up your saves and any existing mods.
2. Download this repository using **Code → Download ZIP**, then extract it.
3. Copy the contents of the extracted repository into the game directory, next to `oriwotw.exe`. Keep `winhttp.dll`, `Ori Multiplayer.bat`, and the `OriMultiplayerMod` directory together.
4. When updating, replace the previous Ori Multiplayer files. If another mod already uses `winhttp.dll`, check compatibility before replacing it. Preserve your personal `OriMultiplayerMod/multiplayer.json`.
5. Run `Ori Multiplayer.bat`. No compilation is required.

## Playing together

1. Select **MULTIPLAYER** in the main menu, or press **Esc → MULTIPLAYER** during gameplay. F1 is no longer used; press Esc or Back to return.
2. One player creates a room. The other enters the host's IP address and the same port. The default port is **TCP 31415**.
3. The host then selects a save.

Use the host computer's reachable IP address when connecting from another computer. `127.0.0.1` refers to the current computer and is only suitable for local testing. Firewall and router settings must allow the connection.

Connect only to trusted players: the network protocol has no password protection or encryption.

## Configuration

`OriMultiplayerMod/multiplayer.example.json` provides sample settings without personal data or absolute paths. Personal settings are stored in `OriMultiplayerMod/multiplayer.json` when settings are saved or the settings page is closed.

Shared world and shared progression are enabled by default. If synchronization was previously disabled, open Settings and use the restore cooperative settings option before connecting. Synchronization settings remain fixed while connected; shared progression requires shared world synchronization.

## Audio

The default launcher disables audio to avoid a known Wwise startup crash. This is a launch workaround, not a fix for the audio engine.

To try launching with sound, run this command from the game directory:

```bat
"Ori Multiplayer.bat" --sound
```

The known crash may return. A personal configuration with `disable_audio=true` still disables sound.

## Optional utilities

- `Test Two Players.bat` opens two game windows on one computer. It creates separate Host and Client profiles, copies saves and the game executable, and creates a link to the game data directory. It is intended for manual testing.
- `Collect Multiplayer Logs.bat` collects local diagnostic logs manually and does not upload them to the internet.
- `Ori Multiplayer.cmd` is an alternate entry point for the launcher.

## Package contents

| Path | Purpose |
| --- | --- |
| `winhttp.dll` | Mod loading entry point |
| `OriMultiplayerMod/Core.dll` | Core mod component |
| `OriMultiplayerMod/Modloader.dll` | Mod loader |
| `OriMultiplayerMod/Multiplayer.dll` | Multiplayer component |
| `OriMultiplayerMod/modloader_config.json` | Loader configuration and game bindings |
| `OriMultiplayerMod/multiplayer.example.json` | Example multiplayer configuration |
| `OriMultiplayerMod/release.json` | Release metadata |
| `OriMultiplayerMod/LICENSE` | Included MIT license and upstream notices |
| `OriMultiplayerMod/Licenses/` | Third-party license notices |
| `README.txt` | Original Russian instructions |
| `SHA256SUMS.txt` | SHA-256 checksums for the published package files |

## Status and limitations

This is a network alpha release. The supplied release metadata reports 84 passed live checks and zero failed checks; these results have not been independently rerun for this repository upload. Full campaign completion is **not verified**.

The original Russian instructions refer to `RELEASE_NOTES.txt`, but that file was not present in the supplied package. See `release.json` for the available release metadata.

## Licenses and credits

Author: **Wang Lin**. Team: **DevSoftWare**.

Existing upstream copyright notices are preserved in `OriMultiplayerMod/LICENSE`. Additional dependency licenses are included in `OriMultiplayerMod/Licenses/`. Ori and the Will of the Wisps and its game assets belong to their respective rights holders.
