# Voxium Ops / Release Checklist

This checklist helps run Voxium reliably for friends/public use.

## 1) Environment
- [ ] `.env` created from `.env.example`
- [ ] `JWT_SECRET` replaced with a strong random value
- [ ] `DATABASE_URL` points to the expected SQLite file location

## 2) Backend Health
- [ ] `cargo check -p backend` passes
- [ ] Backend starts and logs `Backend running`
- [ ] `GET /api/health` returns `{ "status": "ok" }`

## 3) Frontend Runtime Config
- [ ] `discord-app/src/runtime-config.js` has correct `apiBaseUrl`
- [ ] `discord-app/src/runtime-config.js` has correct `wsUrl`
- [ ] `iceServers` configured (STUN, optional TURN)
- [ ] `node --check discord-app/src/main.js` passes

## 4) Networking
- [ ] Port(s) opened in firewall/router
- [ ] If Internet-facing: HTTPS/WSS enabled (Nginx + TLS)
- [ ] If behind CGNAT: tunnel solution configured (Cloudflare/Tailscale/etc.)

## 5) Voice/Screen Reliability
- [ ] TURN server configured for restrictive NAT scenarios (recommended)
- [ ] Voice join/leave tested with 2+ users
- [ ] Screen share tested with 2+ users

## 6) Admin Bootstrap
- [ ] At least one admin user exists (`make_admin` or UI)
- [ ] Server roles list initialized and validated
- [ ] Room permissions tested for user/admin/custom role

## 7) Data Safety
- [ ] DB backup policy defined
- [ ] `uploads/` backup policy defined
- [ ] Restore procedure tested once

## 8) Release Notes
- [ ] Protocol-impacting changes documented in `PROTOCOL.md`
- [ ] Breaking changes communicated to testers/users
- [ ] README updated when setup steps change
