From: Michael Pellegrini <mikep86@gmail.com>
Subject: Re: =?utf-8?b?cGNoX2Nhbjo=?= Data transmission stops after dropped packet
Date: Mon, 26 Nov 2012 17:30:12 +0000 (UTC)
Message-ID: <loom.20121126T181452-657@post.gmane.org>
References: <loom.20121114T160521-534@post.gmane.org> <50AA86DB.7000506@grandegger.com> <loom.20121119T211403-520@post.gmane.org> <50AAA8C8.2080504@grandegger.com> <loom.20121120T151831-134@post.gmane.org> <50ABABDE.8060503@grandegger.com> <loom.20121120T192159-770@post.gmane.org> <50ABF09C.8040303@grandegger.com> <50ACABE2.2020306@grandegger.com> <loom.20121121T160744-278@post.gmane.or  g> <loom.20121121T162041-774@p  ost.gmane.org> <50ACF9C0.8050206@grandegger.com> <loom.20121121T170446-911@post.gmane.org> <50AD042B.3020305 @grandegger.com> <loom.20121121T184014-391@post.gmane.org> <50AD319E.2000209@grandegger.com> <loom.20121121T215717-10 6@post.gmane.org> <loom.20121123T150627-133@post.gmane.org> <50AF8C01.6060 809@grandegger.com> <loom.20121123T155746-12@post.gmane.org> <50AFABB1.7080
  507@grandegger.com> <50AFAFF0.9030706@grandegger.com> <loom.20121123T184133-638@post.gmane.org> <50B2449B.8060708@grandegger.com> <loom.20121126T154645-335@post.gmane.org> <50B38AFB.70209@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:45903 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933861Ab2KZRaZ (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 26 Nov 2012 12:30:25 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1Td2Vv-00043M-5G
	for linux-can@vger.kernel.org; Mon, 26 Nov 2012 18:30:35 +0100
Received: from 96.45.208.254 ([96.45.208.254])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Mon, 26 Nov 2012 18:30:35 +0100
Received: from mikep86 by 96.45.208.254 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Mon, 26 Nov 2012 18:30:35 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Wolfgang Grandegger <wg <at> grandegger.com> writes:

> Not too bad! The return does only happen at high load. When you
> "ifconfig up" the device some kernel messages are printed. Could you
> please show them. I want to understand if the reset really occurs by
> checking some register values.

"ifconfig can0 down" followed by "ifconfig can0 up" produces the following dmesg
output:

[10113.228189] CTRL_REG=0x1
[10113.228213] BTR_REG =0x2301
[10113.228230] TEST_REG =0x80
[10113.228267] c_can_pci 0000:02:0c.3: can0: obj no:1, msgval:0x00000000
[10113.228303] c_can_pci 0000:02:0c.3: can0: obj no:2, msgval:0x00000000
[10113.228330] c_can_pci 0000:02:0c.3: can0: obj no:3, msgval:0x00000000
[10113.228356] c_can_pci 0000:02:0c.3: can0: obj no:4, msgval:0x00000000
[10113.228381] c_can_pci 0000:02:0c.3: can0: obj no:5, msgval:0x00000000
[10113.228407] c_can_pci 0000:02:0c.3: can0: obj no:6, msgval:0x00000000
[10113.228433] c_can_pci 0000:02:0c.3: can0: obj no:7, msgval:0x00000000
[10113.228458] c_can_pci 0000:02:0c.3: can0: obj no:8, msgval:0x00000000
[10113.228484] c_can_pci 0000:02:0c.3: can0: obj no:9, msgval:0x00000000
[10113.228510] c_can_pci 0000:02:0c.3: can0: obj no:10, msgval:0x00000000
[10113.228536] c_can_pci 0000:02:0c.3: can0: obj no:11, msgval:0x00000000
[10113.228562] c_can_pci 0000:02:0c.3: can0: obj no:12, msgval:0x00000000
[10113.228587] c_can_pci 0000:02:0c.3: can0: obj no:13, msgval:0x00000000
[10113.228613] c_can_pci 0000:02:0c.3: can0: obj no:14, msgval:0x00000000
[10113.228639] c_can_pci 0000:02:0c.3: can0: obj no:15, msgval:0x00000000
[10113.228665] c_can_pci 0000:02:0c.3: can0: obj no:16, msgval:0x00000000
[10113.228691] c_can_pci 0000:02:0c.3: can0: obj no:17, msgval:0x00000000
[10113.228716] c_can_pci 0000:02:0c.3: can0: obj no:18, msgval:0x00000000
[10113.228742] c_can_pci 0000:02:0c.3: can0: obj no:19, msgval:0x00000000
[10113.228768] c_can_pci 0000:02:0c.3: can0: obj no:20, msgval:0x00000000
[10113.228794] c_can_pci 0000:02:0c.3: can0: obj no:21, msgval:0x00000000
[10113.228820] c_can_pci 0000:02:0c.3: can0: obj no:22, msgval:0x00000000
[10113.228845] c_can_pci 0000:02:0c.3: can0: obj no:23, msgval:0x00000000
[10113.228871] c_can_pci 0000:02:0c.3: can0: obj no:24, msgval:0x00000000
[10113.228897] c_can_pci 0000:02:0c.3: can0: obj no:25, msgval:0x00000000
[10113.228923] c_can_pci 0000:02:0c.3: can0: obj no:26, msgval:0x00000000
[10113.228949] c_can_pci 0000:02:0c.3: can0: obj no:27, msgval:0x00000000
[10113.228974] c_can_pci 0000:02:0c.3: can0: obj no:28, msgval:0x00000000
[10113.229000] c_can_pci 0000:02:0c.3: can0: obj no:29, msgval:0x00000000
[10113.229026] c_can_pci 0000:02:0c.3: can0: obj no:30, msgval:0x00000000
[10113.229052] c_can_pci 0000:02:0c.3: can0: obj no:31, msgval:0x00000000
[10113.229078] c_can_pci 0000:02:0c.3: can0: obj no:32, msgval:0x00000000
[10113.229105] c_can_pci 0000:02:0c.3: can0: obj no:1, msgval:0x00000001
[10113.229132] c_can_pci 0000:02:0c.3: can0: obj no:2, msgval:0x00000003
[10113.229159] c_can_pci 0000:02:0c.3: can0: obj no:3, msgval:0x00000007
[10113.229185] c_can_pci 0000:02:0c.3: can0: obj no:4, msgval:0x0000000f
[10113.229212] c_can_pci 0000:02:0c.3: can0: obj no:5, msgval:0x0000001f
[10113.229239] c_can_pci 0000:02:0c.3: can0: obj no:6, msgval:0x0000003f
[10113.229266] c_can_pci 0000:02:0c.3: can0: obj no:7, msgval:0x0000007f
[10113.229293] c_can_pci 0000:02:0c.3: can0: obj no:8, msgval:0x000000ff
[10113.229320] c_can_pci 0000:02:0c.3: can0: obj no:9, msgval:0x000001ff
[10113.229347] c_can_pci 0000:02:0c.3: can0: obj no:10, msgval:0x000003ff
[10113.229373] c_can_pci 0000:02:0c.3: can0: obj no:11, msgval:0x000007ff
[10113.229400] c_can_pci 0000:02:0c.3: can0: obj no:12, msgval:0x00000fff
[10113.229427] c_can_pci 0000:02:0c.3: can0: obj no:13, msgval:0x00001fff
[10113.229455] c_can_pci 0000:02:0c.3: can0: obj no:14, msgval:0x00003fff
[10113.229481] c_can_pci 0000:02:0c.3: can0: obj no:15, msgval:0x00007fff
[10113.229508] c_can_pci 0000:02:0c.3: can0: obj no:16, msgval:0x0000ffff
[10113.229527] c_can_pci 0000:02:0c.3: can0: setting BTR=0518 BRPE=0000

Note that I used v7 of the driver to get this data.

> > I tried the PCH driver and hit the transmission failure within a minute.
> 
> Ah. In the function pch_xmit(), could you please move
> 
> 	spin_unlock_irqrestore(&priv->lock, flags);
> 
> to the end of the function just before
> 
>  	return NETDEV_TX_OK;
> 
> and then retry. This would fix races with accessing the message ram as
> well (via pch_can_rw_msg_obj). I missed that.

Alright, I applied the following patch:

*** ../c-can-pci-v7/pch_can.c	2012-11-25 05:09:13.000000000 -0500
--- ./pch_can.c	2012-11-26 11:29:11.350012074 -0500
*************** static netdev_tx_t pch_xmit(struct sk_bu
*** 921,928 ****
  		priv->tx_obj++;
  	}
  
- 	spin_unlock_irqrestore(&priv->lock, flags);
- 
  	/* Setting the CMASK register. */
  	pch_can_bit_set(&priv->regs->ifregs[1].cmask, PCH_CMASK_ALL);
  
--- 921,926 ----
*************** static netdev_tx_t pch_xmit(struct sk_bu
*** 957,962 ****
--- 955,962 ----
  
  	pch_can_rw_msg_obj(&priv->regs->ifregs[1].creq, tx_obj_no);
  
+ 	spin_unlock_irqrestore(&priv->lock, flags);
+ 
  	return NETDEV_TX_OK;
  }

The patched driver did not fail in the first few minutes, so that's a good sign.
I will run this driver overnight.

> > I'm happy to test out more changes to this driver if you think it is worth
> > pursuing.
> 
> Remote debugging is slow, unfortunately. Thanks for your patience.

No problem.  I'm just thankful that the problem is getting addressed.

> > I started a test with the new c_can driver.  I'll check on it throughout
> > the day and let it run overnight as well.
> 
> OK, apart from the return issue above the driver has not changed from
> the functional point of view.

Alright, I will wait until more substantial changes are implemented before
re-running the long-term test on this driver.

Thanks,
Mike



