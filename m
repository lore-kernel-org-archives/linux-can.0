From: Michael Pellegrini <mikep86@gmail.com>
Subject: Re: =?utf-8?b?cGNoX2Nhbjo=?= Data transmission stops after dropped packet
Date: Wed, 21 Nov 2012 15:15:23 +0000 (UTC)
Message-ID: <loom.20121121T160744-278@post.gmane.org>
References: <loom.20121114T160521-534@post.gmane.org> <50A4972A.9070707@hartkopp.net> <50A4EA87.9020206@grandegger.com> <loom.20121115T171319-854@post.gmane.org> <50A55C65.2020003@grandegger.com> <loom.20121115T222748-977@post.gmane.org> <50A95FC1.3050907@grandegger.com> <loom.20121119T155735-163@post.gmane.org> <50AA4FB3.7070009@grandegger.com> <loom.20121119T171647-35@post.gmane.org> <50AA5EE6.6060105@grandegger.com> <loom.20121119T183819-427@post.gmane.org> <50AA86DB.7000506@grandegger.com> <loom.20121119T211403-520@post.gmane.org> <50AAA8C8.2080504@grandegger.com> <loom.20121120T151831-134@post.gmane.org> <50ABABDE.8060503@grandegger.com> <loom.20121120T192159-770@post.gmane.org> <50ABF09C.8040303@grandegger.com> <50ACABE2.2020306@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:46353 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755080Ab2KUPPg (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 21 Nov 2012 10:15:36 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1TbC1g-0000k7-Nv
	for linux-can@vger.kernel.org; Wed, 21 Nov 2012 16:15:44 +0100
Received: from 96.45.208.254 ([96.45.208.254])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 21 Nov 2012 16:15:44 +0100
Received: from mikep86 by 96.45.208.254 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 21 Nov 2012 16:15:44 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Wolfgang Grandegger <wg <at> grandegger.com> writes:

> Could you please try the attached c-can-pci-v4.tar.bz2. I'm puzzled why
> MSI does not get enabled. What does "lspci -vv" list for that device?

"lspci -vv" lists:

02:0c.3 CANBUS: Intel Corporation Platform Controller Hub EG20T Controller Area 
Network (CAN) Controller
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin C routed to IRQ 41
        Region 1: Memory at d0143000 (32-bit, non-prefetchable) [size=512]
        Capabilities: [40] MSI: Enable+ Count=1/1 Maskable- 64bit-
                Address: fee0300c  Data: 4179
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-
,D3hot-,D3cold-)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Kernel driver in use: c_can_pci
        Kernel modules: pch_can_test, pch_can

This driver is working very well so far.  ifconfig shows that I am sending and
receiving CAN messages successfully.  This is confirmed externally by the CAN
Monitor system.

I will start a more intensive test now and report the results.

- Mike

