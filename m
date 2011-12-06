From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: using j1939
Date: Tue, 6 Dec 2011 14:18:15 +0100
Message-ID: <20111206131815.GD322@e-circ.dyndns.org>
References: <20111206104432.91170@gmx.net>
 <20111206121403.GB322@e-circ.dyndns.org>
 <loom.20111206T131950-88@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gate.eia.be ([194.78.71.18]:28928 "EHLO mail.eia.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933140Ab1LFNST (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 6 Dec 2011 08:18:19 -0500
Content-Disposition: inline
In-Reply-To: <loom.20111206T131950-88@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang <wutz@unterderbruecke.de>
Cc: linux-can@vger.kernel.org

> The guys from pengutronix (I am using ptxdist 2010.07.1) told me 
> that I have to know how the things in the repositories 
> have to be built.
> 
can-j1939-utils: (Similar to can-utils)
I think you need to do this:
$ ./autogen.sh
$ ./configure --host=powerpc-603e-linux-gnu --prefix=/usr
$ make
$ make install DESTDIR=...

iproute2-j1939: (Similar to iproute2, which is for sure present in your toolchain)
I think you need to do this:
$ make KERNEL_INCLUDE=<KERNEL_HEADER_PATH> CC=powerpc-603e-linux-gnu-gcc
$ make install DESTDIR=...

can-j1939-modules:
I'm not sure. Building this package with a cross-toolchain is something I never did.
I patched the kernel source itself in a 'cross' situation.
I only used can-j1939-modules for my own host.

anyone?

> > > But now I am facing the next problem, what type of packages do 
> I have to
> create for each particular repository?
Yes, I think so.

Kurt
