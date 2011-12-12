From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: using j1939
Date: Mon, 12 Dec 2011 13:40:31 +0100
Message-ID: <20111212124031.GD351@e-circ.dyndns.org>
References: <loom.20111206T131950-88@post.gmane.org>
 <4EDE1785.9000306@volkswagen.de>
 <20111209134721.GA309@e-circ.dyndns.org>
 <loom.20111209T145701-227@post.gmane.org>
 <20111209143224.GB309@e-circ.dyndns.org>
 <20111209144911.144460@gmx.net>
 <20111209150133.GA1470@e-circ.dyndns.org>
 <loom.20111209T175414-826@post.gmane.org>
 <20111212081217.GA351@e-circ.dyndns.org>
 <loom.20111212T121257-904@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gate.eia.be ([194.78.71.18]:32474 "EHLO mail.eia.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752606Ab1LLMkh (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 12 Dec 2011 07:40:37 -0500
Content-Disposition: inline
In-Reply-To: <loom.20111212T121257-904@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang <wutz@unterderbruecke.de>
Cc: linux-can@vger.kernel.org

On Mon, Dec 12, 2011 at 11:27:33AM +0000, Wolfgang wrote:
> > Yes, that must work. Take everything in net/can/*.
> > I'm not sure on the drivers. They may use other subsystems (like USB)
> > that have differences accross versions.
> > I'd first try to core CAN itself(net/can) and leave the drivers
> (drivers/net/can)
> > as is.
> > The header is a bit a mixture:
> > copy include/linux/can.h, all include/linux/can/*.h  but dev.h, and
> > _no_ include/linux/can/platform/*.h
> 
> Ok I replaced everything as you told me, but while compiling
> 
> make[1]: Entering directory
> `/home/wolfgang/phytec/kernel/OSELAS.BSP-Phytec-phyCORE-MPC512x-tiny-\
> PD09.1.0/platform-phyCORE-MPC5121e/build-target/linux-2.6.31'
>   CHK     include/linux/version.h
>   CHK     include/linux/utsrelease.h
>   SYMLINK include/asm -> include/asm-powerpc
>   CALL    scripts/checksyscalls.sh
>   CHK     include/linux/compile.h
>   CALL    arch/powerpc/kernel/systbl_chk.sh
>   CC      net/can/bcm.o
> In file included from net/can/bcm.c:55:
> include/linux/can.h:80: error: expected specifier-qualifier-list \
> before'__kernel_sa_family_t'

I've noticed in recent kernels that 'sa_family_t' got replaced
by '__kernel_sa_family_t'.
I see no harm in undoing this, thus modifying the new include/linux/can.h,
making sockaddr_can.can_family of type sa_family_t again.

Kurt
