
�
�No debug cores found in the current design.
Before running the implement_debug_core command, either use the Set Up Debug wizard (GUI mode)
or use the create_debug_core and connect_debug_core Tcl commands to insert debug cores into the design.
154*	chipscopeZ16-241h px� 
Q
Command: %s
53*	vivadotcl2 
place_design2default:defaultZ4-113h px� 
�
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2"
Implementation2default:default2
xc7a100t2default:defaultZ17-347h px� 
�
0Got license for feature '%s' and/or device '%s'
310*common2"
Implementation2default:default2
xc7a100t2default:defaultZ17-349h px� 
P
Running DRC with %s threads
24*drc2
82default:defaultZ23-27h px� 
V
DRC finished with %s
79*	vivadotcl2
0 Errors2default:defaultZ4-198h px� 
e
BPlease refer to the DRC report (report_drc) for more information.
80*	vivadotclZ4-199h px� 
p
,Running DRC as a precondition to command %s
22*	vivadotcl2 
place_design2default:defaultZ4-22h px� 
P
Running DRC with %s threads
24*drc2
82default:defaultZ23-27h px� 
�
Rule violation (%s) %s - %s
20*drc2
CKLD-22default:default2T
@Clock Net has IO Driver, not a Clock Buf, and/or non-Clock loads2default:default2�
�Clock net CLK_100M_IBUF is directly driven by an IO rather than a Clock Buffer or may be an IO driving a mix of Clock Buffer and non-Clock loads. This connectivity should be reviewed and corrected as appropriate. Driver(s): CLK_100M_IBUF_inst/O2default:defaultZ23-20h px� 
b
DRC finished with %s
79*	vivadotcl2(
0 Errors, 1 Warnings2default:defaultZ4-198h px� 
e
BPlease refer to the DRC report (report_drc) for more information.
80*	vivadotclZ4-199h px� 
U

Starting %s Task
103*constraints2
Placer2default:defaultZ18-103h px� 
}
BMultithreading enabled for place_design using a maximum of %s CPUs12*	placeflow2
82default:defaultZ30-611h px� 
v

Phase %s%s
101*constraints2
1 2default:default2)
Placer Initialization2default:defaultZ18-101h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2.
Netlist sorting complete. 2default:default2
00:00:00.042default:default2
00:00:00.052default:default2
2516.1022default:default2
0.0002default:default2
35712default:default2
127642default:defaultZ17-722h px� 
E
%Done setting XDC timing constraints.
35*timingZ38-35h px� 
u
)Pushed %s inverter(s) to %s load pin(s).
98*opt2
02default:default2
02default:defaultZ31-138h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2.
Netlist sorting complete. 2default:default2
00:00:00.032default:default2
00:00:00.032default:default2
2516.1022default:default2
0.0002default:default2
35692default:default2
127622default:defaultZ17-722h px� 
�

Phase %s%s
101*constraints2
1.1 2default:default2F
2IO Placement/ Clock Placement/ Build Placer Device2default:defaultZ18-101h px� 
�

Phase %s%s
101*constraints2
1.1.1 2default:default22
ParallelPlaceIOClockAndInitTop2default:defaultZ18-101h px� 
v

Phase %s%s
101*constraints2
1.1.1.1 2default:default2#
Pre-Place Cells2default:defaultZ18-101h px� 
H
3Phase 1.1.1.1 Pre-Place Cells | Checksum: 0350f077
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:04 ; elapsed = 00:00:02 . Memory (MB): peak = 2516.102 ; gain = 0.000 ; free physical = 3568 ; free virtual = 127632default:defaulth px� 
�

Phase %s%s
101*constraints2
1.1.1.2 2default:default2/
Constructing HAPIClkRuleMgr2default:defaultZ18-101h px� 
T
?Phase 1.1.1.2 Constructing HAPIClkRuleMgr | Checksum: 0350f077
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:04 ; elapsed = 00:00:03 . Memory (MB): peak = 2516.102 ; gain = 0.000 ; free physical = 3568 ; free virtual = 127622default:defaulth px� 
}

Phase %s%s
101*constraints2
1.1.1.4 2default:default2*
IOLockPlacementChecker2default:defaultZ18-101h px� 
�

Phase %s%s
101*constraints2
1.1.1.5 2default:default2/
ClockRegionPlacementChecker2default:defaultZ18-101h px� 


