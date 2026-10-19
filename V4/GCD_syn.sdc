###################################################################

# Created by write_sdc on Tue Jun  2 11:23:36 2026

###################################################################
set sdc_version 2.1

set_units -time ns -resistance kOhm -capacitance pF -voltage V -current mA
set_operating_conditions -max slow -max_library slow\
                         -min fast -min_library fast
set_wire_load_model -name tsmc090_wl10 -library slow
set_max_area 0
create_clock [get_ports clk]  -period 10  -waveform {0 5}
set_input_delay -clock clk  0  [get_ports clk]
set_input_delay -clock clk  0  [get_ports start]
set_input_delay -clock clk  0  [get_ports rst_n]
set_input_delay -clock clk  0  [get_ports {inport[7]}]
set_input_delay -clock clk  0  [get_ports {inport[6]}]
set_input_delay -clock clk  0  [get_ports {inport[5]}]
set_input_delay -clock clk  0  [get_ports {inport[4]}]
set_input_delay -clock clk  0  [get_ports {inport[3]}]
set_input_delay -clock clk  0  [get_ports {inport[2]}]
set_input_delay -clock clk  0  [get_ports {inport[1]}]
set_input_delay -clock clk  0  [get_ports {inport[0]}]
set_output_delay -clock clk  0  [get_ports done]
set_output_delay -clock clk  0  [get_ports {outport[7]}]
set_output_delay -clock clk  0  [get_ports {outport[6]}]
set_output_delay -clock clk  0  [get_ports {outport[5]}]
set_output_delay -clock clk  0  [get_ports {outport[4]}]
set_output_delay -clock clk  0  [get_ports {outport[3]}]
set_output_delay -clock clk  0  [get_ports {outport[2]}]
set_output_delay -clock clk  0  [get_ports {outport[1]}]
set_output_delay -clock clk  0  [get_ports {outport[0]}]
