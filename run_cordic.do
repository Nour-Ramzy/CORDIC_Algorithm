vlib work      
vlog CORDIC.v tb.v     
vsim -voptargs=+acc work.tb 
add wave *
run -all
#quit -sim