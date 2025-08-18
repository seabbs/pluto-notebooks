# Simple Pluto Development Workflow 🎯

## Perfect Setup for Notebook Development

### 🚀 Start Pluto Editor (Fixed URL)

**Option 1: Manual start**
```bash
julia --project scripts/pluto_editor.jl
```

**Option 2: Persistent service**  
```bash
./scripts/manage_service.sh start
```

Both give you: **http://localhost:1234** (no secret needed!)

### 📝 Development Process

1. **Edit notebooks**: Open http://localhost:1234
   - Navigate to your `src/` folder
   - Edit `index.jl` and `interactive-example.jl` 
   - Create new notebooks as needed

2. **Save and commit**: When happy with changes
   ```bash
   git add src/
   git commit -m "Updated notebooks"
   git push
   ```

3. **Auto-deploy**: GitHub Actions automatically:
   - Detects push to main branch
   - Runs PlutoPages.generate() 
   - Builds static HTML from notebooks
   - Deploys to `pluto.samabbott.co.uk`
   - Preserves interactive elements via PlutoSliderServer

### 🌐 Result

- **Local development**: http://localhost:1234 (Pluto editor)  
- **Production site**: https://pluto.samabbott.co.uk (deployed notebooks)

### ✅ What Works

- Fixed localhost URL (no changing secrets)
- Persistent service that auto-starts on login
- Interactive notebooks with PlutoUI sliders
- Automatic deployment on git push
- Custom domain with HTTPS

### 🎉 Ready to Use!

Your setup is complete. You can:

1. **Start developing**: `julia --project scripts/pluto_editor.jl`
2. **Make it persistent**: `./scripts/manage_service.sh start`  
3. **Push to deploy**: Commit and push to GitHub

The PlutoPages complexity is hidden - you just edit notebooks and push!