Phase %s%s
101*constraints2
1.1.1.3 2default:default2,
IOBufferPlacementChecker2default:defaultZ18-101h px� 
q

Phase %s%s
101*constraints2
1.1.1.6 2default:default2

DSPChecker2default:defaultZ18-101h px� 
C
.Phase 1.1.1.6 DSPChecker | Checksum: 0350f077
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:08 ; elapsed = 00:00:04 . Memory (MB): peak = 2516.102 ; gain = 0.000 ; free physical = 3567 ; free virtual = 127622default:defaulth px� 
y

Phase %s%s
101*constraints2
1.1.1.7 2default:default2&
V7IOVoltageChecker2default:defaultZ18-101h px� 
K
6Phase 1.1.1.7 V7IOVoltageChecker | Checksum: 0350f077
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:09 ; elapsed = 00:00:04 . Memory (MB): peak = 2516.102 ; gain = 0.000 ; free physical = 3567 ; free virtual = 127622default:defaulth px� 
�

Phase %s%s
101*constraints2
1.1.1.8 2default:default2-
OverlappingPBlocksChecker2default:defaultZ18-101h px� 
R
=Phase 1.1.1.8 OverlappingPBlocksChecker | Checksum: 0350f077
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:09 ; elapsed = 00:00:04 . Memory (MB): peak = 2516.102 ; gain = 0.000 ; free physical = 3567 ; free virtual = 127622default:defaulth px� 
O
:Phase 1.1.1.4 IOLockPlacementChecker | Checksum: 0350f077
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:09 ; elapsed = 00:00:04 . Memory (MB): peak = 2516.102 ; gain = 0.000 ; free physical = 3567 ; free virtual = 127622default:defaulth px� 
�

Phase %s%s
101*constraints2
1.1.1.9 2default:default25
!CheckerForMandatoryPrePlacedCells2default:defaultZ18-101h px� 
Z
EPhase 1.1.1.9 CheckerForMandatoryPrePlacedCells | Checksum: 0350f077
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:09 ; elapsed = 00:00:04 . Memory (MB): peak = 2516.102 ; gain = 0.000 ; free physical = 3567 ; free virtual = 127622default:defaulth px� 
�

Phase %s%s
101*constraints2
	1.1.1.10 2default:default24
 CascadeElementConstraintsChecker2default:defaultZ18-101h px� 
Z
EPhase 1.1.1.10 CascadeElementConstraintsChecker | Checksum: 0350f077
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:09 ; elapsed = 00:00:04 . Memory (MB): peak = 2516.102 ; gain = 0.000 ; free physical = 3567 ; free virtual = 127622default:defaulth px� 
z

Phase %s%s
101*constraints2
	1.1.1.11 2default:default2&
HdioRelatedChecker2default:defaultZ18-101h px� 
L
7Phase 1.1.1.11 HdioRelatedChecker | Checksum: 0350f077
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:09 ; elapsed = 00:00:04 . Memory (MB): peak = 2516.102 ; gain = 0.000 ; free physical = 3567 ; free virtual = 127622default:defaulth px� 
T
?Phase 1.1.1.5 ClockRegionPlacementChecker | Checksum: 0350f077
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:09 ; elapsed = 00:00:04 . Memory (MB): peak = 2516.102 ; gain = 0.000 ; free physical = 3567 ; free virtual = 127622default:defaulth px� 
�

Phase %s%s
101*constraints2
	1.1.1.12 2default:default24
 CheckerForUnsupportedConstraints2default:defaultZ18-101h px� 
Q
<Phase 1.1.1.3 IOBufferPlacementChecker | Checksum: 0350f077
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:09 ; elapsed = 00:00:04 . Memory (MB): peak = 2516.102 ; gain = 0.000 ; free physical = 3567 ; free virtual = 127622default:defaulth px� 
w

Phase %s%s
101*constraints2
	1.1.1.13 2default:default2#
DisallowedInsts2default:defaultZ18-101h px� 
I
4Phase 1.1.1.13 DisallowedInsts | Checksum: 0350f077
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:09 ; elapsed = 00:00:04 . Memory (MB): peak = 2516.102 ; gain = 0.000 ; free physical = 3567 ; free virtual = 127622default:defaulth px� 
}

