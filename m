Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E414F3C3F68;
	Thu,  8 Oct 2026 06:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.162
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791440138; cv=pass; b=jBrFjCIGBwRKE1DFSSF8Z4CX//y9ytDWAVwHBr1MWipQAINAG1TU2V84S4AJXxNPjbKUgOswAsHXbVhxG6gJstLR4StXMjhZ9wqJlhi862OLvd2dv35W9s1uwtNo3la+DtLtHqm8zO/6RBZSkKSxGdtyv1AKXqCgz9yttWUFymY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791440138; c=relaxed/simple;
	bh=eVKdiJaKVt7+u9GhSW/M3pNXcfNh3QwiPtv1h4+vIZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rn1lhReg9PuZSeferkdUTRZIUWkJo0tytoMYHr1En+soER+kA7SmdMvt0+UocEdWpw/mBpG9kQnZPx7s+eGlVfzKqCFIR1UkKpC9VbKgdayfdOKpllh+OxSpnnOckkcrCRfbjJgPu9BJjAsr6EhHhKXd+fQ2IabzQ0RLr3u0IIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=H3MleD9z; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Ro5kd7M6; arc=pass smtp.client-ip=81.169.146.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="H3MleD9z";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Ro5kd7M6"
ARC-Seal: i=1; a=rsa-sha256; t=1791439951; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=jQFiQ0l6TsvPAwYAQ/x9IqV+afeXP/v+CMULzY86KH2FcpYVZBeKGLz5zEGDYeET+C
    GAjemnmmZ9oDLeebWBjV3Eu6N9SWcJDo+dEySh3LUPQAF8upMHQxEHrZIKwcZXNdnqQY
    8pa4e995pUm2lrsdqvdFqcLkPjM9Vx+UmRT56x1S/uPDbHGmX+Q6+mo9D/aXcRISgnOY
    GamWqrjVQNfAAwvijLssVVbiGt3XD1mUJ/rhVZh97JZMxqEKch8D/IPSuTukfu+HRaJt
    nMJ1ZfLh+rMDQUbrmhseXve1WwHOhffTceuI0whwfcRCrKSkcL2xp+PPDjfeqOEJR9Id
    SmEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1791439951;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=PbOlwv8REDAuiHAA9EdjF7kXzE+kwyIa1nF6dsgQpdU=;
    b=VM1CU7YUVclqWnBvHOXeVNip4peyNPsNUOw3oXK1fQjjgkEzKuNvKrg8qor8FvVN/k
    N91akL7huNMGWr1QVszaqYFwLGsuv78NNoikJTykmXROT+LcehDuVuYfrmWqsu0OjpQB
    3jhwJgXaxohBQAYqZ/O8YL61vhzNco2dxuh4wG2n+PtwztS/C5k3DPXeWuoTykSRyIgW
    GRegivlhWsVt/oTS/dY0MnUzeiQa9hz6dOg+HMuS73JOhBvD4F6KsfvxAa1PwB4UJgTy
    mG3ZtJKM8zESaUQ+wyBoacDqfk0z/qM4RsXBnbnWBVzY2FZMSkNZkNayFG8ftLmWaprd
    veHA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1791439951;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=PbOlwv8REDAuiHAA9EdjF7kXzE+kwyIa1nF6dsgQpdU=;
    b=H3MleD9z6qN0hNQbZ0AaVGLoQ6XSapOSiLrFdMFLAfXv63zZ6kBrphiom0XExqiEJA
    KglyxVwwyK5QrPoCydNjycYvp9+gpDjUKIWwTjFT1CVexFwsqm+hPmrGMkAoldALv/W3
    qs9IWQBmQWKgr8Kkb4r2R7fUGHNQCj+wFr/Qd+zMtqWZ2O0Y9W/e3Fhl6O0YU7evsHCk
    Vy0KQe1TRUSfCi2HgK3sMYSPyg0jUl3O8+2zJ01/Ar/LG5guP/HCGbm5zb4iX1LWr8fU
    wdFzJ1n9VsZ3IcTd5Og5gvV4Uy3ib7QKDMoY2EYWenCO4//u2W2SnekaAJeMh24AyLh5
    M+bg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1791439951;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=PbOlwv8REDAuiHAA9EdjF7kXzE+kwyIa1nF6dsgQpdU=;
    b=Ro5kd7M6v7UDU/HhuuNc2gvHokCxQAKeuycdbPdc8PuDRDMc2FYTbpNTI++4Islb0j
    EB2lsNKK+xo7WRq0gpAQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id K04b9a2986CVJZs
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 8 Oct 2026 08:12:31 +0200 (CEST)
Message-ID: <bbc75925-c9ea-4fec-bd8c-38b8fa8db8c6@hartkopp.net>
Date: Thu, 8 Oct 2026 08:12:26 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: vcan: use per-CPU device stats
To: Yogesh Gaur <yogeshgaur.83@gmail.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+937a3a1fbfbc99d6fcaf@syzkaller.appspotmail.com
References: <20261007113611.2082-1-yogeshgaur.83@gmail.com>
 <f06b2a33-570e-4976-b4ac-b26b74f27cc6@hartkopp.net>
 <CAG6enPzuqq3sLNR5bUNn-z1Y49ut8oZW-6=O2TuxC_EK4RJDzA@mail.gmail.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <CAG6enPzuqq3sLNR5bUNn-z1Y49ut8oZW-6=O2TuxC_EK4RJDzA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 08.10.26 06:13, Yogesh Gaur wrote:
