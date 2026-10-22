Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792667677;
	b=IjpYKOIsT2J2diZLeGMMN/m/Tv+hHiD13fFCX0E18zRKJAKK+6PW/07tE7t6TboKNscZ
	 1y6h+E5O9YzPntLXHX/brWbjlNZAB4DTrM0XSvXbcwQGE6KfbyyxMNjk8ver+rp4djxlE
	 SjMv+dhbFlDW1Tm73oTC3Nhb+xJmvmvb4KK9YxhIAThLcwUtLJeyyfpcaf9+UxWg/+IO6
	 w7ZWkokGpnpKSSbdpEYh/C4RyFSL/6dIHhfpjKxCuK0G8qG9EcuBIlhpdBrRqmRnGA8g4
	 uMmCKgzB2f5ZhdwI4D5WmscDMki9rBF1Pv3OH1WH2doKrNt1PIukkrJNKIqUkbKg5zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792667677;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Ths0YCGvNmn17Y9VFGEfg1JvJ+KX1P+SPBSIpfosUZQ=;
	b=1UoWfakgnG68nN92FMv1DwfI4rUbpgjaqPmf5ZHZZHdsmxmDxw5vGvbVQD8LZF85nsu+
	 PFcipMBoRjgr0rcBd1XzRgs/5zVRGQdSN9ho6cXX0xrW/d785Y5uwaDMp5sd5V91g1sL9
	 0HLrtgGzhs+ZkJ0kFgEuY/hnxfgzX9DB9ELkisdfiAk56usPLR1qgrt+WJ1iVKCKu1TJB
	 aUXD73P+P6shwAW3l7sSYPSn2CEo8mO/F8+AoLQxE7PhVvJgsGIlmUOk4sgTQ6pYWxKSA
	 IH0IswATDY0w3/tWJc5oD+u4NJZJgRik6BbNOLYEawjz66kejoOFBxrJ23MvribAe7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T9OBLRqz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE83606A31B;
	Thu, 22 Oct 2026 11:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T9OBLRqz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 340DF1F000C1;
	Thu, 22 Oct 2026 11:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792667676;
	bh=Ths0YCGvNmn17Y9VFGEfg1JvJ+KX1P+SPBSIpfosUZQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=T9OBLRqzx7s5E6EcZruwFqgER8Y6DCkvmdHzGPOOw5i60wZsSP1nrVbYcY7eVp9+G
	 gs+DAFDV6Djvhs7sMA8Yt3HK3V2tRjvmM+k7CduSqjgX4sCFijdpMgenEZSuGOatQT
	 +UU6AFWhaRTLA1KX1FE+OCxRQiG4piZZrv0zUvXCMBCcB7hlk5Gx5dZ/WIMgzRYmCO
	 76AEXpCRns5g9sbfEsnSnEYM5fRBwtb7ohCLu0ywDV9703j6nl/yxS7bqGt5LIDDpd
	 SpjVgICbGiz26+Gf0hnfpdn83i7AB0wZdl9meqNUy8nJkBkqNIBom45Mk1zBeJpTkl
	 yxNSkmdcWkAsA==
Subject: Re: [PATCH net-next 02/11] can: skb: make echo skb freeing safe in
 any IRQ context
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, mailhol@kernel.org,
 stable@kernel.org
Date: Thu, 22 Oct 2026 11:14:35 +0000
Message-ID: <179266767571.3135.16315389281254713343@kernel.org>
In-Reply-To: <20261021102756.1900679-3-mkl@pengutronix.de>
References: <20261021102756.1900679-3-mkl@pengutronix.de>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] After this patch, the comment in virtio_can_start_xmit()
  (drivers/net/can/virtio_can.c) still says "can_put_echo_skb() already…

Pre-existing issues:
- [Medium] At this commit, can_put_echo_skb() in
  drivers/net/can/dev/skb.c handles skb ownership differently depending…

--

can: skb: make echo skb freeing safe in any IRQ context

This patch replaces kfree_skb() with dev_kfree_skb_any() on the drop
paths of can_put_echo_skb(), can_dropped_invalid_skb(),
can_dev_dropped_skb() and can_create_echo_skb(). After a successful clone,
can_create_echo_skb() now releases the original skb with
dev_consume_skb_any() instead of consume_skb(). With these changes the
helpers are safe to call with hardware interrupts disabled.