Phase %s%s
101*constraints2
	1.1.1.14 2default:default2)
Laguna PBlock Checker2default:defaultZ18-101h px� 
O
:Phase 1.1.1.14 Laguna PBlock Checker | Checksum: 0350f077
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:09 ; elapsed = 00:00:04 . Memory (MB): peak = 2516.102 ; gain = 0.000 ; free physical = 3567 ; free virtual = 127622default:defaulth px� 
�

Phase %s%s
101*constraints2
	1.1.1.15 2default:default21
ShapePlacementValidityChecker2default:defaultZ18-101h px� 
Z
EPhase 1.1.1.12 CheckerForUnsupportedConstraints | Checksum: 0350f077
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:09 ; elapsed = 00:00:04 . Memory (MB): peak = 2516.102 ; gain = 0.000 ; free physical = 3567 ; free virtual = 127622default:defaulth px� 
�

Phase %s%s
101*constraints2
	1.1.1.16 2default:default25
!ShapesExcludeCompatibilityChecker2default:defaultZ18-101h px� 
[
FPhase 1.1.1.16 ShapesExcludeCompatibilityChecker | Checksum: 0350f077
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:09 ; elapsed = 00:00:04 . Memory (MB): peak = 2516.102 ; gain = 0.000 ; free physical = 3567 ; free virtual = 127622default:defaulth px� 
�

Phase %s%s
101*constraints2
	1.1.1.17 2default:default2-
IOStdCompatabilityChecker2default:defaultZ18-101h px� 
S
>Phase 1.1.1.17 IOStdCompatabilityChecker | Checksum: 0350f077
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:09 ; elapsed = 00:00:04 . Memory (MB): peak = 2516.102 ; gain = 0.000 ; free physical = 3567 ; free virtual = 127622default:defaulth px� 
W
BPhase 1.1.1.15 ShapePlacementValidityChecker | Checksum: 0350f077
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:12 ; elapsed = 00:00:06 . Memory (MB): peak = 2516.102 ; gain = 0.000 ; free physical = 3563 ; free virtual = 127622default:defaulth px� 
�
�Found overlapping PBlocks. The use of overlapping PBlocks is not recommended as it may lead to legalization errors or unplaced instances.%s708*place2
 2default:defaultZ30-879h px� 
�
bAn IO Bus %s with more than one IO standard is found. Components associated with this bus are: %s
12*place2
SW2default:default2�
�
	<MSGMETA::BEGIN::IO_PORT>SW[15]<MSGMETA::END> of IOStandard LVCMOS33
	<MSGMETA::BEGIN::IO_PORT>SW[14]<MSGMETA::END> of IOStandard LVCMOS33
	<MSGMETA::BEGIN::IO_PORT>SW[13]<MSGMETA::END> of IOStandard LVCMOS33
	<MSGMETA::BEGIN::IO_PORT>SW[12]<MSGMETA::END> of IOStandard LVCMOS33
	<MSGMETA::BEGIN::IO_PORT>SW[11]<MSGMETA::END> of IOStandard LVCMOS33
	<MSGMETA::BEGIN::IO_PORT>SW[10]<MSGMETA::END> of IOStandard LVCMOS33
	<MSGMETA::BEGIN::IO_PORT>SW[9]<MSGMETA::END> of IOStandard LVCMOS18
	<MSGMETA::BEGIN::IO_PORT>SW[8]<MSGMETA::END> of IOStandard LVCMOS18
	<MSGMETA::BEGIN::IO_PORT>SW[7]<MSGMETA::END> of IOStandard LVCMOS33
	<MSGMETA::BEGIN::IO_PORT>SW[6]<MSGMETA::END> of IOStandard LVCMOS33
	<MSGMETA::BEGIN::IO_PORT>SW[5]<MSGMETA::END> of IOStandard LVCMOS33
	<MSGMETA::BEGIN::IO_PORT>SW[4]<MSGMETA::END> of IOStandard LVCMOS33
	<MSGMETA::BEGIN::IO_PORT>SW[3]<MSGMETA::END> of IOStandard LVCMOS33
	<MSGMETA::BEGIN::IO_PORT>SW[2]<MSGMETA::END> of IOStandard LVCMOS33
	<MSGMETA::BEGIN::IO_PORT>SW[1]<MSGMETA::END> of IOStandard LVCMOS33
	<MSGMETA::BEGIN::IO_PORT>SW[0]<MSGMETA::END> of IOStandard LVCMOS33")
SW[15]2
	: of IOStandard LVCMOS33
	"%
SW[14]: of IOStandard LVCMOS33
	"%
SW[13]: of IOStandard LVCMOS33
	"%
SW[12]: of IOStandard LVCMOS33
	"%
SW[11]: of IOStandard LVCMOS33
	"%
SW[10]: of IOStandard LVCMOS33
	"$
SW[9]: of IOStandard LVCMOS18
	"$
SW[8]: of IOStandard LVCMOS18
	"$
SW[7]: of IOStandard LVCMOS33
	"$
SW[6]: of IOStandard LVCMOS33
	"$
SW[5]: of IOStandard LVCMOS33
	"$
SW[4]: of IOStandard LVCMOS33
	"$
SW[3]: of IOStandard LVCMOS33
	"$
SW[2]: of IOStandard LVCMOS33
	"$
SW[1]: of IOStandard LVCMOS33
	""
SW[0]: of IOStandard LVCMOS332default:default8Z30-12h px� 
E
%Done setting XDC timing constraints.
35*timingZ38-35h px� 
{

Phase %s%s
101*constraints2
	1.1.1.18 2default:default2'
IO and Clk Clean Up2default:defaultZ18-101h px� 
�

Phase %s%s
101*constraints2
1.1.1.18.1 2default:default2/
Constructing HAPIClkRuleMgr2default:defaultZ18-101h px� 
W
BPhase 1.1.1.18.1 Constructing HAPIClkRuleMgr | Checksum: 0350f077
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:15 ; elapsed = 00:00:08 . Memory (MB): peak = 2516.102 ; gain = 0.000 ; free physical = 3563 ; free virtual = 127622default:defaulth px� 
M
8Phase 1.1.1.18 IO and Clk Clean Up | Checksum: 0350f077
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:16 ; elapsed = 00:00:08 . Memory (MB): peak = 2516.102 ; gain = 0.000 ; free physical = 3563 ; free virtual = 127622default:defaulth px� 
�

Phase %s%s
101*constraints2
	1.1.1.19 2default:default2>
*Implementation Feasibility check On IDelay2default:defaultZ18-101h px� 
d
OPhase 1.1.1.19 Implementation Feasibility check On IDelay | Checksum: 0350f077
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:16 ; elapsed = 00:00:08 . Memory (MB): peak = 2516.102 ; gain = 0.000 ; free physical = 3563 ; free virtual = 127622default:defaulth px� 
{

Phase %s%s
101*constraints2
	1.1.1.20 2default:default2'
Commit IO Placement2default:defaultZ18-101h px� 
M
8Phase 1.1.1.20 Commit IO Placement | Checksum: 717206cf
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:16 ; elapsed = 00:00:08 . Memory (MB): peak = 2516.102 ; gain = 0.000 ; free physical = 3563 ; free virtual = 127622default:defaulth px� 
U
@Phase 1.1.1 ParallelPlaceIOClockAndInitTop | Checksum: 717206cf
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:16 ; elapsed = 00:00:08 . Memory (MB): peak = 2516.102 ; gain = 0.000 ; free physical = 3563 ; free virtual = 127622default:defaulth px� 
h
SPhase 1.1 IO Placement/ Clock Placement/ Build Placer Device | Checksum: 13c4b5d3f
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:16 ; elapsed = 00:00:08 . Memory (MB): peak = 2516.102 ; gain = 0.000 ; free physical = 3563 ; free virtual = 127622default:defaulth px� 
}

Phase %s%s
101*constraints2
1.2 2default:default2.
Build Placer Netlist Model2default:defaultZ18-101h px� 
v

Phase %s%s
101*constraints2
1.2.1 2default:default2%
Place Init Design2default:defaultZ18-101h px� 
r

Phase %s%s
101*constraints2
1.2.1.1 2default:default2
Make Others2default:defaultZ18-101h px� 
E
0Phase 1.2.1.1 Make Others | Checksum: 1914725ff
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:17 ; elapsed = 00:00:10 . Memory (MB): peak = 2516.102 ; gain = 0.000 ; free physical = 3559 ; free virtual = 127592default:defaulth px� 
~

Phase %s%s
101*constraints2
1.2.1.2 2default:default2+
Init Lut Pin Assignment2default:defaultZ18-101h px� 
Q
<Phase 1.2.1.2 Init Lut Pin Assignment | Checksum: 1914725ff
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:18 ; elapsed = 00:00:10 . Memory (MB): peak = 2516.102 ; gain = 0.000 ; free physical = 3554 ; free virtual = 127552default:defaulth px� 
I
4Phase 1.2.1 Place Init Design | Checksum: 1e023c79e
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:33 ; elapsed = 00:00:16 . Memory (MB): peak = 2516.102 ; gain = 0.000 ; free physical = 3542 ; free virtual = 127442default:defaulth px� 
P
;Phase 1.2 Build Placer Netlist Model | Checksum: 1e023c79e
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:33 ; elapsed = 00:00:16 . Memory (MB): peak = 2516.102 ; gain = 0.000 ; free physical = 3542 ; free virtual = 127442default:defaulth px� 
z

Phase %s%s
101*constraints2
1.3 2default:default2+
Constrain Clocks/Macros2default:defaultZ18-101h px� 
M
8Phase 1.3 Constrain Clocks/Macros | Checksum: 1e023c79e
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:33 ; elapsed = 00:00:16 . Memory (MB): peak = 2516.102 ; gain = 0.000 ; free physical = 3542 ; free virtual = 127442default:defaulth px� 
I
4Phase 1 Placer Initialization | Checksum: 1e023c79e
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:33 ; elapsed = 00:00:16 . Memory (MB): peak = 2516.102 ; gain = 0.000 ; free physical = 3542 ; free virtual = 127442default:defaulth px� 
q

Phase %s%s
101*constraints2
2 2default:default2$
Global Placement2default:defaultZ18-101h px� 
D
/Phase 2 Global Placement | Checksum: 236e5f61f
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:02:13 ; elapsed = 00:01:16 . Memory (MB): peak = 2516.102 ; gain = 0.000 ; free physical = 3519 ; free virtual = 127222default:defaulth px� 
q

Phase %s%s
101*constraints2
3 2default:default2$
Detail Placement2default:defaultZ18-101h px� 
}

Phase %s%s
101*constraints2
3.1 2default:default2.
Commit Multi Column Macros2default:defaultZ18-101h px� 
P
;Phase 3.1 Commit Multi Column Macros | Checksum: 236e5f61f
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:02:15 ; elapsed = 00:01:16 . Memory (MB): peak = 2516.102 ; gain = 0.000 ; free physical = 3519 ; free virtual = 127222default:defaulth px� 


Phase %s%s
101*constraints2
3.2 2default:default20
Commit Most Macros & LUTRAMs2default:defaultZ18-101h px� 
R
=Phase 3.2 Commit Most Macros & LUTRAMs | Checksum: 1e451f816
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:02:39 ; elapsed = 00:01:25 . Memory (MB): peak = 2516.102 ; gain = 0.000 ; free physical = 3519 ; free virtual = 127222default:defaulth px� 
y

Phase %s%s
101*constraints2
3.3 2default:default2*
Area Swap Optimization2default:defaultZ18-101h px� 
L
7Phase 3.3 Area Swap Optimization | Checksum: 20562f095
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:02:40 ; elapsed = 00:01:25 . Memory (MB): peak = 2516.102 ; gain = 0.000 ; free physical = 3519 ; free virtual = 127222default:defaulth px� 
x

Phase %s%s
101*constraints2
3.4 2default:default2)
updateClock Trees: DP2default:defaultZ18-101h px� 
K
6Phase 3.4 updateClock Trees: DP | Checksum: 20562f095
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:02:40 ; elapsed = 00:01:25 . Memory (MB): peak = 2516.102 ; gain = 0.000 ; free physical = 3519 ; free virtual = 127222default:defaulth px� 
x

