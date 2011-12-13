From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: backporting can & can-j1939
Date: Tue, 13 Dec 2011 16:51:10 +0100
Message-ID: <20111213155110.GA314@e-circ.dyndns.org>
References: <20111209143224.GB309@e-circ.dyndns.org>
 <20111209144911.144460@gmx.net>
 <20111209150133.GA1470@e-circ.dyndns.org>
 <loom.20111209T175414-826@post.gmane.org>
 <20111212081217.GA351@e-circ.dyndns.org>
 <loom.20111212T121257-904@post.gmane.org>
 <20111212124031.GD351@e-circ.dyndns.org>
 <loom.20111212T160733-221@post.gmane.org>
 <20111213095312.GC430@e-circ.dyndns.org>
 <loom.20111213T155714-170@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gate.eia.be ([194.78.71.18]:53015 "EHLO mail.eia.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753886Ab1LMPvQ (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 13 Dec 2011 10:51:16 -0500
Content-Disposition: inline
In-Reply-To: <loom.20111213T155714-170@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang <wutz@unterderbruecke.de>
Cc: linux-can@vger.kernel.org

On Tue, Dec 13, 2011 at 03:20:24PM +0000, Wolfgang wrote:
> > It appears quite complex. It may be better to start over
> > with a fresh kernel, and copy those files from my
> > can-j1939-modules, since this repository contains
> > #if KERNEL_VERSION macros that will make it work on 2.6.31.
> 
> I am not really sure, so I ask, should I build a new kernel and after building
> replace the things from can-j1939-modules or should I place the things from
> can-j1939-modules before building the kernel?
> And what particular things should I copy?

Ok, Maybe I did explain it a bit fuzzy.

Like Oliver suggested earlier, you will ultimately build a new kernel.
1. You extract the kernel source (I believe $ptxdist prepare <kernel>).
2. You copy from can-j1939-modules into the extracted kernel sources:
   $ cp -r <can-j1939>/net/can/* <kernel>/net/can/
   $ cp <can-j1939>/include/socketcan/can.h <kernel>/include/linux/can.h
   $ cp <can-j1939>/include/socketcan/can/{bcm,core,error,gw,isotp,j1939,netlink,raw}.h \
	<kernel>/include/linux/can/
   and replace all "#include <socketcan/xxx.h>"
   with "#include <linux/xxx.h>".
   This "#include" thing will appear in files you just copies (net/can/* and include/linux/can*)
3. Continue the build process

Sorry for not making this clear the first time :-).
I hope it is clear now?

Kurt
