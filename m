Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795684292;
	b=s+ZC0/TpVwBUOJPDramDBR2l1BFzPhEwL3BqWbxj4xSbBHA6Nb2sl4A9u5QIGm7AwBw4
	 C79AB20Ec9qNqkiiRWITeo91km3O9G8Eaa5WnDjoFkdr4qTkQKQqgqn8kM2Qt5P7jxowd
	 j5Sh2H280YFucAVCM6J3txy4qsK2nrF+oAA2Jy40kmGSznGFArVzJW07UUwI4pfy7pK5J
	 JkyGLsZZrwcHXhg9FBJdiOUyseWazY8uguxO2HrAD3VFoSobMx3IXnDwj+ougeFYSeOFs
	 yrQI25kLE/iODFwXCoIe85eM2X5o826le1A73feP2PbDIO8uK6sZ8um6DunfgM3vGsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795684292;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gg7sfasjeqE7ld76WQFriJRB2J02JE4QUcg/Bkr8ZlU=;
	b=5ruLJKhwe2zwk7lKPKKQd/MCJZyXLnsCHIrFfi/ohrdMjZUKrnHMSBxVtsvItoSkQM0V
	 St55m9cE/Cbq/IU9kCieg4OewpSZ1J92coa9GGKgY8N6H4OCm4LTF6s5HbcVVWNlFvkxm
	 pvIZjYsvuP9/k9LrWQUQaBe2j/ge4RIieGTbc/yRhM6Ky+hoq53oIn9MQMSiCD70fjTpE
	 rl0F/9IHfOSNKoWFwvP3A3bgzEynSA4YKNoQsRsjf11jC/tGHru+7eImdxPGBUqAcDcBx
	 rIk2H+x3riocvalnBpiESpOxU1FYRNYIwfEfbyoF7NoC+KnvqyBnbH6EPgmHh0d8Wuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tp5XJzUz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FCE606A31C
	for <linux-can@vger.kernel.org>; Thu, 26 Nov 2026 09:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tp5XJzUz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 375051F000CA;
	Thu, 26 Nov 2026 09:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795684291;
	bh=gg7sfasjeqE7ld76WQFriJRB2J02JE4QUcg/Bkr8ZlU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Tp5XJzUzp4UegQhUB4kXmFondQVdPL2lxf6NcU2xz8E8rVdMC3UCTn7GczGau8NV3
	 d2/XlIStTnesGQqebGI0NS8MsKG25Je6Rv2lCqA/TtbX/oex/GB5dcfvoBYWgrvlUs
	 XwzEORYrejtjZL2TXxky6vrGqF1TSPBgQqkkvYomeKRAah/tSeURK+z86586PsjgcV
	 H/cNpzUZFiPgCBDHB8Tlh3MHXL8vkdT4zEeXYQteRVP1KtyNVvlyz6EKgU31RwsSue
	 lIcGTUVUwm82ud3fvSIUFvWaKWWbqERVXynDDO9Y6h6wGSKQBbtGGp3AyjqDp/kQS+
	 Q/cbwEGtxMc0Q==
Message-ID: <sashiko-outbox-235102@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 07/14] can: peak_usb: register the netdevs only once
 all channels are set up
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?U3TDqXBoYW5lIEdyb3NqZWFu?= <s.grosjean@peak-system.fr>
Cc: linux-can@vger.kernel.org, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20261126-canfd_check_channel_idx-v9-7-abe0099b4585@peak-system.fr>
References: <20261126-canfd_check_channel_idx-v9-0-abe0099b4585@peak-system.fr>
 <20261126-canfd_check_channel_idx-v9-7-abe0099b4585@peak-system.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 09:11:30 +0000
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] can: peak_usb: probe command helpers log via netdev_err() before
  registration
--

commit dabb2fbe077091ab1e816680a5ac7e4a6fe596f6
Author: St=C3=A9phane Grosjean <s.grosjean@peak-system.fr>

can: peak_usb: register the netdevs only once all channels are set up

This commit defers registering the CAN netdevs until all channels of an
interface have been initialized in peak_usb_probe(), and tracks registered
channels with PCAN_USB_STATE_REGISTERED for cleanup in
peak_usb_disconnect().

> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/us=
b/peak_usb/pcan_usb.c
> index 90f69afcba974..451d084215049 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
> @@ -390,9 +390,12 @@ static int pcan_usb_get_can_channel_id(struct peak_u=
sb_device *dev, u32 *can_ch_
>  	int err;
> =20
>  	err =3D pcan_usb_wait_rsp(dev, PCAN_USB_CMD_DEVID, PCAN_USB_GET, args);
> +	/* explicit use of dev_xxx() instead of netdev_xxx() here: this is
> +	 * also called during probe, before the netdev is registered.
> +	 */
>  	if (err)
> -		netdev_err(dev->netdev, "getting can channel id failure: %d\n", err);
> -
> +		dev_err(dev->netdev->dev.parent,
> +			"getting can channel id failure: %d\n", err);
>  	else
>  		*can_ch_id =3D args[0];
> =20

[Severity: Low]
Should the command helpers called during probe before register_candev()
also use dev_err() instead of netdev_err()?

pcan_usb_get_can_channel_id(), dev_init(), and dev_set_bus() call helpers
such as pcan_usb_wait_rsp(), pcan_usb_send_cmd(), pcan_usb_pro_send_cmd(),
pcan_usb_pro_wait_rsp(), pcan_usb_pro_send_req(), and
pcan_usb_fd_send_cmd(), which still log errors via netdev_err(dev->netdev,
...) on an unregistered net_device during peak_usb_create_dev().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126-canfd_chec=
k_channel_idx-v9-0-abe0099b4585@peak-system.fr?part=3D7
