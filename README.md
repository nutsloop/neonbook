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

This repository includes two custom Sphinx themes as git submodules:

- [sphinx-neon-synth-theme](https://github.com/nutsloop/sphinx-neon-synth-theme)
- [sphinx-neon-wave-theme](https://github.com/nutsloop/sphinx-neon-wave-theme)

## Build

```bash
# Setup virtual environment and install dependencies
make html THEME=neon-synth

# Or with neon-wave theme
make html THEME=neon-wave

# Build and deploy to neonsignal public directory
make deploy THEME=neon-synth
```

## License

Apache License 2.0. See [LICENSE](LICENSE).

---

AI-Agents used at 99%
