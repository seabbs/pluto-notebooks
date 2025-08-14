#!/usr/bin/env julia

"""
Launch PlutoPages server for local development.

Usage:
    julia scripts/launch_server.jl [--port PORT] [--host HOST]
"""

using PlutoPages
using Dates

const PLUTO_PORT = parse(Int, get(ENV, "PLUTO_PORT", "1234"))
const SITE_PORT = parse(Int, get(ENV, "PLUTOPAGES_PORT", "8080"))
const SITE_DIR = joinpath(dirname(dirname(@__FILE__)), "src")

function launch_development_server()
    try
        println("Starting PlutoPages development server...")
        println("Site directory: $SITE_DIR")
        println("Pluto port: $PLUTO_PORT")
        println("PlutoPages port: $SITE_PORT")
        println("Time: $(now())")
        
        # Ensure log directory exists
        log_dir = joinpath(dirname(dirname(@__FILE__)), "logs")
        isdir(log_dir) || mkdir(log_dir)
        
        # Verify site directory exists
        if !isdir(SITE_DIR)
            error("Site directory does not exist: $SITE_DIR")
        end
        
        # Start PlutoPages development server
        println("Launching PlutoPages.develop() for directory: $SITE_DIR")
        PlutoPages.develop(SITE_DIR; host="localhost", port=SITE_PORT)
        
    catch e
        println("ERROR: Failed to start development server: $e")
        println("Stack trace:")
        for (exc, bt) in Base.catch_stack()
            showerror(stdout, exc, bt)
            println()
        end
        exit(1)
    end
end

function main()
    # Default settings (for backwards compatibility)
    port = 8000
    host = "localhost"
    
    # Parse command line arguments
    for i in 1:length(ARGS)
        if ARGS[i] == "--port" && i < length(ARGS)
            port = parse(Int, ARGS[i+1])
        elseif ARGS[i] == "--host" && i < length(ARGS)
            host = ARGS[i+1]
        elseif ARGS[i] == "--develop"
            # Use the development server instead
            launch_development_server()
            return
        end
    end
    
    # Check if we should use development mode based on environment
    if haskey(ENV, "PLUTOPAGES_PORT")
        launch_development_server()
        return
    end
    
    println("Starting PlutoPages server...")
    println("Host: $host")
    println("Port: $port")
    println("Time: $(now())")
    
    try
        # Start the regular server
        PlutoPages.serve(; host=host, port=port)
    catch e
        println("ERROR: Failed to start server: $e")
        println("Stack trace:")
        for (exc, bt) in Base.catch_stack()
            showerror(stdout, exc, bt)
            println()
        end
        exit(1)
    end
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end