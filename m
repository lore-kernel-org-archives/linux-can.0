From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH 1/2] pch_can: Stop netif queue if last message buffer
 is filled
Date: Wed, 22 Feb 2012 11:58:41 +0100
Message-ID: <4F44CA61.8060200@grandegger.com>
References: <1329840002-20746-1-git-send-email-alexander.stein@systec-electronic.com> <4F43C595.8080706@grandegger.com> <3473249.7elBHfZ9bN@ws-stein>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:49800 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754608Ab2BVK6v (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 22 Feb 2012 05:58:51 -0500
In-Reply-To: <3473249.7elBHfZ9bN@ws-stein>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

On 02/21/2012 05:30 PM, Alexander Stein wrote:
> Hello Wolfgang,
> 
> Am Dienstag, 21. Februar 2012, 17:25:57 schrieb Wolfgang Grandegger:
>> Hi Alexander,
>>
>> On 02/21/2012 05:00 PM, Alexander Stein wrote:
>>> If all Tx buffers are empty and we start queuing frames (more than Tx
>>> buffer size) beginning at the last message buffer we will override the
>>> first inserted entry if it doesn't get sent meanwhile, e.g. low priority
>>> or ACK error. There is no stop condition when all buffers are used.
>>> We will get get awoken by pch_can_tx_complete when the last entry is sent.
>>>
>>> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
>>> ---
>>>  drivers/net/can/pch_can.c |    4 +---
>>>  1 files changed, 1 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/net/can/pch_can.c b/drivers/net/can/pch_can.c
>>> index 6edc25e..3af5341 100644
>>> --- a/drivers/net/can/pch_can.c
>>> +++ b/drivers/net/can/pch_can.c
>>> @@ -903,9 +903,7 @@ static netdev_tx_t pch_xmit(struct sk_buff *skb, struct net_device *ndev)
>>>  
>>>  	tx_obj_no = priv->tx_obj;
>>>  	if (priv->tx_obj == PCH_TX_OBJ_END) {
>>> -		if (ioread32(&priv->regs->treq2) & PCH_TREQ2_TX_MASK)
>>> -			netif_stop_queue(ndev);
>>> -
>>> +		netif_stop_queue(ndev);
>>>  		priv->tx_obj = PCH_TX_OBJ_START;
>>>  	} else {
>>>  		priv->tx_obj++;
>>
>> The pch_can uses a C_CAN core (and for maintenance reasons we would like
>> to get ride of it sooner than later). In that driver the queue is
>> stopped here:
>>
>> http://lxr.linux.no/#linux+v3.2.7/drivers/net/can/c_can/c_can.c#L508
> 
> Does the C_CAN core have a real fifo? The message "fifo" in PCH CAN just uses the first message object. So you will reorder message under some conditions if used like a real fifo.

My understanding is that the CAN controller cores are identical. What
the driver actually uses might be different. Out of order transmission
of message are *not* allowed and the software must take care. With a
real fifo that might be tricky, indeed.

>> Therefore I'm not sure if your fix is enough (without looking into the
>> manual). I could send you a "pch_pci" driver patch for C_CAN, which
>> would allow you to use it. What kernel version are you using?
> 
> We are currently using 2.6.39.

OK, I'm going to prepare a patch for that kernel version first.

More soon...

Wolfgang.
