# Pluto Notebooks

A collection of interactive Julia notebooks built with [Pluto.jl](https://plutojl.org/) and deployed using [PlutoPages.jl](https://plutojl.org/en/docs/plutopages/).

## Getting Started

### Local Development

1. Install Julia (version 1.9 or later)
2. Clone this repository:
   ```bash
   git clone <repository-url>
   cd pluto-notebooks
   ```

3. Install dependencies:
   ```julia
   using Pkg
   Pkg.activate(".")
   Pkg.instantiate()
   ```

4. Launch the development server:
   ```julia
   julia scripts/launch_server.jl
   ```

### Adding New Notebooks

1. Create your notebook in the `src/` directory
2. Ensure it's a valid Pluto.jl notebook
3. The notebook will be automatically included in the site

### Deployment

This repository is configured for automatic deployment to GitHub Pages.
Push to the `main` branch to trigger deployment.

## Project Structure

```
pluto-notebooks/
├── Project.toml          # Julia project configuration
├── src/                  # Pluto notebooks
│   └── index.jl         # Homepage notebook
├── scripts/             # Utility scripts
│   ├── launch_server.jl # Development server
│   └── auto_commit.jl   # Auto-commit utility
├── logs/                # Log files
└── .github/             # GitHub Actions workflows
    └── workflows/
        └── deploy.yml   # Deployment workflow
```