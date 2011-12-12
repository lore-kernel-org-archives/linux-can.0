From: Wolfgang <wutz@unterderbruecke.de>
Subject: Re: using j1939
Date: Mon, 12 Dec 2011 11:27:33 +0000 (UTC)
Message-ID: <loom.20111212T121257-904@post.gmane.org>
References: <20111206104432.91170@gmx.net> <20111206121403.GB322@e-circ.dyndns.org> <loom.20111206T131950-88@post.gmane.org> <4EDE1785.9000306@volkswagen.de> <20111209134721.GA309@e-circ.dyndns.org> <loom.20111209T145701-227@post.gmane.org> <20111209143224.GB309@e-circ.dyndns.org> <20111209144911.144460@gmx.net> <20111209150133.GA1470@e-circ.dyndns.org> <loom.20111209T175414-826@post.gmane.org> <20111212081217.GA351@e-circ.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:47658 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752085Ab1LLL1r (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 12 Dec 2011 06:27:47 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1Ra42s-0002ed-4J
	for linux-can@vger.kernel.org; Mon, 12 Dec 2011 12:27:46 +0100
Received: from fire.d-i-f.com ([80.152.230.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Mon, 12 Dec 2011 12:27:46 +0100
Received: from wutz by fire.d-i-f.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Mon, 12 Dec 2011 12:27:46 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

> Yes, that must work. Take everything in net/can/*.
> I'm not sure on the drivers. They may use other subsystems (like USB)
> that have differences accross versions.
> I'd first try to core CAN itself(net/can) and leave the drivers
(drivers/net/can)
> as is.
> The header is a bit a mixture:
> copy include/linux/can.h, all include/linux/can/*.h  but dev.h, and
> _no_ include/linux/can/platform/*.h

Ok I replaced everything as you told me, but while compiling

make[1]: Entering directory
`/home/wolfgang/phytec/kernel/OSELAS.BSP-Phytec-phyCORE-MPC512x-tiny-\
PD09.1.0/platform-phyCORE-MPC5121e/build-target/linux-2.6.31'
  CHK     include/linux/version.h
  CHK     include/linux/utsrelease.h
  SYMLINK include/asm -> include/asm-powerpc
  CALL    scripts/checksyscalls.sh
  CHK     include/linux/compile.h
  CALL    arch/powerpc/kernel/systbl_chk.sh
  CC      net/can/bcm.o
In file included from net/can/bcm.c:55:
include/linux/can.h:80: error: expected specifier-qualifier-list \
before'__kernel_sa_family_t'
net/can/bcm.c: In function 'bcm_proc_getifname':
net/can/bcm.c:150: error: implicit declaration of function
'dev_get_by_index_rcu'
net/can/bcm.c:150: warning: assignment makes pointer from integer \
without a cast
net/can/bcm.c: In function 'bcm_send_to_user':
net/can/bcm.c:332: error: 'struct sockaddr_can' has no member named\ 
can_family'
net/can/bcm.c:333: error: 'struct sockaddr_can' has no member named 
can_ifindex'
net/can/bcm.c: In function 'bcm_sendmsg':
net/can/bcm.c:1253: error: 'struct sockaddr_can' has no member named 
'can_ifindex'
net/can/bcm.c:1253: error: 'struct sockaddr_can' has no member named 
'can_ifindex'
net/can/bcm.c:1256: error: 'struct sockaddr_can' has no member named 
'can_family'
net/can/bcm.c:1260: error: 'struct sockaddr_can' has no member named 
'can_ifindex'
net/can/bcm.c: In function 'bcm_connect':
net/can/bcm.c:1495: error: 'struct sockaddr_can' has no member named 
'can_ifindex'
net/can/bcm.c:1495: error: 'struct sockaddr_can' has no member named 
'can_ifindex'
net/can/bcm.c:1502: error: 'struct sockaddr_can' has no member named 
'can_ifindex'
net/can/bcm.c:1505: error: 'struct sockaddr_can' has no member named 
'can_ifindex'
net/can/bcm.c: In function 'bcm_recvmsg':
net/can/bcm.c:1559: error: implicit declaration of function 
'sock_recv_ts_and_drops'
make[3]: *** [net/can/bcm.o] Error 1
make[2]: *** [net/can] Error 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [net] Error 2
make[1]: *** Waiting for unfinished jobs....


