onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib DRAM_opt

do {wave.do}

view wave
view structure
view signals

do {DRAM.udo}

run -all

quit -force
