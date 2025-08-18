# PlutoPages Setup Revision Plan

## Issues Identified During Review

### 1. Incorrect PlutoPages API Usage
- **Issue**: Launch script uses wrong method signatures
- **Problem**: `PlutoPages.develop()` expects a path parameter, not keyword arguments for host/port
- **Solution**: Simplify to `PlutoPages.develop(SITE_DIR)`

### 2. Missing PlutoSliderServer Integration
- **Issue**: Not included for interactive notebook exports
- **Impact**: No `@bind` interactivity on deployed site
- **Solution**: Add PlutoSliderServer dependency and configure for static export

### 3. GitHub Actions Workflow Issues
- **Issue**: Using non-existent `PlutoPages.build()` method
- **Problem**: Should use `PlutoPages.generate()` for static site generation
- **Solution**: Update workflow to use correct API

### 4. Auto-commit Not Integrated
- **Issue**: Script exists but not connected to workflow
- **Problem**: No automatic push to GitHub for continuous deployment
- **Solution**: Integrate with file watcher (fswatch)

### 5. Local Testing Not Verified
- **Issue**: Dependencies not installed, functionality not tested
- **Risk**: Unknown if setup actually works
- **Solution**: Install dependencies and test development server

## Learning from Course Example

The [BMLIP course](https://bmlip.github.io/course/) demonstrates:
- Successful Pluto notebook deployment to GitHub Pages
- Interactive notebooks with PlutoSliderServer
- Clean organisation of lecture materials
- Automatic rendering of notebooks to website

## Revised Implementation Strategy

### Phase 1: Core Fixes
1. Update `Project.toml` with correct dependencies
2. Rewrite `launch_server.jl` with proper PlutoPages API
3. Fix GitHub Actions workflow
4. Install and test dependencies

### Phase 2: Enhanced Features
1. Add PlutoSliderServer for interactivity
2. Create example interactive notebook
3. Integrate auto-commit with file watcher
4. Test local development workflow

### Phase 3: Deployment
1. Create GitHub repository 
2. Configure GitHub Pages
3. Test complete deployment pipeline
4. Verify custom domain setup

### Phase 4: Documentation
1. Update README with corrected instructions
2. Document development workflow
3. Create troubleshooting guide
4. Update launchd service configuration if needed

## Key Dependencies

```toml
[deps]
PlutoPages = "d5dc3dd1-4774-47c7-8860-0a1ad9e34b8c"
Pluto = "c3e4b0f8-55cb-11ea-2926-15256bba5781"
PlutoSliderServer = "2fc8631c-6f24-4c5b-bca7-cbb509c42db4"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
Dates = "ade2ca70-3891-5945-98fb-dc099432e06a"
```

## Expected Workflow

1. Edit notebooks in `src/` directory using Pluto
2. PlutoPages development server shows changes at `localhost:????`
3. File watcher triggers auto-commit
4. GitHub Actions builds and deploys to `pluto.samabbott.co.uk`
5. Interactive elements work via PlutoSliderServer precomputation

## Success Criteria

- [ ] Local development server launches successfully
- [ ] Can edit notebooks and see changes immediately
- [ ] Interactive elements (PlutoUI.Slider) work locally
- [ ] GitHub Actions successfully builds and deploys
- [ ] Site accessible at `pluto.samabbott.co.uk`
- [ ] Interactive elements work on deployed site
- [ ] Auto-commit triggers on file changes
- [ ] Persistent service runs on macOS login

## Next Actions

1. Fix core configuration files
2. Test local setup thoroughly
3. Create example interactive content
4. Deploy and verify complete workflow
5. Update documentation with working instructions