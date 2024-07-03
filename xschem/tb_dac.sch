v {xschem version=3.4.5 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
B 2 -290 390 510 790 {flags=graph
y1=4.7e-05
y2=3.3
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=1e-13
x2=1.4e-05
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
node=out
color=4
dataset=-1
unitx=1
logx=0
logy=0
}
B 2 -290 -90 510 310 {flags=graph
y1=0
y2=1.8
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=1e-13
x2=1.4e-05
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0


dataset=-1
unitx=1
logx=0
logy=0
color="4 6"
node="b6
b7"}
B 2 -290 890 510 1290 {flags=graph
y1=1.9e-05
y2=1.8
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=1e-13
x2=1.4e-05
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
node="out2
"
color=7
dataset=-1
unitx=1
logx=0
logy=0
}
T {Simulation} -290 320 0 0 1 1 {}
T {Bit 6 and 7} -300 -170 0 0 1 1 {}
T {Post layout simulation} -290 810 0 0 1 1 {}
N -540 -40 -540 -20 {
lab=GND}
N -570 -120 -540 -120 {
lab=b3}
N -540 -120 -540 -100 {
lab=b3}
N -660 -40 -660 -20 {
lab=GND}
N -690 -120 -660 -120 {
lab=b2}
N -660 -120 -660 -100 {
lab=b2}
N -770 -40 -770 -20 {
lab=GND}
N -800 -120 -770 -120 {
lab=b1}
N -770 -120 -770 -100 {
lab=b1}
N -890 -40 -890 -20 {
lab=GND}
N -920 -120 -890 -120 {
lab=b0}
N -890 -120 -890 -100 {
lab=b0}
N -660 330 -590 330 {
lab=#net1}
N -540 150 -540 170 {
lab=GND}
N -570 70 -540 70 {
lab=b7}
N -540 70 -540 90 {
lab=b7}
N -660 150 -660 170 {
lab=GND}
N -690 70 -660 70 {
lab=b6}
N -660 70 -660 90 {
lab=b6}
N -770 150 -770 170 {
lab=GND}
N -800 70 -770 70 {
lab=b5}
N -770 70 -770 90 {
lab=b5}
N -890 150 -890 170 {
lab=GND}
N -920 70 -890 70 {
lab=b4}
N -890 70 -890 90 {
lab=b4}
N -1160 310 -960 310 {
lab=#net2}
N -960 310 -960 330 {
lab=#net2}
N -1160 410 -1100 410 {
lab=#net3}
N -1100 360 -1100 410 {
lab=#net3}
N -1100 350 -1100 360 {
lab=#net3}
N -1100 350 -960 350 {
lab=#net3}
N -1160 510 -1080 510 {
lab=#net4}
N -1080 370 -1080 510 {
lab=#net4}
N -1080 370 -960 370 {
lab=#net4}
N -1060 390 -960 390 {
lab=#net5}
N -1060 390 -1060 610 {
lab=#net5}
N -1160 610 -1060 610 {
lab=#net5}
N -1040 410 -960 410 {
lab=#net6}
N -1040 410 -1040 710 {
lab=#net6}
N -1160 710 -1040 710 {
lab=#net6}
N -1160 810 -1020 810 {
lab=#net7}
N -1020 430 -1020 810 {
lab=#net7}
N -1020 430 -960 430 {
lab=#net7}
N -1000 450 -960 450 {
lab=#net8}
N -1000 450 -1000 910 {
lab=#net8}
N -1160 910 -1000 910 {
lab=#net8}
N -1160 910 -1000 910 {
lab=#net8}
N -1160 1010 -980 1010 {
lab=#net9}
N -980 470 -960 470 {
lab=#net9}
N -980 470 -980 1010 {
lab=#net9}
N -1370 -120 -1370 -110 {
lab=vcc}
N -1370 -50 -1370 -40 {
lab=GND}
N -1460 -120 -1460 -110 {
lab=vdd}
N -1460 -50 -1460 -40 {
lab=GND}
N -1170 290 -1160 290 {
lab=vdd}
N -1170 270 -1160 270 {
lab=vcc}
N -1160 390 -1150 390 {
lab=vdd}
N -1160 370 -1150 370 {
lab=vcc}
N -1160 490 -1150 490 {
lab=vdd}
N -1160 470 -1150 470 {
lab=vcc}
N -1160 590 -1150 590 {
lab=vdd}
N -1160 570 -1150 570 {
lab=vcc}
N -1160 690 -1150 690 {
lab=vdd}
N -1160 670 -1150 670 {
lab=vcc}
N -1160 790 -1150 790 {
lab=vdd}
N -1160 770 -1150 770 {
lab=vcc}
N -1160 890 -1150 890 {
lab=vdd}
N -1160 870 -1150 870 {
lab=vcc}
N -1160 990 -1150 990 {
lab=vdd}
N -1160 970 -1150 970 {
lab=vcc}
N -590 330 -590 550 {
lab=#net1}
N -590 550 -420 550 {
lab=#net1}
N -420 550 -420 590 {
lab=#net1}
C {r2r.sym} -810 410 0 0 {name=x1}
C {devices/lab_pin.sym} -1460 270 0 0 {name=p1 sig_type=std_logic lab=b0}
C {devices/lab_pin.sym} -1460 370 0 0 {name=p2 sig_type=std_logic lab=b1}
C {devices/lab_pin.sym} -1460 470 0 0 {name=p3 sig_type=std_logic lab=b2}
C {devices/lab_pin.sym} -1460 570 0 0 {name=p4 sig_type=std_logic lab=b3}
C {devices/lab_pin.sym} -720 590 0 0 {name=p5 sig_type=std_logic lab=out}
C {devices/code.sym} -940 1180 0 0 {name=TT_MODELS
only_toplevel=true
format="tcleval( @value )"
value="
** opencircuitdesign pdks install
.lib $::SKYWATER_MODELS/sky130.lib.spice tt

"
spice_ignore=false}
C {devices/vsource.sym} -540 -70 0 0 {name=V1 value="pulse(0 1.8 0 10p 10p 400n 800n)" savecurrent=false}
C {devices/gnd.sym} -540 -20 0 0 {name=l1 lab=GND}
C {devices/lab_pin.sym} -570 -120 0 0 {name=p6 sig_type=std_logic lab=b3}
C {devices/vsource.sym} -660 -70 0 0 {name=V2 value="pulse(0 1.8 0 10p 10p 200n 400n)" savecurrent=false}
C {devices/gnd.sym} -660 -20 0 0 {name=l2 lab=GND}
C {devices/lab_pin.sym} -690 -120 0 0 {name=p7 sig_type=std_logic lab=b2}
C {devices/vsource.sym} -770 -70 0 0 {name=V3 value="pulse(0 1.8 0 10p 10p 100n 200n)" savecurrent=false}
C {devices/gnd.sym} -770 -20 0 0 {name=l3 lab=GND}
C {devices/lab_pin.sym} -800 -120 0 0 {name=p8 sig_type=std_logic lab=b1}
C {devices/vsource.sym} -890 -70 0 0 {name=V4 value="pulse(0 1.8 0 10p 10p 50n 100n)" savecurrent=false}
C {devices/gnd.sym} -890 -20 0 0 {name=l4 lab=GND}
C {devices/lab_pin.sym} -920 -120 0 0 {name=p9 sig_type=std_logic lab=b0
}
C {devices/gnd.sym} -660 350 0 0 {name=l7 lab=GND}
C {devices/launcher.sym} -460 1280 0 0 {name=h5
descr="load waves" 
tclcommand="xschem raw_read $netlist_dir/tb_dac.raw tran"
}
C {devices/gnd.sym} -660 370 0 0 {name=l9 lab=GND}
C {devices/code.sym} -780 1180 0 0 {name=SIMULATION
only_toplevel=false 
value="
* .options filetype=ascii
.control
*tran 1n 128n uic
tran 1n 14000n uic
write tb_dac.raw
.endc
.end
"}
C {devices/lab_pin.sym} -1460 670 0 0 {name=p10 sig_type=std_logic lab=b4}
C {devices/lab_pin.sym} -1460 770 0 0 {name=p11 sig_type=std_logic lab=b5}
C {devices/lab_pin.sym} -1460 870 0 0 {name=p12 sig_type=std_logic lab=b6}
C {devices/lab_pin.sym} -1460 970 0 0 {name=p13 sig_type=std_logic lab=b7
}
C {devices/vsource.sym} -540 120 0 0 {name=V5 value="pulse(0 1.8 0 10p 10p 6400n 12800n)" savecurrent=false}
C {devices/gnd.sym} -540 170 0 0 {name=l5 lab=GND}
C {devices/lab_pin.sym} -570 70 0 0 {name=p14 sig_type=std_logic lab=b7}
C {devices/vsource.sym} -660 120 0 0 {name=V6 value="pulse(0 1.8 0 10p 10p 3200n 6400n)" savecurrent=false}
C {devices/gnd.sym} -660 170 0 0 {name=l6 lab=GND}
C {devices/lab_pin.sym} -690 70 0 0 {name=p15 sig_type=std_logic lab=b6}
C {devices/vsource.sym} -770 120 0 0 {name=V7 value="pulse(0 1.8 0 10p 10p 1600n 3200n)" savecurrent=false}
C {devices/gnd.sym} -770 170 0 0 {name=l10 lab=GND}
C {devices/lab_pin.sym} -800 70 0 0 {name=p16 sig_type=std_logic lab=b5}
C {devices/vsource.sym} -890 120 0 0 {name=V8 value="pulse(0 1.8 0 10p 10p 800n 1600n)" savecurrent=false}
C {devices/gnd.sym} -890 170 0 0 {name=l11 lab=GND}
C {devices/lab_pin.sym} -920 70 0 0 {name=p17 sig_type=std_logic lab=b4

}
C {dac_drive.sym} -1310 300 0 0 {name=x2}
C {dac_drive.sym} -1310 400 0 0 {name=x3}
C {dac_drive.sym} -1310 500 0 0 {name=x4}
C {dac_drive.sym} -1310 600 0 0 {name=x5}
C {dac_drive.sym} -1310 700 0 0 {name=x6}
C {dac_drive.sym} -1310 800 0 0 {name=x7}
C {dac_drive.sym} -1310 900 0 0 {name=x8}
C {dac_drive.sym} -1310 1000 0 0 {name=x9}
C {devices/vsource.sym} -1370 -80 0 0 {name=V9 value=3.3 savecurrent=false}
C {devices/gnd.sym} -1370 -40 0 0 {name=l12 lab=GND}
C {devices/lab_pin.sym} -1370 -120 2 1 {name=p18 sig_type=std_logic lab=vcc
}
C {devices/vsource.sym} -1460 -80 0 0 {name=V10 value=1.8 savecurrent=false}
C {devices/gnd.sym} -1460 -40 0 0 {name=l13 lab=GND}
C {devices/lab_pin.sym} -1460 -120 2 1 {name=p19 sig_type=std_logic lab=vdd
}
C {devices/lab_pin.sym} -1160 290 2 0 {name=p20 sig_type=std_logic lab=vdd
}
C {devices/lab_pin.sym} -1160 270 2 0 {name=p21 sig_type=std_logic lab=vcc
}
C {devices/lab_pin.sym} -1150 390 2 0 {name=p22 sig_type=std_logic lab=vdd
}
C {devices/lab_pin.sym} -1150 370 2 0 {name=p23 sig_type=std_logic lab=vcc
}
C {devices/lab_pin.sym} -1150 490 2 0 {name=p24 sig_type=std_logic lab=vdd
}
C {devices/lab_pin.sym} -1150 470 2 0 {name=p25 sig_type=std_logic lab=vcc
}
C {devices/lab_pin.sym} -1150 590 2 0 {name=p26 sig_type=std_logic lab=vdd
}
C {devices/lab_pin.sym} -1150 570 2 0 {name=p27 sig_type=std_logic lab=vcc
}
C {devices/lab_pin.sym} -1150 690 2 0 {name=p28 sig_type=std_logic lab=vdd
}
C {devices/lab_pin.sym} -1150 670 2 0 {name=p29 sig_type=std_logic lab=vcc
}
C {devices/lab_pin.sym} -1150 790 2 0 {name=p30 sig_type=std_logic lab=vdd
}
C {devices/lab_pin.sym} -1150 770 2 0 {name=p31 sig_type=std_logic lab=vcc
}
C {devices/lab_pin.sym} -1150 890 2 0 {name=p32 sig_type=std_logic lab=vdd
}
C {devices/lab_pin.sym} -1150 870 2 0 {name=p33 sig_type=std_logic lab=vcc
}
C {devices/lab_pin.sym} -1150 990 2 0 {name=p34 sig_type=std_logic lab=vdd
}
C {devices/lab_pin.sym} -1150 970 2 0 {name=p35 sig_type=std_logic lab=vcc
}
C {devices/gnd.sym} -1160 330 0 0 {name=l14 lab=GND}
C {devices/gnd.sym} -1160 430 0 0 {name=l15 lab=GND}
C {devices/gnd.sym} -1160 530 0 0 {name=l16 lab=GND}
C {devices/gnd.sym} -1160 630 0 0 {name=l17 lab=GND}
C {devices/gnd.sym} -1160 730 0 0 {name=l18 lab=GND}
C {devices/gnd.sym} -1160 830 0 0 {name=l19 lab=GND}
C {devices/gnd.sym} -1160 930 0 0 {name=l20 lab=GND}
C {devices/gnd.sym} -1160 1030 0 0 {name=l21 lab=GND}
C {pad_model.sym} -570 610 0 0 {name=x10}
C {devices/gnd.sym} -720 630 0 0 {name=l8 lab=GND}
