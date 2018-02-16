From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v2 2/3] can: cc770: Stop queue on NETDEV_TX_BUSY
Date: Fri, 16 Feb 2018 16:20:45 +0100
Message-ID: <a85004a1-d390-e2cd-d8a2-ed15f03cd3c2@grandegger.com>
References: <20180130165649.22732-1-andri.yngvason@marel.com>
 <d62fdd54-4d06-db35-a0a0-b69759286bb5@grandegger.com>
 <8cd354eb-b610-b309-2a3f-a345f56aaecf@grandegger.com>
 <1798644.r6m8FyMpzN@blindfold>
 <bba8155f-4865-d457-4d8d-56ffc71acd59@grandegger.com>
 <1bccaf3c-faab-33ae-e1d8-8344d5d9a537@grandegger.com>
 <c1141307-fb16-3b0b-882b-c09376875cee@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailproxy03.manitu.net ([217.11.48.67]:42780 "EHLO
        mailproxy03.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752602AbeBPPUs (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 16 Feb 2018 10:20:48 -0500
In-Reply-To: <c1141307-fb16-3b0b-882b-c09376875cee@pengutronix.de>
Content-Language: en-GB
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Richard Weinberger <richard@sigma-star.at>
Cc: Andri Yngvason <andri.yngvason@marel.com>, linux-can@vger.kernel.org, sigurbjorn.narfason@marel.com, hrafnkell.eiriksson@marel.com, patric.thysell@br-automation.com

Hello Marc,

Am 16.02.2018 um 15:22 schrieb Marc Kleine-Budde:
> On 02/12/2018 10:36 PM, Wolfgang Grandegger wrote:
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
> 
> It seems to me these patches are still WIP, right? Or should I take some
> to into my git-tree?

Richard? My comment was about "TX register is still occupied!, which in 
fact seems not to happen.

Wolfgang.
