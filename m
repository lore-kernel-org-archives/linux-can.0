From: Bhupesh SHARMA <bhupesh.sharma@st.com>
Subject: RE: [PATCH 1/2] pch_can: Stop netif queue if last message buffer is
 filled
Date: Wed, 22 Feb 2012 19:11:06 +0800
Message-ID: <D5ECB3C7A6F99444980976A8C6D896384ED2A2C1C6@EAPEX1MAIL1.st.com>
References: <1329840002-20746-1-git-send-email-alexander.stein@systec-electronic.com>
 <4F43C595.8080706@grandegger.com> <3473249.7elBHfZ9bN@ws-stein>
 <4F44CA61.8060200@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from eu1sys200aog117.obsmtp.com ([207.126.144.143]:48013 "EHLO
	eu1sys200aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752755Ab2BVLLs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 22 Feb 2012 06:11:48 -0500
In-Reply-To: <4F44CA61.8060200@grandegger.com>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

> -----Original Message-----
> From: linux-can-owner@vger.kernel.org [mailto:linux-can-
> owner@vger.kernel.org] On Behalf Of Wolfgang Grandegger
> Sent: Wednesday, February 22, 2012 4:29 PM
> To: Alexander Stein
> Cc: Marc Kleine-Budde; linux-can@vger.kernel.org
> Subject: Re: [PATCH 1/2] pch_can: Stop netif queue if last message
> buffer is filled
> 
> On 02/21/2012 05:30 PM, Alexander Stein wrote:
> > Hello Wolfgang,
> >
> > Am Dienstag, 21. Februar 2012, 17:25:57 schrieb Wolfgang Grandegger:
> >> Hi Alexander,
> >>
> >> On 02/21/2012 05:00 PM, Alexander Stein wrote:
> >>> If all Tx buffers are empty and we start queuing frames (more than
> Tx
> >>> buffer size) beginning at the last message buffer we will override
> the
> >>> first inserted entry if it doesn't get sent meanwhile, e.g. low
> priority
> >>> or ACK error. There is no stop condition when all buffers are used.
> >>> We will get get awoken by pch_can_tx_complete when the last entry
> is sent.
> >>>
> >>> Signed-off-by: Alexander Stein <alexander.stein@systec-
> electronic.com>
> >>> ---
> >>>  drivers/net/can/pch_can.c |    4 +---
> >>>  1 files changed, 1 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/drivers/net/can/pch_can.c b/drivers/net/can/pch_can.c
> >>> index 6edc25e..3af5341 100644
> >>> --- a/drivers/net/can/pch_can.c
> >>> +++ b/drivers/net/can/pch_can.c
> >>> @@ -903,9 +903,7 @@ static netdev_tx_t pch_xmit(struct sk_buff
> *skb, struct net_device *ndev)
> >>>
> >>>  	tx_obj_no = priv->tx_obj;
> >>>  	if (priv->tx_obj == PCH_TX_OBJ_END) {
> >>> -		if (ioread32(&priv->regs->treq2) & PCH_TREQ2_TX_MASK)
> >>> -			netif_stop_queue(ndev);
> >>> -
> >>> +		netif_stop_queue(ndev);
> >>>  		priv->tx_obj = PCH_TX_OBJ_START;
> >>>  	} else {
> >>>  		priv->tx_obj++;
> >>
> >> The pch_can uses a C_CAN core (and for maintenance reasons we would
> like
> >> to get ride of it sooner than later). In that driver the queue is
> >> stopped here:
> >>
> >> http://lxr.linux.no/#linux+v3.2.7/drivers/net/can/c_can/c_can.c#L508
> >
> > Does the C_CAN core have a real fifo? The message "fifo" in PCH CAN
> just uses the first message object. So you will reorder message under
> some conditions if used like a real fifo.
> 
> My understanding is that the CAN controller cores are identical. What
> the driver actually uses might be different. Out of order transmission
> of message are *not* allowed and the software must take care. With a
> real fifo that might be tricky, indeed.

The C_CAN core has no real FIFO. The same needs to be implemented via SW.
This is necessary because the message objects are filled/emptied as per the
message object priority. As soon as you mark the Message Object 0 as "free"
incoming messages will be stored here (if you are using Msg 0 for Rx purposes),
otherwise this message object will be Tx'ed first (if you are using Msg 0 for
Tx purposes).

Note: The C_CAN UM talks about a possibility of configuring a FIFO for Rx objects
but you need SW mechanisms to again maintain "in-order" reception.

> >> Therefore I'm not sure if your fix is enough (without looking into
> the
> >> manual). I could send you a "pch_pci" driver patch for C_CAN, which
> >> would allow you to use it. What kernel version are you using?
> >
> > We are currently using 2.6.39.
> 
> OK, I'm going to prepare a patch for that kernel version first.
> 
> More soon...
> 

I have made a series of changes in my C_CAN driver which I need to merge
and submit to mainline.

Will do that in coming days. It is on my TO-DO list for long now :(

Regards,
Bhupesh
