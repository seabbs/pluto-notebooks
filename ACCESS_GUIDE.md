# PlutoPages Access Guide 🎯

## Your Development Server is Running!

### 🌐 Access Points

**PlutoPages Development Dashboard** 
- The development dashboard will be accessible at a localhost URL
- Check the logs to see the exact URL: `./scripts/manage_service.sh logs`
- Look for lines mentioning browser tabs or dashboard URLs

**Site Preview**
- The generated static site preview will also be at a localhost URL  
- This shows how your site will look when deployed to `pluto.samabbott.co.uk`

### 📝 Development Workflow

1. **Find Your URLs**
   ```bash
   ./scripts/manage_service.sh logs
   ```
   Look for messages about browser tabs or dashboard URLs

2. **Edit Notebooks**
   - Edit files in `src/` directory
   - `src/index.jl` - Homepage notebook
   - `src/interactive-example.jl` - Interactive demo

3. **View Changes**
   - PlutoPages automatically regenerates when files change
   - Refresh your browser to see updates
   - Or use "Read input files again" button in dashboard

### 🔧 Service Management

```bash
# Check if running
./scripts/manage_service.sh status

# View recent logs (to find URLs)
./scripts/manage_service.sh logs

# Restart if needed
./scripts/manage_service.sh restart

# Stop service
./scripts/manage_service.sh stop
```

### 🚫 Auto-Commit Disabled

Auto-commit features are available but NOT enabled by default for safety:
- `scripts/auto_commit.jl` - Manual commit tool
- `scripts/watch_and_commit.sh` - File watcher (requires manual start)

To manually commit changes:
```bash
julia --project scripts/auto_commit.jl
```

### 🌍 Deployment

When you're ready to deploy to `pluto.samabbott.co.uk`:
1. Manually commit and push your changes
2. GitHub Actions will automatically deploy
3. Site will be available at your custom domain

### 📋 Current Status

- ✅ Development server running (PID 78)
- ✅ Auto-regeneration enabled
- ✅ Service will restart automatically
- ✅ Service starts on login
- 🚫 Auto-commit disabled (safe)

### 🆘 Troubleshooting

**Can't find the URLs?**
```bash
./scripts/manage_service.sh logs
```

**Service not responding?**
```bash
./scripts/manage_service.sh restart
```

**Need to edit notebooks?**
Open the files in `src/` directory with any editor, or use the Pluto interface once you find the dashboard URL.