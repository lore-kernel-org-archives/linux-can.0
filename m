From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: pch_can: Data transmission stops after dropped packet
Date: Mon, 26 Nov 2012 16:30:03 +0100
Message-ID: <50B38AFB.70209@grandegger.com>
References: <loom.20121114T160521-534@post.gmane.org> <50AA86DB.7000506@grandegger.com> <loom.20121119T211403-520@post.gmane.org> <50AAA8C8.2080504@grandegger.com> <loom.20121120T151831-134@post.gmane.org> <50ABABDE.8060503@grandegger.com> <loom.20121120T192159-770@post.gmane.org> <50ABF09C.8040303@grandegger.com> <50ACABE2.2020306@grandegger.com> <loom.20121121T160744-278@post.gmane.or  g> <loom.20121121T162041-774@p  ost.gmane.org> <50ACF9C0.8050206@grandegger.com> <loom.20121121T170446-911@post.gmane.org> <50AD042B.3020305 @grandegger.com> <loom.20121121T184014-391@post.gmane.org> <50AD319E.2000209@grandegger.com> <loom.20121121T215717-10 6@post.gmane.org> <loom.20121123T150627-133@post.gmane.org> <50AF8C01.6060 809@grandegger.com> <loom.20121123T155746-12@post.gmane.org> <50AFABB1.7080
 507@grandegger.com> <50AFAFF0.9030706@grandegger.com> <loom.20121123T184133-638@post.gmane.org> <50B2449B.8060708@grandegger.com> <loom.20121126T154645-335@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:33646 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755126Ab2KZPaH (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 26 Nov 2012 10:30:07 -0500
In-Reply-To: <loom.20121126T154645-335@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Michael Pellegrini <mikep86@gmail.com>
Cc: linux-can@vger.kernel.org

On 11/26/2012 03:54 PM, Michael Pellegrini wrote:
> Wolfgang Grandegger <wg <at> grandegger.com> writes:
> 
>> There is a return in the critical section which must also be handled.
>> Hope you didn't hit it...
>>
>> I have attached v7 fixing this issue. Furthermore I have added spinlock
>> protection to the PCH driver. It needs fixing, even if I want to get
>> ride of it as soon as possible. Could you please give this driver a try
>> as well? The README tells how to build the modules. I will also send my
>> current patch stack for the record (and feedback).
> 
> Oops, I missed that return.  Looks like the system didn't hit it though,
> the CAN interface was still functional after running continuously over the 
> weekend.

Not too bad! The return does only happen at high load. When you
"ifconfig up" the device some kernel messages are printed. Could you
please show them. I want to understand if the reset really occurs by
checking some register values.

> I tried the PCH driver and hit the transmission failure within a minute.

Ah. In the function pch_xmit(), could you please move

	spin_unlock_irqrestore(&priv->lock, flags);

to the end of the function just before

 	return NETDEV_TX_OK;

and then retry. This would fix races with accessing the message ram as
well (via pch_can_rw_msg_obj). I missed that.

> I'm happy to test out more changes to this driver if you think it is worth
> pursuing.

Remote debugging is slow, unfortunately. Thanks for your patience.

> I started a test with the new c_can driver.  I'll check on it throughout
> the day and let it run overnight as well.

OK, apart from the return issue above the driver has not changed from
the functional point of view.

Wolfgang.

