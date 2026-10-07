Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913D13446A6;
	Wed,  7 Oct 2026 17:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.221
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791393252; cv=pass; b=aJ9bUq5GSJCsJcQNcqBTdY/9cKxFFEsakvOOSPkk5YAwcvLK8trrc6cvbmq3lmfyjelCfP2KgHT6p2Da4/IUVTEG/ox5RCiVeWi3aFaYJFmkxzmln5+K9X7Szz32kOB3ZoUoGCqg6EvVEeNiGpk4IaXQU5uyJ4bi7IxaQDfJLvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791393252; c=relaxed/simple;
	bh=Oi0PA4x8+sNf68spT8NEeTF5S83qMcq09VsqFFQndGI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AmQ5blAHXEObrH+Z4RipCIl4fUCsnpepE59JpqwxGnp3uFGrIy5ARfcOLhjSpAy9aMtmgvdMZMsl+mp2/5av+pJQhUuROLnuTF1MDoLq02q8mYpHeHvI5M9Eee6HhnbGwPGKa57mHD4mWAFXWHQGrREY3pr6MHdaHbuZnRs+nUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=dgU5swux; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=ZGY1mCLn; arc=pass smtp.client-ip=81.169.146.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="dgU5swux";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="ZGY1mCLn"
ARC-Seal: i=1; a=rsa-sha256; t=1791393055; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=AmyfI0U6tOSBlWe7S1XQo6lGcbh8wptkBIGnHYObINjwYHQ/eo5ZoreXVE1t0nXPgr
    zowCAzbDba2Z75hyFb5VbRBZK4nLcaBwXHE7kDQeqrmcbuU3cESfS3340bIktBHSLu7l
    oix3hM59zvT+CgExNN4aa+9Um/zukC8URgOZL+QoAZ3EO41j52/P+g4c0CHgtY4ugKJG
    bHM5JTnIkPwp3NuckpOF5Bunep2bU32iNAc1T6ts5zGZ7Fjp95UL0CTNA8ddZm0+bM2G
    dzqwGZOB0goW4yI6cOO+zahRJTaGUffN1/3FyLjsmUq1ChwE2qr6J4TBumT7ofVMf90h
    ezag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1791393055;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Flf0UuR0tyly8cemdMiShmI5JYO+/f1UwJzefGNDu7Y=;
    b=Tk55mESAFCLgxXOFCjPYowiXXtz/SvTOKTGmoZByRtCWjUAayBCCN3ww5nfKeivPd3
    LVfeBUTf3iMOOVVWm8WBSb3gKpMq2cFpXTP02MIPWFvUfazrmhzpmayJeKGNK7SiH1G5
    3036FW+gFmsMJBG+AjxDWJyZiqAfhFWFj7AfrQ1+jnvxskKAiLwfQKn+WcAqKukaawAl
    9TqJ9ZCVWHE6vSBqkJgYapPRvN0BVIskgeb/thFkNlw5I300TFkJYSwxzbTUEzNOG+xi
    lBsFscUogJUH8ePsti3eWaYhq1XnTOenPXGlzP/zRMjOUOZzc2gAb+iqc1WhgU3PTEgz
    uZJg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1791393055;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Flf0UuR0tyly8cemdMiShmI5JYO+/f1UwJzefGNDu7Y=;
    b=dgU5swuxk/KePYSmHT9XACOEXIe0ts0DyeTFOg8/I+9aYTq/1tEsRL+E2L6FmOKHeg
    yZrnJb0B0IQF7PyqFUJd0z9/K9/5J3jSURjA/O/AU/3RtfoxwcYuVqWMUht07rmOWs05
    HZ0VmhCIpLA7ZrMAvGu+AS9nojuDvtbrUoOoKW/o9NBWdBgUFUInUvgxnncEQ3hufRWV
    qjCb8kMJCkuNhzcBLUN87WExzwVKTeql53jSklTWe9sU6eLTNFvaY6kb65bbyyC/Wugn
    e9b0SpOFKa4VeKfRSbhiLyn4XtfXwEUCNmPq6FNbt+/7PhkjH301SrQ67BOS8SIasvdd
    tqTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1791393055;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Flf0UuR0tyly8cemdMiShmI5JYO+/f1UwJzefGNDu7Y=;
    b=ZGY1mCLnXOKSCB6Xg95ys5NR2a4GSWEsJFDsusEblseiEbVT0VMpYpFW7hUht5NY+S
    GXbiYt5eZTwiQ4NK6vBg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id K04b9a297HAtHdC
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 7 Oct 2026 19:10:55 +0200 (CEST)
Message-ID: <f06b2a33-570e-4976-b4ac-b26b74f27cc6@hartkopp.net>
Date: Wed, 7 Oct 2026 19:10:49 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: vcan: use per-CPU device stats
To: Yogesh Gaur <yogeshgaur.83@gmail.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+937a3a1fbfbc99d6fcaf@syzkaller.appspotmail.com
References: <20261007113611.2082-1-yogeshgaur.83@gmail.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20261007113611.2082-1-yogeshgaur.83@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 07.10.26 13:36, Yogesh Gaur wrote:
> vcan_tx() and vcan_rx() update dev->stats with plain increments and
> rely on the tx queue lock to serialise them.  That only holds for a
> single tx queue.  vcan does not implement get_num_tx_queues(), so
> rtnl_create_link() honours IFLA_NUM_TX_QUEUES and a vcan device can be
> created with several queues

