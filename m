From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: [RFC v2 0/7] pch_can/c_can: fix races and add PCH support to c_can
Date: Thu, 06 Dec 2012 16:55:44 +0100
Message-ID: <1581334.WlLyGle2s4@ws-stein>
References: <1354199987-10350-1-git-send-email-wg@grandegger.com> <50C0B6A8.8080509@grandegger.com> <50C0B97B.5020107@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:43049 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1423878Ab2LFPzr (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 6 Dec 2012 10:55:47 -0500
In-Reply-To: <50C0B97B.5020107@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org, bhupesh.sharma@st.com, tomoya.rohm@gmail.com

Hello Wolfgang,

On Thursday 06 December 2012 16:27:55, Wolfgang Grandegger wrote:
> >>> I think it's enough to write the message once.
> >>
> >> I can reply to this one immediatly. Not it is not sufficent to write once. This was my 1st implementation (iowrite32 just above the do) and noticed in case the write doesn't succeed I won't succeed until all ioread32 have passed. IMO I must write again if it failed before.
> > 
> > Puh, even worse. Then I'm really surprised that the driver continues to
> > work more or less properly. Anyway, sometime it takes up to 500+ us for
> > the good value to show up. If we have a real write-read sequence to the
> > same register, everything can happen. Looks like broken hardware.
> 
> Could you show the output of "lspci -vv" of your system?

Here we go,

Alexander

00:00.0 Host bridge: Intel Corporation Device 4114 (rev 05)
	Subsystem: Intel Corporation Device 4108
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0

00:01.0 Host bridge: Intel Corporation Device 8183 (rev 02)
	Subsystem: Intel Corporation Device 8186
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0

00:02.0 Display controller: Intel Corporation Device 4108 (rev 05)
	Subsystem: Intel Corporation Device 4108
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin A routed to IRQ 255
	Region 0: Memory at a0200000 (32-bit, non-prefetchable) [disabled] [size=1M]
	Region 1: I/O ports at 4008 [disabled] [size=8]
	Region 2: Memory at 90000000 (32-bit, non-prefetchable) [disabled] [size=256M]
	Region 3: Memory at a03c0000 (32-bit, non-prefetchable) [disabled] [size=256K]
	Capabilities: [d0] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [b0] Vendor Specific Information <?>
	Capabilities: [90] MSI: Mask- 64bit- Count=1/1 Enable-
		Address: 00000000  Data: 0000

00:03.0 Multimedia video controller: Intel Corporation Device 8182 (rev 02)
	Subsystem: Intel Corporation Device 8186
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin A routed to IRQ 255
	Region 0: Memory at a0300000 (32-bit, non-prefetchable) [disabled] [size=512K]
	Region 1: I/O ports at 4000 [disabled] [size=8]
	Region 2: Memory at 80000000 (32-bit, non-prefetchable) [disabled] [size=256M]
	Region 3: Memory at a0380000 (32-bit, non-prefetchable) [disabled] [size=256K]
	Capabilities: [d0] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [b0] Vendor Specific Information <?>
	Capabilities: [90] MSI: Mask- 64bit- Count=1/1 Enable-
		Address: 00000000  Data: 0000

00:17.0 PCI bridge: Intel Corporation Device 8184 (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=02, sec-latency=0
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: a0100000-a01fffff
	Prefetchable memory behind bridge: 40000000-401fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v1) Root Port (Slot-), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #1, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0 <256ns, L1 <4us
			ClockPM+ Surprise- LLActRep+ BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
	Capabilities: [90] Subsystem: Intel Corporation Device 8186
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100] Virtual Channel <?>
	Kernel driver in use: pcieport

00:18.0 PCI bridge: Intel Corporation Device 8185 (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
	I/O behind bridge: 00002000-00002fff
	Memory behind bridge: a0000000-a00fffff
	Prefetchable memory behind bridge: 40200000-403fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #2, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0 <256ns, L1 <4us
			ClockPM+ Surprise- LLActRep+ BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surpise+
			Slot #  2, PowerLimit 10.000000; Interlock- NoCompl-
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt+ HPIrq+ LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet- LinkState+
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
	Capabilities: [90] Subsystem: Intel Corporation Device 8186
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100] Virtual Channel <?>
	Kernel driver in use: pcieport

