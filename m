From: Austin Schuh <austin@peloton-tech.com>
Subject: Re: CAN message timestamping
Date: Mon, 4 Apr 2016 13:32:06 -0700
Message-ID: <CANGgnMbPmrCxCXddj_hOhTc6v3uHrtMtmfDZLOYjs+4TLjSdkA@mail.gmail.com>
References: <CANGgnMbLhYDdiK_tff0cEW+umuMOPN0h9x7t7cMK-xjMAMNBmQ@mail.gmail.com>
 <56F23F1F.6040101@hartkopp.net> <CANGgnMaOs03rJByb9KVFFG1p45ZuWZ4qt8-F7y6oqtdDveNs2A@mail.gmail.com>
 <CANGgnMbzfVcK+PgAeFMFHjCZMCSosHE2xfctOfkdFb=+ZHrQaw@mail.gmail.com>
 <CANGgnMaK0wXwsKJZB0SssPje9r6qCVYUQzbJsqW+BdSDCQ1iPA@mail.gmail.com>
 <56FBC3C4.80400@hartkopp.net> <CANGgnMa3OJxiK=7bQo3MHmWR3+O0-4LwfgXf9CV2oePUY0gtBg@mail.gmail.com>
 <5702C43C.4000506@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-yw0-f169.google.com ([209.85.161.169]:36645 "EHLO
	mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754917AbcDDUc0 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 4 Apr 2016 16:32:26 -0400
Received: by mail-yw0-f169.google.com with SMTP id g3so268198786ywa.3
        for <linux-can@vger.kernel.org>; Mon, 04 Apr 2016 13:32:26 -0700 (PDT)
In-Reply-To: <5702C43C.4000506@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can <linux-can@vger.kernel.org>, Philipp Schrader <philipp@peloton-tech.com>

On Mon, Apr 4, 2016 at 12:45 PM, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> Hi Austin,
>
>
> On 03/30/2016 06:50 PM, Austin Schuh wrote:
>>
>> Hi Oliver,
>>
>> On Wed, Mar 30, 2016 at 5:17 AM, Oliver Hartkopp <socketcan@hartkopp.net>
>> wrote:
>>>
>>> Hi Austin,
>>>
>>> On 03/29/2016 06:28 AM, Austin Schuh wrote:
>>>>
>>>>
>>>> On Mon, Mar 28, 2016 at 8:42 PM, Austin Schuh <austin@peloton-tech.com>
>>>> wrote:
>>>>>
>>>>>
>>>>> On Mon, Mar 28, 2016 at 6:51 PM, Austin Schuh <austin@peloton-tech.com>
>>>>> wrote:
>>>>> Turns out timestamping in the driver is pretty easy.  The following
>>>>> seems to be working for me.  (comments welcome!)  I don't think this
>>>>> is something that should be up streamed, but I'm including it here in
>>>>> case there is other interest.  I'm reading both clocks in the ISR to
>>>>> reduce the amount of time difference between when they are both read.
>>>>>
>>>>> $ git diff
>>>>> diff --git a/drivers/net/can/sja1000/sja1000.c
>>>>> b/drivers/net/can/sja1000/sja1000.c
>>>>> index 76ef900..55d6583 100644
>>>>> --- a/drivers/net/can/sja1000/sja1000.c
>>>>> +++ b/drivers/net/can/sja1000/sja1000.c
>>>>> @@ -370,6 +370,10 @@ static void sja1000_rx(struct net_device *dev)
>>>>>           /* release receive buffer */
>>>>>           sja1000_write_cmdreg(priv, CMD_RRB);
>>>>>
>>>>> +       struct skb_shared_hwtstamps *shhwtstamps =
>>>>> +           skb_hwtstamps(skb);
>>>>> +       shhwtstamps->syststamp = ktime_get();
>>>>> +       skb->tstamp = ktime_get_real();
>>>>>           netif_rx(skb);
>>>>>
>>>>>           stats->rx_packets++;
>>>
>>>
>>>
>>> Yes. I was also thinking about doing the timestamping directly at hw
>>> interrupt time.
>>>
>>> The point is, that timestamping is an option.
>>> The timestamping is only done if someone requires timestamps - an then it
>>> is
>>> done in the net-rx softirq (which is not that precise which is probably
>>> the
>>> reason for rx hardware timestamping).
>>
>>
>>  From what I see in the two drivers I've looked at so far, hardware
>> timestamping is done unconditionally.  Normal timestamping seems to be
>> done conditional on if SOCK_RCVTSTAMP is set on the sock and if it has
>> not already been timestamped.
>
>
> The fact that HW timstamping is done unconditionally should be discussed
> separately. E.g. by some net_timestamp_needed() function which would have to
> be introduced in linux/net/core/dev.c ...

Sounds reasonable.  I'll implement a RFC without this part in the next
week or so and send it out.  Once I've got something that's a bit
better than what I have now, I'll send it out.

>> drivers/net/can/usb/peak_usb/pcan_usb.c, in pcan_usb_decode_data, the
>> hardware timestamp is populated unconditionally.  I saw something
>> similar in the tg3 driver, though it was hidden behind an if statement
>> that I had trouble figuring out for sure when it was triggered.
>>
>> I haven't checked to see if the bits are available where we need them,
>> but there are option bits attached to struct sock in net/core/sock.c
>> that signal if timestamping is required.
>>
>> What do you think makes sense here?  I'm nervous about breaking things...
>
>
> See above - I would vote for a local solution first.
>
>
>>>
>>>> I missed the TX timestamping.  I didn't see a clean way to get access
>>>> to the echo skb.
>>>>
>>>> --- a/drivers/net/can/sja1000/sja1000.c
>>>> +++ b/drivers/net/can/sja1000/sja1000.c
>>>> @@ -518,10 +524,19 @@ irqreturn_t sja1000_interrupt(int irq, void
>>>> *dev_id)
>>>>                                   stats->tx_errors++;
>>>>                                   can_free_echo_skb(dev, 0);
>>>>                           } else {
>>>> +                               struct can_priv *can_priv_struct =
>>>> netdev_priv(dev);
>>>>                                   /* transmission complete */
>>>>                                   stats->tx_bytes +=
>>>>                                           priv->read_reg(priv,
>>>> SJA1000_FI)
>>>> & 0xf;
>>>>                                   stats->tx_packets++;
>>>> +                               if (can_priv_struct->echo_skb[0]) {
>>>> +                                       struct sk_buff *skb =
>>>> can_priv_struct->echo_skb[0];
>>>> +                                       struct skb_shared_hwtstamps
>>>> *shhwtstamps =
>>>> +                                               skb_hwtstamps(skb);
>>>> +                                       shhwtstamps->syststamp =
>>>> ktime_get();
>>>> +                                       skb->tstamp = ktime_get_real();
>>>> +                               }
>>>> +
>>>>                                   can_get_echo_skb(dev, 0);
>>>
>>>
>>>
>>> I think a proper way would be to put this directly in can_get_echo_skb(),
>>> as
>>> poking into can_priv_struct->echo_skb[0] can just be a proof of concept
>>> for
>>> tx timstamping.
>>>
>
> (..)
>
>> Works for me.
>
>
> Not for me :-)
>
>> I don't like running a custom kernel when I don't need
>> to.  Before I put together a patch, let's figure out what makes sense.
>> I'm more than capable of writing the software, but my kernel internals
>> background and knowledge of best practices isn't very good.
>
>
> I wonder if it makes sense to create a helper function to set the timestamps
> following your suggestion and call this function in can_get_echo_skb().
>
> Regards,
> Oliver
>

Ok!  I *think* I have enough to put together a first patch for
comments and test it on my SJA1000 and on vcan.  Thanks!  If you have
other thoughts, please let me know.

Austin
