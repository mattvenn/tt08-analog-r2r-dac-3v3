v {xschem version=3.4.5 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N 140 -50 140 -20 {
lab=b0}
N 410 -50 410 -20 {
lab=b1}
N 650 -50 650 -20 {
lab=b2}
N 900 -50 900 -20 {
lab=b3}
N 1150 -50 1150 -20 {
lab=b4}
N 1390 -50 1390 -20 {
lab=b5}
N 1640 -50 1640 -20 {
lab=b6}
N 1860 -50 1860 -20 {
lab=b7}
N 140 130 270 130 {
lab=a}
N 140 130 140 160 {
lab=a}
N 330 130 410 130 {
lab=b}
N 410 130 540 130 {
lab=b}
N 600 130 650 130 {
lab=c}
N 650 130 790 130 {
lab=c}
N 850 130 900 130 {
lab=d}
N 900 130 1040 130 {
lab=d}
N 1100 130 1150 130 {
lab=e}
N 1150 130 1280 130 {
lab=e}
N 1340 130 1390 130 {
lab=f}
N 1390 130 1530 130 {
lab=f}
N 1590 130 1640 130 {
lab=g}
N 1640 130 1760 130 {
lab=g}
N 1820 130 1860 130 {
lab=out}
N 1860 130 2000 130 {
lab=out}
N 140 290 140 360 {
lab=VGND}
N 140 40 140 70 {
lab=#net1}
N 410 40 410 70 {
lab=#net2}
N 650 40 650 70 {
lab=#net3}
N 900 40 900 70 {
lab=#net4}
N 1150 40 1150 70 {
lab=#net5}
N 1390 40 1390 70 {
lab=#net6}
N 1640 40 1640 70 {
lab=#net7}
N 1860 40 1860 70 {
lab=#net8}
N 140 220 140 230 {
lab=#net9}
N 380 470 400 470 {
lab=VGND}
N 380 570 400 570 {
lab=VGND}
C {sky130_fd_pr/res_high_po_0p35.sym} 140 10 0 0 {name=R1
L=45
model=res_high_po_1p41
spiceprefix=X
mult=1}
C {sky130_fd_pr/res_high_po_0p35.sym} 410 10 0 0 {name=R7
L=45
model=res_high_po_1p41
spiceprefix=X
mult=1}
C {devices/lab_pin.sym} 390 10 0 0 {name=p11 lab=VGND}
C {sky130_fd_pr/res_high_po_0p35.sym} 650 10 0 0 {name=R10
L=45
model=res_high_po_1p41
spiceprefix=X
mult=1}
C {devices/lab_pin.sym} 630 10 0 0 {name=p12 lab=VGND}
C {sky130_fd_pr/res_high_po_0p35.sym} 900 10 0 0 {name=R13
L=45
model=res_high_po_1p41
spiceprefix=X
mult=1}
C {devices/lab_pin.sym} 880 10 0 0 {name=p13 lab=VGND}
C {sky130_fd_pr/res_high_po_0p35.sym} 1150 10 0 0 {name=R16
L=45
model=res_high_po_1p41
spiceprefix=X
mult=1}
C {devices/lab_pin.sym} 1130 10 0 0 {name=p14 lab=VGND}
C {sky130_fd_pr/res_high_po_0p35.sym} 1390 10 0 0 {name=R19
L=45
model=res_high_po_1p41
spiceprefix=X
mult=1}
C {devices/lab_pin.sym} 1370 10 0 0 {name=p15 lab=VGND}
C {sky130_fd_pr/res_high_po_0p35.sym} 1640 10 0 0 {name=R22
L=45
model=res_high_po_1p41
spiceprefix=X
mult=1}
C {devices/lab_pin.sym} 1620 10 0 0 {name=p16 lab=VGND}
C {sky130_fd_pr/res_high_po_0p35.sym} 1860 10 0 0 {name=R25
L=45
model=res_high_po_1p41
spiceprefix=X
mult=1}
C {devices/lab_pin.sym} 1840 10 0 0 {name=p17 lab=VGND}
C {devices/lab_pin.sym} 120 10 0 0 {name=p18 lab=VGND}
C {sky130_fd_pr/res_high_po_0p35.sym} 300 130 3 0 {name=R5
L=45
model=res_high_po_1p41
spiceprefix=X
mult=1}
C {devices/lab_pin.sym} 300 150 3 0 {name=p20 lab=VGND}
C {sky130_fd_pr/res_high_po_0p35.sym} 570 130 3 0 {name=R8
L=45
model=res_high_po_1p41
spiceprefix=X
mult=1}
C {devices/lab_pin.sym} 570 150 3 0 {name=p22 lab=VGND}
C {sky130_fd_pr/res_high_po_0p35.sym} 820 130 3 0 {name=R11
L=45
model=res_high_po_1p41
spiceprefix=X
mult=1}
C {devices/lab_pin.sym} 820 150 3 0 {name=p24 lab=VGND}
C {sky130_fd_pr/res_high_po_0p35.sym} 1070 130 3 0 {name=R14
L=45
model=res_high_po_1p41
spiceprefix=X
mult=1}
C {devices/lab_pin.sym} 1070 150 3 0 {name=p26 lab=VGND}
C {sky130_fd_pr/res_high_po_0p35.sym} 1310 130 3 0 {name=R17
L=45
model=res_high_po_1p41
spiceprefix=X
mult=1}
C {devices/lab_pin.sym} 1310 150 3 0 {name=p28 lab=VGND}
C {sky130_fd_pr/res_high_po_0p35.sym} 1560 130 3 0 {name=R20
L=45
model=res_high_po_1p41
spiceprefix=X
mult=1}
C {devices/lab_pin.sym} 1560 150 3 0 {name=p30 lab=VGND}
C {sky130_fd_pr/res_high_po_0p35.sym} 1790 130 3 0 {name=R23
L=45
model=res_high_po_1p41
spiceprefix=X
mult=1}
C {devices/lab_pin.sym} 1790 150 3 0 {name=p32 lab=VGND}
C {sky130_fd_pr/res_high_po_0p35.sym} 140 190 0 0 {name=R3
L=45
model=res_high_po_1p41
spiceprefix=X
mult=1}
C {devices/lab_pin.sym} 120 190 0 0 {name=p34 lab=VGND}
C {devices/ipin.sym} 140 -50 0 0 {name=p1 lab=b0}
C {devices/ipin.sym} 410 -50 0 0 {name=p2 lab=b1}
C {devices/ipin.sym} 650 -50 0 0 {name=p3 lab=b2}
C {devices/ipin.sym} 900 -50 0 0 {name=p4 lab=b3}
C {devices/ipin.sym} 1150 -50 0 0 {name=p5 lab=b4}
C {devices/ipin.sym} 1390 -50 0 0 {name=p6 lab=b5
}
C {devices/ipin.sym} 1640 -50 0 0 {name=p7 lab=b6}
C {devices/ipin.sym} 1860 -50 0 0 {name=p8 lab=b7}
C {devices/opin.sym} 2000 130 0 0 {name=p9 lab=out}
C {devices/lab_pin.sym} -30 310 0 0 {name=p19 lab=VGND}
C {devices/iopin.sym} -30 310 0 0 {name=p21 lab=VGND}
C {devices/lab_pin.sym} 140 360 0 0 {name=p23 lab=VGND}
C {sky130_fd_pr/res_high_po_0p35.sym} 140 100 0 0 {name=R2
L=45
model=res_high_po_1p41
spiceprefix=X
mult=1}
C {sky130_fd_pr/res_high_po_0p35.sym} 410 100 0 0 {name=R6
L=45
model=res_high_po_1p41
spiceprefix=X
mult=1}
C {devices/lab_pin.sym} 390 100 0 0 {name=p10 lab=VGND}
C {sky130_fd_pr/res_high_po_0p35.sym} 650 100 0 0 {name=R9
L=45
model=res_high_po_1p41
spiceprefix=X
mult=1}
C {devices/lab_pin.sym} 630 100 0 0 {name=p25 lab=VGND}
C {sky130_fd_pr/res_high_po_0p35.sym} 900 100 0 0 {name=R12
L=45
model=res_high_po_1p41
spiceprefix=X
mult=1}
C {devices/lab_pin.sym} 880 100 0 0 {name=p27 lab=VGND}
C {sky130_fd_pr/res_high_po_0p35.sym} 1150 100 0 0 {name=R15
L=45
model=res_high_po_1p41
spiceprefix=X
mult=1}
C {devices/lab_pin.sym} 1130 100 0 0 {name=p29 lab=VGND}
C {sky130_fd_pr/res_high_po_0p35.sym} 1390 100 0 0 {name=R18
L=45
model=res_high_po_1p41
spiceprefix=X
mult=1}
C {devices/lab_pin.sym} 1370 100 0 0 {name=p31 lab=VGND}
C {sky130_fd_pr/res_high_po_0p35.sym} 1640 100 0 0 {name=R21
L=45
model=res_high_po_1p41
spiceprefix=X
mult=1}
C {devices/lab_pin.sym} 1620 100 0 0 {name=p33 lab=VGND}
C {sky130_fd_pr/res_high_po_0p35.sym} 1860 100 0 0 {name=R24
L=45
model=res_high_po_1p41
spiceprefix=X
mult=1}
C {devices/lab_pin.sym} 1840 100 0 0 {name=p35 lab=VGND}
C {devices/lab_pin.sym} 120 100 0 0 {name=p36 lab=VGND}
C {sky130_fd_pr/res_high_po_0p35.sym} 140 260 0 0 {name=R4
L=45
model=res_high_po_1p41
spiceprefix=X
mult=1}
C {devices/lab_pin.sym} 120 260 0 0 {name=p37 lab=VGND}
C {sky130_fd_pr/res_high_po_0p35.sym} 420 470 0 0 {name=R26
L=45
model=res_high_po_1p41
spiceprefix=X
mult=1}
C {devices/lab_pin.sym} 420 500 0 0 {name=p38 lab=VGND}
C {devices/lab_pin.sym} 380 470 0 0 {name=p40 lab=VGND}
C {devices/lab_pin.sym} 420 440 0 0 {name=p41 lab=VGND}
C {sky130_fd_pr/res_high_po_0p35.sym} 420 570 0 0 {name=R27
L=45
model=res_high_po_1p41
spiceprefix=X
mult=1}
C {devices/lab_pin.sym} 420 600 0 0 {name=p39 lab=VGND}
C {devices/lab_pin.sym} 380 570 0 0 {name=p42 lab=VGND}
C {devices/lab_pin.sym} 420 540 0 0 {name=p43 lab=VGND}
C {devices/lab_wire.sym} 140 130 0 0 {name=p44 sig_type=std_logic lab=a}
C {devices/lab_wire.sym} 410 130 2 0 {name=p45 sig_type=std_logic lab=b}
C {devices/lab_wire.sym} 650 130 2 0 {name=p46 sig_type=std_logic lab=c}
C {devices/lab_wire.sym} 900 130 2 0 {name=p47 sig_type=std_logic lab=d}
C {devices/lab_wire.sym} 1150 130 2 0 {name=p48 sig_type=std_logic lab=e}
C {devices/lab_wire.sym} 1390 130 2 0 {name=p49 sig_type=std_logic lab=f}
C {devices/lab_wire.sym} 1640 130 2 0 {name=p50 sig_type=std_logic lab=g}