00:1b.0 Audio device: Intel Corporation System Controller Hub (SCH Poulsbo) HD Audio Controller (rev 02)
	Subsystem: Intel Corporation Device 8186
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at a0400000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed unknown, Width x0, ASPM unknown, Latency L0 <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM L0s Enabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
	Capabilities: [100] Virtual Channel <?>
	Capabilities: [130] Root Complex Link <?>
	Kernel driver in use: HDA Intel

00:1f.0 ISA bridge: Intel Corporation Device 8186 (rev 02)
	Subsystem: Intel Corporation Device 8186
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Kernel driver in use: lpc_sch

01:00.0 PCI bridge: Intel Corporation Device 8800 (rev 01) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Bus: primary=01, secondary=02, subordinate=02, sec-latency=0
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: a0100000-a01fffff
	Prefetchable memory behind bridge: 0000000040000000-00000000400fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	Expansion ROM at 40100000 [disabled] [size=64K]
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0+,D1+,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [70] Express (v2) PCI/PCI-X Bridge, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop- BrConfRtry-
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0 <512ns, L1 <64us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB

02:00.0 Class ff00: Intel Corporation Device 8801 (rev 01)
	Subsystem: Intel Corporation Device 8801
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Region 1: Memory at a0102000 (32-bit, non-prefetchable) [size=2K]
	Expansion ROM at 40000000 [disabled] [size=128K]
	Capabilities: [40] MSI: Mask- 64bit- Count=1/1 Enable-
		Address: 00000000  Data: 0000
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: pch_phub

02:00.1 Ethernet controller: Intel Corporation Device 8802 (rev 02)
	Subsystem: Intel Corporation Device 8802
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 55
	Region 0: I/O ports at 3020 [size=32]
	Region 1: Memory at a0107000 (32-bit, non-prefetchable) [size=512]
	Capabilities: [40] MSI: Mask- 64bit- Count=1/1 Enable+
		Address: fee0300c  Data: 41d1
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: pch_gbe
	Kernel modules: pch_gbe

02:00.2 Class ff00: Intel Corporation Device 8803 (rev 01)
	Subsystem: Intel Corporation Device 8803
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 40
	Region 1: Memory at a0114000 (32-bit, non-prefetchable) [size=64]
	Capabilities: [40] MSI: Mask- 64bit- Count=1/1 Enable+
		Address: fee0300c  Data: 4149
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: pch_gpio

02:02.0 USB Controller: Intel Corporation Device 8804 (rev 02) (prog-if 10 [OHCI])
	Subsystem: Intel Corporation Device 8804
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin B routed to IRQ 19
	Region 0: Memory at a0113000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [40] MSI: Mask- 64bit- Count=1/1 Enable-
		Address: 00000000  Data: 0000
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: ohci_hcd

02:02.1 USB Controller: Intel Corporation Device 8805 (rev 02) (prog-if 10 [OHCI])
	Subsystem: Intel Corporation Device 8805
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin B routed to IRQ 19
	Region 0: Memory at a0112000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [40] MSI: Mask- 64bit- Count=1/1 Enable-
		Address: 00000000  Data: 0000
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: ohci_hcd

02:02.2 USB Controller: Intel Corporation Device 8806 (rev 02) (prog-if 10 [OHCI])
	Subsystem: Intel Corporation Device 8806
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin B routed to IRQ 19
	Region 0: Memory at a0111000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [40] MSI: Mask- 64bit- Count=1/1 Enable-
		Address: 00000000  Data: 0000
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: ohci_hcd

02:02.3 USB Controller: Intel Corporation Device 8807 (rev 02) (prog-if 20 [EHCI])
	Subsystem: Intel Corporation Device 8807
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin B routed to IRQ 19
	Region 0: Memory at a0110000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [40] MSI: Mask- 64bit- Count=1/1 Enable-
		Address: 00000000  Data: 0000
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: ehci_hcd

