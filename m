From: Wolfgang <wutz@unterderbruecke.de>
Subject: Re: backporting can & can-j1939
Date: Wed, 14 Dec 2011 13:29:08 +0000 (UTC)
Message-ID: <loom.20111214T140958-737@post.gmane.org>
References: <20111209143224.GB309@e-circ.dyndns.org> <20111209144911.144460@gmx.net> <20111209150133.GA1470@e-circ.dyndns.org> <loom.20111209T175414-826@post.gmane.org> <20111212081217.GA351@e-circ.dyndns.org> <loom.20111212T121257-904@post.gmane.org> <20111212124031.GD351@e-circ.dyndns.org> <loom.20111212T160733-221@post.gmane.org> <20111213095312.GC430@e-circ.dyndns.org> <loom.20111213T155714-170@post.gmane.org> <20111213155110.GA314@e-circ.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:46861 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751519Ab1LNN30 (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 14 Dec 2011 08:29:26 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1Raotf-00078E-Qp
	for linux-can@vger.kernel.org; Wed, 14 Dec 2011 14:29:23 +0100
Received: from fire.d-i-f.com ([80.152.230.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 14 Dec 2011 14:29:23 +0100
Received: from wutz by fire.d-i-f.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 14 Dec 2011 14:29:23 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Your proposal worked perfect, I can still hardly believe it.

on the target:

$ dmesg | fgrep -i can

mpc52xx_can 80001300.mscan: MSCAN at 0xd1080300, irq 16, clock 100000000 Hz
mpc52xx_can 80001380.mscan: MSCAN at 0xd1084380, irq 17, clock 100000000 Hz
can: controller area network core (rev 20090105 abi 8)
can: raw protocol (rev 20090105)
can: broadcast manager protocol (rev 20090105 t)
can: netlink gateway (rev 20101209)
can: SAE J1939


but when I type (according  to the j1939.txt)

$ ip link set can0 j1939 on

it says:

Error: either "dev" is duplicate, or "j1939" is a garbage.

What have I done wrong, or how is it made right?


Thank you very much so far!!

--Wolfgang


