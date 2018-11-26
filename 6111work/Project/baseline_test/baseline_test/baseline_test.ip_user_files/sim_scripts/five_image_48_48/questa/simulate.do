onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib five_image_48_48_opt

do {wave.do}

view wave
view structure
view signals

do {five_image_48_48.udo}

run -all

quit -force
