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

function commit_changes(push_to_remote=false)
    """Commit all changes with timestamp."""
    timestamp = Dates.format(now(), "yyyy-mm-dd HH:MM:SS")
    commit_msg = "Auto-commit: notebook updates at $timestamp\n\n🤖 Generated with [Claude Code](https://claude.ai/code)\n\nCo-Authored-By: Claude <noreply@anthropic.com>"
    
    run(`git add .`)
    run(`git commit -m $commit_msg`)
    
    println("✓ Committed changes: Auto-commit at $timestamp")
    
    if push_to_remote
        try
            run(`git push origin main`)
            println("✓ Pushed to remote repository")
        catch e
            println("⚠ Failed to push to remote: $e")
        end
    end
end

function main()
    if !isdir(".git")
        println("Error: Not in a git repository")
        exit(1)
    end
    
    # Check for --push flag
    push_to_remote = "--push" in ARGS
    
    if git_status()
        commit_changes(push_to_remote)
    else
        println("No changes to commit")
    end
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end