Phase %s%s
101*constraints2
3.5 2default:default2)
Timing Path Optimizer2default:defaultZ18-101h px� 
K
6Phase 3.5 Timing Path Optimizer | Checksum: 1bf66eec0
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:02:47 ; elapsed = 00:01:28 . Memory (MB): peak = 2516.102 ; gain = 0.000 ; free physical = 3519 ; free virtual = 127222default:defaulth px� 
t

Phase %s%s
101*constraints2
3.6 2default:default2%
Fast Optimization2default:defaultZ18-101h px� 
G
2Phase 3.6 Fast Optimization | Checksum: 1bf66eec0
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:02:47 ; elapsed = 00:01:28 . Memory (MB): peak = 2516.102 ; gain = 0.000 ; free physical = 3519 ; free virtual = 127222default:defaulth px� 


Phase %s%s
101*constraints2
3.7 2default:default20
Small Shape Detail Placement2default:defaultZ18-101h px� 
Q
<Phase 3.7 Small Shape Detail Placement | Checksum: fde366bf
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:03:04 ; elapsed = 00:01:42 . Memory (MB): peak = 2516.102 ; gain = 0.000 ; free physical = 3516 ; free virtual = 127202default:defaulth px� 
u

Phase %s%s
101*constraints2
3.8 2default:default2&
Re-assign LUT pins2default:defaultZ18-101h px� 
H
3Phase 3.8 Re-assign LUT pins | Checksum: 18fe816eb
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:03:06 ; elapsed = 00:01:44 . Memory (MB): peak = 2516.102 ; gain = 0.000 ; free physical = 3516 ; free virtual = 127202default:defaulth px� 
�

