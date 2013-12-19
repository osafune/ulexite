# ------------------------------------------
# Create generated clocks based on PLLs

derive_pll_clocks -create_base_clocks


# ------------------------------------------
# Original Clock Setting:

create_clock -period "20.000 ns" -name {CLOCK_50} {CLOCK_50}
create_clock -period "20.000 ns" -name {CLOCK_50_2} {CLOCK_50_2}


