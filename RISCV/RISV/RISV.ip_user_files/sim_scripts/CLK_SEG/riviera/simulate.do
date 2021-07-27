onbreak {quit -force}
onerror {quit -force}

asim +access +r +m+CLK_SEG -L xpm -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.CLK_SEG xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {CLK_SEG.udo}

run -all

endsim

quit -force
