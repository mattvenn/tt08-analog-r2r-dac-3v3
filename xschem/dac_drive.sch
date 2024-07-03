v {xschem version=3.4.5 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
T {Transmission gate (incl. level shifting)} 380 -190 0 0 0.4 0.4 {}
N -190 -480 -170 -480 {
lab=ctrl}
N -190 -480 -190 -380 {
lab=ctrl}
N -190 -380 -170 -380 {
lab=ctrl}
N -230 -430 -190 -430 {
lab=ctrl}
N -130 -350 -130 -330 {
lab=VGND}
N -130 -530 -130 -510 {
lab=VDPWR}
N -130 -450 -130 -410 {
lab=ctrl_n}
N -130 -430 -50 -430 {
lab=ctrl_n}
N 460 -400 460 -360 {
lab=#net1}
N 680 -400 680 -360 {
lab=#net2}
N 460 -380 520 -380 {
lab=#net1}
N 520 -380 600 -430 {
lab=#net1}
N 600 -430 640 -430 {
lab=#net1}
N 500 -430 540 -430 {
lab=#net2}
N 540 -430 620 -380 {
lab=#net2}
N 620 -380 680 -380 {
lab=#net2}
N 400 -260 680 -260 {
lab=VGND}
N 680 -300 680 -260 {
lab=VGND}
N 460 -300 460 -260 {
lab=VGND}
N 380 -330 420 -330 {
lab=ctrl}
N 720 -330 760 -330 {
lab=ctrl_n}
N 460 -500 460 -460 {
lab=VAPWR}
N 680 -500 680 -460 {
lab=VAPWR}
N 680 -380 720 -380 {
lab=#net2}
N 720 -380 740 -380 {
lab=#net2}
N 460 -600 460 -560 {
lab=VAPWR}
N 460 -600 680 -600 {
lab=VAPWR}
N 680 -600 680 -560 {
lab=VAPWR}
N 400 -600 460 -600 {
lab=VAPWR}
N 840 -530 860 -530 {
lab=#net2}
N 840 -530 840 -330 {
lab=#net2}
N 840 -330 860 -330 {
lab=#net2}
N 740 -430 840 -430 {
lab=#net2}
N 680 -600 900 -600 {
lab=VAPWR}
N 900 -600 900 -560 {
lab=VAPWR}
N 680 -260 900 -260 {
lab=VGND}
N 900 -300 900 -260 {
lab=VGND}
N 900 -500 900 -360 {
lab=#net3}
N 900 -430 940 -430 {
lab=#net3}
N 120 -260 400 -260 {
lab=VGND}
N 120 -600 400 -600 {
lab=VAPWR}
N -230 -260 120 -260 {
lab=VGND}
N -130 -330 -130 -260 {
lab=VGND}
N -230 -600 -130 -600 {
lab=VDPWR}
N -130 -600 -130 -530 {
lab=VDPWR}
N 740 -430 740 -380 {
lab=#net2}
N 680 -560 680 -500 {
lab=VAPWR}
N 460 -560 460 -500 {
lab=VAPWR}
N 1010 -530 1030 -530 {
lab=#net3}
N 1010 -530 1010 -330 {
lab=#net3}
N 1010 -330 1030 -330 {
lab=#net3}
N 1070 -500 1070 -360 {
lab=out}
N 940 -430 1010 -430 {
lab=#net3}
N 900 -600 1070 -600 {
lab=VAPWR}
N 1070 -600 1070 -560 {
lab=VAPWR}
N 900 -260 1070 -260 {
lab=VGND}
N 1070 -300 1070 -260 {
lab=VGND}
N 1070 -430 1140 -430 {
lab=out}
C {devices/title.sym} 160 -30 0 0 {name=l1 author="Sylvain Munaut"}
C {devices/ipin.sym} -230 -430 2 1 {name=p5 lab=ctrl sim_pinnumber=4}
C {sky130_fd_pr/pfet3_g5v0d10v5.sym} 880 -530 0 0 {name=M1
W=0.84
L=0.5
body=VAPWR
nf=1
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_g5v0d10v5
spiceprefix=X
}
C {sky130_fd_pr/nfet3_g5v0d10v5.sym} 880 -330 0 0 {name=M2
W=0.42
L=0.5
body=VGND
nf=1
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_g5v0d10v5
spiceprefix=X
}
C {devices/iopin.sym} -230 -260 2 0 {name=p8 lab=VGND sim_pinnumber=1}
C {devices/iopin.sym} -230 -600 2 0 {name=p9 lab=VDPWR sim_pinnumber=2}
C {sky130_fd_pr/nfet3_01v8.sym} -150 -380 0 0 {name=M7
W=0.42
L=0.15
body=VGND
nf=1
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet3_01v8_hvt.sym} -150 -480 0 0 {name=M8
W=1
L=0.15
body=VDPWR
nf=1
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_01v8_hvt
spiceprefix=X
}
C {devices/lab_wire.sym} -50 -430 0 1 {name=p10 sig_type=std_logic lab=ctrl_n}
C {sky130_fd_pr/nfet3_g5v0d10v5.sym} 440 -330 0 0 {name=M9
W=0.42
L=0.5
body=VGND
nf=1
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_g5v0d10v5
spiceprefix=X
}
C {sky130_fd_pr/nfet3_g5v0d10v5.sym} 700 -330 0 1 {name=M10
W=0.42
L=0.5
body=VGND
nf=1
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_g5v0d10v5
spiceprefix=X
}
C {sky130_fd_pr/pfet3_g5v0d10v5.sym} 480 -430 0 1 {name=M11
W=0.42
L=0.5
body=VAPWR
nf=1
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_g5v0d10v5
spiceprefix=X
}
C {sky130_fd_pr/pfet3_g5v0d10v5.sym} 660 -430 0 0 {name=M12
W=0.42
L=0.5
body=VAPWR
nf=1
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_g5v0d10v5
spiceprefix=X
}
C {devices/lab_wire.sym} 760 -330 0 1 {name=p12 sig_type=std_logic lab=ctrl_n}
C {devices/lab_wire.sym} 380 -330 0 0 {name=p13 sig_type=std_logic lab=ctrl}
C {devices/iopin.sym} 120 -600 2 0 {name=p14 lab=VAPWR sim_pinnumber=3}
C {sky130_fd_pr/pfet3_g5v0d10v5.sym} 1050 -530 0 0 {name=M3
W=3
L=0.5
body=VAPWR
nf=1
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_g5v0d10v5
spiceprefix=X
}
C {sky130_fd_pr/nfet3_g5v0d10v5.sym} 1050 -330 0 0 {name=M4
W=3
L=0.5
body=VGND
nf=1
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_g5v0d10v5
spiceprefix=X
}
C {devices/opin.sym} 1140 -430 0 0 {name=p1 lab=out}
