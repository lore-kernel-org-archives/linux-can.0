From: Jan Sondhauss <jan.sondhauss@wago.com>
Subject: Re: [PATCH] can: =?utf-8?b?dGlfaGVjYzo=?= fix rx wrong sequence issue
Date: Mon, 8 Sep 2014 10:15:08 +0000 (UTC)
Message-ID: <loom.20140908T110614-355@post.gmane.org>
References: <1349678436-747-1-git-send-email-anilkumar@ti.com> <5097A45F.3000606@pengutronix.de> <5098023F.5040001@pengutronix.de> <50980825.6030805@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:44827 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752879AbaIHKZF (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 8 Sep 2014 06:25:05 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1XQw87-0003dI-EG
	for linux-can@vger.kernel.org; Mon, 08 Sep 2014 12:25:03 +0200
Received: from 217.237.185.168 ([217.237.185.168])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Mon, 08 Sep 2014 12:25:03 +0200
Received: from jan.sondhauss by 217.237.185.168 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Mon, 08 Sep 2014 12:25:03 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Marc Kleine-Budde <mkl <at> pengutronix.de> writes:

> 
> > [..]
> > 
> >> Then I had a closer look at AnilKumar Ch's patch, the canme register is
> >> not changed if a the CAN core currently receives a CAN frame. I added
> >> AnilKumar Ch's busy loop before modifying the canme register, and it
> >> works now. So I conclude that the "pick next free mailbox" algorithm in
> >> the CAN core is racy. You are not allowed to do something that changes a
> >> mailbox's status from disabled/full to enabled/free when a CAN frame is
> >> received. As you cannot control CAN frame reception, this is a nice
> >> hardware race condition. Please add this to the manual and errata sheets.
> > 
> > I really want to know where the race window starts and ends, in order to
> > specify proper timeouts.
> > [..]
> > 
> > We have to use the spin_lock because the CANME register is shared
> > between the rx and tx path. I think it's better to make use of
> > CANRPM+CANMIM, because I think the critical path is the modification of
> > the CANRPM register, which is not shared, so it can be written without
> > the need for the spin_lock.
> 
> I've implemented both solutions and both are working. I've instrumented
> how long the CAN driver does stay in the while loop. I've loaded the CAN
> bus with:
> [..]
> 
> AnilKumar, can you get in contact with the hardware people to figure out
> a better solution than to cycle 4k times in a loop?
> 
> Marc

Hello Marc, hello AnilKumar,

is there a proper solution to this problem available yet? I haven't found one
on linux-can repository, but maybe I've been looking at the wrong place.
We are running a "custom" 3.6.11 kernel with PREEMPT_RT_FULL on a Ti AM3517.
Also we applied AnilKumars busy-wait-for-rx-idle-loop.

We have a problem in one test-case with two can-devices (including our device
under test) where we are exchanging messages in a request-response matter:
The am3517 sends 16 requests in a row and then expects 16 response messages.

Under some circumstances the driver stays in the napi's-poll list forever, 
because there is a message available in a lower "main"-mailbox but 
rx_next points to the first mailbox: 

[24817.008123] ti_hecc: priv->rx_next 0000001f
[24817.012769] ti_hecc: HECC_CANME fffffff0
[24817.017015] ti_hecc: HECC_CANMD fffffff0
[24817.021261] ti_hecc: HECC_CANRMP 40000000

It looks to me that the access to the CANME register in the ti_hecc_rx_pkt()
function is also racy:

	spin_lock_irqsave(&priv->mbx_lock, flags);
	hecc_clear_bit(priv, HECC_CANME, mbx_mask);
	hecc_write(priv, HECC_CANRMP, mbx_mask);
	/* enable mailbox only if it is part of rx buffer mailboxes */
	if (mbxno < HECC_RX_BUFFER_MBOX)
		hecc_set_bit(priv, HECC_CANME, mbx_mask);
	spin_unlock_irqrestore(&priv->mbx_lock, flags);

That makes me wonder what was the purpose of the else-branch in the 
ti_hecc_rx_poll() function (as it prevents us from receiving messages)?:

		} else if (priv->rx_next >= HECC_RX_BUFFER_MBOX) {            
			break; /* pkt not received yet */
		}

Our problem is somewhat off-topic, but relates to the racy CANME access so I
hope I posted at the right place. :)

Thanks and best regards,
Jan

 











