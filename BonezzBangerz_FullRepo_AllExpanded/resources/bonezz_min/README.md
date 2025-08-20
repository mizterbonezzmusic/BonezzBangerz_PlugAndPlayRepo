# Bonezz Minimal Plug‑n‑Play (ONE resource)

This single resource combines:
- UC blips (numbered + legend-hidden)
- UC safehouse markers (enter action)
- Corrupt Cops Lite (randomized outcomes; command `/ucbrief`)

## Install
1) Drop **bonezz_min** into `resources/`.
2) Add to `server.cfg` **below** qb-core/target/inventory:
   ```cfg
   ensure bonezz_min
   ```
3) (Optional) Keep **Bonezz_Rx_AllInOne_v3** if you want the full items set.

## Commands
- `/ucbrief` → triggers a briefing outcome (clean/sting/intervention).

## Config
Edit `config.lua` (jobs, blips, legend mode, marker coords, chances).
