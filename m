Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF3B18C332;
	Fri,  9 Oct 2026 00:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791505839; cv=none; b=b5swAX7B/u08Fyzdx0gNry4xLzA0CDuyebOEyuDoZHdiZ2EWIQiuBTS3HN9Bon61bXEwDNbLlf96xEBFzu3NGFjNTbi6SjMVlYvJ7mQaz/6Kxq9Vn/RUajBa6m3xlYbY6cihKcbKPBCS/fHXyQXh0SXSWWT8/s3haDjmtus+mJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791505839; c=relaxed/simple;
	bh=URRvgDBplzN3sqMnTx/dAfUQXrmvhIRimPvbRCKl7OM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FcehiaXr74YGVGshh+zWjiuHK5yx0SYQ7+hJo+PQxZ2wbSHE7VX+xTp27cSkYDvL/1HhzvgzetdEbvmQmXTQ9foBf9njXo4b6QRH0gWpGcr+BJEKMyG1RTJwVeNKK2g+rko/J+Rsh1R6DIO+0rN9c9r1LJF7Wu7RN1PQWLS4AQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bKYzVVEu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKYzVVEu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22E6E1F000FF;
	Fri,  9 Oct 2026 00:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791505837;
	bh=JZzHSdvSKNduzkcGnAy9HI6B6lQJhJSfLNRHSEEf5xw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bKYzVVEum/tR+9LUkIaUzH02HwQWekm5Ui6L1sstxMdCxRtM5b9XnfH/KiKX5WxNH
	 T+viX3nDAzKs/mRXxGw2O8jaH6+U75Rz/0nqSzdeb2fzvabiWi0yaY55hOAbAI8m8g
	 HWa67thfQBjPIjX4OFC+uwQ2d94eXXdgQL1pzMmhjrLNQqhisbHy1NEedVXJSkPJId
	 dfhV0k1uYN4fnslbErKm/SGfN8SSaln+UyTtHK+dQC16Kitu2+5wAfaXLUmhwMkiAf
	 bJeQsM+HlkDsTiVznQmo5KR/PQgdQOt8n1RV8LPPLGGlDhSyKACJmhP4rlP4Ul+zVO
	 yNZ4pu8z8j2RQ==
Subject: Re: [PATCH] can: vcan: use per-CPU device stats
From: netdev-bot+sashiko@kernel.org
To: yogeshgaur.83@gmail.com
Cc: mkl@pengutronix.de, mailhol@kernel.org, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+937a3a1fbfbc99d6fcaf@syzkaller.appspotmail.com, kuba@kernel.org
Date: Fri, 09 Oct 2026 00:30:36 +0000
Message-ID: <179150583668.1406898.16297101260619649490@kernel.org>
In-Reply-To: <20261007113611.2082-1-yogeshgaur.83@gmail.com>
References: <20261007113611.2082-1-yogeshgaur.83@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 (1) · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete.
- [Low] The commit message gets the cause wrong: 'vcan does not implement
  get_num_tx_queues(), so rtnl_create_link() honours IFLA_NUM_TX_QUEUES'.
- [Low] The patch fixes a syzbot-reported data race (it has Reported-by:
  syzbot+937a3a1fbfbc99d6fcaf and a Closes: link) that loses tx/rx…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but the sibling
  driver vxcan (drivers/net/can/vxcan.c) has the same multi-queue stats…

--

can: vcan: use per-CPU device stats

The patch moves the vcan tx/rx packet and byte counters off dev->stats,
where they were plain increments, and onto the core per-CPU dstats. It
sets pcpu_stat_type to NETDEV_PCPU_STAT_DSTATS and uses
dev_dstats_rx_add() and dev_dstats_tx_add(). This addresses a KCSAN data
race that syzbot reported on vcan devices with several tx queues.

Closes: https://syzkaller.appspot.com/bug?extid=937a3a1fbfbc99d6fcaf

> single tx queue.  vcan does not implement get_num_tx_queues(), so
> rtnl_create_link() honours IFLA_NUM_TX_QUEUES and a vcan device can be
> created with several queues, each with its own xmit lock.

[Severity: Low]
Is this cause and effect accurate? rtnl_create_link() uses
IFLA_NUM_TX_QUEUES whenever the attribute is present. It only falls back
to ops->get_num_tx_queues() when the attribute is absent:

