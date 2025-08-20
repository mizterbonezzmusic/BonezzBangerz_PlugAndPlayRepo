# Bonezz Bangerz – Plug & Play Deployment (QBCore Addon)

This repo is a **ready-to-deploy** addon for txAdmin/QBCore servers.

## What's included
- `resources/bonezz_min` — one lean resource (UC blips + safehouses + corrupt-lite `/ucbrief`).
- `server.cfg.example` — ready-to-copy config using the new server name: **Bonezz Bangerz**.
- `recipes/Bonezz_Full_Remote/recipe.yaml` — remote file recipe for txAdmin (imports by URL).
- `docs/server_addon.cfg` — the `ensure` snippet to paste if you keep your existing cfg.

## Remote Recipe (txAdmin)
1. Push this repo to GitHub under your account.
2. Grab the raw URL to `recipes/Bonezz_Full_Remote/recipe.yaml`, e.g.:
   `https://raw.githubusercontent.com/<YOUR-USERNAME>/BonezzBangerz_PlugAndPlayRepo/main/recipes/Bonezz_Full_Remote/recipe.yaml`
3. In **txAdmin → Deployments → Recipe → Import Remote File**, paste the raw URL, then **Deploy**.
4. Use `server.cfg.example` or paste `docs/server_addon.cfg` into your cfg.
5. Live Console:
   ```
   refresh
   ensure bonezz_min
   ```

## Local Drop-in
- You can also just copy `resources/bonezz_min` into your `resources/` folder and add `ensure bonezz_min` to `server.cfg`.

## Identifiers & GOD
- Your identifiers are included in the recipe under `identifiers:` (txAdmin admin).
- The **ACE block** in `server.cfg.example` grants in-game **GOD** perms to the same IDs.

## Notes
- No quotes around `ensure` lines; Linux is case-sensitive.
- Keep only one UC resource active to avoid conflicts.

MIT License in root.

---

### Legacy Packs Included
- Bonezz_Rx_AllInOne_v3
- Bonezz_UC_Blips_v2
- Bonezz_UC_Safehouses
- Corrupt_Cops

> If any are placeholders (stub), replace the folder content with your actual resource files before production.
