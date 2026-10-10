Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4E535AC14;
	Sat, 10 Oct 2026 14:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791640970; cv=none; b=vEx+EYm83sBbkH8kSyx1eDqNmjTkRwNtrVypjEdyptYJvkYBhw1uDcOrj5//0hdV6AppbC7ELQPmNdGF+3CpK/2QtVAHpBKiaScWrP+eFXg5Ck8PXWBORDkgwHj8J/4gHrnz3DZ/gdJ3WelAvW2aCSeCblTF4Vr+kqmXxDLmRps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791640970; c=relaxed/simple;
	bh=uz+ZmIakBkUVkStOGP3IGDRq8w+uxpnV+jkP9VS9LwQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dBr36uu3otjU5tOTulPcIQWrQYHNqrOnbxfdc8PAZC90Li8/rXzEossY3Nt91Tc8yyHh2PXiIFfAbCtyWlPeRBtBac3WBy6o1DN03yKTZvt3P12zfz8K4k+y1NfXNy32J4B16P/Ctaay0lDhPo0sM87HgTm2u/OQuP4bfXL2III=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=apFNrgDn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="apFNrgDn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E423A1F000FF;
	Sat, 10 Oct 2026 14:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791640969;
	bh=O4hzZrNbh8yaR5MMGy/JhFNOtVUr4m1LHYTRlOkUwv8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=apFNrgDn2zDMcT/rEzYF9s7YhKeq4nYIkyhY4zK+2JhcSO009+c29ERthyA//gtsi
	 VSmdAwHdrgei1IHA99QKL8z5DpFlz1MZV3nByqNfqiv+QoZuQAmrLhWgVF0/q72QfY
	 IBot+/liffzmo1Sk3dzD09zia+0rb/vWh46r260ygu7U6IHvv25x4rsTcTA2Bnat4e
	 x4rbPA++Wk+lt0cuGTgCmP+9kq0x/B96vAgHnF/7xIoYr2vINEHfDVkm7M1hNanZmW
	 bO0aUA/AHDlyvl+Qc5rDfendcCK6X9PRVcJFBah90OaAUhI/5MLr+QK19vL5wJiizg
	 mVOzd/0Mqv1SQ==
Subject: Re: [PATCH net-next 03/37] can: convert unreliable ARPHRD_CAN type
 checks to robust can_get_ml_priv()
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, hemanth.selam@gmail.com
Date: Sat, 10 Oct 2026 14:02:48 +0000
Message-ID: <179164096840.434549.11863787117718202775@kernel.org>
In-Reply-To: <20261009134323.64064-4-mkl@pengutronix.de>
References: <20261009134323.64064-4-mkl@pengutronix.de>
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

- [Low] The commit message calls the change a conversion of 'unreliable'
  ARPHRD_CAN checks to 'robust' can_get_ml_priv() checks.

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but isotp_bind()
  in net/can/isotp.c ignores the return values of both can_rx_register()…

--

can: convert unreliable ARPHRD_CAN type checks to robust can_get_ml_priv()

This patch replaces the remaining dev->type != ARPHRD_CAN checks in
af_can, bcm, gw, isotp and raw with can_get_ml_priv(). The reason given is
that TUNSETLINK can switch a down TUN/TAP device to ARPHRD_CAN while its
ml_priv stays NULL.

Link: https://patch.msgid.link/20261009121115.61012-1-socketcan@hartkopp.net

> diff --git a/net/can/af_can.c b/net/can/af_can.c
> index 34fe3b28d576f..dc27ace43719d 100644
> --- a/net/can/af_can.c
> +++ b/net/can/af_can.c

[ ... ]

> @@ -519,7 +519,7 @@ void can_rx_unregister(struct net *net, struct net_device *dev, canid_t can_id,
>  	struct can_rcv_lists_stats *rcv_lists_stats = net->can.rcv_lists_stats;
>  	struct can_dev_rcv_lists *dev_rcv_lists;
>  
> -	if (dev && dev->type != ARPHRD_CAN)
> +	if (dev && !can_get_ml_priv(dev))
>  		return;

[Severity: Low]
The commit message describes this change as replacing "unreliable" checks
with "robust" ones. Should it also say that the change closes a NULL
pointer dereference that a user can trigger?

Before this patch, the sequence looks like this:

  ioctl(TUNSETLINK, ARPHRD_CAN) on a down tun device
    tun->dev->type = (int) arg;      /* ml_priv stays NULL */
  isotp_bind()
    old dev->type != ARPHRD_CAN check passes
    can_rx_register() returns -ENODEV, return value ignored
    so->bound = 1; so->dev = dev;
  isotp_release() or isotp_notify()
    can_rx_unregister(net, so->dev, ...)
      old dev->type != ARPHRD_CAN guard passes
      can_dev_rcv_lists_find()
        can_ml = can_get_ml_priv(dev);   /* NULL */
        return &can_ml->dev_rcv_lists;
      hlist_for_each_entry_rcu() walks the near-NULL pointer

dev_rcv_lists sits at offset 0 of struct can_ml_priv, so the returned
pointer is near-NULL and the list walk oopses.

Triggering this only requires owning a tun device, or CAP_NET_ADMIN inside
an unprivileged user namespace.

The patch carries a Cc: stable tag. Could the message name the oops in
can_rx_unregister() (reached through isotp_release() or isotp_notify()) and
the privilege needed to trigger it?

[ ... ]

> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index f5dc9d04bd686..6c28802c0605f 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c

[ ... ]

> @@ -1610,7 +1611,7 @@ static int isotp_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int l
>  		err = -ENODEV;
>  		goto out;
>  	}
> -	if (dev->type != ARPHRD_CAN) {
> +	if (!can_get_ml_priv(dev)) {
>  		err = -ENODEV;
>  		goto out_put_dev;
>  	}

[Severity: Medium]
This is a pre-existing issue, not one introduced by this patch. Further
down, isotp_bind() still ignores the return values of both
can_rx_register() calls:

	if (isotp_register_rxid(so))
		can_rx_register(net, dev, rx_id, SINGLE_MASK(rx_id),
				isotp_rcv, sk, ...);
	...
	can_rx_register(net, dev, tx_id, SINGLE_MASK(tx_id),
			isotp_rcv_echo, sk, ...);

	/* switch to new settings */
	...
	so->bound = 1;

The can_get_ml_priv() check above now rules out -ENODEV. Using
dev_get_by_index(net, ...) also guarantees the netns matches. That leaves
one possible failure: -ENOMEM from can_rx_register():

	rcv = kmem_cache_alloc(rcv_cache, GFP_KERNEL);
	if (!rcv)
		return -ENOMEM;

If that allocation fails, bind() still returns 0. The socket then never
receives flow control frames, or never receives its own TX echoes.

Transfers would stall until the hrtimers fire. Later, isotp_release() or
isotp_notify() would hit the "receive list entry not found" warning in
can_rx_unregister().

Should isotp_bind() check these return values, and unwind the first
registration if the second one fails?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009134323.64064-2-mkl%40pengutronix.de
