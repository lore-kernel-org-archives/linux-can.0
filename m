From: Wolfgang <wutz@unterderbruecke.de>
Subject: Re: Cross-compiling iproute2-j1939
Date: Thu, 15 Dec 2011 11:24:13 +0000 (UTC)
Message-ID: <loom.20111215T114301-18@post.gmane.org>
References: <20111212124031.GD351@e-circ.dyndns.org> <loom.20111212T160733-221@post.gmane.org> <20111213095312.GC430@e-circ.dyndns.org> <loom.20111213T155714-170@post.gmane.org> <20111213155110.GA314@e-circ.dyndns.org> <loom.20111214T140958-737@post.gmane.org> <20111214154351.GB6112@e-circ.dyndns.org> <loom.20111214T190347-790@post.gmane.org> <20111214204237.GC306@e-circ.dyndns.org> <loom.20111215T085023-710@post.gmane.org> <20111215092018.GB321@e-circ.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:36778 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753670Ab1LOLY1 (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 15 Dec 2011 06:24:27 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1Rb9QI-0001Av-I8
	for linux-can@vger.kernel.org; Thu, 15 Dec 2011 12:24:26 +0100
Received: from fire.d-i-f.com ([80.152.230.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Thu, 15 Dec 2011 12:24:26 +0100
Received: from wutz by fire.d-i-f.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Thu, 15 Dec 2011 12:24:26 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

> I think Pengutronix supports compiling iproute2 _with_ some patches. 
>think you better apply those too. 
When you can use it I could send you the bash compiling iproute2 with pengutronix

I don't know which or what they patched, so I applied your proposal (I had to
change it in the iproute2-j1939, not in the BSP?) - and it worked.

When I have it to change it in the BSP, I am wondering how it get reference, 
because I do $make KERNEL_INCLUDE=<KERNEL_HEADER_PATH> CC=...

but the kernel header path is .../built-target/linux-2.6.31 and the
iproute2 path is ../built-target/iproute2-2.6.29-1 so they aren't 
in touch, as I understand that.

But I hope I did it right!! So can I now copy and/or replace the 
things which I created from compiling iproute2-j1939 and can-utils-j1939 
to the target or all of it?

(iproute2 created 6 directories etc, lib, sbin, share, usr, var)

--Wolfgang


