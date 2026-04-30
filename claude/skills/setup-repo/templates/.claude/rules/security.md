# Security

Constraints for production code. These are non-negotiable.

## Data Handling

- NEVER log PII, credentials, tokens, or API keys
- NEVER commit secrets to git — use environment variables
- NEVER hardcode connection strings, passwords, or keys
- Validate all user input at system boundaries
- Sanitize output to prevent XSS

## Database

- ALWAYS use parameterized queries — NEVER string concatenation for SQL
- Apply principle of least privilege for database roles
- Escape user input in NoSQL queries

## Authentication & Authorization

- NEVER store passwords in plaintext — use bcrypt or argon2
- NEVER expose internal IDs in URLs without authorization checks
- Validate JWTs on every request, not just at login

## Project-Specific

<!-- Add project-specific security requirements below. Examples: -->
<!-- - All API endpoints MUST require authentication except /health and /public/* -->
<!-- - PII must be encrypted at rest using [encryption method] -->
<!-- - CORS is restricted to [allowed origins] -->
