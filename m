From: Michael Pellegrini <mikep86@gmail.com>
Subject: Re: =?utf-8?b?cGNoX2Nhbjo=?= Data transmission stops after dropped packet
Date: Thu, 15 Nov 2012 16:23:23 +0000 (UTC)
Message-ID: <loom.20121115T171319-854@post.gmane.org>
References: <loom.20121114T160521-534@post.gmane.org> <50A4972A.9070707@hartkopp.net> <50A4EA87.9020206@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:34746 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992633Ab2KOQXj (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 15 Nov 2012 11:23:39 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1TZ2EG-0001fp-DX
	for linux-can@vger.kernel.org; Thu, 15 Nov 2012 17:23:48 +0100
Received: from 96.45.208.254 ([96.45.208.254])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Thu, 15 Nov 2012 17:23:48 +0100
Received: from mikep86 by 96.45.208.254 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Thu, 15 Nov 2012 17:23:48 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Wolfgang Grandegger <wg <at> grandegger.com> writes:

> > 
> > 3. It turned out that the pch_can controller is created upon the C_CAN
> > CAN controller IP-core. Therefore Wolfgang posted an idea to replace the
> > pch_can driver with a PCI-attached C_CAN driver:
> > 
> > http://thread.gmane.org/gmane.linux.can/815
> > 
> > I don't know the current state of the tests/replacement.
> 
> As you can see from this thread, the replacement patch did not yet
> succesfully run on such a platform. But I definitively would like to get
> rid of the obsolete pch_can driver. Testers are welcome! Michael, would
> you be able/willing to test a patch, even with a recent kernel version?

I would be willing to test a patch, however any fix would need to be back-ported
to the 3.2.0 kernel to be useful to me.  For the sake of testing though, I would
be willing to update to a newer kernel.

Also, I should warn you that I am not a Linux expert.  Thus, operations like
updating/recompiling the kernel are new to me and I'll need some help working
through the process.

> 
> > But a general C_CAN PCI driver has been contributed by Frederico Vaga which
> > became a mainline driver in June
> > 
> > http://git.kernel.org/?
p=linux/kernel/git/torvalds/linux.git;a=commitdiff;h=5b92da0443c2585e31b64e86c2e
1b8e22845d4bb
> > 
> > Don't know if this driver can be used out of the box, when the PCI IDs of 
the
> > PCH_CAN board are added ...
> > 
> > But maybe the guys in CC know 
> 
> You need a PCI driver first.
> 
> Wolfgang.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo <at> vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 




