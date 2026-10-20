Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792505827;
	b=3AIBqu0HNM4hmJA+ph674mtX3MKb8vnN7VYC7tWc4RraQ+MvUuISsPMnB3XGV19841HH
	 4DVWsHKtN7OxVXRZTpVlE1p5Xxf5OvUh0GEUMfxt1drbgICVZf2pfFuhP/x9ze0JxZo9Y
	 9gwo7xsaov2iZUKTFkkCSAgJ7R7vYPNzr9YB+k+7T7MaS6BfwZ4hW0kxN0Mtv47e0C1TD
	 9tWqRE/MGtV7CXE3AAyqagdRgObwLqZrnX+yqs3IBPepm3OZJz6DoaFMDeX5eqcrW9L6/
	 A9kQQr+xRG3M6LylJGCUSTmCFKo3gcQ31FT1cUZds8opFAKXudPCwCgwfaK/mPCiErw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505827;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+fP5LZselHKKxJ1B5TkCcTWkgPio9liMTjr8xdAXZcQ=;
	b=JQAr+CGddL24sh6HFRBVd/aYqwoYNK5hJuYJvAgTZlD+aevJu4/sNtYKtfxpK86z8N12
	 zMV4DrGlHjRv1L3Trkk7rDkn13SQMLjSvBLgTlTEMl2FP/aDzDidWykKzYMTqlP5fscTN
	 DA5a/LstMg3j6T2ZwaBdvBG7n8X0VVzHNiW6xxjIq3+bGwMZHAbLbiIySAunKAqpEvgxs
	 iu3TmUFvCHJ4gUwj84YRE+1IEVeXyWsuZk9llsGnKhIebGw53g5v68sK3g2EMOdxN7yFJ
	 0By4EfiJvHL49SpQMhUec5fix6Ab/r/3oD87jOsQY0sHvL/GrxwDs2+HzgCi7tLBWhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wb0k2EXQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8034E606AA13
	for <linux-can@vger.kernel.org>; Tue, 20 Oct 2026 14:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wb0k2EXQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A98701F000C4;
	Tue, 20 Oct 2026 14:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792505826;
	bh=+fP5LZselHKKxJ1B5TkCcTWkgPio9liMTjr8xdAXZcQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Wb0k2EXQzlJWOL2bskrPViYy5sjQegebTOYpp3eS/eRax9ov9jAm8CPEp+uM8vL0E
	 4UpZGbrLG3RXY6dPPoejX1uTxU3hHzCzCvfxZWULXWhv+KL5oGG5fLVO+8ZWCZrHRj
	 LeRkNN/G+SyJLVaOLZK0gwHWqGUeg2j3F/rLLBMmrE1MV0oHdOFIejas9CnBMIHHfB
	 +8hgao2iU5LiCTNSBeyrHz48EJru3P7S5xMidUJacl2Q8wnS7baNND9VstdRfi/1wC
	 FwOVMgNg4PUcUcvRft1T2W2e9HiC83PKV+WTRmhRAG+pJGncc1EDLfsCpwDJuPtjGO
	 9fF1/h16RkLUg==
Message-ID: <sashiko-outbox-179109@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 06/10] can: peak_usb: harden channel handling in
 PCAN-USB FD
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?U3TDqXBoYW5lIEdyb3NqZWFu?= <s.grosjean@peak-system.fr>
Cc: linux-can@vger.kernel.org, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20261020-canfd_check_channel_idx-v5-6-a62b35b867f0@peak-system.fr>
References: <20261020-canfd_check_channel_idx-v5-0-a62b35b867f0@peak-system.fr>
 <20261020-canfd_check_channel_idx-v5-6-a62b35b867f0@peak-system.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 14:17:05 +0000
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] can: peak_usb: race and livelock between peak_usb_ndo_open() and p=
eak_usb_stop_rx()
--

commit a785087e84d7ed9d274560d9a3d814cad1b1ffde
Author: St=C3=A9phane Grosjean <s.grosjean@peak-system.fr>

can: peak_usb: harden channel handling in PCAN-USB FD

This patch validates the CAN channel number reported in PCAN-USB FD
firmware messages against the adapter's controller count and checks for
NULL device slots. It also stops RX URBs on sibling channels when probe
fails or during disconnect before freeing or unregistering devices.

> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/c=
an/usb/peak_usb/pcan_usb_core.c
> index a1b17e1e6fea6..4c08656e77681 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
> @@ -574,6 +574,9 @@ static int peak_usb_ndo_open(struct net_device *netde=
v)
>  	struct peak_usb_device *dev =3D netdev_priv(netdev);
>  	int err;
> =20
> +	if (!test_bit(PCAN_USB_STATE_CONNECTED, &dev->state))
> +		return -ENODEV;
> +
>  	/* common open */
>  	err =3D open_candev(netdev);
>  	if (err)
> @@ -904,6 +907,22 @@ int pcan_get_ts_info(struct net_device *dev, struct =
kernel_ethtool_ts_info *info
>  	return 0;
>  }
> =20
> +/*
> + * stop RX on dev and on all its previous siblings: clearing CONNECTED m=
akes
> + * peak_usb_ndo_open() fail, then poisoning the RX anchors waits for run=
ning
> + * completion handlers and makes any later submission on them fail.
> + */
> +static void peak_usb_stop_rx(struct peak_usb_device *dev)
> +{
> +	struct peak_usb_device *d;
> +
> +	for (d =3D dev; d; d =3D d->prev_siblings)
> +		clear_bit(PCAN_USB_STATE_CONNECTED, &d->state);
> +
> +	for (d =3D dev; d; d =3D d->prev_siblings)
> +		usb_poison_anchored_urbs(&d->rx_submitted);
> +}

[Severity: High]
Can peak_usb_stop_rx() race with a concurrent peak_usb_ndo_open() and
trigger a livelock in usb_poison_anchored_urbs() or leave the device open
with all RX URBs killed?

peak_usb_ndo_open() runs under rtnl_lock, whereas peak_usb_stop_rx() is
called from peak_usb_disconnect() and the peak_usb_create_dev() error path
without holding rtnl_lock. If peak_usb_ndo_open() passes the
PCAN_USB_STATE_CONNECTED check before peak_usb_stop_rx() clears the bit,
peak_usb_ndo_open() proceeds into peak_usb_start():

drivers/net/can/usb/peak_usb/pcan_usb_core.c:peak_usb_start() {
    ...
		usb_anchor_urb(urb, &dev->rx_submitted);

		err =3D usb_submit_urb(urb, GFP_KERNEL);
		if (err) {
			if (err =3D=3D -ENODEV)
				netif_device_detach(dev->netdev);

			usb_unanchor_urb(urb);
			usb_free_urb(urb);
			break;
		}
    ...
}

In peak_usb_start(), each newly allocated RX URB is anchored to
dev->rx_submitted before usb_submit_urb() is called (and remains anchored
with use_count =3D=3D 0 until usb_unanchor_urb() if submission fails). If
peak_usb_stop_rx() calls usb_poison_anchored_urbs(&d->rx_submitted) during
that window:

drivers/usb/core/urb.c:usb_poison_anchored_urbs() {
	do {
		spin_lock_irq(&anchor->lock);
		anchor->poisoned =3D 1;
		while (!list_empty(&anchor->urb_list)) {
			victim =3D list_entry(anchor->urb_list.prev,
					    struct urb, anchor_list);
			/* make sure the URB isn't freed before we kill it */
			usb_get_urb(victim);
			spin_unlock_irq(&anchor->lock);
			/* this will unanchor the URB */
			usb_poison_urb(victim);
			usb_put_urb(victim);
			spin_lock_irq(&anchor->lock);
		}
		surely_empty =3D usb_anchor_check_wakeup(anchor);

		spin_unlock_irq(&anchor->lock);
		cpu_relax();
	} while (!surely_empty);
}

Because the unsubmitted URB has urb->ep =3D=3D NULL and urb->use_count =3D=
=3D 0,
usb_poison_urb() returns immediately without sleeping or unanchoring it, so
usb_poison_anchored_urbs() spins in the inner while loop without yielding.
If peak_usb_stop_rx() preempted peak_usb_start() on the same CPU, could
this cause a soft lockup?

Also, if peak_usb_start() submits at least one RX URB (i >=3D 1) before
peak_usb_stop_rx() poisons dev->rx_submitted, usb_poison_anchored_urbs()
kills the already-submitted URB(s) and causes the next usb_submit_urb() to
fail with -EPERM. Since peak_usb_start() only treats RX submission failure
as fatal when i =3D=3D 0:

drivers/net/can/usb/peak_usb/pcan_usb_core.c:peak_usb_start() {
    ...
	if (i < PCAN_USB_MAX_RX_URBS) {
		if (i =3D=3D 0) {
			netdev_err(netdev, "couldn't setup any rx URB\n");
			return err;
		}

		netdev_warn(netdev, "rx performance may be slow\n");
	}
    ...
}

and pcan_usb_fd_send_cmd() returns 0 once PCAN_USB_STATE_CONNECTED is
cleared, wouldn't peak_usb_ndo_open() succeed with all RX URBs killed after
teardown has begun?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020-canfd_chec=
k_channel_idx-v5-0-a62b35b867f0@peak-system.fr?part=3D6
