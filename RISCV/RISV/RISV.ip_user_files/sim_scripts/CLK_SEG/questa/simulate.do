onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib CLK_SEG_opt

do {wave.do}

view wave
view structure
view signals

do {CLK_SEG.udo}

run -all

quit -force
