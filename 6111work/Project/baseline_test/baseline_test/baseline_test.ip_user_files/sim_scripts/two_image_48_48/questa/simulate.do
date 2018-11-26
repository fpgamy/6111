onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib two_image_48_48_opt

do {wave.do}

view wave
view structure
view signals

do {two_image_48_48.udo}

run -all

quit -force
