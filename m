From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Cross-compiling iproute2-j1939
Date: Thu, 15 Dec 2011 10:20:18 +0100
Message-ID: <20111215092018.GB321@e-circ.dyndns.org>
References: <20111212124031.GD351@e-circ.dyndns.org>
 <loom.20111212T160733-221@post.gmane.org>
 <20111213095312.GC430@e-circ.dyndns.org>
 <loom.20111213T155714-170@post.gmane.org>
 <20111213155110.GA314@e-circ.dyndns.org>
 <loom.20111214T140958-737@post.gmane.org>
 <20111214154351.GB6112@e-circ.dyndns.org>
 <loom.20111214T190347-790@post.gmane.org>
 <20111214204237.GC306@e-circ.dyndns.org>
 <loom.20111215T085023-710@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gate.eia.be ([194.78.71.18]:24780 "EHLO mail.eia.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755868Ab1LOJUY (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 15 Dec 2011 04:20:24 -0500
Content-Disposition: inline
In-Reply-To: <loom.20111215T085023-710@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang <wutz@unterderbruecke.de>
Cc: linux-can@vger.kernel.org

On Thu, Dec 15, 2011 at 08:35:30AM +0000, Wolfgang wrote:
> > I hope this demistifies a tiny bit
> 
> OK, I think things got a bit clearer for me.
> 
> 1. You have to get the j1939 'into' the kernel space (check).
> 2. You have to cross compile the utils (check) and iproute2(remaining) and copy 
>    it in the running target user space.
> 
> Hope I got that right!?
Yes, that's it.
You summarized it well, I'll reuse this for documentation eventually.
> 
> 
> Now let's handle the problem with compilation of the iproute2, 
> I did,
> $make CC=powerpc-603e-linux-gnu-gcc error:
> 
> powerpc-603e-linux-gnu-gcc -D_GNU_SOURCE -O2 -Wstrict-prototypes -Wall 
> -I../include -DRESOLVE_HOSTNAMES -DLIBDIR=\"/usr/lib/\" -I/usr//usr/include  -o 
> arpd arpd.c ../lib/libnetlink.a ../lib/libutil.a -ldb -lpthread
> /opt/OSELAS.Toolchain-1.99.3/powerpc-603e-linux-gnu/gcc-4.3.2-glibc-2.8-binutils-
> 2.18-kernel-2.6.27-sanitized/lib/gcc/powerpc-603e-linux-gnu/4.3.2/../../../..
> /powerpc-603e-linux-gnu/bin/ld: cannot find -ldb
> collect2: ld returned 1 exit status
> make[1]: *** [arpd] Error 1
> make[1]: Leaving directory `/home/wolfgang/iproute2-j1939/misc'
> make: *** [all] Error 2
> 
> Could that be a problem, because of an previous error a copied the db_185 header 
> from the host to the toolchain usr/include directory?
I think you got really far now, and reached 'arpd' (on my system, 'ip' is compiled then).
'arpd' needs 'libdb'. I don't think copying the db_185 header is a problem, but the
libdb.so or libdb.a remains absent.

I think Pengutronix supports compiling iproute2 _with_ some patches. I think you
better apply those too.
As an alternative, you could get rid of arpd (I'm not using it on our target) with following
patch or similar:

Kurt

Index: iproute2-2.6.35/misc/Makefile
===================================================================
--- iproute2-2.6.35.orig/misc/Makefile	2010-08-25 16:27:27.000000000 +0200
+++ iproute2-2.6.35/misc/Makefile	2010-08-25 16:29:58.000000000 +0200
@@ -1,10 +1,10 @@
 SSOBJ=ss.o ssfilter.o
 LNSTATOBJ=lnstat.o lnstat_util.o
 
-TARGETS=ss nstat ifstat rtacct arpd lnstat
-
 include ../Config
 
+TARGETS=ss nstat ifstat rtacct lnstat $(MISC_EXTRA)
+
 all: $(TARGETS)
 
 ss: $(SSOBJ) $(LIBUTIL)
