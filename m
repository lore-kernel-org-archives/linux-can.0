From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: pch_can: Data transmission stops after dropped packet
Date: Thu, 13 Dec 2012 15:04:35 +0100
Message-ID: <5514012.Sv8BXqiA5S@ws-stein>
References: <loom.20121114T160521-534@post.gmane.org> <1647541.efLPJ8JS7c@ws-stein> <50C79699.1070801@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:38386 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756289Ab2LMOEj (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 13 Dec 2012 09:04:39 -0500
In-Reply-To: <50C79699.1070801@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Michael Pellegrini <mikep86@gmail.com>, linux-can@vger.kernel.org

Hello Wolfgang,

On Tuesday 11 December 2012 21:24:57, Wolfgang Grandegger wrote:
> > I cannot say if any (small) I2C transfer at all raises the problem. I run 'cangen -I 0x300 can0' on my PC connected to my test board. A I2C connected LED is triggered by heartbeat thus there is a small I2C traffic each second. I couldn't see any errors in dmesg in about 10 minutes.
> > But even with that small CAN traffic (next to nothing) a 'watch sensors' (which queries several I2C sensors every 2s) caused errors in dmesg. It seems the problem isn't related to CAN bus load at all.
> 
> Yes, that's also my impression. Most likely it's a problem on the PCI
> bus with caching or concurrent access. Any chance to use a more recent
> version of the Linux kernel?

I tried your v3 patchset based on 6be35c700f742e911ecedd07fcc43d4439922334 (which is next-next/master being merged into Linus' master branch) and it got even "worse". Which actually means I even get PCI write errors if there is no I2C traffic at all (compared the interrupt before and after the test). In the end it's the same error in each case:
[  321.702036] c_can_pci 0000:02:0c.3 can0: write 0xe to offset 0x0 failed. got: 0x0
[  322.630034] c_can_pci 0000:02:0c.3 can0: write 0xe to offset 0x0 failed. got: 0x0
[  350.026035] c_can_pci 0000:02:0c.3 can0: write 0xe to offset 0x0 failed. got: 0x0
[  354.932033] c_can_pci 0000:02:0c.3 can0: write 0xe to offset 0x0 failed. got: 0x0
[  374.812036] c_can_pci 0000:02:0c.3 can0: write 0xe to offset 0x0 failed. got: 0x0
[  378.099034] c_can_pci 0000:02:0c.3 can0: write 0xe to offset 0x0 failed. got: 0x0
[  386.068034] c_can_pci 0000:02:0c.3 can0: write 0xe to offset 0x0 failed. got: 0x0
[  399.639034] c_can_pci 0000:02:0c.3 can0: write 0xe to offset 0x0 failed. got: 0x0
[  401.034033] c_can_pci 0000:02:0c.3 can0: write 0xe to offset 0x0 failed. got: 0x0
[  410.143034] c_can_pci 0000:02:0c.3 can0: write 0xe to offset 0x0 failed. got: 0x0
[  415.082034] c_can_pci 0000:02:0c.3 can0: write 0xe to offset 0x0 failed. got: 0x0
[  418.593033] c_can_pci 0000:02:0c.3 can0: write 0xe to offset 0x0 failed. got: 0x0
[  439.871035] c_can_pci 0000:02:0c.3 can0: write 0xe to offset 0x0 failed. got: 0x0
[  564.614037] c_can_pci 0000:02:0c.3 can0: write 0xe to offset 0x0 failed. got: 0x0
[  586.593035] c_can_pci 0000:02:0c.3 can0: write 0xe to offset 0x0 failed. got: 0x0

I compared the output of lspci -vv from v3.0.31+ and v3.7+ and there are only  few changes which, I suspect, should not have any influence:
* different MSI Data register content
* PCI bridges have a bigger prefetchable memory range
* driver description for HDA audio changed
* Address of the expansion ROM from the external ethernet controller changed (same as the address at the bridges)
* "Kernel driver in use" ehci_hcd and ehci-pci for USB reported by lspci have exchanged

All in all nothing which should have influence.

Best regards,
Alexander

