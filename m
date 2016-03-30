From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: CAN message timestamping
Date: Wed, 30 Mar 2016 14:17:08 +0200
Message-ID: <56FBC3C4.80400@hartkopp.net>
References: <CANGgnMbLhYDdiK_tff0cEW+umuMOPN0h9x7t7cMK-xjMAMNBmQ@mail.gmail.com>
 <56F23F1F.6040101@hartkopp.net>
 <CANGgnMaOs03rJByb9KVFFG1p45ZuWZ4qt8-F7y6oqtdDveNs2A@mail.gmail.com>
 <CANGgnMbzfVcK+PgAeFMFHjCZMCSosHE2xfctOfkdFb=+ZHrQaw@mail.gmail.com>
 <CANGgnMaK0wXwsKJZB0SssPje9r6qCVYUQzbJsqW+BdSDCQ1iPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161]:35773 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751631AbcC3MRN (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 30 Mar 2016 08:17:13 -0400
In-Reply-To: <CANGgnMaK0wXwsKJZB0SssPje9r6qCVYUQzbJsqW+BdSDCQ1iPA@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Austin Schuh <austin@peloton-tech.com>, linux-can <linux-can@vger.kernel.org>, Philipp Schrader <philipp@peloton-tech.com>

Hi Austin,

On 03/29/2016 06:28 AM, Austin Schuh wrote:
> On Mon, Mar 28, 2016 at 8:42 PM, Austin Schuh <austin@peloton-tech.com> wrote:
>> On Mon, Mar 28, 2016 at 6:51 PM, Austin Schuh <austin@peloton-tech.com> wrote:
>>> Hi Oliver,
>>>
>>> I spent some time trying recvmsg, but it still only gives me
>>> timestamps with the real-time clock.  I do like the interface much
>>> better.  Thanks!
>>>
>>> I was able to get
>>>    setsockopt(socket_, SOL_SOCKET, SO_TIMESTAMPNS,
>>>        &enabled, sizeof(enabled))
>>> and
>>>    const int stamping_val = SOF_TIMESTAMPING_SOFTWARE |
>>>        SOF_TIMESTAMPING_SYS_HARDWARE |
>>>        SOF_TIMESTAMPING_RAW_HARDWARE;
>>>    setsockopt(socket_, SOL_SOCKET, SO_TIMESTAMPING, &stamping_val,
>>>        sizeof(stamping_val))
>>> to successfully timestamp values with recvmsg.

Great!

>> Turns out timestamping in the driver is pretty easy.  The following
>> seems to be working for me.  (comments welcome!)  I don't think this
>> is something that should be up streamed, but I'm including it here in
>> case there is other interest.  I'm reading both clocks in the ISR to
>> reduce the amount of time difference between when they are both read.
>>
>> $ git diff
>> diff --git a/drivers/net/can/sja1000/sja1000.c
>> b/drivers/net/can/sja1000/sja1000.c
>> index 76ef900..55d6583 100644
>> --- a/drivers/net/can/sja1000/sja1000.c
>> +++ b/drivers/net/can/sja1000/sja1000.c
>> @@ -370,6 +370,10 @@ static void sja1000_rx(struct net_device *dev)
>>          /* release receive buffer */
>>          sja1000_write_cmdreg(priv, CMD_RRB);
>>
>> +       struct skb_shared_hwtstamps *shhwtstamps =
>> +           skb_hwtstamps(skb);
>> +       shhwtstamps->syststamp = ktime_get();
>> +       skb->tstamp = ktime_get_real();
>>          netif_rx(skb);
>>
>>          stats->rx_packets++;

Yes. I was also thinking about doing the timestamping directly at hw 
interrupt time.

The point is, that timestamping is an option.
The timestamping is only done if someone requires timestamps - an then 
it is done in the net-rx softirq (which is not that precise which is 
probably the reason for rx hardware timestamping).

> I missed the TX timestamping.  I didn't see a clean way to get access
> to the echo skb.
>
> --- a/drivers/net/can/sja1000/sja1000.c
> +++ b/drivers/net/can/sja1000/sja1000.c
> @@ -518,10 +524,19 @@ irqreturn_t sja1000_interrupt(int irq, void *dev_id)
>                                  stats->tx_errors++;
>                                  can_free_echo_skb(dev, 0);
>                          } else {
> +                               struct can_priv *can_priv_struct =
> netdev_priv(dev);
>                                  /* transmission complete */
>                                  stats->tx_bytes +=
>                                          priv->read_reg(priv, SJA1000_FI) & 0xf;
>                                  stats->tx_packets++;
> +                               if (can_priv_struct->echo_skb[0]) {
> +                                       struct sk_buff *skb =
> can_priv_struct->echo_skb[0];
> +                                       struct skb_shared_hwtstamps
> *shhwtstamps =
> +                                               skb_hwtstamps(skb);
> +                                       shhwtstamps->syststamp = ktime_get();
> +                                       skb->tstamp = ktime_get_real();
> +                               }
> +
>                                  can_get_echo_skb(dev, 0);

I think a proper way would be to put this directly in 
can_get_echo_skb(), as poking into can_priv_struct->echo_skb[0] can just 
be a proof of concept for tx timstamping.

I'm fine with adding a more precise timestamping into CAN drivers but I 
wonder how other drivers implement this feature taking without killing 
the 'optional' feature.

Best regards,
Oliver

