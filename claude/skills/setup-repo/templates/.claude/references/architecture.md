# Architecture

<!-- Claude reads this when doing cross-cutting work. Fill in the sections -->
<!-- that apply to your project — delete the rest. -->

## Overview

<!-- What this system does in 1-2 sentences. -->

## Key Components

<!-- Major parts of the system and their responsibilities. -->

| Component | Responsibility |
|-----------|---------------|
| <!-- e.g., API server --> | <!-- Handles HTTP requests, auth, routing --> |
| <!-- e.g., Worker --> | <!-- Processes background jobs from queue --> |
| <!-- e.g., Database --> | <!-- Postgres — schema managed by migrations --> |

## Data Flow

<!-- How data moves through the system. Describe the happy path for a typical request. -->

## External Dependencies

<!-- Services, APIs, and infrastructure this project depends on. -->

| Dependency | Purpose | Failure Mode |
|-----------|---------|-------------|
| <!-- e.g., Stripe --> | <!-- Payment processing --> | <!-- Retry with backoff --> |
| <!-- e.g., Redis --> | <!-- Session cache --> | <!-- Fall back to DB --> |

## Deployment

<!-- How this gets to production. CI/CD pipeline, environments, etc. -->