02:02.4 USB Controller: Intel Corporation Device 8808 (rev 02) (prog-if fe [USB Device])
	Subsystem: Intel Corporation Device 8808
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin B routed to IRQ 255
	Region 1: Memory at a0100000 (32-bit, non-prefetchable) [disabled] [size=8K]
	Capabilities: [40] MSI: Mask- 64bit- Count=1/1 Enable-
		Address: 00000000  Data: 0000
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:04.0 SD Host controller: Intel Corporation Device 8809 (rev 01) (prog-if 01)
	Subsystem: Intel Corporation Device 8809
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin C routed to IRQ 49
	Region 0: Memory at a0106000 (32-bit, non-prefetchable) [size=512]
	Capabilities: [80] MSI: Mask- 64bit- Count=1/1 Enable+
		Address: fee0300c  Data: 41a1
	Capabilities: [90] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: sdhci-pci

02:04.1 SD Host controller: Intel Corporation Device 880a (rev 01) (prog-if 01)
	Subsystem: Intel Corporation Device 880a
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin C routed to IRQ 50
	Region 0: Memory at a0105000 (32-bit, non-prefetchable) [size=512]
	Capabilities: [80] MSI: Mask- 64bit- Count=1/1 Enable+
		Address: fee0300c  Data: 41a9
	Capabilities: [90] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: sdhci-pci

02:06.0 SATA controller: Intel Corporation Device 880b (rev 02) (prog-if 01 [AHCI 1.0])
	Subsystem: Intel Corporation Device 880b
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin D routed to IRQ 47
	Region 4: I/O ports at 3000 [size=32]
	Region 5: Memory at a0103000 (32-bit, non-prefetchable) [size=1K]
	Expansion ROM at 40020000 [disabled] [size=128K]
	Capabilities: [40] MSI: Mask- 64bit- Count=1/1 Enable+
		Address: fee0300c  Data: 4191
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [60] SATA HBA <?>
	Kernel driver in use: ahci

02:08.0 USB Controller: Intel Corporation Device 880c (rev 02) (prog-if 10 [OHCI])
	Subsystem: Intel Corporation Device 880c
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at a010f000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [40] MSI: Mask- 64bit- Count=1/1 Enable-
		Address: 00000000  Data: 0000
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: ohci_hcd

02:08.1 USB Controller: Intel Corporation Device 880d (rev 02) (prog-if 10 [OHCI])
	Subsystem: Intel Corporation Device 880d
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at a010e000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [40] MSI: Mask- 64bit- Count=1/1 Enable-
		Address: 00000000  Data: 0000
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: ohci_hcd

02:08.2 USB Controller: Intel Corporation Device 880e (rev 02) (prog-if 10 [OHCI])
	Subsystem: Intel Corporation Device 880e
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at a010d000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [40] MSI: Mask- 64bit- Count=1/1 Enable-
		Address: 00000000  Data: 0000
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: ohci_hcd

02:08.3 USB Controller: Intel Corporation Device 880f (rev 02) (prog-if 20 [EHCI])
	Subsystem: Intel Corporation Device 880f
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at a010c000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [40] MSI: Mask- 64bit- Count=1/1 Enable-
		Address: 00000000  Data: 0000
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: ehci_hcd

02:0a.0 Class ff00: Intel Corporation Device 8810
	Subsystem: Intel Corporation Device 8810
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin B routed to IRQ 41
	Region 1: Memory at a010b000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [40] MSI: Mask- 64bit- Count=1/1 Enable+
		Address: fee0300c  Data: 4151
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [60] #00 [0000]
	Kernel driver in use: pch-dma

02:0a.1 Serial controller: Intel Corporation Device 8811 (rev 01) (prog-if 02 [16550])
	Subsystem: Intel Corporation Device 8811
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin B routed to IRQ 43
	Region 0: I/O ports at 3058 [size=8]
	Region 1: Memory at a0119000 (32-bit, non-prefetchable) [size=16]
	Capabilities: [40] MSI: Mask- 64bit- Count=1/1 Enable+
		Address: fee0300c  Data: 4169
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: pch_uart

02:0a.2 Serial controller: Intel Corporation Device 8812 (prog-if 02 [16550])
	Subsystem: Intel Corporation Device 8812
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin B routed to IRQ 44
	Region 0: I/O ports at 3050 [size=8]
	Region 1: Memory at a0118000 (32-bit, non-prefetchable) [size=16]
	Capabilities: [40] MSI: Mask- 64bit- Count=1/1 Enable+
		Address: fee0300c  Data: 4171
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: pch_uart

