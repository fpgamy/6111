onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib one_image_48_48_opt

do {wave.do}

view wave
view structure
view signals

do {one_image_48_48.udo}

run -all

quit -force
