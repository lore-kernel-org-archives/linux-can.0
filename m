Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7F82E62B7;
	Fri, 16 Oct 2026 02:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792118224; cv=none; b=F1gOm+vRDuuYWRFXHQ8tFr9whu5kqaVZzeIcQER3fI9taWIHW6UMEwn2tSm2FmEHxjR4wrwTnQq4htTGAnqmPbqCvsvSZestZpL6w4vFrXH5n2BQr57Z4+PH5Cx/oVzNK2JjWWGIu4kIcIDmOdBu1Lhq/RTqflAO/ZwDT03tOdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792118224; c=relaxed/simple;
	bh=JDB1oUU5OYZaYQslaG4fCmkP0uPRt0UTEkdyVnVes+g=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sdy4E6pyhAJBBeyNSuKvyuTOdFXnEHqraiRqRrlZwsSWeTZYzUcNY9HvdnsFtv9MSGrjKgldAqOocdcoqZwGOIenMuCJ72wbusZTSO/Ntye4PtQloXZ3We4wEG156cMdYZ+dfJKMfCCyP8D5Z7XTYjARX3WF9XHfqmAQeg4OOn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wni/1fiK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wni/1fiK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1D1F1F000C4;
	Fri, 16 Oct 2026 02:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792118223;
	bh=hkraSBayj39YDT7jsKqIPrmfUyXqKkJ0nVZCMzuzfts=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Wni/1fiKu3EWKjZqoSyDGMfh0OFkIiLyNd6u5X3LpbKFIs9et1KGjlf9eJ0eVA5VT
	 3WcRwS+5aSxcdwgGbWpzzmSZGCDdk3o4Vbz91V9UloZpO9YH13/bpOMOlr2mrteG7+
	 Fz7ykgcBQzZM2kVmQMi/NiLjhBu7e/QHoHZj9MXopdld6fB1Y5cYkc2o1dSKq2iKtt
	 ko5UeNJkXmlqXilbkXAj2qOeJjhmcjghRlhX7jw06cAQ0+sRHvM21oDMz81VXvcG+0
	 B/0wXLCuqMk+4cQXrkxzwPp6a5rOFdQ2Y0SbZIYqmyFlRvE7Pby2tnsmbJ+rtBzFV8
	 QeoQs5N9fWZYQ==
Subject: Re: [PATCH net-next 03/37] can: replace ARPHRD_CAN type checks with
 can_get_ml_priv()
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, socketcan@hartkopp.net,
 kurt.van.dijck@eia.be
Date: Fri, 16 Oct 2026 02:37:02 +0000
Message-ID: <179211822219.434549.7841003426566715206@kernel.org>
In-Reply-To: <20261015015336.816543-4-mkl@pengutronix.de>
References: <20261015015336.816543-4-mkl@pengutronix.de>
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

- [Low] The commit message is partly wrong about where the crash happens.

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but isotp_bind()
  (net/can/isotp.c) throws away the return value of both…

--

can: replace ARPHRD_CAN type checks with can_get_ml_priv()

This patch replaces the remaining dev->type == ARPHRD_CAN checks in
af_can, bcm, gw, isotp and raw with can_get_ml_priv(). The goal is to
keep TUN/TAP devices that were retyped to ARPHRD_CAN via TUNSETLINK away
from CAN code that dereferences a NULL dev->ml_priv.

Link: https://patch.msgid.link/20261012164802.94113-1-socketcan@hartkopp.net

> The TUNSETLINK ioctl allows a down TUN/TAP device to set its hardware
> type to ARPHRD_CAN while dev->ml_priv remains NULL. Such a repurposed
> netdevice passes the ARPHRD_CAN checks and triggers a NULL pointer
> dereference when CAN filters are created and when they are removed,
> e.g. by the CAN protocols' netdevice notifier handlers.

[Severity: Low]
Is the "when CAN filters are created" part accurate for this tree?

Before this patch, can_rx_register() already rejected such a device:

net/can/af_can.c:can_rx_register() {
    ...
	if (dev && (dev->type != ARPHRD_CAN || !can_get_ml_priv(dev)))
		return -ENODEV;
    ...
}

can_rcv(), canfd_rcv() and canxl_rcv() also already tested
!can_get_ml_priv(dev). That makes those four af_can.c hunks look like
simplifications that don't change behavior. This holds for kernels
that already carry commit 8aa59e3559494.

The only unguarded path seems to be can_rx_unregister(). It checked only
dev->type and then went on to:

net/can/af_can.c:can_dev_rcv_lists_find() {
	if (dev) {
		struct can_ml_priv *can_ml = can_get_ml_priv(dev);
		return &can_ml->dev_rcv_lists;
    ...
}

The trigger that can actually be reached appears to be isotp.
isotp_bind() checked only ARPHRD_CAN and ignored the -ENODEV from both
can_rx_register() calls. It then set so->bound = 1 and set so->dev to
the TUN device. A later teardown then crashed:

isotp_release() / isotp_notify(NETDEV_UNREGISTER)
  can_rx_unregister()
    can_dev_rcv_lists_find()
      &can_ml->dev_rcv_lists   <- can_ml == NULL

raw, bcm and gw check the can_rx_register() return value and never
record the device, so they don't seem to be able to reach this path.

Could the commit message name the removal path (can_rx_unregister()
reached via isotp_bind()) as the actual crash site, and say that the
other af_can.c hunks are cleanups?

The code change itself looks complete. No ARPHRD_CAN checks remain in
net/can/ after this patch.

> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index f5dc9d04bd68..6c28802c0605 100644
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
This issue was not introduced by this patch. Further down in
isotp_bind(), the return values of both can_rx_register() calls are
thrown away, and the socket is marked bound anyway:

	if (isotp_register_rxid(so))
		can_rx_register(net, dev, rx_id, SINGLE_MASK(rx_id),
				isotp_rcv, sk, "isotp", sk);
	...
	can_rx_register(net, dev, tx_id, SINGLE_MASK(tx_id),
			isotp_rcv_echo, sk, "isotpe", sk);

	/* switch to new settings */
	...
	so->bound = 1;

With this patch the -ENODEV case can no longer happen here, because the
device check now matches the one in can_rx_register(). can_rx_register()
can still return -ENOMEM, though:

net/can/af_can.c:can_rx_register() {
    ...
	rcv = kmem_cache_alloc(rcv_cache, GFP_KERNEL);
	if (!rcv)
		return -ENOMEM;
    ...
}

If that allocation fails, does bind() report success even though the
socket never receives flow control or echo frames? Transfers would then
fail through the FC/echo timeouts. On release or NETDEV_UNREGISTER,
can_rx_unregister() would also print "can: receive list entry not
found".

Should isotp_bind() check these return values and unwind on failure?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015015336.816543-2-mkl%40pengutronix.de
