Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493785;
	b=BK845D0Un1Zcfu4ldSFYIGyIDzG8SkW5rhlLR0RbUmzjBY5lNcarp1mSNYif1o+mNsd2
	 TmlmEz1sxVwrhfX/J/kZ5zLkISMOujwvdQhdprIA+WEfXEwwU6bgIOIZc1ELs3/Dy2lYu
	 EX8jy86Ok1bz2CzdmCyK4Y6DZjxJxFU7Ve9yMwkJV3YlfHunMjpRajwwy8ap4LiOC1oZ4
	 IJX/IUewhVBRVBNV754y/BiR7sgUr3BdsyiHPgV82I4iGuU/viB+8si6lnfNmjgEjbwa2
	 01pUkTV6If5KMFfOUazxy4OIaZ5xW9M7Xcc4VPxEGIvA86NErOZRTO4DTITIK7LbKiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493785;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=J4Jteh1xfUqK7+IXf/8IBoxPvjANmLz8jpU/E+Z2jvo=;
	b=YUTeWGmccjLBZfeowuZ0crYdJNQ9p4OuFbgxRmSr/o9QLDQiOfkcz1HoEqmf72ra4Off
	 bn/A3qV7lBEk4b7oatWpaLDcFRvslZ0lX99662Vt6jBDJhb5GKR/85RWAtFogR114cu3N
	 9mZ79+95RzRJfs/fLl+HScP4lb0W9uPj3G82M+XOKeegwssSLecpTF55txYkITVwiqxBg
	 SNlgGDeT2PBWqFnXXHF91C8B5y737p79ZiYUMf8tgMza5c36ad873z0Rog5Ef+LRUeUBM
	 UoUNqLT5oeGCyzQIaZa0X19cS+pnRQIsEQERiHIUaH61L+3E6PFuYNpKiaviAmFJRXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JifkzUIG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A7E606A31A
	for <linux-can@vger.kernel.org>; Tue, 20 Oct 2026 10:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JifkzUIG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 231C51F000C4;
	Tue, 20 Oct 2026 10:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792493785;
	bh=J4Jteh1xfUqK7+IXf/8IBoxPvjANmLz8jpU/E+Z2jvo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JifkzUIGZxnAf8fA2FrAsvHNZAXNN4l6EATd0tXT/elm/OZF2V5xdWm3KYObNfJIV
	 IIjrIp7fCZHTaOMHBIwEz+wJt3bITSTJoHY+Z3L51ygKLmocrLM9J+z7cnDnmRtLX3
	 0iZmkjtFCDW5hR23avxBuLcCJVWyKySy7VA3gA8hO1/SvqHUrpLP/CcNzEo5/QF5M2
	 Bvoh22GvLSYPf2Q2Znr0EUm1P6BlLOKo6lsZKIc2Zg1KJCIHpCaYr1Ub5JU7D2d/ZE
	 +DdwwYrs/Ffpf6LkrBBfHW8QIkp7bobwjZMcxryEJJBlXBNl7EMQrExLRYsrCmI97k
	 gDiitd/zrMQiQ==
Message-ID: <sashiko-outbox-178865@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 09/10] can: peak_usb: register the netdev only once
 the channel is set up
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?U3TDqXBoYW5lIEdyb3NqZWFu?= <stephane.grosjean@free.fr>
Cc: linux-can@vger.kernel.org, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20261020-canfd_check_channel_idx-v4-9-bfbde81f8bab@peak-system.fr>
References: <20261020-canfd_check_channel_idx-v4-0-bfbde81f8bab@peak-system.fr>
 <20261020-canfd_check_channel_idx-v4-9-bfbde81f8bab@peak-system.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 10:56:24 +0000
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] can: peak_usb: race on shared cmd_buffer_addr and fw_info in pea=
k_usb_create_dev()
- [Medium] can: peak_usb: pcan_usb_fd_init() copies mutable ctrlmode from r=
egistered sibling
--

commit 3972b9e3eaed319bc2c27f112d5201b474f8cd40
Author: St=C3=A9phane Grosjean <s.grosjean@peak-system.fr>

can: peak_usb: register the netdev only once the channel is set up

This commit moves register_candev() to the end of peak_usb_create_dev() so
that a CAN channel's netdev cannot be opened or configured by userspace
before dev_init(), dev_set_bus(), and dev_get_can_channel_id() have
completed.

> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/c=
an/usb/peak_usb/pcan_usb_core.c
> index 4c08656e77681..ccfc26d3e5a6b 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
> @@ -998,15 +998,6 @@ static int peak_usb_create_dev(const struct peak_usb=
_adapter *peak_usb_adapter,
>  	SET_NETDEV_DEV(netdev, &intf->dev);
>  	netdev->dev_id =3D ctrl_idx;
> =20
> -	err =3D register_candev(netdev);
> -	if (err) {
> -		dev_err(&intf->dev, "couldn't register CAN device: %d\n", err);
> -		goto lbl_restore_intf_data;
> -	}
> -
> -	if (dev->prev_siblings)
> -		(dev->prev_siblings)->next_siblings =3D dev;
> -
>  	/* keep hw revision into the netdevice */
>  	tmp16 =3D le16_to_cpu(usb_dev->descriptor.bcdDevice);
>  	dev->device_rev =3D tmp16 >> 8;
> @@ -1014,7 +1005,7 @@ static int peak_usb_create_dev(const struct peak_us=
b_adapter *peak_usb_adapter,
>  	if (dev->adapter->dev_init) {
>  		err =3D dev->adapter->dev_init(dev);
>  		if (err)
> -			goto lbl_unregister_candev;
> +			goto lbl_restore_intf_data;
>  	}
> =20
>  	/* set bus off */
> @@ -1027,6 +1018,18 @@ static int peak_usb_create_dev(const struct peak_u=
sb_adapter *peak_usb_adapter,
>  	/* get CAN channel id early */
>  	dev->adapter->dev_get_can_channel_id(dev, &dev->can_channel_id);
> =20
> +	/* register the netdev only once the channel is fully set up, so that
> +	 * it can't be opened or configured while being initialized.
> +	 */
> +	err =3D register_candev(netdev);
> +	if (err) {
> +		dev_err(&intf->dev, "couldn't register CAN device: %d\n", err);
> +		goto adap_dev_free;
> +	}

[Severity: Medium]
On multi-channel PCAN-USB FD adapters (such as PCAN-USB Pro FD and
PCAN-USB X6), can registering channel 0 here still leave a race on the
shared command buffer and fw_info while subsequent channels are being
initialized?

In peak_usb_probe(), peak_usb_create_dev() is called in a loop over
ctrl_count without holding rtnl_lock():

drivers/net/can/usb/peak_usb/pcan_usb_core.c:peak_usb_probe() {
	for (i =3D 0; i < peak_usb_adapter->ctrl_count; i++) {
		err =3D peak_usb_create_dev(peak_usb_adapter, intf, i);
		...
	}
}

Once iteration 0 calls register_candev(), channel 0 is visible to
userspace (for example udev or systemd-networkd) and its netdev or
ethtool callbacks can run under rtnl_lock() while peak_usb_create_dev()
is initializing channel 1 outside of rtnl_lock().

During channel 1 setup, pcan_usb_fd_init() attaches to channel 0's
usb_if and cmd_buffer_addr:

drivers/net/can/usb/peak_usb/pcan_usb_fd.c:pcan_usb_fd_init() {
	...
	} else {
		/* otherwise, simply copy previous sibling's values */
		struct pcan_usb_fd_device *ppdev =3D
			container_of(dev->prev_siblings,
				     struct pcan_usb_fd_device, dev);

		pdev->usb_if =3D ppdev->usb_if;
		pdev->cmd_buffer_addr =3D ppdev->cmd_buffer_addr;
	...
	pcan_usb_fd_set_clock_domain(dev, i);

	/* set LED in default state (end of init phase) */
	pcan_usb_fd_set_can_led(dev, PCAN_UFD_LED_DEF);
}

Channel 1 then uses that shared cmd_buffer_addr in
pcan_usb_fd_set_clock_domain(), pcan_usb_fd_set_can_led(), and
pcan_usb_fd_set_bus(), which can concurrently overwrite commands built by
channel 0's open, bittiming, or ethtool callbacks.

In addition, peak_usb_create_dev() for channel 1 calls
pcan_usb_fd_get_can_channel_id():

drivers/net/can/usb/peak_usb/pcan_usb_fd.c:pcan_usb_fd_get_can_channel_id()=
 {
	int err;
	struct pcan_usb_fd_if *usb_if =3D pcan_usb_fd_dev_if(dev);

	err =3D pcan_usb_fd_read_fwinfo(dev, &usb_if->fw_info);
	if (err)
		return err;
	...
}

pcan_usb_fd_read_fwinfo() calls pcan_usb_pro_send_req(), which zeroes the
shared usb_if->fw_info buffer with memset() before usb_control_msg(),
transiently clearing fw_info.cmd_out_ep to 0 while channel 0 may be
sending commands via pcan_usb_fd_send_cmd() or
pcan_usb_fd_restart_async().


[Severity: Medium]
Also on multi-channel PCAN-USB FD adapters, could channel 1 end up
copying runtime-modified ctrlmode flags from channel 0 during probe?

In pcan_usb_fd_init(), secondary channels copy dev.can.ctrlmode from
their previous sibling:

drivers/net/can/usb/peak_usb/pcan_usb_fd.c:pcan_usb_fd_init() {
	...
	} else {
		...
		/* do a copy of the ctrlmode[_supported] too */
		dev->can.ctrlmode =3D ppdev->dev.can.ctrlmode;
		dev->can.ctrlmode_supported =3D ppdev->dev.can.ctrlmode_supported;
	}
}

Because channel 0 is now registered via register_candev() before
pcan_usb_fd_init() runs for channel 1, userspace can configure channel 0
via can_changelink() -> can_ctrlmode_changelink() and set flags such as
CAN_CTRLMODE_FD, CAN_CTRLMODE_LISTENONLY, or CAN_CTRLMODE_ONE_SHOT in
ppdev->dev.can.ctrlmode before channel 1 copies it. Channel 1 would then
inherit those runtime flags (for example having CAN_CTRLMODE_FD set in
dev->can.ctrlmode while its netdev->mtu is still CAN_MTU) before being
registered.

[ ... ]

>  	netdev_info(netdev, "attached to %s channel %u (device 0x%08X)\n",
>  		    peak_usb_adapter->name, ctrl_idx, dev->can_channel_id);

[ ... ]

>
endasi

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020-canfd_chec=
k_channel_idx-v4-0-bfbde81f8bab@peak-system.fr?part=3D9
