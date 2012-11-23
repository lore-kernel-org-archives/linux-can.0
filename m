From: Michael Pellegrini <mikep86@gmail.com>
Subject: Re: =?utf-8?b?cGNoX2Nhbjo=?= Data transmission stops after dropped packet
Date: Fri, 23 Nov 2012 15:14:31 +0000 (UTC)
Message-ID: <loom.20121123T160526-473@post.gmane.org>
References: <loom.20121114T160521-534@post.gmane.org> <50A95FC1.3050907@grandegger.com> <loom.20121119T155735-163@post.gmane.org> <50AA4FB3.7070009@grandegger.com> <loom.20121119T171647-35@post.gmane.org> <50AA5EE6.6060105@grandegger.com> <loom.20121119T183819-427@post.gmane.org> <50AA86DB.7000506@grandegger.com> <loom.20121119T211403-520@post.gmane.org> <50AAA8C8.2080504@grandegger.com> <loom.20121120T151831-134@post.gmane.org> <50ABABDE.8060503@grandegger.com> <loom.20121120T192159-770@post.gmane.org> <50ABF09C.8040303@grandegger.com> <50ACABE2.2020306@grandegger.com> <loom.20121121T160744-278@post.gmane.or  g> <loom.20121121T162041-774@p  ost.gmane.org> <50ACF9C0.8050206@grandegger.com> <loom.20121121T170446-911@post.gmane.org> <50AD042B.3020305@grandegger.com> <loom.20121121T184014-391
  @post.gmane.org> <50AD319E.2000209@grandegger.com> <loom.20121121T215717-106@post.gmane.org> <loom.20121123T150627-133@post.gmane.org> <50AF8C01.6060809@grandegger.com> <50AF8C91.3020307@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:46010 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751978Ab2KWPOs (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 23 Nov 2012 10:14:48 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1Tbuy0-0000Xu-Rf
	for linux-can@vger.kernel.org; Fri, 23 Nov 2012 16:14:56 +0100
Received: from 96.45.208.254 ([96.45.208.254])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Fri, 23 Nov 2012 16:14:56 +0100
Received: from mikep86 by 96.45.208.254 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Fri, 23 Nov 2012 16:14:56 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Wolfgang Grandegger <wg <at> grandegger.com> writes:

> When the module is loaded the driver prints out some values. Could you
> please show the output?

On module load, dmesg reports:

[238233.481246] c_can_pci 0000:02:0c.3: PCI INT C -> GSI 18 (level, low) ->
 IRQ 18
[238233.481440] c_can_pci 0000:02:0c.3: irq 41 for MSI/MSI-X
[238233.481483] c_can_pci 0000:02:0c.3: MSI enabled
[238233.481519] c_can_pci 0000:02:0c.3: setting latency timer to 64
[238233.481543] c_can_pci_probe: bar=1
[238233.481624] c_can_pci_probe: addr=f842c000
[238233.492906] CTRL_REG=0x0
[238233.492931] BTR_REG =0x518
[238233.492949] TEST_REG =0x80
[238233.610409] c_can_pci_reset_pch: addr=f842c1fc reset=0x0
[238233.610589] c_can_pci 0000:02:0c.3: can0: setting BTR=0518 BRPE=0000

> Another question? At what rate do you send messages?

6 to 7 messages are sent in bursts every 100ms.  They are sent without any delay
between each message, which is what I think is triggering this driver bug.

- Mike 




