From: Michael Pellegrini <mikep86@gmail.com>
Subject: Re: =?utf-8?b?cGNoX2Nhbjo=?= Data transmission stops after dropped packet
Date: Tue, 20 Nov 2012 14:25:58 +0000 (UTC)
Message-ID: <loom.20121120T151831-134@post.gmane.org>
References: <loom.20121114T160521-534@post.gmane.org> <50A4972A.9070707@hartkopp.net> <50A4EA87.9020206@grandegger.com> <loom.20121115T171319-854@post.gmane.org> <50A55C65.2020003@grandegger.com> <loom.20121115T222748-977@post.gmane.org> <50A95FC1.3050907@grandegger.com> <loom.20121119T155735-163@post.gmane.org> <50AA4FB3.7070009@grandegger.com> <loom.20121119T171647-35@post.gmane.org> <50AA5EE6.6060105@grandegger.com> <loom.20121119T183819-427@post.gmane.org> <50AA86DB.7000506@grandegger.com> <loom.20121119T211403-520@post.gmane.org> <50AAA8C8.2080504@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:37934 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751198Ab2KTO0T (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 20 Nov 2012 09:26:19 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1TaomR-0002BN-SZ
	for linux-can@vger.kernel.org; Tue, 20 Nov 2012 15:26:28 +0100
Received: from 96.45.208.254 ([96.45.208.254])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Tue, 20 Nov 2012 15:26:27 +0100
Received: from mikep86 by 96.45.208.254 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Tue, 20 Nov 2012 15:26:27 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Wolfgang Grandegger <wg <at> grandegger.com> writes:

> 
> There is obviously still a problem when insmoding the driver. The only
> significant difference vs. the pch_probe() is the line:
> 
>   pci_set_master(pdev);
> 
> which I have commented out. Furthermore I fixed another problem with the
> register access (the shift was wrong). Please retry with the attached
> c-can-pci-v3.tar.bz2.
> 
> Wolfgang.
> 
> Attachment (c-can-pci-v3.tar.bz2): application/x-bzip, 11 KiB

The new driver loads!  After loading the driver, I am able to see the CAN 
interface in ifconfig.  Dmesg output after loading is:

[ 4285.596420] c_can_pci 0000:02:0c.3: PCI INT C -> GSI 18 (level, low) -> IRQ 
18
[ 4285.597107] c_can_pci 0000:02:0c.3: irq 41 for MSI/MSI-X
[ 4285.597135] c_can_pci_probe: bar=1
[ 4285.597191] c_can_pci_probe: addr=f8450000
[ 4285.685151] c_can_pci_reset_pch: addr=f84501fc
[ 4285.685332] c_can_pci 0000:02:0c.3: can0: setting BTR=0518 BRPE=0000

However, everything isn't fixed yet.  After sending a handful of messages, the 
CAN interface hits the same problem that started this thread.  My application 
prints the error "No buffer space available" and the only way to recover is an 
interface reset via "ifconfig can0 down" followed by "ifconfig can0 up".

Is there any information you need me to capture to assist you in debugging?

- Mike

