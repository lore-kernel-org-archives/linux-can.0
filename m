Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C38C495059;
	Sat, 10 Oct 2026 14:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791640990; cv=none; b=HyCkNOVxxsGZuiRa2ffGXi4bN+EIc6F2NQH3IxPhOU5MvHK4VeD+pgkYVVsFvx3XN2Kx1llWxgoOBSrmBcGjbHzT2U5N87iUxtiehWewJEvNAk1MishAcXCVYT+/7xa7/j8j9a+iyjgqqYOd72OokID1l/4q6FowlF36uoYHBms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791640990; c=relaxed/simple;
	bh=NhVM5tBcecobBuWt8Bw0N9ZVHcF89/LKF8gA1fMCXHY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UoccjunhLfERWTznlTtWOuubUo6rXr1reUdsnL5Eo8mqRLGX/KgCzjB9zE7NiZSehjKajpq8//2P12FtA1Rqa3tWYnCZm1/wH/DOoOL8nGva8xi5D+kv9Hd5MezBovwz+HJgsNWTRJgcKaY2rsy5EAGNF4TdEPryG4htFc/NLco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MltN8fqB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MltN8fqB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AF8C1F00893;
	Sat, 10 Oct 2026 14:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791640985;
	bh=2loVJc7MdRa79kz8tg+l0lchkoHB8b8zUbj47TQ+myI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MltN8fqBcf6Zt+t5+fCS10OAWxd9PGTVFR9u3Soo/MAsVwR32oAVz71VYotPr9Xa5
	 +RQjXKDci3CJ5gbQYITr2ZMgBZa5yZBxzW/mHkp4/wxf1PMVFaPuBXbt+kHktVAQ/s
	 3JIpd1E1MtvTEgcpL9botfG8f9dDkP0iBLnmsKM+Ex30aeefeynJHGxSyc4wJEAZw2
	 rJiggAjyqg52YmRuB7EO8aImJhkdfBVuURfQcNqUzsRaTbMwWKT9dbhvvQ5FjoCeJQ
	 Bsqk2xBFiBJu0raS9H8OebjNjs454a+bIHHmlRKm5/ejGbfGywB9Bc+MdUOQqeNCv9
	 RQgn4CkS/ruFA==
Subject: Re: [PATCH net-next 27/37] can: esd: acc_start_xmit(): do not touch
 skb after can_put_echo_skb()
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, hemanth.selam@gmail.com
Date: Sat, 10 Oct 2026 14:03:04 +0000
Message-ID: <179164098409.434549.11105129942719184044@kernel.org>
In-Reply-To: <20261009134323.64064-28-mkl@pengutronix.de>
References: <20261009134323.64064-28-mkl@pengutronix.de>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] This commit fixes a use-after-free that is reachable in practice,
  but it has no `Fixes:` or `Cc: stable@vger.kernel.org` trailer.

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but
  acc_txq_put() (drivers/net/can/esd/esdacc.c) loads the CAN payload as…

--

can: esd: acc_start_xmit(): do not touch skb after can_put_echo_skb()

This commit splits acc_txq_put() in two. acc_txq_put() now only loads the
payload and DLC into the controller, and the new acc_txq_start() writes the
CAN id, which starts the TX. acc_start_xmit() now loads the data before it
calls can_put_echo_skb(), and starts the TX afterwards.

Link: https://patch.msgid.link/20260929-esd-fix-skb-deref-v2-1-542e3e19fb25@pengutronix.de

> After the call to can_put_echo_skb() in acc_start_xmit() the skb should be
> considered invalid and not accessed anymore, but acc_txq_put() will access
> the skb's data.

[Severity: Low]
Should this patch carry a Fixes: tag and Cc: stable@vger.kernel.org?

The phrase "should be considered invalid" makes the problem sound
theoretical. The old ordering looks like a reachable use-after-free, though.
can_put_echo_skb() frees the original skb on several paths:

drivers/net/can/dev/skb.c:can_put_echo_skb() {
    ...
	if (!(dev->flags & IFF_ECHO) || ...) {
		dev_kfree_skb_any(skb);
		return 0;
	}

	if (!priv->echo_skb[idx]) {
		skb = can_create_echo_skb(skb);
		if (!skb)
			return -ENOMEM;
    ...
	} else {
		...
		dev_kfree_skb_any(skb);
		return -EBUSY;
	}
    ...
}

can_create_echo_skb() also frees the skb when the GFP_ATOMIC clone fails:

include/linux/can/skb.h:can_create_echo_skb() {
	nskb = skb_clone(skb, GFP_ATOMIC);
	if (unlikely(!nskb)) {
		dev_kfree_skb_any(skb);
		return NULL;
	}
    ...
}

In ndo_start_xmit, dev_kfree_skb_any() frees the skb right away. The old
call to acc_txq_put(core, acc_id, acc_dlc, cf->data) then read 8 bytes of
freed memory and loaded them into the TX FIFO as the CAN payload.

This ordering came in with commit 9721866f07e1 ("can: esd: add support for
esd GmbH PCIe/402 CAN interface family"). Could the following be added?

Fixes: 9721866f07e1 ("can: esd: add support for esd GmbH PCIe/402 CAN interface family")
Cc: stable@vger.kernel.org

Could the commit message also say that the old order read freed skb data
whenever can_put_echo_skb() failed?

> diff --git a/drivers/net/can/esd/esdacc.c b/drivers/net/can/esd/esdacc.c
> index 73e66f9a3781c..05d41ed34a02e 100644
> --- a/drivers/net/can/esd/esdacc.c
> +++ b/drivers/net/can/esd/esdacc.c
> @@ -62,14 +62,17 @@ static void acc_resetmode_leave(struct acc_core *core)
>  	acc_resetmode_entered(core);
>  }
>  
> -static void acc_txq_put(struct acc_core *core, u32 acc_id, u32 acc_dlc,
> -			const void *data)
> +static void acc_txq_put(struct acc_core *core, u32 acc_dlc, const void *data)
>  {
>  	acc_write32_noswap(core, ACC_CORE_OF_TXFIFO_DATA_1,
>  			   *((const u32 *)(data + 4)));
>  	acc_write32_noswap(core, ACC_CORE_OF_TXFIFO_DATA_0,
>  			   *((const u32 *)data));

[Severity: Medium]
This is a pre-existing issue and was not introduced by this patch. Since
acc_txq_put() is being reworked anyway, are the payload bytes reversed on
big-endian hosts?

The payload is loaded as native-endian u32 values. It is then written with
acc_write32_noswap(), which despite its name goes through iowrite32():

drivers/net/can/esd/esdacc.h:acc_write32_noswap() {
	iowrite32(v, core->addr + offs);
}

iowrite32() works like writel() and applies cpu_to_le32(). On a big-endian
CPU, the bytes inside each 32-bit word get swapped. On little-endian, b0
lands in register byte lane 0; on big-endian, b3 lands there.

The RX path in handle_core_msg_rxtxdone() keeps the byte order on any host:

	memcpy(cf->data, msg->data, cf->len);

So TX and RX handle the payload differently on BE hosts. The driver only
depends on PCI && HAS_DMA, so it can be built for BE PCI platforms such as
powerpc, parisc or big-endian mips.

Would an accessor that keeps memory byte order work here instead, for
example __raw_writel() or iowrite32_rep(addr, data, 1)?

>  	acc_write32(core, ACC_CORE_OF_TXFIFO_DLC, acc_dlc);
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009134323.64064-2-mkl%40pengutronix.de