> On Wed, Oct 7, 2026 at 10:41 PM Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>>
>>
>>
>> On 07.10.26 13:36, Yogesh Gaur wrote:
>>> vcan_tx() and vcan_rx() update dev->stats with plain increments and
>>> rely on the tx queue lock to serialise them.  That only holds for a
>>> single tx queue.  vcan does not implement get_num_tx_queues(), so
>>> rtnl_create_link() honours IFLA_NUM_TX_QUEUES and a vcan device can be
>>> created with several queues
>>
>> dev_dstats_tx_add() has been introduced in Linux 6.14 so it is probably
>> some can-next material for Linux 7.4+.
> 
> Agreed.
> 
>>
>> Btw. why don't we implement get_num_tx_queues() and return 1 as a
>> potential stable fix? This would add a correct locking via the existing
>> tx queue lock for all vcan statistics right?
> 
> The locking argument holds: vcan is not LLTX, and every counter update
> (tx, the echo-mode rx in vcan_rx(), and tx_dropped from
> can_dropped_invalid_skb()) happens in vcan_tx() under the xmit locak.
> 
> But get_num_tx_queues() alone does not stop the multi-queue case, as
> rtnl_create_link() only consults it when userspace did not ask.

Right, but there is no reason why userspace should set this value - 
except if you want to race in the stats now ;-)

>>
>> Best regards,
>> Oliver
>>
>> ps. vxcan should have a similar problem.
> 
> Yes - same pattern and the same single-queue argument works there.
> 
> Plan for v2: limiting vcan and vxcan to one TX queue, then the dstats
> conversion for can-next.

Great! This might then also cover the dstats for "real" CAN devices as 
Marc already pointed out.

Many thanks!
Oliver

