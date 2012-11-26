From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: pch_can: Data transmission stops after dropped packet
Date: Mon, 26 Nov 2012 19:13:54 +0100
Message-ID: <50B3B162.9020905@grandegger.com>
References: <loom.20121114T160521-534@post.gmane.org> <50AAA8C8.2080504@grandegger.com> <loom.20121120T151831-134@post.gmane.org> <50ABABDE.8060503@grandegger.com> <loom.20121120T192159-770@post.gmane.org> <50ABF09C.8040303@grandegger.com> <50ACABE2.2020306@grandegger.com> <loom.20121121T160744-278@post.gmane.or  g> <loom.20121121T162041-774@p  ost.gmane.org> <50ACF9C0.8050206@grandegger.com> <loom.20121121T170446-911@post.gmane.org> <50AD042B.3020305 @grandegger.com> <loom.20121121T184014-391@post.gmane.org> <50AD319E.2000209@grandegger.com> <loom.20121121T215717-10 6@post.gmane.org> <loom.20121123T150627-133@post.gmane.org> <50AF8C01.6060 809@grandegger.com> <loom.20121123T155746-12@post.gmane.org> <50AFABB1.7080 507@grandegger.com> <50AFAFF0.9030706@grandegger.com> <loom.20121123T184133
 -638@post.gmane.org> <50B2449B.8060708@grandegger.com> <loom.20121126T154645-335@post.gmane.org> <50B38AFB.70209@grandegger.com> <loom.20121126T181452-657@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:51540 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756577Ab2KZSN5 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 26 Nov 2012 13:13:57 -0500
In-Reply-To: <loom.20121126T181452-657@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Michael Pellegrini <mikep86@gmail.com>
Cc: linux-can@vger.kernel.org

On 11/26/2012 06:30 PM, Michael Pellegrini wrote:
> Wolfgang Grandegger <wg <at> grandegger.com> writes:
> 
>> Not too bad! The return does only happen at high load. When you
>> "ifconfig up" the device some kernel messages are printed. Could you
>> please show them. I want to understand if the reset really occurs by
>> checking some register values.
> 
> "ifconfig can0 down" followed by "ifconfig can0 up" produces the following dmesg
> output:
> 
> [10113.228189] CTRL_REG=0x1
> [10113.228213] BTR_REG =0x2301
> [10113.228230] TEST_REG =0x80

These are the correct reset values. Therefore, a reset did occur.

> Note that I used v7 of the driver to get this data.
> 
>>> I tried the PCH driver and hit the transmission failure within a minute.
>>
>> Ah. In the function pch_xmit(), could you please move
>>
>> 	spin_unlock_irqrestore(&priv->lock, flags);
>>
>> to the end of the function just before
>>
>>  	return NETDEV_TX_OK;
>>
>> and then retry. This would fix races with accessing the message ram as
>> well (via pch_can_rw_msg_obj). I missed that.
> 
> Alright, I applied the following patch:
> 
> *** ../c-can-pci-v7/pch_can.c	2012-11-25 05:09:13.000000000 -0500
> --- ./pch_can.c	2012-11-26 11:29:11.350012074 -0500
> *************** static netdev_tx_t pch_xmit(struct sk_bu
> *** 921,928 ****
>   		priv->tx_obj++;
>   	}
>   
> - 	spin_unlock_irqrestore(&priv->lock, flags);
> - 
>   	/* Setting the CMASK register. */
>   	pch_can_bit_set(&priv->regs->ifregs[1].cmask, PCH_CMASK_ALL);
>   
> --- 921,926 ----
> *************** static netdev_tx_t pch_xmit(struct sk_bu
> *** 957,962 ****
> --- 955,962 ----
>   
>   	pch_can_rw_msg_obj(&priv->regs->ifregs[1].creq, tx_obj_no);
>   
> + 	spin_unlock_irqrestore(&priv->lock, flags);
> + 
>   	return NETDEV_TX_OK;
>   }
> 
> The patched driver did not fail in the first few minutes, so that's a good sign.
> I will run this driver overnight.

OK, thank. I think the problem is fixed.

>>> I'm happy to test out more changes to this driver if you think it is worth
>>> pursuing.
>>
>> Remote debugging is slow, unfortunately. Thanks for your patience.
> 
> No problem.  I'm just thankful that the problem is getting addressed.
> 
>>> I started a test with the new c_can driver.  I'll check on it throughout
>>> the day and let it run overnight as well.
>>
>> OK, apart from the return issue above the driver has not changed from
>> the functional point of view.
> 
> Alright, I will wait until more substantial changes are implemented before
> re-running the long-term test on this driver.

Yes, maybe we can come up with an even better solution.

Wolfgang.

