From: Wolfgang <wutz@unterderbruecke.de>
Subject: Re: Using can & can-j1939
Date: Thu, 15 Dec 2011 08:35:30 +0000 (UTC)
Message-ID: <loom.20111215T085023-710@post.gmane.org>
References: <20111212081217.GA351@e-circ.dyndns.org> <loom.20111212T121257-904@post.gmane.org> <20111212124031.GD351@e-circ.dyndns.org> <loom.20111212T160733-221@post.gmane.org> <20111213095312.GC430@e-circ.dyndns.org> <loom.20111213T155714-170@post.gmane.org> <20111213155110.GA314@e-circ.dyndns.org> <loom.20111214T140958-737@post.gmane.org> <20111214154351.GB6112@e-circ.dyndns.org> <loom.20111214T190347-790@post.gmane.org> <20111214204237.GC306@e-circ.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:46945 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757616Ab1LOIfq (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 15 Dec 2011 03:35:46 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1Rb6mz-0006t8-F8
	for linux-can@vger.kernel.org; Thu, 15 Dec 2011 09:35:41 +0100
Received: from fire.makon-engineering.de ([80.152.230.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Thu, 15 Dec 2011 09:35:41 +0100
Received: from wutz by fire.makon-engineering.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Thu, 15 Dec 2011 09:35:41 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

> I hope this demistifies a tiny bit

OK, I think things got a bit clearer for me.

1. You have to get the j1939 'into' the kernel space (check).
2. You have to cross compile the utils (check) and iproute2(remaining) and copy 
   it in the running target user space.

Hope I got that right!?


Now let's handle the problem with compilation of the iproute2, 
I did,
$make CC=powerpc-603e-linux-gnu-gcc error:

powerpc-603e-linux-gnu-gcc -D_GNU_SOURCE -O2 -Wstrict-prototypes -Wall 
-I../include -DRESOLVE_HOSTNAMES -DLIBDIR=\"/usr/lib/\" -I/usr//usr/include  -o 
arpd arpd.c ../lib/libnetlink.a ../lib/libutil.a -ldb -lpthread
/opt/OSELAS.Toolchain-1.99.3/powerpc-603e-linux-gnu/gcc-4.3.2-glibc-2.8-binutils-
2.18-kernel-2.6.27-sanitized/lib/gcc/powerpc-603e-linux-gnu/4.3.2/../../../..
/powerpc-603e-linux-gnu/bin/ld: cannot find -ldb
collect2: ld returned 1 exit status
make[1]: *** [arpd] Error 1
make[1]: Leaving directory `/home/wolfgang/iproute2-j1939/misc'
make: *** [all] Error 2

Could that be a problem, because of an previous error a copied the db_185 header 
from the host to the toolchain usr/include directory?

--Wolfgang