> 
> Yogesh
>>
>> , each with its own xmit lock.  Two CPUs
>>> transmitting on different queues then update the same counters
>>> concurrently and lose increments:
>>>
>>>     BUG: KCSAN: data-race in vcan_tx / vcan_tx
>>>     read-write to 0xffff88811aad8228 of 8 bytes by interrupt on cpu 1:
>>>      vcan_tx+0x325/0x5d0 drivers/net/can/vcan.c:110
>>>      dev_hard_start_xmit+0x10c/0x380 net/core/dev.c:3969
>>>      __dev_queue_xmit+0xbfd/0x1ec0 net/core/dev.c:4958
>>>      can_send+0x584/0x720 net/can/af_can.c:279
>>>      bcm_can_tx+0x3ba/0x5b0 net/can/bcm.c:367
>>>     read-write to 0xffff88811aad8228 of 8 bytes by interrupt on cpu 0:
>>>      vcan_tx+0x325/0x5d0 drivers/net/can/vcan.c:110
>>>     value changed: 0x00000000000025ef -> 0x00000000000025f0
>>>
>>> Switch the packet and byte counters to the core's per-CPU dstats.
>>> The core allocates them for NETDEV_PCPU_STAT_DSTATS and folds them
>>> together with dev->stats in dev_get_stats(), so tx_dropped from
>>> can_dropped_invalid_skb() is still reported.
>>>
>>> Reported-by: syzbot+937a3a1fbfbc99d6fcaf@syzkaller.appspotmail.com
>>> Closes: https://syzkaller.appspot.com/bug?extid=937a3a1fbfbc99d6fcaf
>>> Assisted-by: LLM
>>> Signed-off-by: Yogesh Gaur <yogeshgaur.83@gmail.com>
>>> ---
>>>    drivers/net/can/vcan.c | 13 ++++---------
>>>    1 file changed, 4 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/net/can/vcan.c b/drivers/net/can/vcan.c
>>> index 76e6b7b5c6a1..2ff90cb7eee9 100644
>>> --- a/drivers/net/can/vcan.c
>>> +++ b/drivers/net/can/vcan.c
>>> @@ -71,10 +71,7 @@ MODULE_PARM_DESC(echo, "Echo sent frames (for testing). Default: 0 (Off)");
>>>
>>>    static void vcan_rx(struct sk_buff *skb, struct net_device *dev)
>>>    {
>>> -     struct net_device_stats *stats = &dev->stats;
>>> -
>>> -     stats->rx_packets++;
>>> -     stats->rx_bytes += can_skb_get_data_len(skb);
>>> +     dev_dstats_rx_add(dev, can_skb_get_data_len(skb));
>>>
>>>        skb->pkt_type  = PACKET_BROADCAST;
>>>        skb->dev       = dev;
>>> @@ -85,7 +82,6 @@ static void vcan_rx(struct sk_buff *skb, struct net_device *dev)
>>>
>>>    static netdev_tx_t vcan_tx(struct sk_buff *skb, struct net_device *dev)
>>>    {
>>> -     struct net_device_stats *stats = &dev->stats;
>>>        unsigned int len;
>>>        int loop;
>>>
>>> @@ -93,8 +89,7 @@ static netdev_tx_t vcan_tx(struct sk_buff *skb, struct net_device *dev)
>>>                return NETDEV_TX_OK;
>>>
>>>        len = can_skb_get_data_len(skb);
>>> -     stats->tx_packets++;
>>> -     stats->tx_bytes += len;
>>> +     dev_dstats_tx_add(dev, len);
>>>
>>>        /* set flag whether this packet has to be looped back */
>>>        loop = skb->pkt_type == PACKET_LOOPBACK;
>>> @@ -107,8 +102,7 @@ static netdev_tx_t vcan_tx(struct sk_buff *skb, struct net_device *dev)
>>>                        /* only count the packets here, because the
>>>                         * CAN core already did the echo for us
>>>                         */
>>> -                     stats->rx_packets++;
>>> -                     stats->rx_bytes += len;
>>> +                     dev_dstats_rx_add(dev, len);
>>>                }
>>>                consume_skb(skb);
>>>                return NETDEV_TX_OK;
>>> @@ -185,6 +179,7 @@ static void vcan_setup(struct net_device *dev)
>>>        dev->netdev_ops         = &vcan_netdev_ops;
>>>        dev->ethtool_ops        = &vcan_ethtool_ops;
>>>        dev->needs_free_netdev  = true;
>>> +     dev->pcpu_stat_type     = NETDEV_PCPU_STAT_DSTATS;
>>>    }
>>>
>>>    static struct rtnl_link_ops vcan_link_ops __read_mostly = {
>>

