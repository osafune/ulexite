# ------------------------------------------
# Create generated clocks based on PLLs

derive_pll_clocks -create_base_clocks


# ------------------------------------------
# Original Clock Setting:

create_clock -period "20.000 ns" -name {CLOCK_50} {CLOCK_50}
create_clock -period "20.000 ns" -name {CLOCK_50_2} {CLOCK_50_2}


# ---------------------------------------------
# The following Clock Group Setting:

set_clock_groups -asynchronous \
	-group { \
		avpll|altpll_component|auto_generated|pll1|clk[0] \
		avpll|altpll_component|auto_generated|pll1|clk[1] \
		CLOCK_50 \
	} \
	-group { \
		syspll|altpll_component|auto_generated|pll1|clk[1] \
		syspll|altpll_component|auto_generated|pll1|clk[2] \
		CLOCK_50_2 \
	}


# ---------------------------------------------