Phase %s%s
101*constraints2
3.9 2default:default22
Pipeline Register Optimization2default:defaultZ18-101h px� 
T
?Phase 3.9 Pipeline Register Optimization | Checksum: 18fe816eb
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:03:07 ; elapsed = 00:01:44 . Memory (MB): peak = 2516.102 ; gain = 0.000 ; free physical = 3516 ; free virtual = 127202default:defaulth px� 
u

Phase %s%s
101*constraints2
3.10 2default:default2%
Fast Optimization2default:defaultZ18-101h px� 
H
3Phase 3.10 Fast Optimization | Checksum: 18fe816eb
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:03:19 ; elapsed = 00:01:48 . Memory (MB): peak = 2516.102 ; gain = 0.000 ; free physical = 3515 ; free virtual = 127192default:defaulth px� 
D
/Phase 3 Detail Placement | Checksum: 18fe816eb
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:03:19 ; elapsed = 00:01:49 . Memory (MB): peak = 2516.102 ; gain = 0.000 ; free physical = 3515 ; free virtual = 127192default:defaulth px� 
�

Phase %s%s
101*constraints2
4 2default:default2<
(Post Placement Optimization and Clean-Up2default:defaultZ18-101h px� 
{

Phase %s%s
101*constraints2
4.1 2default:default2,
Post Commit Optimization2default:defaultZ18-101h px� 
E
%Done setting XDC timing constraints.
35*timingZ38-35h px� 
}

Phase %s%s
101*constraints2
4.1.1 2default:default2,
updateClock Trees: PCOPT2default:defaultZ18-101h px� 
P
;Phase 4.1.1 updateClock Trees: PCOPT | Checksum: 1f136baf2
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:03:41 ; elapsed = 00:01:55 . Memory (MB): peak = 2516.102 ; gain = 0.000 ; free physical = 3513 ; free virtual = 127172default:defaulth px� 
�

Phase %s%s
101*constraints2
4.1.2 2default:default2/
Post Placement Optimization2default:defaultZ18-101h px� 
�
hPost Placement Timing Summary WNS=%s. For the most accurate timing information please run report_timing.610*place2
0.4492default:defaultZ30-746h px� 
R
=Phase 4.1.2 Post Placement Optimization | Checksum: e7a336b9
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:03:42 ; elapsed = 00:01:56 . Memory (MB): peak = 2516.102 ; gain = 0.000 ; free physical = 3513 ; free virtual = 127172default:defaulth px� 
M
8Phase 4.1 Post Commit Optimization | Checksum: e7a336b9
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:03:43 ; elapsed = 00:01:57 . Memory (MB): peak = 2516.102 ; gain = 0.000 ; free physical = 3513 ; free virtual = 127172default:defaulth px� 
�

Phase %s%s
101*constraints2
4.2 2default:default25
!Sweep Clock Roots: Post-Placement2default:defaultZ18-101h px� 
V
APhase 4.2 Sweep Clock Roots: Post-Placement | Checksum: e7a336b9
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:03:43 ; elapsed = 00:01:57 . Memory (MB): peak = 2516.102 ; gain = 0.000 ; free physical = 3513 ; free virtual = 127182default:defaulth px� 
�

Phase %s%s
101*constraints2
4.3 2default:default27
#Uram Pipeline Register Optimization2default:defaultZ18-101h px� 
X
CPhase 4.3 Uram Pipeline Register Optimization | Checksum: e7a336b9
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:03:43 ; elapsed = 00:01:57 . Memory (MB): peak = 2516.102 ; gain = 0.000 ; free physical = 3513 ; free virtual = 127172default:defaulth px� 
y

Phase %s%s
101*constraints2
4.4 2default:default2*
Post Placement Cleanup2default:defaultZ18-101h px� 
K
6Phase 4.4 Post Placement Cleanup | Checksum: e7a336b9
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:03:44 ; elapsed = 00:01:57 . Memory (MB): peak = 2516.102 ; gain = 0.000 ; free physical = 3513 ; free virtual = 127172default:defaulth px� 
s

Phase %s%s
101*constraints2
4.5 2default:default2$
Placer Reporting2default:defaultZ18-101h px� 
E
0Phase 4.5 Placer Reporting | Checksum: e7a336b9
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:03:44 ; elapsed = 00:01:58 . Memory (MB): peak = 2516.102 ; gain = 0.000 ; free physical = 3513 ; free virtual = 127172default:defaulth px� 
z

Phase %s%s
101*constraints2
4.6 2default:default2+
Final Placement Cleanup2default:defaultZ18-101h px� 
M
8Phase 4.6 Final Placement Cleanup | Checksum: 11759f2ec
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:03:44 ; elapsed = 00:01:58 . Memory (MB): peak = 2516.102 ; gain = 0.000 ; free physical = 3513 ; free virtual = 127172default:defaulth px� 
\
GPhase 4 Post Placement Optimization and Clean-Up | Checksum: 11759f2ec
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:03:44 ; elapsed = 00:01:58 . Memory (MB): peak = 2516.102 ; gain = 0.000 ; free physical = 3513 ; free virtual = 127172default:defaulth px� 
>
)Ending Placer Task | Checksum: 10bc0ef8b
*commonh px� 
�

