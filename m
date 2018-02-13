From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v2 2/3] can: cc770: Stop queue on NETDEV_TX_BUSY
Date: Tue, 13 Feb 2018 17:30:16 +0100
Message-ID: <2058d676-9d13-348d-9a0c-eb591969a25e@grandegger.com>
References: <20180130165649.22732-1-andri.yngvason@marel.com>
 <d62fdd54-4d06-db35-a0a0-b69759286bb5@grandegger.com>
 <8cd354eb-b610-b309-2a3f-a345f56aaecf@grandegger.com>
 <1798644.r6m8FyMpzN@blindfold>
 <bba8155f-4865-d457-4d8d-56ffc71acd59@grandegger.com>
 <1bccaf3c-faab-33ae-e1d8-8344d5d9a537@grandegger.com>
 <151851795369.10946.7788373784181887753@maxwell>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailproxy02.manitu.net ([217.11.48.66]:47354 "EHLO
        mailproxy02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933927AbeBMQa0 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 13 Feb 2018 11:30:26 -0500
In-Reply-To: <151851795369.10946.7788373784181887753@maxwell>
Content-Language: en-GB
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andri Yngvason <andri.yngvason@marel.com>, Richard Weinberger <richard@sigma-star.at>
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de, sigurbjorn.narfason@marel.com, hrafnkell.eiriksson@marel.com, patric.thysell@br-automation.com



Am 13.02.2018 um 11:32 schrieb Andri Yngvason:
> Hello Wolfgang, Richard,
> 
> Quoting Wolfgang Grandegger (2018-02-12 21:36:37)
>> Am 12.02.2018 um 22:28 schrieb Wolfgang Grandegger:
>>> Am 12.02.2018 um 21:55 schrieb Richard Weinberger:
>>>> Am Montag, 12. Februar 2018, 21:44:11 CET schrieb Wolfgang Grandegger:
>>>>> Am 12.02.2018 um 21:37 schrieb Wolfgang Grandegger:
>>>>>> Hello,
>>>>>>
>>>>>> Am 12.02.2018 um 20:40 schrieb Richard Weinberger:
>>>>>>> Andri,
>>>>>>>
>>>>>>> Am Dienstag, 30. Januar 2018, 17:56:48 CET schrieb Andri Yngvason:
>>>>>>>> If the queue is not stopped, the start_xmit function will continue
>>>>>>>> to be
>>>>>>>> called until the driver or the system is reset.
>>>>>>>>
>>>>>>>> Signed-off-by: Andri Yngvason <andri.yngvason@marel.com>
>>>>>>>> ---
>>>>>>>>     drivers/net/can/cc770/cc770.c | 1 +
>>>>>>>>     1 file changed, 1 insertion(+)
>>>>>>>>
>>>>>>>> diff --git a/drivers/net/can/cc770/cc770.c
>>>>>>>> b/drivers/net/can/cc770/cc770.c
>>>>>>>> index 9fed163..12d3b89 100644
>>>>>>>> --- a/drivers/net/can/cc770/cc770.c
>>>>>>>> +++ b/drivers/net/can/cc770/cc770.c
>>>>>>>> @@ -405,6 +405,7 @@ static netdev_tx_t cc770_start_xmit(struct
>>>>>>>> sk_buff *skb,
>>>>>>>> struct net_device *dev)
>>>>>>>>
>>>>>>>>         if ((cc770_read_reg(priv,
>>>>>>>>                     msgobj[mo].ctrl1) & TXRQST_UNC) == TXRQST_SET) {
>>>>>>>> +        netif_stop_queue(dev);
>>>>>>>>             netdev_err(dev, "TX register is still occupied!\n");
>>>>>>>>             return NETDEV_TX_BUSY;
>>>>>>>>         }
>>>>>>>
>>>>>>> I see that some can drivers stop the queue, others not.
>>>>>>> What exactly is the problem in this case?
>>>>>>
>>>>>> Stopping the queue and returning NETDEV_TX_BUSY does make little sense.
>>>>>> NETDEV_TX_BUSY will tell the upper layer to retry asap. In general that
>>>>>> case should be avoided by stopping the queue earlier. Actually,
>>>>>> netif_stop_queue(dev) is called directly after the if block above,
>>>>>> which means that "TX register is still occupied" indicates an
>>>>>> error/bug.
>>>>>> I think there is a race somewhere.
>>>>>
>>>>> If you run on "-rt", the IRQ is threaded. This would explain the issue.
>>>>>
>>>>> Wolfgang.
>>>>
>>>> Andri, do you see the "TX register is still occupied!" error message?
>>>> In my case, I never saw it while working on the rt-related stalls
>>>> during my
>>>> tests.
>>>
>>> At a closer look I cannot identify a race. Anyway, the message should
>>> never show up.
>>
>> You could try to get a function trace by enabling functions tracing and
>> stopping it with "tracing_off" when the if block above is entered. A
>> filter for "cc770_*" and "netif_*" might be useful as well.
>>
>> Wolfgang.
> 
> There is no issue currently that will cause NETDEV_TX_BUSY to be returned. I
> included this patch because while I was working on PATCH 3, this return would
> stall the system when I ran into the race condition which I subsequently fixed.

OK.

> Also, according to include/linux/netdevice.h:
>   * netdev_tx_t (*ndo_start_xmit)(struct sk_buff *skb,
>   *                               struct net_device *dev);
>   *	Called when a packet needs to be transmitted.
>   *	Returns NETDEV_TX_OK.  Can return NETDEV_TX_BUSY, but you should stop
>   *	the queue before that can happen; it's for obsolete devices and weird
>   *	corner cases, but the stack really does a non-trivial amount
>   *	of useless work if you return NETDEV_TX_BUSY.
>   *	Required; cannot be NULL.
> 
> All netdevs should stop the queue before returning NETDEV_TX_BUSY.

Thanks for the info, I was not aware of that. Without stopping the 
queue, the upper layer will retry asap... which may cause heavy CPU 
load... which is bad!

Wolfgang.
