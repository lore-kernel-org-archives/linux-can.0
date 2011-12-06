From: Wolfgang <wutz@unterderbruecke.de>
Subject: Re: using j1939
Date: Tue, 6 Dec 2011 12:37:56 +0000 (UTC)
Message-ID: <loom.20111206T131950-88@post.gmane.org>
References: <20111206104432.91170@gmx.net> <20111206121403.GB322@e-circ.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:55906 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933310Ab1LFMiL (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 6 Dec 2011 07:38:11 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1RXuHh-0004Sl-BG
	for linux-can@vger.kernel.org; Tue, 06 Dec 2011 13:38:09 +0100
Received: from fire.d-i-f.com ([80.152.230.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Tue, 06 Dec 2011 13:38:09 +0100
Received: from wutz by fire.d-i-f.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Tue, 06 Dec 2011 13:38:09 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

> I'm afraid you lost me on this. Using your (cross)toolchain, you do
> $ make
> etc. to compile (& install) the binaries.

The guys from pengutronix (I am using ptxdist 2010.07.1) told me 
that I have to know how the things in the repositories 
have to be built.

> > But now I am facing the next problem, what type of packages do 
I have to
create for each particular repository?
> I believe you're asking something for a specific build system, but I
> do not know which one.
> What build system do you use?

found and using toolchain:
'/opt/OSELAS.Toolchain-1.99.3/powerpc-603e-linux-gnu/
gcc-4.3.2-glibc-2.8-binutils-2.18-kernel-2.6.27-sanitized/bin'


> Would it be interesting to setup things on your (linux) host 
>PC on a virtual CAN bus?
> Then several things may be a lot easier.

It should or have to run on the target phyCore MPC5121etiny

Wolfgang