dev_dstats_tx_add() has been introduced in Linux 6.14 so it is probably 
some can-next material for Linux 7.4+.

Btw. why don't we implement get_num_tx_queues() and return 1 as a 
potential stable fix? This would add a correct locking via the existing 
tx queue lock for all vcan statistics right?

Best regards,
Oliver

ps. vxcan should have a similar problem.

, each with its own xmit lock.  Two CPUs
> transmitting on different queues then update the same counters
> concurrently and lose increments:
> 
>    BUG: KCSAN: data-race in vcan_tx / vcan_tx
>    read-write to 0xffff88811aad8228 of 8 bytes by interrupt on cpu 1:
>     vcan_tx+0x325/0x5d0 drivers/net/can/vcan.c:110
>     dev_hard_start_xmit+0x10c/0x380 net/core/dev.c:3969
>     __dev_queue_xmit+0xbfd/0x1ec0 net/core/dev.c:4958
>     can_send+0x584/0x720 net/can/af_can.c:279
>     bcm_can_tx+0x3ba/0x5b0 net/can/bcm.c:367
>    read-write to 0xffff88811aad8228 of 8 bytes by interrupt on cpu 0:
>     vcan_tx+0x325/0x5d0 drivers/net/can/vcan.c:110
>    value changed: 0x00000000000025ef -> 0x00000000000025f0
> 
> Switch the packet and byte counters to the core's per-CPU dstats.
> The core allocates them for NETDEV_PCPU_STAT_DSTATS and folds them
> together with dev->stats in dev_get_stats(), so tx_dropped from
> can_dropped_invalid_skb() is still reported.
> 
> Reported-by: syzbot+937a3a1fbfbc99d6fcaf@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=937a3a1fbfbc99d6fcaf
> Assisted-by: LLM
> Signed-off-by: Yogesh Gaur <yogeshgaur.83@gmail.com>
> ---
>   drivers/net/can/vcan.c | 13 ++++---------
>   1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/can/vcan.c b/drivers/net/can/vcan.c
> index 76e6b7b5c6a1..2ff90cb7eee9 100644
> --- a/drivers/net/can/vcan.c
> +++ b/drivers/net/can/vcan.c
> @@ -71,10 +71,7 @@ MODULE_PARM_DESC(echo, "Echo sent frames (for testing). Default: 0 (Off)");
>   
>   static void vcan_rx(struct sk_buff *skb, struct net_device *dev)
>   {
> -	struct net_device_stats *stats = &dev->stats;
> -
> -	stats->rx_packets++;
> -	stats->rx_bytes += can_skb_get_data_len(skb);
> +	dev_dstats_rx_add(dev, can_skb_get_data_len(skb));
>   
>   	skb->pkt_type  = PACKET_BROADCAST;
>   	skb->dev       = dev;
> @@ -85,7 +82,6 @@ static void vcan_rx(struct sk_buff *skb, struct net_device *dev)
>   
>   static netdev_tx_t vcan_tx(struct sk_buff *skb, struct net_device *dev)
>   {
> -	struct net_device_stats *stats = &dev->stats;
>   	unsigned int len;
>   	int loop;
>   
> @@ -93,8 +89,7 @@ static netdev_tx_t vcan_tx(struct sk_buff *skb, struct net_device *dev)
>   		return NETDEV_TX_OK;
>   
>   	len = can_skb_get_data_len(skb);
> -	stats->tx_packets++;
> -	stats->tx_bytes += len;
> +	dev_dstats_tx_add(dev, len);
>   
>   	/* set flag whether this packet has to be looped back */
>   	loop = skb->pkt_type == PACKET_LOOPBACK;
> @@ -107,8 +102,7 @@ static netdev_tx_t vcan_tx(struct sk_buff *skb, struct net_device *dev)
>   			/* only count the packets here, because the
>   			 * CAN core already did the echo for us
>   			 */
> -			stats->rx_packets++;
> -			stats->rx_bytes += len;
> +			dev_dstats_rx_add(dev, len);
>   		}
>   		consume_skb(skb);
>   		return NETDEV_TX_OK;
> @@ -185,6 +179,7 @@ static void vcan_setup(struct net_device *dev)
>   	dev->netdev_ops		= &vcan_netdev_ops;
>   	dev->ethtool_ops	= &vcan_ethtool_ops;
>   	dev->needs_free_netdev	= true;
> +	dev->pcpu_stat_type	= NETDEV_PCPU_STAT_DSTATS;
>   }
>   
>   static struct rtnl_link_ops vcan_link_ops __read_mostly = {

