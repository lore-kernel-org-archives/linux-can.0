From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: using j1939
Date: Mon, 12 Dec 2011 09:12:17 +0100
Message-ID: <20111212081217.GA351@e-circ.dyndns.org>
References: <20111206104432.91170@gmx.net>
 <20111206121403.GB322@e-circ.dyndns.org>
 <loom.20111206T131950-88@post.gmane.org>
 <4EDE1785.9000306@volkswagen.de>
 <20111209134721.GA309@e-circ.dyndns.org>
 <loom.20111209T145701-227@post.gmane.org>
 <20111209143224.GB309@e-circ.dyndns.org>
 <20111209144911.144460@gmx.net>
 <20111209150133.GA1470@e-circ.dyndns.org>
 <loom.20111209T175414-826@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gate.eia.be ([194.78.71.18]:28839 "EHLO mail.eia.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751598Ab1LLIMW (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 12 Dec 2011 03:12:22 -0500
Content-Disposition: inline
In-Reply-To: <loom.20111209T175414-826@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Wagner <wutz@unterderbruecke.de>
Cc: linux-can@vger.kernel.org

On Fri, Dec 09, 2011 at 05:23:52PM +0000, Wolfgang Wagner wrote:
> > Ok, I suppose you do not compile your kernel yourself.
> 
> Yes, ptxdist compiles everything automatic, but as Oliver suggest
> for my system I can can drop the kernel and compile it again with 
> 
> $ ptxdist drop kernel compile
> $ ptxdist go
> 
> So is there a possibility to modify my kernel with files of your
> linux-can-j1939 repository and compile it again?
Yes, that must work. Take everything in net/can/*.
I'm not sure on the drivers. They may use other subsystems (like USB)
that have differences accross versions.
I'd first try to core CAN itself(net/can) and leave the drivers (drivers/net/can)
as is.
The header is a bit a mixture:
copy include/linux/can.h, all include/linux/can/*.h  but dev.h, and
_no_ include/linux/can/platform/*.h

> 
> 
> > Let's stick to the original plan then and get can-j1939-modules working
> (after getting iproute2-j1939 up).
> 
> So if I use the tarball iproute2-2.6.39.tar.gz, you can find everywhere,
> it should work? Or is there the possibility, that I possibly can faulty
> one?
I think a iproute2-2.6.39.tar.gz should compile.
Iproute2-j1939 did fail because of CAN definitions, that are in  a standard
iproute2 also.
If that one  compiles, my iproute2-j1939 should work as.
> 

Kurt
