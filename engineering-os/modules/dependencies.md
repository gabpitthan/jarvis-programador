# DEPENDENCIES & SUPPLY CHAIN

Load when adding/upgrading/removing packages, images or external build dependencies.

Before adding dependency:
- verify existing stack cannot reasonably solve it;
- exact package identity;
- maintainer/source;
- docs;
- activity;
- license;
- vulnerabilities;
- compatibility;
- size/runtime impact.

Use lockfiles and avoid unrelated mass upgrades.
Consider scanning, SBOM, provenance, secret scanning, SAST and pinning when proportionate.
