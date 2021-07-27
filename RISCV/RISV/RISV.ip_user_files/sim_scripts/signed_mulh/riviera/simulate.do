onbreak {quit -force}
onerror {quit -force}

asim +access +r +m+signed_mulh -L xpm -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.signed_mulh xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {signed_mulh.udo}

run -all

endsim

quit -force
