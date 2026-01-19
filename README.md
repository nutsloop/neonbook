# NeonBook

Documentation for [neonsignal](https://github.com/nutsloop/neonsignal) - a high-performance HTTP/2 server written in modern C++23.

## About

NeonBook is the official documentation built with Sphinx, featuring custom neon-themed styling. It covers:

- **Getting Started** - Build from source and run the server
- **Architecture** - Event loops, HTTP/2 frames, and virtual hosting
- **Features** - SSE streaming, performance tuning, HTTP/2 compliance
- **Operations** - Production deployment with systemd and Let's Encrypt
- **Benchmarks** - Performance reports and analysis

## Themes

This repository includes three custom Sphinx themes as git submodules:

- [neon-synth](https://github.com/nutsloop/neon-synth)
- [neon-wave](https://github.com/nutsloop/neon-wave)
- [neon-static](https://github.com/nutsloop/neon-static)

## Build

```bash
# Setup virtual environment and install dependencies
make html THEME=neon-synth

# Or with neon-wave theme
make html THEME=neon-wave

# Or with neon-static theme
make html THEME=neon-static

# Build and deploy to neonsignal public directory
make deploy THEME=neon-synth
```

## Environment variables

These are read by `source/conf.py` and passed into the themes.

- `NEONBOOK_THEME`: `neon-synth`, `neon-wave`, or `neon-static` (default: `neon-synth`)
- `NEONBOOK_VHS`: toggle VHS effects (default: `on`)
- `NEONBOOK_PERF_LOG`: enable performance console logging (default: `off`)
- `NEONBOOK_PERF_SOUND`: play a siren on heavy load (default: `off`)
- `NEONBOOK_PERF_NOTIFY`: desktop notification on heavy load (default: `off`)

`neon-static` ignores `NEONBOOK_VHS`, `NEONBOOK_PERF_SOUND`, and `NEONBOOK_PERF_NOTIFY`.

For boolean flags, any value other than `0`, `off`, `false`, or `no` is treated as on.

## License

Apache License 2.0. See [LICENSE](LICENSE).

---

AI-Agents used at 99%
