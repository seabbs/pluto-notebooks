#!/usr/bin/env julia

"""
Serve built PlutoPages site on fixed ports.

This script:
1. Generates the static site using PlutoPages.generate()
2. Serves the built site on a fixed port
3. Provides a simple file server without secrets
"""

using PlutoPages
using HTTP
using Sockets
using Dates

const SITE_PORT = 8080
const DASHBOARD_PORT = 8081

function generate_site()
    """Generate static site from notebooks."""
    println("Generating static site...")
    
    project_root = dirname(dirname(@__FILE__))
    input_dir = joinpath(project_root, "src")
    output_dir = joinpath(project_root, "generated_site") 
    cache_dir = joinpath(project_root, ".cache")
    
    # Generate the site
    PlutoPages.generate(
        input_dir=input_dir,
        output_dir=output_dir, 
        cache_dir=cache_dir
    )
    
    println("✓ Site generated in: $output_dir")
    return output_dir
end

function serve_directory(directory::String, port::Int, name::String)
    """Serve a directory on the specified port."""
    println("Starting $name on http://localhost:$port")
    
    # Simple file server
    HTTP.serve("127.0.0.1", port) do request::HTTP.Request
        # Parse the requested path
        path = HTTP.URI(request.target).path
        if path == "/"
            path = "/index.html"
        end
        
        # Remove leading slash and construct file path
        file_path = joinpath(directory, lstrip(path, '/'))
        
        try
            if isfile(file_path)
                content = read(file_path)
                # Determine content type
                ext = lowercase(splitext(file_path)[2])
                content_type = if ext == ".html"
                    "text/html"
                elseif ext == ".css"
                    "text/css"
                elseif ext == ".js"
                    "application/javascript"
                elseif ext == ".json"
                    "application/json"
                else
                    "application/octet-stream"
                end
                
                return HTTP.Response(200, ["Content-Type" => content_type], content)
            else
                # Try index.html in subdirectories
                index_path = joinpath(file_path, "index.html")
                if isfile(index_path)
                    content = read(index_path)
                    return HTTP.Response(200, ["Content-Type" => "text/html"], content)
                else
                    return HTTP.Response(404, "File not found: $path")
                end
            end
        catch e
            println("Error serving $file_path: $e")
            return HTTP.Response(500, "Internal server error")
        end
    end
end

function create_dashboard_html(site_port::Int)
    """Create a simple dashboard HTML page."""
    html = """
    <!DOCTYPE html>
    <html>
    <head>
        <title>PlutoPages Dashboard</title>
        <meta charset="utf-8">
        <style>
            body { font-family: system-ui, sans-serif; max-width: 800px; margin: 2em auto; padding: 0 2em; }
            .header { text-align: center; margin-bottom: 2em; }
            .card { background: #f8f9fa; border-radius: 8px; padding: 1.5em; margin: 1em 0; }
            .status { color: #28a745; font-weight: bold; }
            a { color: #007bff; text-decoration: none; }
            a:hover { text-decoration: underline; }
            .refresh { background: #007bff; color: white; border: none; padding: 0.5em 1em; border-radius: 4px; cursor: pointer; }
            .refresh:hover { background: #0056b3; }
        </style>
        <script>
            function refreshSite() {
                fetch('/regenerate', { method: 'POST' })
                    .then(response => response.text())
                    .then(data => {
                        alert('Site regeneration triggered!');
                        setTimeout(() => window.location.reload(), 2000);
                    })
                    .catch(error => alert('Error: ' + error));
            }
        </script>
    </head>
    <body>
        <div class="header">
            <h1>📚 PlutoPages Dashboard</h1>
            <p class="status">● Server Running</p>
        </div>
        
        <div class="card">
            <h2>🌐 Site Preview</h2>
            <p>Your generated site is available at:</p>
            <p><strong><a href="http://localhost:$site_port" target="_blank">http://localhost:$site_port</a></strong></p>
        </div>
        
        <div class="card">
            <h2>📝 Development</h2>
            <p>Edit your notebooks in the <code>src/</code> directory:</p>
            <ul>
                <li>index.jl/.jlmd (Homepage)</li>
                <li>Standalone .jl files or notebook folders</li>
                <li>Use <code>task create &lt;name&gt;</code> for new notebook folders</li>
            </ul>
        </div>
        
        <div class="card">
            <h2>🔄 Site Regeneration</h2>
            <p>To regenerate the site after making changes:</p>
            <button class="refresh" onclick="refreshSite()">Regenerate Site</button>
            <p><small>Or use the file watcher: <code>./scripts/watch_and_commit.sh</code></small></p>
        </div>
        
        <div class="card">
            <h2>⚙️ Server Info</h2>
            <p><strong>Dashboard:</strong> http://localhost:$(DASHBOARD_PORT)</p>
            <p><strong>Site Preview:</strong> http://localhost:$site_port</p>
            <p><strong>Last Generated:</strong> $(now())</p>
        </div>
    </body>
    </html>
    """
    return html
end

function serve_dashboard(port::Int, site_port::Int)
    """Serve the dashboard on the specified port."""
    println("Starting Dashboard on http://localhost:$port")
    
    HTTP.serve("127.0.0.1", port) do request::HTTP.Request
        if request.method == "GET" && request.target == "/"
            return HTTP.Response(200, ["Content-Type" => "text/html"], create_dashboard_html(site_port))
        elseif request.method == "POST" && request.target == "/regenerate"
            try
                generate_site()
                return HTTP.Response(200, "Site regenerated successfully!")
            catch e
                return HTTP.Response(500, "Error regenerating site: $e")
            end
        else
            return HTTP.Response(404, "Not found")
        end
    end
end

function main()
    println("=== PlutoPages Fixed-Address Server ===")
    println("Time: $(now())")
    println()
    
    # Generate initial site
    site_dir = generate_site()
    
    println()
    println("🌐 Starting servers...")
    println("Dashboard: http://localhost:$DASHBOARD_PORT")
    println("Site Preview: http://localhost:$SITE_PORT")
    println()
    println("Press Ctrl+C to stop")
    println()
    
    # Start both servers
    @async serve_dashboard(DASHBOARD_PORT, SITE_PORT)
    serve_directory(site_dir, SITE_PORT, "Site Preview")
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end