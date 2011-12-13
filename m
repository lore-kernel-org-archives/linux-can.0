From: Wolfgang <wutz@unterderbruecke.de>
Subject: Re: backporting can & can-j1939
Date: Tue, 13 Dec 2011 15:20:24 +0000 (UTC)
Message-ID: <loom.20111213T155714-170@post.gmane.org>
References: <20111209134721.GA309@e-circ.dyndns.org> <loom.20111209T145701-227@post.gmane.org> <20111209143224.GB309@e-circ.dyndns.org> <20111209144911.144460@gmx.net> <20111209150133.GA1470@e-circ.dyndns.org> <loom.20111209T175414-826@post.gmane.org> <20111212081217.GA351@e-circ.dyndns.org> <loom.20111212T121257-904@post.gmane.org> <20111212124031.GD351@e-circ.dyndns.org> <loom.20111212T160733-221@post.gmane.org> <20111213095312.GC430@e-circ.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:51325 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752031Ab1LMPUk (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 13 Dec 2011 10:20:40 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1RaU9n-0003jN-Lb
	for linux-can@vger.kernel.org; Tue, 13 Dec 2011 16:20:39 +0100
Received: from fire.d-i-f.com ([80.152.230.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Tue, 13 Dec 2011 16:20:39 +0100
Received: from wutz by fire.d-i-f.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Tue, 13 Dec 2011 16:20:39 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

> It appears quite complex. It may be better to start over
> with a fresh kernel, and copy those files from my
> can-j1939-modules, since this repository contains
> #if KERNEL_VERSION macros that will make it work on 2.6.31.

I am not really sure, so I ask, should I build a new kernel and after building
replace the things from can-j1939-modules or should I place the things from
can-j1939-modules before building the kernel?
And what particular things should I copy?

--Wolfgang



