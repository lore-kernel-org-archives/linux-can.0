From: Michael Pellegrini <mikep86@gmail.com>
Subject: Re: =?utf-8?b?cGNoX2Nhbjo=?= Data transmission stops after dropped packet
Date: Fri, 23 Nov 2012 17:52:00 +0000 (UTC)
Message-ID: <loom.20121123T184133-638@post.gmane.org>
References: <loom.20121114T160521-534@post.gmane.org> <50AA4FB3.7070009@grandegger.com> <loom.20121119T171647-35@post.gmane.org> <50AA5EE6.6060105@grandegger.com> <loom.20121119T183819-427@post.gmane.org> <50AA86DB.7000506@grandegger.com> <loom.20121119T211403-520@post.gmane.org> <50AAA8C8.2080504@grandegger.com> <loom.20121120T151831-134@post.gmane.org> <50ABABDE.8060503@grandegger.com> <loom.20121120T192159-770@post.gmane.org> <50ABF09C.8040303@grandegger.com> <50ACABE2.2020306@grandegger.com> <loom.20121121T160744-278@post.gmane.or  g> <loom.20121121T162041-774@p  ost.gmane.org> <50ACF9C0.8050206@grandegger.com> <loom.20121121T170446-911@post.gmane.org> <50AD042B.3020305 @grandegger.com> <loom.20121121T184014-391@post.gmane.org> <50AD319E.2000209@grandegger.com> <loom.20121121T215717-10
  6@post.gmane.org> <loom.20121123T150627-133@post.gmane.org> <50AF8C01.6060809@grandegger.com> <loom.20121123T155746-12@post.gmane.org> <50AFABB1.7080507@grandegger.com> <50AFAFF0.9030706@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:54213 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752813Ab2KWRwR (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 23 Nov 2012 12:52:17 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1TbxQP-0003gK-6N
	for linux-can@vger.kernel.org; Fri, 23 Nov 2012 18:52:25 +0100
Received: from 96.45.208.254 ([96.45.208.254])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Fri, 23 Nov 2012 18:52:25 +0100
Received: from mikep86 by 96.45.208.254 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Fri, 23 Nov 2012 18:52:25 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Wolfgang Grandegger <wg <at> grandegger.com> writes:

> > That's clear. Therefore please remove that printk for testing. For a
> > quick test could you please add spin_locks to c_can_do_rx_poll() similar
> > to c_can_do_tx(). My suspicion is that there is a race in accessing the
> > message ram. There is this infamous c_can_msg_obj_is_busy() in
> > c_can_object_get() and c_can_object_put().
> 
> And please use:
> 
> CONFIG_CAN_DEBUG_DEVICES=y CONFIG_CAN_C_CAN_PCI=m make -C
> /usr/src/linux-headers-`uname -r` SUBDIRS=`pwd` modules
> 
> otherwise we will not have debug messages.

Ok, I've applied the following patch:

*** ../c-can-pci-v5/c_can.c	2012-11-21 14:47:03.000000000 -0500
--- ./c_can.c	2012-11-23 12:27:05.946016919 -0500
*************** static int c_can_do_rx_poll(struct net_d
*** 795,800 ****
--- 795,803 ----
  	unsigned int msg_obj, msg_ctrl_save;
  	struct c_can_priv *priv = netdev_priv(dev);
  	u32 val = c_can_read_reg32(priv, C_CAN_INTPND1_REG);
+ 	unsigned long flags;
+ 
+ 	spin_lock_irqsave(&priv->lock, flags);
  
  	for (msg_obj = C_CAN_MSG_OBJ_RX_FIRST;
  			msg_obj <= C_CAN_MSG_OBJ_RX_LAST && quota > 0;
*************** static int c_can_do_rx_poll(struct net_d
*** 843,848 ****
--- 846,853 ----
  		}
  	}
  
+ 	spin_unlock_irqrestore(&priv->lock, flags);
+ 
  	return num_rx_pkts;
  }
  
*************** static irqreturn_t c_can_isr(int irq, vo
*** 1084,1090 ****
  	struct c_can_priv *priv = netdev_priv(dev);
  
  	priv->irqstatus = priv->read_reg(priv, C_CAN_INT_REG);
! 	printk("%s: irqstatus=%#x\n", __func__, priv->irqstatus);
  	if (!priv->irqstatus)
  		return IRQ_NONE;
  
--- 1089,1095 ----
  	struct c_can_priv *priv = netdev_priv(dev);
  
  	priv->irqstatus = priv->read_reg(priv, C_CAN_INT_REG);
! 	//printk("%s: irqstatus=%#x\n", __func__, priv->irqstatus);
  	if (!priv->irqstatus)
  		return IRQ_NONE;

I also built the modules with debug messages enabled, per your instructions.
I'm seeing more output in dmesg now, so I think I was building with debug
messages disabled previously.  I apologize for that.

I will run a long-term test with this driver over the weekend and see how it
holds up.

Thanks,
Mike


