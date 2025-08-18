### A Pluto.jl notebook ###
# v0.20.15

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    #! format: off
    return quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
    #! format: on
end

# ╔═╡ 12345678-1234-5678-9012-123456789012
md"""
# Interactive Data Visualisation Example

This notebook demonstrates PlutoUI interactivity that will work on the deployed site through PlutoSliderServer.
"""

# ╔═╡ 23456789-2345-6789-0123-234567890123
md"""
## Simple Slider Example

Use the slider below to change the number of points in a scatter plot:
"""

# ╔═╡ 34567890-3456-7890-1234-345678901234
@bind n_points Slider(10:10:100, default=50, show_value=true)

# ╔═╡ 45678901-4567-8901-2345-456789012345
begin
	Random.seed!(42)
	x = randn(n_points)
	y = randn(n_points)
	
	scatter(x, y, 
		title="Scatter Plot with $n_points Points",
		xlabel="X values",
		ylabel="Y values",
		alpha=0.7,
		markersize=4)
end

# ╔═╡ 56789012-5678-9012-3456-567890123456
md"""
## Function Visualiser

Choose a function and adjust parameters:
"""

# ╔═╡ 67890123-6789-0123-4567-678901234567
@bind func_type Select(["sin", "cos", "tan", "exp"])

# ╔═╡ 78901234-7890-1234-5678-789012345678
@bind amplitude Slider(0.5:0.1:2.0, default=1.0, show_value=true)

# ╔═╡ 89012345-8901-2345-6789-890123456789
@bind frequency Slider(0.5:0.1:3.0, default=1.0, show_value=true)

# ╔═╡ 90123456-9012-3456-7890-901234567890
begin
	x_vals = -2π:0.1:2π
	
	if func_type == "sin"
		y_vals = amplitude .* sin.(frequency .* x_vals)
	elseif func_type == "cos"
		y_vals = amplitude .* cos.(frequency .* x_vals)
	elseif func_type == "tan"
		y_vals = amplitude .* tan.(frequency .* x_vals)
		y_vals = clamp.(y_vals, -5, 5)  # Clamp for better visualisation
	elseif func_type == "exp"
		y_vals = amplitude .* exp.(frequency .* x_vals / 5)  # Scale for visibility
		y_vals = clamp.(y_vals, -10, 10)
	end
	
	plot(x_vals, y_vals,
		title="$func_type function: amplitude=$amplitude, frequency=$frequency",
		xlabel="x",
		ylabel="y",
		linewidth=2,
		legend=false)
end

# ╔═╡ 01234567-0123-4567-8901-012345678901
md"""
## Summary

This notebook shows:
- Interactive sliders that update plots in real-time
- Multiple UI elements working together
- Function visualisation with parameter control

When deployed via PlutoSliderServer, these interactive elements will work on the static website without requiring a Julia server!
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.11.6"
manifest_format = "2.0"
project_hash = "da39a3ee5e6b4b0d3255bfef95601890afd80709"

[deps]
"""

# ╔═╡ Cell order:
# ╟─12345678-1234-5678-9012-123456789012
# ╟─23456789-2345-6789-0123-234567890123
# ╟─34567890-3456-7890-1234-345678901234
# ╟─45678901-4567-8901-2345-456789012345
# ╟─56789012-5678-9012-3456-567890123456
# ╟─67890123-6789-0123-4567-678901234567
# ╟─78901234-7890-1234-5678-789012345678
# ╟─89012345-8901-2345-6789-890123456789
# ╟─90123456-9012-3456-7890-901234567890
# ╟─01234567-0123-4567-8901-012345678901
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
