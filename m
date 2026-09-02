Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911F147209B
	for <linux-can@vger.kernel.org>; Wed,  2 Sep 2026 11:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788348381; cv=none; b=Krztw8jClwTi8qFt4+uf5NN5WnknQcaQVYPafM6Cj1IskmVRVSjHlTLE02pie0aus3kqHB8M4DjG8nldiu+YhkvIAHM67YFsFmxoQmSfM8Q7oWk5Gpn8RsomCAqUxdzqoXwB4EI7yQdJ8ZUrEEGlP46z125YffQeCANQqe/UB/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788348381; c=relaxed/simple;
	bh=UFlhj7iuNS/GLZWF/rhJ7yMeTKEmQsqqawm39iWWPNA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dK0M7VGdRftTCOZqNZcNLrWOnqsa4vcAisrDqMK4qAXnK3XDYeAPKYNx483X0P5pa7628mANSPFaYUDDiFL/5xWchb3OaIM8GXjmV9rAU01Dc1jp44/DP9g0Rwq00JawViyYon2FQRSBdp9wBpr0SKbh1Qg0B5Ghd0xWIUx4JcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S7N/qceB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S7N/qceB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC79D1F000E9;
	Wed,  2 Sep 2026 11:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788348380;
	bh=a+3ZOCwOkYbZKYFPcxG379UehzBGo58/cn4/B7MVF6M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S7N/qceBfxqUbSlaYpfG4AjQ8zsK37SoyZHL9LbJ2ki6I/7JrsXN7A9zQlXsWTFiL
	 zT19jnAXJtYc9Fa2kFre65E/2QdnFdWo5Ezpi0OsO0U/6JhQgLuo4FsqYfbQtQ98Tr
	 smzx0ZqhmL3bnyiQe+olGPAnTffEDzHzNu7M/q5jR13JKJ2XjcMJrEdfVYwkf3TbEe
	 l+4TbReNM6QJHyh0z9JPWE0XrvER71WrEiMcTRtZW8EC/WF7bxqh9Odavn/K7mo4tP
	 WhWsjlpnDP56Od+OfahYtIsRZbSboo2fWmBD26rCs3ANbfsWPnXA/jVIJimhB8NzNZ
	 AN3CjEA1R0Fuw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] can: kvaser_usb: fix potential crash in probe
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anton Olsson" <anol@kvaser.com>
Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>
In-Reply-To: <20260902110611.2426535-1-anol@kvaser.com>
References: <20260902110611.2426535-1-anol@kvaser.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 11:26:19 +0000
Message-Id: <20260902112619.CC79D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Divide by Zero / Denial of Service in TX acknowledge handler.
- [High] Information leak of uninitialized kernel heap memory to USB device.
--

commit 75516ad10c900aec22101c30d8bc4a80c7eebdbf
Author: Anton Olsson <anol@kvaser.com>
Subject: can: kvaser_usb: fix potential crash in probe

The leaf driver does not return any errors when no clock configuration can
be found, instead emitting a null-check warning. This patch adds default
cases to return -ENODEV when no matching configuration is found.

Link: https://lore.kernel.org/linux-can/20260828-sassy-ammonite-of-focus-b2=
f17c-mkl@pengutronix.de/T/#t

> diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/n=
et/can/usb/kvaser_usb/kvaser_usb_leaf.c
> index a876c7819b81c..2091de2e4f8fc 100644
> --- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
> +++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
> @@ -747,8 +747,8 @@ static int kvaser_usb_leaf_send_simple_cmd(const stru=
ct kvaser_usb *dev,
>  	return rc;
>  }
> =20
> -static void kvaser_usb_leaf_get_software_info_leaf(struct kvaser_usb *de=
v,
> -						   const struct leaf_cmd_softinfo *softinfo)
> +static int kvaser_usb_leaf_get_software_info_leaf(struct kvaser_usb *dev,
> +						  const struct leaf_cmd_softinfo *softinfo)
>  {
>  	u32 fw_version;
>  	u32 sw_options =3D le32_to_cpu(softinfo->sw_options);

[Severity: Critical]
This is a pre-existing issue, but further down in this function,
softinfo->max_outstanding_tx is read from the device and stored without
validation:

	dev->max_tx_urbs =3D le16_to_cpu(softinfo->max_outstanding_tx);

If a malicious USB device reports 0 during initialization, could this trigg=
er
a kernel panic due to a divide-by-zero when the USB device later sends a TX
acknowledge packet? For instance, in kvaser_usb_leaf_tx_acknowledge():

	context =3D &priv->tx_contexts[tid % dev->max_tx_urbs];

The Hydra device family seems to be subject to the exact same vulnerability
in kvaser_usb_hydra_tx_acknowledge() via transid % dev->max_tx_urbs.

Should we validate that dev->max_tx_urbs is greater than 0 before continuin=
g?

[ ... ]

[Severity: High]
This is a pre-existing issue, but I noticed another potential problem in
kvaser_usb_leaf_frame_to_cmd() where a command structure is allocated using
kmalloc_obj() without zeroing the memory:

drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c:kvaser_usb_leaf_frame_to_c=
md() {
	...
	cmd =3D kmalloc_obj(*cmd, GFP_ATOMIC);
	if (cmd) {
	...
}

For standard CAN frames, the driver initializes data[0] and data[1], but
appears to leave data[2..4] uninitialized:

		} else {
			cmd->id =3D CMD_TX_STD_MESSAGE;
			cmd->u.tx_can.data[0] =3D (cf->can_id >> 6) & 0x1f;
			cmd->u.tx_can.data[1] =3D cf->can_id & 0x3f;
		}

Additionally, if cf->len is less than 8, the remainder of the 14-byte data
array up to data[13] seems to remain uninitialized:

		cmd->u.tx_can.data[5] =3D can_get_cc_dlc(cf, priv->can.ctrlmode);
		memcpy(&cmd->u.tx_can.data[6], cf->data, cf->len);

Since the entire structure is then transmitted over the USB bus, can this
leak uninitialized kernel heap memory to an attached USB device?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902110611.2426=
535-1-anol@kvaser.com?part=3D1
