From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [sja1000/peak_pci]: looks like loss of IRQ on Tegra3 based system...
Date: Thu, 22 May 2014 11:48:43 +0200
Message-ID: <537DC7FB.5070904@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:43013 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754047AbaEVJsr (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 22 May 2014 05:48:47 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi,

Here is an issue a user of the peak_pci driver encounters and for which 
any help is welcome. I have copied some extracts of some of the e-mails 
and debug he did, if this might help. His system is quite specific since 
he runs a 3.1 Kernel on a nVidia Tegra3 but he says he applied all the 
linux-can patches that should... I'm currently having a look to this 
serie of patches, but meanwhile, in case this loss of IRQ when no cable 
is plugged is something heard by anyone...

To recap, after some time with cable completely unplugged and a 
userspace process continuously trying to transmit, IRQs just stop 
getting delivered from the peak device. If the operator toggles PCI 
reset for just that device (in /sys/bus/pci/devices/0000:03:00.0/reset) 
they come back again.

Here's an example reg dump (user added a quick debugfs hack) of when the 
device is in this state. Note that IR in sja1000 and ICR in PETA has 
pending interrupts, but he's not getting them signaled. Well, things may 
be unhappy later since he's reading out IR through debugfs and thus 
clearing it, but the device is not making forward progress anyway :) 
Note that the PITA registers are just being read out as a 32bit value 
for ease of printing.

can0: REG_MOD(0)=0x00
can0: REG_CMR(1)=0x00
can0: REG_SR(2)=0x40
can0: REG_IR(3)=0x40
can0: REG_IER(4)=0x7f
can0: REG_ALC(11)=0x02
can0: REG_ECC(12)=0xa2
can0: REG_EWL(13)=0x60
can0: REG_RXERR(14)=0x87
can0: REG_TXERR(15)=0x00
can0: REG_ACCC0(16)=0x03
can0: REG_ACCC1(17)=0x00
can0: REG_ACCC2(18)=0xa0
can0: REG_ACCC3(19)=0x00
can0: REG_ACCM0(20)=0x00
can0: REG_ACCM1(21)=0x00
can0: REG_ACCM2(22)=0x03
can0: REG_ACCM3(23)=0x00
can0: REG_RMC(29)=0x00
can0: REG_RBSA(30)=0x00
can0: REG_BTR0(6)=0x00
can0: REG_BTR1(7)=0x1c
can0: REG_OCR(8)=0x1a
can0: REG_CDR(31)=0xc7
can0: REG_FI(16)=0x03
can0: REG_ID1(17)=0x00
can0: REG_ID2(18)=0xa0
can0: REG_ID3(19)=0x00
can0: REG_ID4(20)=0x00
can0: PITA_ICR(0x0)=0x30002
can0: PITA_GPIOICR(0x18)=0x50a00
can0: PITA_MISC(0x1c)=0x4000000

Below is the output of lspci -vv on his board. The working CAN device is 
03:00.0.

03:00.0 Network controller: PEAK-System Technik GmbH Device 0008 (rev 02)
Subsystem: PEAK-System Technik GmbH Device 0005
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ 
Stepping- SERR+ FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 32 bytes
Interrupt: pin A routed to IRQ 480
Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=64K]
Region 1: Memory at 10010000 (32-bit, non-prefetchable) [size=64K]
Capabilities: [50] Power Management version 0
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [70] MSI: Enable+ Count=1/1 Maskable- 64bit+
Address: 00000000a65b8000  Data: 0000
Capabilities: [90] Express (v1) Endpoint, MSI 00
DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
MaxPayload 128 bytes, MaxReadReq 512 bytes
DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s, Latency L0 
unlimited, L1 <1us
ClockPM- Surprise- LLActRep- BwNot-
LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk- DLActive- 
BWMgmt- ABWMgmt-
Kernel driver in use: peak_pci

Thank you very much in advance for your help, it is very much appreciated.

Stephane
--
PEAK-System Technik GmbH, Otto-Roehm-Strasse 69, D-64293 Darmstadt 
Geschaeftsleitung: A.Gach/U.Wilhelm,St.Nr.:007/241/13586 FA Darmstadt 
HRB-9183 Darmstadt, Ust.IdNr.:DE 202220078, WEE-Reg.-Nr.: DE39305391 
Tel.+49 (0)6151-817320 / Fax:+49 (0)6151-817329, info@peak-system.com
--
