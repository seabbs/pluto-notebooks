#!/usr/bin/env julia

"""
Launch PlutoPages server for local development.

Usage:
    julia scripts/launch_server.jl [--port PORT] [--host HOST]
"""

using PlutoPages
using Dates

function main()
    # Default settings
    port = 8000
    host = "localhost"
    
    # Parse command line arguments
    for i in 1:length(ARGS)
        if ARGS[i] == "--port" && i < length(ARGS)
            port = parse(Int, ARGS[i+1])
        elseif ARGS[i] == "--host" && i < length(ARGS)
            host = ARGS[i+1]
        end
    end
    
    println("Starting PlutoPages server...")
    println("Host: $host")
    println("Port: $port")
    println("Time: $(now())")
    
    # Start the server
    PlutoPages.serve(; host=host, port=port)
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end