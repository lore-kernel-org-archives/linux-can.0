From: Andri Yngvason <andri.yngvason@marel.com>
Subject: Re: peak_pci: TX Frame Loss
Date: Thu, 19 Nov 2015 10:12:49 +0000
Message-ID: <20151119101249.17903.72690@maxwell.marel.net>
References: <20151118145121.32487.38169@maxwell.marel.net>
 <564D8A79.7090605@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-am1on0056.outbound.protection.outlook.com ([157.56.112.56]:51424
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756210AbbKSK3z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 19 Nov 2015 05:29:55 -0500
In-Reply-To: <564D8A79.7090605@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>, linux-can@vger.kernel.org
Cc: wg@grandegger.com, mkl@pengutronix.de

Hi Stephane,

Quoting Stephane Grosjean (2015-11-19 08:38:17)
> Hi Andri,
> 
> Could you first give me the result of sudo lspci -d 1c: -vvv please?
root@sensorx:~# ./lspci -d 1c: -vvv
03:00.0 Class 0280: Device 001c:0008 (rev 02)
        Subsystem: Device 001c:0005
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Interrupt: pin A routed to IRQ 19
        Region 0: Memory at f7d10000 (32-bit, non-prefetchable) [size=64K]
        Region 1: Memory at f7d00000 (32-bit, non-prefetchable) [size=64K]
        Capabilities: [50] Power Management version 0
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [70] MSI: Enable- Count=1/2 Maskable- 64bit+
                Address: 0000000000000000  Data: 0000
        Capabilities: [90] Express (v1) Endpoint, MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
                LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s, Exit Latency L0s unlimited, L1 <1us
                        ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
        Capabilities: [100 v1] Vendor Specific Information: ID=0000 Rev=0 Len=00c <?>
        Kernel driver in use: peak_pci
>
[...]

Thanks,
Andri
