From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: pch_can: Data transmission stops after dropped packet
Date: Tue, 11 Dec 2012 21:21:34 +0100
Message-ID: <50C795CE.6060804@grandegger.com>
References: <loom.20121114T160521-534@post.gmane.org> <50ACABE2.2020306@grandegger.com> <50C0B05F.7020606@grandegger.com> <2331999.ZYFOYXdjyx@ws-stein> <50C1160A.20203@grandegger.com> <loom.20121211T153556-802@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:54794 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753083Ab2LKUVh (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 11 Dec 2012 15:21:37 -0500
In-Reply-To: <loom.20121211T153556-802@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Michael Pellegrini <mikep86@gmail.com>
Cc: linux-can@vger.kernel.org

On 12/11/2012 03:46 PM, Michael Pellegrini wrote:
> Wolfgang Grandegger <wg <at> grandegger.com> writes:
> 
>> To summarize my understanding of your problem(s). As long as there are
>> no I2C transfers, everything works fine, right? The patch below does
>> report some write-readback failures but that's due to reserved read-only
>> bits. I assume t hat you also use my "RFC v2" patches for c_can.
>>
>> Trouble starts with concurrent I2C transfers. Then the protected
>> write-readback test fails, which I regard as abnormal hardware behavior,
>> resulting in message losses and out-of-order reception.
>>
>> Would be interesting to compare the hardware. Michael, could you also
>> show the output of "lspci -vv".
> 
> I applied the patch provided.  On driver load, dmesg reports the following:
> 
> [  379.817717] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. 
> got: 0x2000

This is normal because the register returns always that *read-only* bit.
Nothing to worry about. You seem not to observe the serious
write-readback errors Alexander reported.

> "lspci -vv" reports:
> 
> 02:0c.2 Serial bus controller [0c80]: Intel Corporation Platform Controller Hub 
> EG20T I2C Controller
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
> Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
> <MAbort- >SERR- <PERR- INTx-
>         Latency: 0
>         Interrupt: pin C routed to IRQ 7
>         Region 1: Memory at d0144000 (32-bit, non-prefetchable) [size=256]
>         Capabilities: [40] MSI: Enable- Count=1/1 Maskable- 64bit-
>                 Address: 00000000  Data: 0000
>         Capabilities: [50] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-
> ,D3hot-,D3cold-)
>                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
> 
> 02:0c.3 CANBUS: Intel Corporation Platform Controller Hub EG20T Controller Area 
> Network (CAN) Controller
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
> Stepping- SERR- FastB2B- DisINTx+
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
> <MAbort- >SERR- <PERR- INTx-
>         Latency: 0
>         Interrupt: pin C routed to IRQ 42
>         Region 1: Memory at d0143000 (32-bit, non-prefetchable) [size=512]
>         Capabilities: [40] MSI: Enable+ Count=1/1 Maskable- 64bit-
>                 Address: fee0300c  Data: 4179
>         Capabilities: [50] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-
> ,D3hot-,D3cold-)
>                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>         Kernel driver in use: c_can_pci
>         Kernel modules: c_can_pci
> 
> Based on a quick test, the CAN interface appears functional with this driver.
> However, I am unable to test the I2C interface as I can't get I2C devices to
> appear in /dev right now.
> 
> I apologize for the delay in getting these results back to you.

OK, anyway, thanks for testing.

Wolfgang.

