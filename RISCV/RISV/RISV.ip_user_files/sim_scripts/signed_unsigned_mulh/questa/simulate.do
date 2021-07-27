onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib signed_unsigned_mulh_opt

do {wave.do}

view wave
view structure
view signals

do {signed_unsigned_mulh.udo}

run -all

quit -force
