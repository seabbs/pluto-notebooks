#!/usr/bin/env julia

"""
Launch Pluto notebook editor for development.

Simple script to start Pluto on a fixed port for notebook editing.
"""

using Pluto

const PLUTO_PORT = 1234

function main()
    println("🚀 Starting Pluto notebook editor...")
    println("Port: $PLUTO_PORT")
    println("Directory: $(pwd())")
    println("Edit notebooks in: src/")
    println()
    
    # Start Pluto on fixed port
    Pluto.run(
        port=PLUTO_PORT,
        host="127.0.0.1",
        launch_browser=true,
        require_secret_for_access=false  # No secret needed for localhost
    )
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end