02:0a.3 Serial controller: Intel Corporation Device 8813 (prog-if 02 [16550])
	Subsystem: Intel Corporation Device 8813
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin B routed to IRQ 45
	Region 0: I/O ports at 3048 [size=8]
	Region 1: Memory at a0117000 (32-bit, non-prefetchable) [size=16]
	Capabilities: [40] MSI: Mask- 64bit- Count=1/1 Enable+
		Address: fee0300c  Data: 4179
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: pch_uart

02:0a.4 Serial controller: Intel Corporation Device 8814 (prog-if 02 [16550])
	Subsystem: Intel Corporation Device 8814
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin B routed to IRQ 46
	Region 0: I/O ports at 3040 [size=8]
	Region 1: Memory at a0116000 (32-bit, non-prefetchable) [size=16]
	Capabilities: [40] MSI: Mask- 64bit- Count=1/1 Enable+
		Address: fee0300c  Data: 4181
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: pch_uart

02:0c.0 Class ff00: Intel Corporation Device 8815
	Subsystem: Intel Corporation Device 8815
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin C routed to IRQ 42
	Region 1: Memory at a010a000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [40] MSI: Mask- 64bit- Count=1/1 Enable+
		Address: fee0300c  Data: 4161
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [60] #00 [0000]
	Kernel driver in use: pch-dma

02:0c.1 Serial bus controller [0c80]: Intel Corporation Device 8816
	Subsystem: Intel Corporation Device 8816
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin C routed to IRQ 48
	Region 1: Memory at a0115000 (32-bit, non-prefetchable) [size=32]
	Capabilities: [40] MSI: Mask- 64bit- Count=1/1 Enable+
		Address: fee0300c  Data: 4199
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: pch_spi

02:0c.2 Serial bus controller [0c80]: Intel Corporation Device 8817
	Subsystem: Intel Corporation Device 8817
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin C routed to IRQ 18
	Region 1: Memory at a0109000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [40] MSI: Mask- 64bit- Count=1/1 Enable-
		Address: 00000000  Data: 0000
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: i2c_eg20t

02:0c.3 CANBUS: Intel Corporation Device 8818
	Subsystem: Intel Corporation Device 8818
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin C routed to IRQ 51
	Region 1: Memory at a0104000 (32-bit, non-prefetchable) [size=512]
	Capabilities: [40] MSI: Mask- 64bit- Count=1/1 Enable+
		Address: fee0300c  Data: 41b1
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: c_can_pci
	Kernel modules: c_can_pci

02:0c.4 Class ff00: Intel Corporation Device 8819 (rev 01)
	Subsystem: Intel Corporation Device 8819
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin C routed to IRQ 255
	Region 1: Memory at a0108000 (32-bit, non-prefetchable) [disabled] [size=256]
	Capabilities: [40] MSI: Mask- 64bit- Count=1/1 Enable-
		Address: 00000000  Data: 0000
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

03:00.0 Ethernet controller: Intel Corporation 82574L Gigabit Network Connection
	Subsystem: Intel Corporation Device 0000
	Physical Slot: 2
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 17
	Region 0: Memory at a0000000 (32-bit, non-prefetchable) [size=128K]
	Region 2: I/O ports at 2000 [disabled] [size=32]
	Region 3: Memory at a0020000 (32-bit, non-prefetchable) [size=16K]
	Expansion ROM at 40200000 [disabled] [size=2K]
	Capabilities: [c8] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [d0] MSI: Mask- 64bit+ Count=1/1 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [e0] Express (v1) Endpoint, MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0 <2us, L1 <64us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
	Capabilities: [a0] MSI-X: Enable+ Mask- TabSize=5
		Vector table: BAR=3 offset=00000000
		PBA: BAR=3 offset=00002000
	Capabilities: [100] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
	Capabilities: [140] Device Serial Number f6-01-f8-ff-ff-c2-50-00
	Kernel driver in use: e1000e
	Kernel modules: e1000e


