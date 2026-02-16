# Voxium Protocol (v1 Draft)

This document describes the current custom protocol used by Voxium.

## Scope
- HTTP REST API for auth, rooms, messages, uploads, moderation
- WebSocket JSON events for real-time updates and signaling
- WebRTC media for voice/screen share (peer-to-peer mesh)

## Versioning
- Current protocol version: `v1` (informal)
- Recommendation: introduce explicit `protocol_version` in WS handshake and API responses

## Transport Layers
- HTTP: request/response endpoints under `/api/*`
- WebSocket: endpoint `/ws` for event stream and signaling relay
- WebRTC: direct peer media channels, signaling via WebSocket

## Authentication
- JWT issued on login/register
- HTTP: `Authorization: Bearer <token>`
- WebSocket: current flow relies on client `join` payload identity, with server-side role checks in critical handlers

## Core HTTP Endpoints

### Auth
- `POST /api/register`
- `POST /api/login`
- `GET /api/users/me`
- `PATCH /api/users/me`

### Roles & Users
- `PATCH /api/users/{id}/role`
- `DELETE /api/users/{id}`
- `GET /api/server/roles`
- `POST /api/server/roles`
- `DELETE /api/server/roles/{name}`
- `GET /api/server/users`

### Rooms
- `GET /api/rooms`
- `POST /api/rooms`
- `PATCH /api/rooms/{id}`
- `DELETE /api/rooms/{id}`

### Messages
- `GET /api/rooms/{room_id}/messages`
- `GET /api/messages/search`
- `DELETE /api/messages/{id}`
- `POST /api/messages/{id}/pin`
- `DELETE /api/messages/{id}/pin`
- `GET /api/rooms/{room_id}/pins`
- `DELETE /api/users/{id}/messages`

### Uploads
- `POST /api/upload`
- `GET /uploads/*` (static files)

## WebSocket Event Envelope

All events are JSON objects. Common fields:
- `type`: event type string
- `room_id`, `user_id`, `username` (optional by event)
- message events may include `id`, `content`, `created_at`, `image_url`, `reply_to_id`

### Main Real-Time Events
- `join`
- `leave`
- `presence`
- `message`
- `typing`
- `room_deleted`
- `room_updated`
- `message_deleted`
- `message_pinned`
- `message_unpinned`
- `messages_purged`

### Voice Signaling Events
- `voice_join`
- `voice_leave`
- `voice_state`
- `voice_signal`

## Permission Model (Current)
- User has one role string (e.g. `user`, `admin`, custom)
- Room has `required_role`
- Access rules:
  - room with `required_role = user`: all authenticated users
  - room with another role: matching role or `admin`
- Critical operations (role management, room updates/deletes, moderation) require `admin`

## Recommended Next Protocol Improvements
- Add explicit protocol version in WS `join` and server hello
- Add structured error events (`error_code`, `message`, `context`)
- Add ACK IDs for critical WS actions
- Add event schemas (JSON Schema/OpenAPI style)
- Add replay-safe IDs and monotonic ordering metadata
