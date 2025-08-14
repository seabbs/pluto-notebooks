#!/usr/bin/env julia

"""
Auto-commit script for PlutoPages notebooks.

Automatically commits changes to notebooks with timestamps.
Useful for development workflow where you want to track notebook evolution.
"""

using Dates

function git_status()
    """Check if there are changes to commit."""
    result = read(`git status --porcelain`, String)
    return !isempty(strip(result))
end

function commit_changes()
    """Commit all changes with timestamp."""
    timestamp = Dates.format(now(), "yyyy-mm-dd HH:MM:SS")
    commit_msg = "Auto-commit: notebook updates at $timestamp"
    
    run(`git add .`)
    run(`git commit -m $commit_msg`)
    
    println("Committed changes: $commit_msg")
end

function main()
    if !isdir(".git")
        println("Error: Not in a git repository")
        exit(1)
    end
    
    if git_status()
        commit_changes()
    else
        println("No changes to commit")
    end
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end