Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792488409;
	b=L45nB/8jWS0J03/TLGtRJj0X3L36Ehu/nZM3Y8Clj1BFLWGJvAWpCOo6vy7mLyDgBC4s
	 KtjzMbV4/ypOLdbfuoX5RL96ze/1OUxK8RCXbrCs58LL9HTci/YcOHBqbQ87yB8ztEL1O
	 6Uzj4XU6TUvhFGSC8qKlxDLISgmDmIybMCagEu6hmCI/mmiScTLNMthPY4clscmk7liK1
	 yvH2Flzo+N92aKwrC1M3ftxtvXVd/j6Hf6TGhYhPA+7mpfZqN3znUhw0ytvML+bUPf6pZ
	 /Dxrrlgx0c1e+VHqnHmBOHmjtwpJmHkHnhbUTjLlp2Z1LqO6Rh6iO7cdwo9xwXy67yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792488409;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wxnaW3FvgGrsWPezDgBbAsaJGfl4O0r4GtV3EVPiCVg=;
	b=5P9Js7qoGkMz1Fga1rWITUgytFG+VrvUOmbZSzERVObaJcUfFysIzFqe2rrvrlAxnzdu
	 N2PCCfanIApLd7sP2xP1k/CUPi7aOH6jgQuQRPFX35vjATjCePxR4zkPHAdXrSiwT4NPb
	 i8cMr1WswDKNN8chEyrBrASl1gwfW4G1DqwunjOzYdBvVzxfweqFPMxk8YW9M/MVOdVd0
	 wa10cW+KaZxEUfbVJe7QIL7KAqHMBPbY5ABhtHm8Oem5lJ9jfJz9fMa8/N5nS83/5kBos
	 KfAD1y40uaXd5tPUk4+n00hxygUgWknmcRJWoYjGbC/15R6t16OxhMvGmJTYcjEpRAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GjlS0JVv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE29606A319
	for <linux-can@vger.kernel.org>; Tue, 20 Oct 2026 09:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GjlS0JVv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E68C1F000C5;
	Tue, 20 Oct 2026 09:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792488408;
	bh=wxnaW3FvgGrsWPezDgBbAsaJGfl4O0r4GtV3EVPiCVg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GjlS0JVvcbMZFruQyYZGYO0rbHL2ZLPtNwNgRoPJmIhwmjL3FFmadYsj7rv68w6uE
	 BDY0D2HUwOvDtcgM5sEslLEqCw7LWBZiDfTDDsyGfwWeKJtPadVyzYVDkynQCuwRTD
	 omP8vFdgI0d3+7CFgN7yC8q2L9NEnHrr1dMSqxW5+YB5uciIWU6ILoyBjufJW4AW77
	 6mXT7K9LqWIhF8ZiV7GJhZmdpe3e2Rt/Frmk2vYADTJsh2OK+c6lVoT9EzBQP+KvEo
	 2F/7rGwojGr0w2Jok2OBooyXUI4cYTkpXWA17iHkkTnEUdPUiVtxX6Qg5ZNEBcqLUM
	 IbEIyjCENX4Dg==
Message-ID: <sashiko-outbox-178730@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 09/10] can: peak_usb: unregister the netdev before
 dev_free() on probe failure
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?U3TDqXBoYW5lIEdyb3NqZWFu?= <stephane.grosjean@free.fr>
Cc: linux-can@vger.kernel.org, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20261020-canfd_check_channel_idx-v3-9-74d17c5a599e@peak-system.fr>
References: <20261020-canfd_check_channel_idx-v3-0-74d17c5a599e@peak-system.fr>
 <20261020-canfd_check_channel_idx-v3-9-74d17c5a599e@peak-system.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 09:26:47 +0000
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
- [High] can: peak_usb: premature register_candev() in peak_usb_create_dev()
- [High] can: peak_usb: race in peak_usb_create_dev() due to early register=
_candev()
--

commit 6bb32b19acf3e432c5b71035bb9ab5846f5137aa
Author: St=C3=A9phane Grosjean <s.grosjean@peak-system.fr>

can: peak_usb: unregister the netdev before dev_free() on probe failure

This commit moves unregister_candev() before dev->adapter->dev_free() in the
adap_dev_free error path of peak_usb_create_dev() so that closing an already
opened netdev does not access resources freed by dev_free().

> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/c=
an/usb/peak_usb/pcan_usb_core.c
> index 4c08656e77681..981168fead927 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
> @@ -1039,8 +1039,13 @@ static int peak_usb_create_dev(const struct peak_u=
sb_adapter *peak_usb_adapter,
>  	 */
>  	peak_usb_stop_rx(dev->prev_siblings);
> =20
> +	/* as in peak_usb_disconnect(), unregister the netdev before calling
> +	 * dev_free(): closing it may still use what dev_free() releases.
> +	 */
> +	unregister_candev(netdev);
>  	if (dev->adapter->dev_free)
>  		dev->adapter->dev_free(dev);
> +	goto lbl_restore_intf_data;
> =20
>  lbl_unregister_candev:
>  	unregister_candev(netdev);

[Severity: High]
Can a similar use-after-free still occur on the lbl_unregister_candev error
path when dev->adapter->dev_init(dev) fails?

In peak_usb_create_dev(), register_candev(netdev) is called with
PCAN_USB_STATE_CONNECTED already set before dev->adapter->dev_init(dev):

drivers/net/can/usb/peak_usb/pcan_usb_core.c:peak_usb_create_dev() {
	...
	err =3D register_candev(netdev);
	if (err) {
		dev_err(&intf->dev, "couldn't register CAN device: %d\n", err);
		goto lbl_restore_intf_data;
	}
	...
	if (dev->adapter->dev_init) {
		err =3D dev->adapter->dev_init(dev);
		if (err)
			goto lbl_unregister_candev;
	}
}

In pcan_usb_fd_init(), channel 0 allocates pdev->usb_if and
pdev->cmd_buffer_addr and then performs sleeping USB transfers in
pcan_usb_fd_read_fwinfo() and pcan_usb_fd_drv_loaded(). If the netdev is
opened during this window and pcan_usb_fd_drv_loaded() (or
pcan_usb_fd_read_fwinfo()) fails, pcan_usb_fd_init() frees
pdev->cmd_buffer_addr and pdev->usb_if before returning:

drivers/net/can/usb/peak_usb/pcan_usb_fd.c:pcan_usb_fd_init() {
	...
err_out_2:
	kfree(pdev->cmd_buffer_addr);
err_out_1:
	kfree(pdev->usb_if);
err_out:
	return err;
}

peak_usb_create_dev() then jumps to lbl_unregister_candev and calls
unregister_candev(netdev), which invokes peak_usb_ndo_stop() ->
pcan_usb_fd_stop() and pcan_usb_fd_set_bus(dev, 0), accessing the already
freed pdev->usb_if and pdev->cmd_buffer_addr.

[Severity: High]
Because register_candev(netdev) exposes the device before dev_init(),
dev_set_bus(dev, 0), and dev_get_can_channel_id() have completed, what
prevents userspace from opening or configuring the netdev while those
callbacks are still running?

In pcan_usb_pro_init(), usb_if is kept in a local variable across three
sleeping USB control requests before pdev->usb_if is assigned:

drivers/net/can/usb/peak_usb/pcan_usb_pro.c:pcan_usb_pro_init() {
	...
	pdev->usb_if =3D usb_if;
	/* publish dev to the decoders */
	smp_store_release(&usb_if->dev[dev->ctrl_idx], dev);
}

If peak_usb_ndo_open() -> peak_usb_start() -> pcan_usb_pro_start() runs
before pdev->usb_if is set, it dereferences a NULL pdev->usb_if (and
similarly for pdev->cmd_buffer_addr and pdev->usb_if in pcan_usb_fd_start()
or pcan_usb_fd_set_bittiming_slow() before pcan_usb_fd_init() populates
them).

Even after those pointers are assigned, peak_usb_create_dev() calls
dev_init(), dev_set_bus(dev, 0), and dev_get_can_channel_id() outside
rtnl_lock(). Could a concurrent ndo_open or bittiming callback race with
probe on the shared command buffer (pdev->cmd_buffer_addr or dev->cmd_buf),
or could dev_set_bus(dev, 0) in peak_usb_create_dev() switch the controller
back off after peak_usb_ndo_open() has already started it?

Would registering the candev only after hardware initialization and
dev_set_bus(dev, 0) have succeeded avoid all of these races?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020-canfd_chec=
k_channel_idx-v3-0-74d17c5a599e@peak-system.fr?part=3D9