net/core/rtnetlink.c:rtnl_create_link() {
    ...
	if (tb[IFLA_NUM_TX_QUEUES])
		num_tx_queues = nla_get_u32(tb[IFLA_NUM_TX_QUEUES]);
	else if (ops->get_num_tx_queues)
		num_tx_queues = ops->get_num_tx_queues();
    ...
}

So adding get_num_tx_queues() to vcan would not prevent a multi-queue
device.

Could the wording be changed so it does not suggest that?

> Reported-by: syzbot+937a3a1fbfbc99d6fcaf@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=937a3a1fbfbc99d6fcaf
> Assisted-by: LLM
> Signed-off-by: Yogesh Gaur <yogeshgaur.83@gmail.com>

[Severity: Low]
This isn't a bug, but this patch fixes a data race reported by syzbot.
Should it carry a Fixes: tag naming the commit that introduced the
problem? That would let stable and backport tooling tell which trees need
the fix.

> diff --git a/drivers/net/can/vcan.c b/drivers/net/can/vcan.c
> index 76e6b7b5c6a11..2ff90cb7eee9e 100644
> --- a/drivers/net/can/vcan.c
> +++ b/drivers/net/can/vcan.c

[ ... ]

> @@ -93,8 +89,7 @@ static netdev_tx_t vcan_tx(struct sk_buff *skb, struct net_device *dev)
>  		return NETDEV_TX_OK;
>  
>  	len = can_skb_get_data_len(skb);
> -	stats->tx_packets++;
> -	stats->tx_bytes += len;
> +	dev_dstats_tx_add(dev, len);

[Severity: High]
Does this fully close the race described in the commit message?

vcan_tx() still calls can_dropped_invalid_skb() first. That helper's drop
path does a plain increment on the shared dev->stats:

drivers/net/can/dev/skb.c:can_dropped_invalid_skb() {
    ...
inval_skb:
	kfree_skb(skb);
	dev->stats.tx_dropped++;
	return true;
}

Take a vcan created with IFLA_NUM_TX_QUEUES > 1. Two CPUs send invalid
frames on different tx queues, for example via AF_PACKET with a non-CAN
skb->protocol. Each CPU holds only its own queue's xmit lock:

__dev_direct_xmit()
    HARD_TX_LOCK(dev, txq, smp_processor_id());
    netdev_start_xmit()
        vcan_tx()
            can_dropped_invalid_skb()
                dev->stats.tx_dropped++;

Can these tx_dropped increments still be lost? Could KCSAN still report a
data-race in vcan_tx / vcan_tx on this path?

The commit message says tx_dropped "is still reported" because
dev_get_dstats64() folds in dev->stats. The field itself is still updated
without any shared lock, though.

Would it make sense to use DEV_STATS_INC(dev, tx_dropped) in
can_dropped_invalid_skb(), which would cover every CAN driver? Another
option is for vcan to count drops with dev_dstats_tx_dropped().

[ ... ]

> @@ -185,6 +179,7 @@ static void vcan_setup(struct net_device *dev)
>  	dev->netdev_ops		= &vcan_netdev_ops;
>  	dev->ethtool_ops	= &vcan_ethtool_ops;
>  	dev->needs_free_netdev	= true;
> +	dev->pcpu_stat_type	= NETDEV_PCPU_STAT_DSTATS;
>  }

[Severity: Medium]
This isn't a bug introduced by this patch, but the sibling driver vxcan
seems to have the same multi-queue stats race. vxcan_xmit() in
drivers/net/can/vxcan.c does plain increments on both the local and the
peer device stats:

drivers/net/can/vxcan.c:vxcan_xmit() {
    ...
		srcstats->tx_packets++;
		srcstats->tx_bytes += len;
		peerstats = &peer->stats;
		peerstats->rx_packets++;
		peerstats->rx_bytes += len;
    ...
}

It also does dev->stats.tx_dropped++ when the peer is gone.

rtnl_create_link() also honours IFLA_NUM_TX_QUEUES for a vxcan pair, and
vxcan does not set pcpu_stat_type. Concurrent xmits on different tx
queues can lose these increments, including the updates to the peer's rx
counters.

Should vxcan get the same conversion?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261007113611.2082-1-yogeshgaur.83%40gmail.com
