#!/usr/bin/env julia

"""
Launch PlutoPages development server.

Usage:
    julia scripts/launch_server.jl

Opens PlutoPages development dashboard and site preview.
"""

using PlutoPages
using Dates

const SITE_DIR = joinpath(dirname(dirname(@__FILE__)), "src")

function launch_development_server()
    try
        println("=== PlutoPages Development Server ===")
        println("Time: $(now())")
        println("Site directory: $SITE_DIR")
        
        # Ensure directories exist
        log_dir = joinpath(dirname(dirname(@__FILE__)), "logs")
        isdir(log_dir) || mkdir(log_dir)
        
        # Verify site directory exists
        if !isdir(SITE_DIR)
            error("Site directory does not exist: $SITE_DIR")
        end
        
        println("Launching PlutoPages development server...")
        println("This will open two browser tabs:")
        println("  1. PlutoPages development dashboard")
        println("  2. Website preview")
        println("Changes to files in src/ will auto-regenerate the site.")
        println()
        
        # Start PlutoPages development server
        # This opens the development dashboard and site preview
        project_root = dirname(dirname(@__FILE__))
        input_dir = joinpath(project_root, "src")
        output_dir = joinpath(project_root, "generated_site")
        cache_dir = joinpath(project_root, ".cache")
        
        println("Starting PlutoPages.develop()...")
        println("This will open the PlutoPages development dashboard")
        println("Input: $input_dir")
        println("Output: $output_dir")
        println()
        
        PlutoPages.develop(
            input_dir=input_dir,
            output_dir=output_dir,
            cache_dir=cache_dir
        )
        
    catch e
        println("ERROR: Failed to start development server")
        println("Error: $e")
        
        # More detailed error info
        if e isa MethodError
            println("\nThis might be due to:")
            println("- Missing dependencies (run: julia --project -e 'using Pkg; Pkg.instantiate()')")
            println("- Incorrect PlutoPages version")
        end
        
        println("\nStack trace:")
        for (exc, bt) in Base.catch_stack()
            showerror(stdout, exc, bt)
            println()
        end
        exit(1)
    end
end

if abspath(PROGRAM_FILE) == @__FILE__
    launch_development_server()
end