Link: https://patch.msgid.link/tencent_E84809CF236D0137885E7E4E4D58340B3208@qq.com

> diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
> index bc0787535b524..46c151eece8f7 100644
> --- a/drivers/net/can/dev/skb.c
> +++ b/drivers/net/can/dev/skb.c
> @@ -63,7 +63,7 @@ int can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
>  	    (skb->protocol != htons(ETH_P_CAN) &&
>  	     skb->protocol != htons(ETH_P_CANFD) &&
>  	     skb->protocol != htons(ETH_P_CANXL))) {
> -		kfree_skb(skb);
> +		dev_kfree_skb_any(skb);
>  		return 0;
>  	}
>  
> @@ -91,7 +91,7 @@ int can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
>  	} else {
>  		/* locking problem with netif_stop_queue() ?? */
>  		netdev_err(dev, "%s: BUG! echo_skb %d is occupied!\n", __func__, idx);
> -		kfree_skb(skb);
> +		dev_kfree_skb_any(skb);
>  		return -EBUSY;
>  	}

[Severity: Medium]
This is a pre-existing issue and was not introduced by this patch. Since
these error paths in can_put_echo_skb() are being changed anyway, should
the out-of-bounds index path free the skb as well?

At this commit that path returns without freeing or storing the skb:

drivers/net/can/dev/skb.c:can_put_echo_skb() {
	if (idx >= priv->echo_skb_max) {
		netdev_err(dev, "%s: BUG! Trying to access can_priv::echo_skb out of bounds (%u/max %u)\n",
			   __func__, idx, priv->echo_skb_max);
		return -EINVAL;
	}
    ...
}

The -EBUSY, -ENOMEM and IFF_ECHO/protocol drop paths all free the skb,
and callers depend on that. For example, virtio_can_start_xmit() does:

	err = can_put_echo_skb(skb, dev, can_tx_msg->putidx, 0);
	if (unlikely(err)) {
		/* skb was already freed by can_put_echo_skb() on error */
		...
		goto kick;
	}

Won't the skb leak if a driver passes idx >= priv->echo_skb_max?

The -EINVAL branch comes from commit 6411959c10fe. A later patch in this
series, "can: dev: can_put_echo_skb(): free skb on invalid echo index",
adds dev_kfree_skb_any(skb) before the return -EINVAL. By the end of the
series, every return path consumes the skb.

[ ... ]

> diff --git a/include/linux/can/skb.h b/include/linux/can/skb.h
> index 5d27843862fca..87ace09c0d8bd 100644
> --- a/include/linux/can/skb.h
> +++ b/include/linux/can/skb.h
> @@ -78,12 +78,12 @@ static inline struct sk_buff *can_create_echo_skb(struct sk_buff *skb)
>  
>  	nskb = skb_clone(skb, GFP_ATOMIC);
>  	if (unlikely(!nskb)) {
> -		kfree_skb(skb);
> +		dev_kfree_skb_any(skb);
>  		return NULL;
>  	}
>  
>  	can_skb_set_owner(nskb, skb->sk);
> -	consume_skb(skb);
> +	dev_consume_skb_any(skb);

[Severity: Low]
This isn't a bug, but the comment in virtio_can_start_xmit() still names
the old helper:

drivers/net/can/virtio_can.c:virtio_can_start_xmit() {
    ...
		/*
		 * can_put_echo_skb() already consumed skb via consume_skb(),
		 * so returning NETDEV_TX_BUSY would cause the stack to requeue
		 * a freed pointer. Drop the frame and return OK instead.
		 */
    ...
}

What the comment says about ownership is still correct.
dev_consume_skb_any() gives up the skb whether it frees it directly or
defers the free. Only the helper name is out of date.

The commit message FAQ says this comment will be updated in a separate
series to make backporting easier, and it is still unchanged at the end of
this series. Should it say dev_consume_skb_any() instead?

>  	return nskb;
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261021102756.1900679-2-mkl%40pengutronix.de
