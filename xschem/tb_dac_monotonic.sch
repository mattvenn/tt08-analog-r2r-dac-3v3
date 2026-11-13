v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
F {}
E {}
B 2 -900 800 300 1200 {flags=graph
y1=0
y2=3.3
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=0
x2=255
divx=8
subdivx=1
xlabmag=1.0
ylabmag=1.0
node="out_ref
out_new
out_refx
out_newx"
color="4 7 6 12"
dataset=-1
unitx=1
logx=0
logy=0
}
B 2 500 800 1700 1200 {flags=graph
y1=-3
y2=3
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=0
x2=255
divx=8
subdivx=1
xlabmag=1.0
ylabmag=1.0
node="inl_ref
inl_new
inl_refx
inl_newx"
color="4 7 6 12"
dataset=-1
unitx=1
logx=0
logy=0
}
T {tb_dac_monotonic: static transfer function of the R2R DAC, all 256 codes as a DC sweep.} -1560 -640 0 0 0.6 0.6 {}
T {Find the code 127->128 non-monotonic step seen on silicon, then resize the output stage (M3/M4) of dac_drive_sized
(dac_drive_sized.sch) and compare NEW against REF. Results are printed to the ngspice log.} -1560 -580 0 0 0.4 0.4 {}
T {REF: 8 x dac_drive (as taped out) + r2r} -1100 -230 0 0 0.5 0.5 {}
T {NEW: 8 x dac_drive_sized + r2r} 300 -230 0 0 0.5 0.5 {}
T {10Meg = 10x scope probe} 900 400 0 0 0.3 0.3 {}
T {DAC output vs code (REF, NEW, REF_X, NEW_X)} -900 760 0 0 0.5 0.5 {}
T {INL in LSB (endpoint), 127->128 drop = non-monotonic step} 500 760 0 0 0.5 0.5 {}
C {devices/vsource.sym} -1500 -400 0 0 {name=V1 value=3.3 savecurrent=false}
C {devices/lab_pin.sym} -1500 -430 2 0 {name=p1 sig_type=std_logic lab=vcc}
C {devices/gnd.sym} -1500 -370 0 0 {name=l1 lab=GND}
C {devices/vsource.sym} -1380 -400 0 0 {name=V2 value=1.8 savecurrent=false}
C {devices/lab_pin.sym} -1380 -430 2 0 {name=p2 sig_type=std_logic lab=vdd}
C {devices/gnd.sym} -1380 -370 0 0 {name=l2 lab=GND}
C {dac_drive.sym} -900 -100 0 0 {name=x1}
C {devices/lab_pin.sym} -1050 -130 0 0 {name=p3 sig_type=std_logic lab=b0}
C {devices/lab_pin.sym} -750 -130 2 0 {name=p4 sig_type=std_logic lab=vcc}
C {devices/lab_pin.sym} -750 -110 2 0 {name=p5 sig_type=std_logic lab=vdd}
C {devices/lab_pin.sym} -750 -90 2 0 {name=p6 sig_type=std_logic lab=dr0}
C {devices/gnd.sym} -750 -70 0 0 {name=l3 lab=GND}
C {dac_drive.sym} -900 0 0 0 {name=x2}
C {devices/lab_pin.sym} -1050 -30 0 0 {name=p7 sig_type=std_logic lab=b1}
C {devices/lab_pin.sym} -750 -30 2 0 {name=p8 sig_type=std_logic lab=vcc}
C {devices/lab_pin.sym} -750 -10 2 0 {name=p9 sig_type=std_logic lab=vdd}
C {devices/lab_pin.sym} -750 10 2 0 {name=p10 sig_type=std_logic lab=dr1}
C {devices/gnd.sym} -750 30 0 0 {name=l4 lab=GND}
C {dac_drive.sym} -900 100 0 0 {name=x3}
C {devices/lab_pin.sym} -1050 70 0 0 {name=p11 sig_type=std_logic lab=b2}
C {devices/lab_pin.sym} -750 70 2 0 {name=p12 sig_type=std_logic lab=vcc}
C {devices/lab_pin.sym} -750 90 2 0 {name=p13 sig_type=std_logic lab=vdd}
C {devices/lab_pin.sym} -750 110 2 0 {name=p14 sig_type=std_logic lab=dr2}
C {devices/gnd.sym} -750 130 0 0 {name=l5 lab=GND}
C {dac_drive.sym} -900 200 0 0 {name=x4}
C {devices/lab_pin.sym} -1050 170 0 0 {name=p15 sig_type=std_logic lab=b3}
C {devices/lab_pin.sym} -750 170 2 0 {name=p16 sig_type=std_logic lab=vcc}
C {devices/lab_pin.sym} -750 190 2 0 {name=p17 sig_type=std_logic lab=vdd}
C {devices/lab_pin.sym} -750 210 2 0 {name=p18 sig_type=std_logic lab=dr3}
C {devices/gnd.sym} -750 230 0 0 {name=l6 lab=GND}
C {dac_drive.sym} -900 300 0 0 {name=x5}
C {devices/lab_pin.sym} -1050 270 0 0 {name=p19 sig_type=std_logic lab=b4}
C {devices/lab_pin.sym} -750 270 2 0 {name=p20 sig_type=std_logic lab=vcc}
C {devices/lab_pin.sym} -750 290 2 0 {name=p21 sig_type=std_logic lab=vdd}
C {devices/lab_pin.sym} -750 310 2 0 {name=p22 sig_type=std_logic lab=dr4}
C {devices/gnd.sym} -750 330 0 0 {name=l7 lab=GND}
C {dac_drive.sym} -900 400 0 0 {name=x6}
C {devices/lab_pin.sym} -1050 370 0 0 {name=p23 sig_type=std_logic lab=b5}
C {devices/lab_pin.sym} -750 370 2 0 {name=p24 sig_type=std_logic lab=vcc}
C {devices/lab_pin.sym} -750 390 2 0 {name=p25 sig_type=std_logic lab=vdd}
C {devices/lab_pin.sym} -750 410 2 0 {name=p26 sig_type=std_logic lab=dr5}
C {devices/gnd.sym} -750 430 0 0 {name=l8 lab=GND}
C {dac_drive.sym} -900 500 0 0 {name=x7}
C {devices/lab_pin.sym} -1050 470 0 0 {name=p27 sig_type=std_logic lab=b6}
C {devices/lab_pin.sym} -750 470 2 0 {name=p28 sig_type=std_logic lab=vcc}
C {devices/lab_pin.sym} -750 490 2 0 {name=p29 sig_type=std_logic lab=vdd}
C {devices/lab_pin.sym} -750 510 2 0 {name=p30 sig_type=std_logic lab=dr6}
C {devices/gnd.sym} -750 530 0 0 {name=l9 lab=GND}
C {dac_drive.sym} -900 600 0 0 {name=x8}
C {devices/lab_pin.sym} -1050 570 0 0 {name=p31 sig_type=std_logic lab=b7}
C {devices/lab_pin.sym} -750 570 2 0 {name=p32 sig_type=std_logic lab=vcc}
C {devices/lab_pin.sym} -750 590 2 0 {name=p33 sig_type=std_logic lab=vdd}
C {devices/lab_pin.sym} -750 610 2 0 {name=p34 sig_type=std_logic lab=dr7}
C {devices/gnd.sym} -750 630 0 0 {name=l10 lab=GND}
C {r2r.sym} -350 300 0 0 {name=x9}
C {devices/lab_pin.sym} -500 230 0 0 {name=p35 sig_type=std_logic lab=dr0}
C {devices/lab_pin.sym} -500 250 0 0 {name=p36 sig_type=std_logic lab=dr1}
C {devices/lab_pin.sym} -500 270 0 0 {name=p37 sig_type=std_logic lab=dr2}
C {devices/lab_pin.sym} -500 290 0 0 {name=p38 sig_type=std_logic lab=dr3}
C {devices/lab_pin.sym} -500 310 0 0 {name=p39 sig_type=std_logic lab=dr4}
C {devices/lab_pin.sym} -500 330 0 0 {name=p40 sig_type=std_logic lab=dr5}
C {devices/lab_pin.sym} -500 350 0 0 {name=p41 sig_type=std_logic lab=dr6}
C {devices/lab_pin.sym} -500 370 0 0 {name=p42 sig_type=std_logic lab=dr7}
C {devices/lab_pin.sym} -200 230 2 0 {name=p43 sig_type=std_logic lab=out_ref}
C {devices/gnd.sym} -200 250 0 0 {name=l11 lab=GND}
C {devices/res.sym} -50 340 0 0 {name=R1
value=10Meg
footer=false
device=resistor
m=1}
C {devices/lab_pin.sym} -50 310 2 0 {name=p44 sig_type=std_logic lab=out_ref}
C {devices/gnd.sym} -50 370 0 0 {name=l12 lab=GND}
C {dac_drive_sized.sym} 500 -100 0 0 {name=x11}
C {devices/lab_pin.sym} 350 -130 0 0 {name=p45 sig_type=std_logic lab=b0}
C {devices/lab_pin.sym} 650 -130 2 0 {name=p46 sig_type=std_logic lab=vcc}
C {devices/lab_pin.sym} 650 -110 2 0 {name=p47 sig_type=std_logic lab=vdd}
C {devices/lab_pin.sym} 650 -90 2 0 {name=p48 sig_type=std_logic lab=dn0}
C {devices/gnd.sym} 650 -70 0 0 {name=l13 lab=GND}
C {dac_drive_sized.sym} 500 0 0 0 {name=x12}
C {devices/lab_pin.sym} 350 -30 0 0 {name=p49 sig_type=std_logic lab=b1}
C {devices/lab_pin.sym} 650 -30 2 0 {name=p50 sig_type=std_logic lab=vcc}
C {devices/lab_pin.sym} 650 -10 2 0 {name=p51 sig_type=std_logic lab=vdd}
C {devices/lab_pin.sym} 650 10 2 0 {name=p52 sig_type=std_logic lab=dn1}
C {devices/gnd.sym} 650 30 0 0 {name=l14 lab=GND}
C {dac_drive_sized.sym} 500 100 0 0 {name=x13}
C {devices/lab_pin.sym} 350 70 0 0 {name=p53 sig_type=std_logic lab=b2}
C {devices/lab_pin.sym} 650 70 2 0 {name=p54 sig_type=std_logic lab=vcc}
C {devices/lab_pin.sym} 650 90 2 0 {name=p55 sig_type=std_logic lab=vdd}
C {devices/lab_pin.sym} 650 110 2 0 {name=p56 sig_type=std_logic lab=dn2}
C {devices/gnd.sym} 650 130 0 0 {name=l15 lab=GND}
C {dac_drive_sized.sym} 500 200 0 0 {name=x14}
C {devices/lab_pin.sym} 350 170 0 0 {name=p57 sig_type=std_logic lab=b3}
C {devices/lab_pin.sym} 650 170 2 0 {name=p58 sig_type=std_logic lab=vcc}
C {devices/lab_pin.sym} 650 190 2 0 {name=p59 sig_type=std_logic lab=vdd}
C {devices/lab_pin.sym} 650 210 2 0 {name=p60 sig_type=std_logic lab=dn3}
C {devices/gnd.sym} 650 230 0 0 {name=l16 lab=GND}
C {dac_drive_sized.sym} 500 300 0 0 {name=x15}
C {devices/lab_pin.sym} 350 270 0 0 {name=p61 sig_type=std_logic lab=b4}
C {devices/lab_pin.sym} 650 270 2 0 {name=p62 sig_type=std_logic lab=vcc}
C {devices/lab_pin.sym} 650 290 2 0 {name=p63 sig_type=std_logic lab=vdd}
C {devices/lab_pin.sym} 650 310 2 0 {name=p64 sig_type=std_logic lab=dn4}
C {devices/gnd.sym} 650 330 0 0 {name=l17 lab=GND}
C {dac_drive_sized.sym} 500 400 0 0 {name=x16}
C {devices/lab_pin.sym} 350 370 0 0 {name=p65 sig_type=std_logic lab=b5}
C {devices/lab_pin.sym} 650 370 2 0 {name=p66 sig_type=std_logic lab=vcc}
C {devices/lab_pin.sym} 650 390 2 0 {name=p67 sig_type=std_logic lab=vdd}
C {devices/lab_pin.sym} 650 410 2 0 {name=p68 sig_type=std_logic lab=dn5}
C {devices/gnd.sym} 650 430 0 0 {name=l18 lab=GND}
C {dac_drive_sized.sym} 500 500 0 0 {name=x17}
C {devices/lab_pin.sym} 350 470 0 0 {name=p69 sig_type=std_logic lab=b6}
C {devices/lab_pin.sym} 650 470 2 0 {name=p70 sig_type=std_logic lab=vcc}
C {devices/lab_pin.sym} 650 490 2 0 {name=p71 sig_type=std_logic lab=vdd}
C {devices/lab_pin.sym} 650 510 2 0 {name=p72 sig_type=std_logic lab=dn6}
C {devices/gnd.sym} 650 530 0 0 {name=l19 lab=GND}
C {dac_drive_sized.sym} 500 600 0 0 {name=x18}
C {devices/lab_pin.sym} 350 570 0 0 {name=p73 sig_type=std_logic lab=b7}
C {devices/lab_pin.sym} 650 570 2 0 {name=p74 sig_type=std_logic lab=vcc}
C {devices/lab_pin.sym} 650 590 2 0 {name=p75 sig_type=std_logic lab=vdd}
C {devices/lab_pin.sym} 650 610 2 0 {name=p76 sig_type=std_logic lab=dn7}
C {devices/gnd.sym} 650 630 0 0 {name=l20 lab=GND}
C {r2r.sym} 1050 300 0 0 {name=x19}
C {devices/lab_pin.sym} 900 230 0 0 {name=p77 sig_type=std_logic lab=dn0}
C {devices/lab_pin.sym} 900 250 0 0 {name=p78 sig_type=std_logic lab=dn1}
C {devices/lab_pin.sym} 900 270 0 0 {name=p79 sig_type=std_logic lab=dn2}
C {devices/lab_pin.sym} 900 290 0 0 {name=p80 sig_type=std_logic lab=dn3}
C {devices/lab_pin.sym} 900 310 0 0 {name=p81 sig_type=std_logic lab=dn4}
C {devices/lab_pin.sym} 900 330 0 0 {name=p82 sig_type=std_logic lab=dn5}
C {devices/lab_pin.sym} 900 350 0 0 {name=p83 sig_type=std_logic lab=dn6}
C {devices/lab_pin.sym} 900 370 0 0 {name=p84 sig_type=std_logic lab=dn7}
C {devices/lab_pin.sym} 1200 230 2 0 {name=p85 sig_type=std_logic lab=out_new}
C {devices/gnd.sym} 1200 250 0 0 {name=l21 lab=GND}
C {devices/res.sym} 1350 340 0 0 {name=R2
value=10Meg
footer=false
device=resistor
m=1}
C {devices/lab_pin.sym} 1350 310 2 0 {name=p86 sig_type=std_logic lab=out_new}
C {devices/gnd.sym} 1350 370 0 0 {name=l22 lab=GND}
C {devices/code_shown.sym} -1560 -260 0 0 {name=TT_MODELS
only_toplevel=true
format="tcleval( @value )"
value="
** opencircuitdesign pdks install
** tt (no mismatch) so runs are repeatable.
** use tt_mm (and the MC loop below) to see the random spread
.lib $::SKYWATER_MODELS/sky130.lib.spice tt
"
spice_ignore=false}
C {devices/code_shown.sym} -1560 330 0 0 {name=SIMULATION
only_toplevel=false
value="
* NEW = dac_drive_sized: M3 W=27 nf=9, M4 W=9 nf=3 (3x)
* REF = dac_drive as taped out: M3 W=9 nf=3, M4 W=3 nf=1
* to try other sizes, edit M3/M4 in dac_drive_sized.sch

.control
* all 256 codes as one DC sweep (seconds, after ~45s of model loading)
* the 'out of range for pow/^' errors come from the res_high_po model during
* the first Newton iterations and are harmless
dc Vcode 0 255 1
let lsb_ref = (v(out_ref)[255]-v(out_ref)[0])/255
let st_ref = v(out_ref)[1,255]-v(out_ref)[0,254]
let dnlmin_ref = minimum(st_ref)/lsb_ref - 1
let mono_ref = minimum(st_ref) gt 0
let s15_ref = (v(out_ref)[16]-v(out_ref)[15])*1000
let s31_ref = (v(out_ref)[32]-v(out_ref)[31])*1000
let s63_ref = (v(out_ref)[64]-v(out_ref)[63])*1000
let s127_ref = (v(out_ref)[128]-v(out_ref)[127])*1000
let s191_ref = (v(out_ref)[192]-v(out_ref)[191])*1000
let fs_ref = v(out_ref)[255]
let inl_ref = (v(out_ref)-v(out_ref)[0])/lsb_ref - v(code)
let lsbmv_ref = lsb_ref*1000
let lsb_new = (v(out_new)[255]-v(out_new)[0])/255
let st_new = v(out_new)[1,255]-v(out_new)[0,254]
let dnlmin_new = minimum(st_new)/lsb_new - 1
let mono_new = minimum(st_new) gt 0
let s15_new = (v(out_new)[16]-v(out_new)[15])*1000
let s31_new = (v(out_new)[32]-v(out_new)[31])*1000
let s63_new = (v(out_new)[64]-v(out_new)[63])*1000
let s127_new = (v(out_new)[128]-v(out_new)[127])*1000
let s191_new = (v(out_new)[192]-v(out_new)[191])*1000
let fs_new = v(out_new)[255]
let inl_new = (v(out_new)-v(out_new)[0])/lsb_new - v(code)
let lsbmv_new = lsb_new*1000
let lsb_refx = (v(out_refx)[255]-v(out_refx)[0])/255
let st_refx = v(out_refx)[1,255]-v(out_refx)[0,254]
let dnlmin_refx = minimum(st_refx)/lsb_refx - 1
let mono_refx = minimum(st_refx) gt 0
let s15_refx = (v(out_refx)[16]-v(out_refx)[15])*1000
let s31_refx = (v(out_refx)[32]-v(out_refx)[31])*1000
let s63_refx = (v(out_refx)[64]-v(out_refx)[63])*1000
let s127_refx = (v(out_refx)[128]-v(out_refx)[127])*1000
let s191_refx = (v(out_refx)[192]-v(out_refx)[191])*1000
let fs_refx = v(out_refx)[255]
let inl_refx = (v(out_refx)-v(out_refx)[0])/lsb_refx - v(code)
let lsbmv_refx = lsb_refx*1000
let lsb_newx = (v(out_newx)[255]-v(out_newx)[0])/255
let st_newx = v(out_newx)[1,255]-v(out_newx)[0,254]
let dnlmin_newx = minimum(st_newx)/lsb_newx - 1
let mono_newx = minimum(st_newx) gt 0
let s15_newx = (v(out_newx)[16]-v(out_newx)[15])*1000
let s31_newx = (v(out_newx)[32]-v(out_newx)[31])*1000
let s63_newx = (v(out_newx)[64]-v(out_newx)[63])*1000
let s127_newx = (v(out_newx)[128]-v(out_newx)[127])*1000
let s191_newx = (v(out_newx)[192]-v(out_newx)[191])*1000
let fs_newx = v(out_newx)[255]
let inl_newx = (v(out_newx)-v(out_newx)[0])/lsb_newx - v(code)
let lsbmv_newx = lsb_newx*1000

echo
echo '================ DAC static summary (mV / LSB) ================'
echo '                 REF(sch)   NEW(sch)   REF_X(extr)   NEW_X(extr)'
echo 'LSB mV           ' $&lsbmv_ref '  ' $&lsbmv_new '  ' $&lsbmv_refx '  ' $&lsbmv_newx
echo 'full scale V     ' $&fs_ref '  ' $&fs_new '  ' $&fs_refx '  ' $&fs_newx
echo 'step 15->16 mV   ' $&s15_ref '  ' $&s15_new '  ' $&s15_refx '  ' $&s15_newx
echo 'step 31->32 mV   ' $&s31_ref '  ' $&s31_new '  ' $&s31_refx '  ' $&s31_newx
echo 'step 63->64 mV   ' $&s63_ref '  ' $&s63_new '  ' $&s63_refx '  ' $&s63_newx
echo 'step 127->128 mV ' $&s127_ref '  ' $&s127_new '  ' $&s127_refx '  ' $&s127_newx
echo 'step 191->192 mV ' $&s191_ref '  ' $&s191_new '  ' $&s191_refx '  ' $&s191_newx
echo 'min DNL LSB      ' $&dnlmin_ref '  ' $&dnlmin_new '  ' $&dnlmin_refx '  ' $&dnlmin_newx
echo 'monotonic        ' $&mono_ref '  ' $&mono_new '  ' $&mono_refx '  ' $&mono_newx
echo 'silicon (20261113-103016): 127->128 -24.8mV, 63->64 -5.8mV, 191->192 -5.6mV, 31->32 +2.8mV, min DNL -2.95'
echo '==============================================================='
wrdata tb_dac_monotonic.txt v(out_ref) v(out_new) v(out_refx) v(out_newx)
write tb_dac_monotonic.raw v(code) v(out_ref) v(out_new) inl_ref inl_new v(out_refx) v(out_newx) inl_refx inl_newx v(dr0) v(dr7) v(dn0) v(dn7) v(b0) v(b7)
.endc
"}
C {devices/launcher.sym} -1480 1250 0 0 {name=h1
descr="load waves"
tclcommand="xschem raw_read $netlist_dir/tb_dac_monotonic.raw dc"}
C {devices/title.sym} -1500 1400 0 0 {name=l100 author="Matt Venn"}
C {devices/vsource.sym} -1260 -400 0 0 {name=Vcode value=0 savecurrent=false}
C {devices/lab_pin.sym} -1260 -430 2 1 {name=pc1 sig_type=std_logic lab=code}
C {devices/gnd.sym} -1260 -370 0 0 {name=lc1 lab=GND}
T {DAC code = DC value of Vcode (0..255),
swept by the dc command.
Bb0..Bb7 decode it into the
8 input bits (1.8V logic)} -1440 -170 0 0 0.3 0.3 {}
C {devices/bsource.sym} -1500 60 0 0 {name=Bb0 VAR=V FUNC="1.8*(floor((v(code)+0.25)/1)-2*floor((v(code)+0.25)/2))" m=1}
C {devices/lab_pin.sym} -1500 30 2 1 {name=pb0 sig_type=std_logic lab=b0}
C {devices/gnd.sym} -1500 90 0 0 {name=lb0 lab=GND}
C {devices/bsource.sym} -1380 60 0 0 {name=Bb1 VAR=V FUNC="1.8*(floor((v(code)+0.25)/2)-2*floor((v(code)+0.25)/4))" m=1}
C {devices/lab_pin.sym} -1380 30 2 1 {name=pb1 sig_type=std_logic lab=b1}
C {devices/gnd.sym} -1380 90 0 0 {name=lb1 lab=GND}
C {devices/bsource.sym} -1260 60 0 0 {name=Bb2 VAR=V FUNC="1.8*(floor((v(code)+0.25)/4)-2*floor((v(code)+0.25)/8))" m=1}
C {devices/lab_pin.sym} -1260 30 2 1 {name=pb2 sig_type=std_logic lab=b2}
C {devices/gnd.sym} -1260 90 0 0 {name=lb2 lab=GND}
C {devices/bsource.sym} -1140 60 0 0 {name=Bb3 VAR=V FUNC="1.8*(floor((v(code)+0.25)/8)-2*floor((v(code)+0.25)/16))" m=1}
C {devices/lab_pin.sym} -1140 30 2 1 {name=pb3 sig_type=std_logic lab=b3}
C {devices/gnd.sym} -1140 90 0 0 {name=lb3 lab=GND}
C {devices/bsource.sym} -1500 220 0 0 {name=Bb4 VAR=V FUNC="1.8*(floor((v(code)+0.25)/16)-2*floor((v(code)+0.25)/32))" m=1}
C {devices/lab_pin.sym} -1500 190 2 1 {name=pb4 sig_type=std_logic lab=b4}
C {devices/gnd.sym} -1500 250 0 0 {name=lb4 lab=GND}
C {devices/bsource.sym} -1380 220 0 0 {name=Bb5 VAR=V FUNC="1.8*(floor((v(code)+0.25)/32)-2*floor((v(code)+0.25)/64))" m=1}
C {devices/lab_pin.sym} -1380 190 2 1 {name=pb5 sig_type=std_logic lab=b5}
C {devices/gnd.sym} -1380 250 0 0 {name=lb5 lab=GND}
C {devices/bsource.sym} -1260 220 0 0 {name=Bb6 VAR=V FUNC="1.8*(floor((v(code)+0.25)/64)-2*floor((v(code)+0.25)/128))" m=1}
C {devices/lab_pin.sym} -1260 190 2 1 {name=pb6 sig_type=std_logic lab=b6}
C {devices/gnd.sym} -1260 250 0 0 {name=lb6 lab=GND}
C {devices/bsource.sym} -1140 220 0 0 {name=Bb7 VAR=V FUNC="1.8*(floor((v(code)+0.25)/128)-2*floor((v(code)+0.25)/256))" m=1}
C {devices/lab_pin.sym} -1140 190 2 1 {name=pb7 sig_type=std_logic lab=b7}
C {devices/gnd.sym} -1140 250 0 0 {name=lb7 lab=GND}
T {REF_X: extracted dac_drive + extracted r2r (mag/*.sim.spice)} -1100 1270 0 0 0.5 0.5 {}
T {NEW_X: extracted dac_drive_sized + extracted r2r} 300 1270 0 0 0.5 0.5 {}
C {dac_drive.sym} -900 1400 0 0 {name=x21
schematic=dac_drive_parax.sim
spice_sym_def="tcleval(.include [file normalize ../mag/dac_drive.sim.spice])"
tclcommand="textwindow [file normalize ../mag/dac_drive.sim.spice]"}
C {devices/lab_pin.sym} -1050 1370 0 0 {name=p501 sig_type=std_logic lab=b0}
C {devices/lab_pin.sym} -750 1370 2 0 {name=p502 sig_type=std_logic lab=vcc}
C {devices/lab_pin.sym} -750 1390 2 0 {name=p503 sig_type=std_logic lab=vdd}
C {devices/lab_pin.sym} -750 1410 2 0 {name=p504 sig_type=std_logic lab=xr0}
C {devices/gnd.sym} -750 1430 0 0 {name=l505 lab=GND}
C {dac_drive.sym} -900 1500 0 0 {name=x22
schematic=dac_drive_parax.sim
spice_sym_def="tcleval(.include [file normalize ../mag/dac_drive.sim.spice])"
tclcommand="textwindow [file normalize ../mag/dac_drive.sim.spice]"}
C {devices/lab_pin.sym} -1050 1470 0 0 {name=p506 sig_type=std_logic lab=b1}
C {devices/lab_pin.sym} -750 1470 2 0 {name=p507 sig_type=std_logic lab=vcc}
C {devices/lab_pin.sym} -750 1490 2 0 {name=p508 sig_type=std_logic lab=vdd}
C {devices/lab_pin.sym} -750 1510 2 0 {name=p509 sig_type=std_logic lab=xr1}
C {devices/gnd.sym} -750 1530 0 0 {name=l510 lab=GND}
C {dac_drive.sym} -900 1600 0 0 {name=x23
schematic=dac_drive_parax.sim
spice_sym_def="tcleval(.include [file normalize ../mag/dac_drive.sim.spice])"
tclcommand="textwindow [file normalize ../mag/dac_drive.sim.spice]"}
C {devices/lab_pin.sym} -1050 1570 0 0 {name=p511 sig_type=std_logic lab=b2}
C {devices/lab_pin.sym} -750 1570 2 0 {name=p512 sig_type=std_logic lab=vcc}
C {devices/lab_pin.sym} -750 1590 2 0 {name=p513 sig_type=std_logic lab=vdd}
C {devices/lab_pin.sym} -750 1610 2 0 {name=p514 sig_type=std_logic lab=xr2}
C {devices/gnd.sym} -750 1630 0 0 {name=l515 lab=GND}
C {dac_drive.sym} -900 1700 0 0 {name=x24
schematic=dac_drive_parax.sim
spice_sym_def="tcleval(.include [file normalize ../mag/dac_drive.sim.spice])"
tclcommand="textwindow [file normalize ../mag/dac_drive.sim.spice]"}
C {devices/lab_pin.sym} -1050 1670 0 0 {name=p516 sig_type=std_logic lab=b3}
C {devices/lab_pin.sym} -750 1670 2 0 {name=p517 sig_type=std_logic lab=vcc}
C {devices/lab_pin.sym} -750 1690 2 0 {name=p518 sig_type=std_logic lab=vdd}
C {devices/lab_pin.sym} -750 1710 2 0 {name=p519 sig_type=std_logic lab=xr3}
C {devices/gnd.sym} -750 1730 0 0 {name=l520 lab=GND}
C {dac_drive.sym} -900 1800 0 0 {name=x25
schematic=dac_drive_parax.sim
spice_sym_def="tcleval(.include [file normalize ../mag/dac_drive.sim.spice])"
tclcommand="textwindow [file normalize ../mag/dac_drive.sim.spice]"}
C {devices/lab_pin.sym} -1050 1770 0 0 {name=p521 sig_type=std_logic lab=b4}
C {devices/lab_pin.sym} -750 1770 2 0 {name=p522 sig_type=std_logic lab=vcc}
C {devices/lab_pin.sym} -750 1790 2 0 {name=p523 sig_type=std_logic lab=vdd}
C {devices/lab_pin.sym} -750 1810 2 0 {name=p524 sig_type=std_logic lab=xr4}
C {devices/gnd.sym} -750 1830 0 0 {name=l525 lab=GND}
C {dac_drive.sym} -900 1900 0 0 {name=x26
schematic=dac_drive_parax.sim
spice_sym_def="tcleval(.include [file normalize ../mag/dac_drive.sim.spice])"
tclcommand="textwindow [file normalize ../mag/dac_drive.sim.spice]"}
C {devices/lab_pin.sym} -1050 1870 0 0 {name=p526 sig_type=std_logic lab=b5}
C {devices/lab_pin.sym} -750 1870 2 0 {name=p527 sig_type=std_logic lab=vcc}
C {devices/lab_pin.sym} -750 1890 2 0 {name=p528 sig_type=std_logic lab=vdd}
C {devices/lab_pin.sym} -750 1910 2 0 {name=p529 sig_type=std_logic lab=xr5}
C {devices/gnd.sym} -750 1930 0 0 {name=l530 lab=GND}
C {dac_drive.sym} -900 2000 0 0 {name=x27
schematic=dac_drive_parax.sim
spice_sym_def="tcleval(.include [file normalize ../mag/dac_drive.sim.spice])"
tclcommand="textwindow [file normalize ../mag/dac_drive.sim.spice]"}
C {devices/lab_pin.sym} -1050 1970 0 0 {name=p531 sig_type=std_logic lab=b6}
C {devices/lab_pin.sym} -750 1970 2 0 {name=p532 sig_type=std_logic lab=vcc}
C {devices/lab_pin.sym} -750 1990 2 0 {name=p533 sig_type=std_logic lab=vdd}
C {devices/lab_pin.sym} -750 2010 2 0 {name=p534 sig_type=std_logic lab=xr6}
C {devices/gnd.sym} -750 2030 0 0 {name=l535 lab=GND}
C {dac_drive.sym} -900 2100 0 0 {name=x28
schematic=dac_drive_parax.sim
spice_sym_def="tcleval(.include [file normalize ../mag/dac_drive.sim.spice])"
tclcommand="textwindow [file normalize ../mag/dac_drive.sim.spice]"}
C {devices/lab_pin.sym} -1050 2070 0 0 {name=p536 sig_type=std_logic lab=b7}
C {devices/lab_pin.sym} -750 2070 2 0 {name=p537 sig_type=std_logic lab=vcc}
C {devices/lab_pin.sym} -750 2090 2 0 {name=p538 sig_type=std_logic lab=vdd}
C {devices/lab_pin.sym} -750 2110 2 0 {name=p539 sig_type=std_logic lab=xr7}
C {devices/gnd.sym} -750 2130 0 0 {name=l540 lab=GND}
C {r2r.sym} -350 1800 0 0 {name=x29
schematic=r2r_parax.sim
spice_sym_def="tcleval(.include [file normalize ../mag/r2r.sim.spice])"
tclcommand="textwindow [file normalize ../mag/r2r.sim.spice]"}
C {devices/lab_pin.sym} -500 1730 0 0 {name=p541 sig_type=std_logic lab=xr0}
C {devices/lab_pin.sym} -500 1750 0 0 {name=p542 sig_type=std_logic lab=xr1}
C {devices/lab_pin.sym} -500 1770 0 0 {name=p543 sig_type=std_logic lab=xr2}
C {devices/lab_pin.sym} -500 1790 0 0 {name=p544 sig_type=std_logic lab=xr3}
C {devices/lab_pin.sym} -500 1810 0 0 {name=p545 sig_type=std_logic lab=xr4}
C {devices/lab_pin.sym} -500 1830 0 0 {name=p546 sig_type=std_logic lab=xr5}
C {devices/lab_pin.sym} -500 1850 0 0 {name=p547 sig_type=std_logic lab=xr6}
C {devices/lab_pin.sym} -500 1870 0 0 {name=p548 sig_type=std_logic lab=xr7}
C {devices/lab_pin.sym} -200 1730 2 0 {name=p549 sig_type=std_logic lab=out_refx}
C {devices/gnd.sym} -200 1750 0 0 {name=l550 lab=GND}
C {devices/res.sym} -50 1840 0 0 {name=R3
value=10Meg
footer=false
device=resistor
m=1}
C {devices/lab_pin.sym} -50 1810 2 0 {name=p551 sig_type=std_logic lab=out_refx}
C {devices/gnd.sym} -50 1870 0 0 {name=l552 lab=GND}
C {dac_drive_sized.sym} 500 1400 0 0 {name=x31
schematic=dac_drive_sized_parax.sim
spice_sym_def="tcleval(.include [file normalize ../mag/dac_drive_sized.sim.spice])"
tclcommand="textwindow [file normalize ../mag/dac_drive_sized.sim.spice]"}
C {devices/lab_pin.sym} 350 1370 0 0 {name=p553 sig_type=std_logic lab=b0}
C {devices/lab_pin.sym} 650 1370 2 0 {name=p554 sig_type=std_logic lab=vcc}
C {devices/lab_pin.sym} 650 1390 2 0 {name=p555 sig_type=std_logic lab=vdd}
C {devices/lab_pin.sym} 650 1410 2 0 {name=p556 sig_type=std_logic lab=xn0}
C {devices/gnd.sym} 650 1430 0 0 {name=l557 lab=GND}
C {dac_drive_sized.sym} 500 1500 0 0 {name=x32
schematic=dac_drive_sized_parax.sim
spice_sym_def="tcleval(.include [file normalize ../mag/dac_drive_sized.sim.spice])"
tclcommand="textwindow [file normalize ../mag/dac_drive_sized.sim.spice]"}
C {devices/lab_pin.sym} 350 1470 0 0 {name=p558 sig_type=std_logic lab=b1}
C {devices/lab_pin.sym} 650 1470 2 0 {name=p559 sig_type=std_logic lab=vcc}
C {devices/lab_pin.sym} 650 1490 2 0 {name=p560 sig_type=std_logic lab=vdd}
C {devices/lab_pin.sym} 650 1510 2 0 {name=p561 sig_type=std_logic lab=xn1}
C {devices/gnd.sym} 650 1530 0 0 {name=l562 lab=GND}
C {dac_drive_sized.sym} 500 1600 0 0 {name=x33
schematic=dac_drive_sized_parax.sim
spice_sym_def="tcleval(.include [file normalize ../mag/dac_drive_sized.sim.spice])"
tclcommand="textwindow [file normalize ../mag/dac_drive_sized.sim.spice]"}
C {devices/lab_pin.sym} 350 1570 0 0 {name=p563 sig_type=std_logic lab=b2}
C {devices/lab_pin.sym} 650 1570 2 0 {name=p564 sig_type=std_logic lab=vcc}
C {devices/lab_pin.sym} 650 1590 2 0 {name=p565 sig_type=std_logic lab=vdd}
C {devices/lab_pin.sym} 650 1610 2 0 {name=p566 sig_type=std_logic lab=xn2}
C {devices/gnd.sym} 650 1630 0 0 {name=l567 lab=GND}
C {dac_drive_sized.sym} 500 1700 0 0 {name=x34
schematic=dac_drive_sized_parax.sim
spice_sym_def="tcleval(.include [file normalize ../mag/dac_drive_sized.sim.spice])"
tclcommand="textwindow [file normalize ../mag/dac_drive_sized.sim.spice]"}
C {devices/lab_pin.sym} 350 1670 0 0 {name=p568 sig_type=std_logic lab=b3}
C {devices/lab_pin.sym} 650 1670 2 0 {name=p569 sig_type=std_logic lab=vcc}
C {devices/lab_pin.sym} 650 1690 2 0 {name=p570 sig_type=std_logic lab=vdd}
C {devices/lab_pin.sym} 650 1710 2 0 {name=p571 sig_type=std_logic lab=xn3}
C {devices/gnd.sym} 650 1730 0 0 {name=l572 lab=GND}
C {dac_drive_sized.sym} 500 1800 0 0 {name=x35
schematic=dac_drive_sized_parax.sim
spice_sym_def="tcleval(.include [file normalize ../mag/dac_drive_sized.sim.spice])"
tclcommand="textwindow [file normalize ../mag/dac_drive_sized.sim.spice]"}
C {devices/lab_pin.sym} 350 1770 0 0 {name=p573 sig_type=std_logic lab=b4}
C {devices/lab_pin.sym} 650 1770 2 0 {name=p574 sig_type=std_logic lab=vcc}
C {devices/lab_pin.sym} 650 1790 2 0 {name=p575 sig_type=std_logic lab=vdd}
C {devices/lab_pin.sym} 650 1810 2 0 {name=p576 sig_type=std_logic lab=xn4}
C {devices/gnd.sym} 650 1830 0 0 {name=l577 lab=GND}
C {dac_drive_sized.sym} 500 1900 0 0 {name=x36
schematic=dac_drive_sized_parax.sim
spice_sym_def="tcleval(.include [file normalize ../mag/dac_drive_sized.sim.spice])"
tclcommand="textwindow [file normalize ../mag/dac_drive_sized.sim.spice]"}
C {devices/lab_pin.sym} 350 1870 0 0 {name=p578 sig_type=std_logic lab=b5}
C {devices/lab_pin.sym} 650 1870 2 0 {name=p579 sig_type=std_logic lab=vcc}
C {devices/lab_pin.sym} 650 1890 2 0 {name=p580 sig_type=std_logic lab=vdd}
C {devices/lab_pin.sym} 650 1910 2 0 {name=p581 sig_type=std_logic lab=xn5}
C {devices/gnd.sym} 650 1930 0 0 {name=l582 lab=GND}
C {dac_drive_sized.sym} 500 2000 0 0 {name=x37
schematic=dac_drive_sized_parax.sim
spice_sym_def="tcleval(.include [file normalize ../mag/dac_drive_sized.sim.spice])"
tclcommand="textwindow [file normalize ../mag/dac_drive_sized.sim.spice]"}
C {devices/lab_pin.sym} 350 1970 0 0 {name=p583 sig_type=std_logic lab=b6}
C {devices/lab_pin.sym} 650 1970 2 0 {name=p584 sig_type=std_logic lab=vcc}
C {devices/lab_pin.sym} 650 1990 2 0 {name=p585 sig_type=std_logic lab=vdd}
C {devices/lab_pin.sym} 650 2010 2 0 {name=p586 sig_type=std_logic lab=xn6}
C {devices/gnd.sym} 650 2030 0 0 {name=l587 lab=GND}
C {dac_drive_sized.sym} 500 2100 0 0 {name=x38
schematic=dac_drive_sized_parax.sim
spice_sym_def="tcleval(.include [file normalize ../mag/dac_drive_sized.sim.spice])"
tclcommand="textwindow [file normalize ../mag/dac_drive_sized.sim.spice]"}
C {devices/lab_pin.sym} 350 2070 0 0 {name=p588 sig_type=std_logic lab=b7}
C {devices/lab_pin.sym} 650 2070 2 0 {name=p589 sig_type=std_logic lab=vcc}
C {devices/lab_pin.sym} 650 2090 2 0 {name=p590 sig_type=std_logic lab=vdd}
C {devices/lab_pin.sym} 650 2110 2 0 {name=p591 sig_type=std_logic lab=xn7}
C {devices/gnd.sym} 650 2130 0 0 {name=l592 lab=GND}
C {r2r.sym} 1050 1800 0 0 {name=x39
schematic=r2r_parax.sim
spice_sym_def="tcleval(.include [file normalize ../mag/r2r.sim.spice])"
tclcommand="textwindow [file normalize ../mag/r2r.sim.spice]"}
C {devices/lab_pin.sym} 900 1730 0 0 {name=p593 sig_type=std_logic lab=xn0}
C {devices/lab_pin.sym} 900 1750 0 0 {name=p594 sig_type=std_logic lab=xn1}
C {devices/lab_pin.sym} 900 1770 0 0 {name=p595 sig_type=std_logic lab=xn2}
C {devices/lab_pin.sym} 900 1790 0 0 {name=p596 sig_type=std_logic lab=xn3}
C {devices/lab_pin.sym} 900 1810 0 0 {name=p597 sig_type=std_logic lab=xn4}
C {devices/lab_pin.sym} 900 1830 0 0 {name=p598 sig_type=std_logic lab=xn5}
C {devices/lab_pin.sym} 900 1850 0 0 {name=p599 sig_type=std_logic lab=xn6}
C {devices/lab_pin.sym} 900 1870 0 0 {name=p600 sig_type=std_logic lab=xn7}
C {devices/lab_pin.sym} 1200 1730 2 0 {name=p601 sig_type=std_logic lab=out_newx}
C {devices/gnd.sym} 1200 1750 0 0 {name=l602 lab=GND}
C {devices/res.sym} 1350 1840 0 0 {name=R4
value=10Meg
footer=false
device=resistor
m=1}
C {devices/lab_pin.sym} 1350 1810 2 0 {name=p603 sig_type=std_logic lab=out_newx}
C {devices/gnd.sym} 1350 1870 0 0 {name=l604 lab=GND}