%s
*constraints2�
�Time (s): cpu = 00:03:44 ; elapsed = 00:01:58 . Memory (MB): peak = 2516.102 ; gain = 0.000 ; free physical = 3513 ; free virtual = 127172default:defaulth px� 
Z
Releasing license: %s
83*common2"
Implementation2default:defaultZ17-83h px� 
�
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
1052default:default2
272default:default2
02default:default2
02default:defaultZ4-41h px� 
^
%s completed successfully
29*	vivadotcl2 
place_design2default:defaultZ4-42h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2"
place_design: 2default:default2
00:03:482default:default2
00:02:002default:default2
2516.1022default:default2
0.0002default:default2
35132default:default2
127172default:defaultZ17-722h px� 
D
Writing placer database...
1603*designutilsZ20-1893h px� 
=
Writing XDEF routing.
211*designutilsZ20-211h px� 
J
#Writing XDEF routing logical nets.
209*designutilsZ20-209h px� 
J
#Writing XDEF routing special nets.
210*designutilsZ20-210h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2)
Write XDEF Complete: 2default:default2
00:00:092default:default2
00:00:042default:default2
2516.1022default:default2
0.0002default:default2
33872default:default2
127182default:defaultZ17-722h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2&
write_checkpoint: 2default:default2
00:00:112default:default2
00:00:072default:default2
2516.1022default:default2
0.0002default:default2
34882default:default2
127172default:defaultZ17-722h px� 
�
�report_io: Time (s): cpu = 00:00:00.11 ; elapsed = 00:00:00.16 . Memory (MB): peak = 2516.102 ; gain = 0.000 ; free physical = 3487 ; free virtual = 12716
*commonh px� 
�
�report_utilization: Time (s): cpu = 00:00:00.30 ; elapsed = 00:00:00.36 . Memory (MB): peak = 2516.102 ; gain = 0.000 ; free physical = 3487 ; free virtual = 12716
*commonh px� 
�
�report_control_sets: Time (s): cpu = 00:00:00.15 ; elapsed = 00:00:00.22 . Memory (MB): peak = 2516.102 ; gain = 0.000 ; free physical = 3485 ; free virtual = 12716
*commonh px� 


End Record