onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib signed_mul_opt

do {wave.do}

view wave
view structure
view signals

do {signed_mul.udo}

run -all

quit -force
