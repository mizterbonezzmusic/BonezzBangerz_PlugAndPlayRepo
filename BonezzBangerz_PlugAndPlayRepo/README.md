# BonezzBangerz_PlugAndPlayRepo

This package stores your base `server.cfg` and acts as the anchor repo for txAdmin deployments.
Use alongside:
- BonezzBangerz_Addons_Core.zip
- BonezzBangerz_Addons_Extra.zip

## Deploy (txAdmin Recipe Quick Steps)
1) Install base cfx, qbcore, oxmysql, pma-voice (or use your existing install).
2) Upload **server-data/server.cfg** to the server root as `server.cfg`.
3) Upload & extract the two addons zips into your server root so they merge into `/resources`.
4) Edit `server.cfg` to set your Keymaster key and MySQL string.
5) Restart server.
