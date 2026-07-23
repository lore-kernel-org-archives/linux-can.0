Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA073EDE4D
	for <linux-can@vger.kernel.org>; Thu, 23 Jul 2026 07:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784793160; cv=none; b=ScWr/Eo2pSLk/lfCdjsX3izw/kJPPybChf+s3yk3BcBwFsCB57Md7+H7aqxhpNJWkn6ZD1xipYDi1Biul4mIKBBxQsp35KWONaJLemkwWaCxamrtdNXO1vXxYhdL2Rn3Myx1F8YODDikRTernJmDmENvhgpIxGWEuJpwN7AAl8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784793160; c=relaxed/simple;
	bh=x2bieFmkGj2ouGYZNb4fU1D5eQKiXA5vKQBEMHKzalQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=t4W1ADjtCiCBzQKBt7L8I4MH40l3gnVhi0i6kAutOdGp4gqMncJuQHqaR2e/zRQCeJO+ajxtRSl7KfPChxuiIPYaWRdKhQNOi/o0kutHZLfRC1NSYNSPeZsF2WpFN/T/yQB3SrCkakkjdV6mg7JN6KA6rlhISuzl+h/5mQKP0yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=awTkIX2o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="awTkIX2o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 775B51F000E9;
	Thu, 23 Jul 2026 07:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784793158;
	bh=kGs9cAehUGqnf4Elj1GywzCJ7qNPKiqG+s5gdW0IZ68=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=awTkIX2odMN2dK7S2N9+8CKlX5Db7n+qHKlygUycvlzFtGCUYmDAgig/65ErQ9lt3
	 2mUO/WWX2pt/mK8Fevyvd/Mb4YPnC+40fS1MorF6T7WUlXJg6w8xnqmOuNxjPsfV/K
	 Masbg4e5pzpuz73oNFMGnnOzmJIxytlcieU74COIYWLkwjhxFslOOQX0ElbP0wq7Gw
	 pNAj18YVEn1xslEJXm5eai5WFlOfpDpF+T4u6i3ZN+ggSFG488s2pYysBxSE7Ye5qC
	 n+AigYk0oeNfC1lknzrnzFVvBnCQc0QHhN2wgXHj4f9IV2nNX3xY1GGgPFKf76CyOV
	 LDugk7gltKcig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] can: usb: ixxat_usb: add CL2/V2 protocol layer with
 CAN
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?U3TDqXBoYW5lIEdyb3NqZWFu?= <stephane.grosjean@free.fr>
Cc: "Vincent Mailhol" <mailhol@kernel.org>, linux-can@vger.kernel.org, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Oleksij Rempel" <o.rempel@pengutronix.de>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>
In-Reply-To: <20260723072955.32575-4-stephane.grosjean@free.fr>
References: <20260723072955.32575-1-stephane.grosjean@free.fr>
 <20260723072955.32575-4-stephane.grosjean@free.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 07:52:37 +0000
Message-Id: <20260723075238.775B51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The CAN FD Transmitter Delay Compensation offset (tdo) calculati=
on overflows its 16-bit type at low bitrates, leading to silent truncation =
and incorrect hardware configuration.
--

--- Patch [3]: [PATCH 3/4] can: usb: ixxat_usb: add CL2/V2 protocol layer w=
ith CAN ---
commit 41a98ff00a0f9a2ad35a45bd14b45d0c0f12d57f
Author: St=C3=A9phane Grosjean <s.grosjean@peak-system.fr>

can: usb: ixxat_usb: add CL2/V2 protocol layer with CAN

This commit adds the ixxat_usb_cl2.c file to implement the CL2 transfer
protocol used by IXXAT USB-to-CAN V2 and CAN FD adapters. It exports
descriptors and initialization routines for standard and CAN FD bittiming
configurations.

> diff --git a/drivers/net/can/usb/ixxat_usb/ixxat_usb_cl2.c b/drivers/net/=
can/usb/ixxat_usb/ixxat_usb_cl2.c
> new file mode 100644
> index 0000000000000..6a56a2bbdbbf7
> --- /dev/null
> +++ b/drivers/net/can/usb/ixxat_usb/ixxat_usb_cl2.c
[ ... ]
> +static const struct can_bittiming_const usb2can_fd_btd =3D {
> +	.name =3D KBUILD_MODNAME,
> +	.tseg1_min =3D IXXAT_USB2CANFD_TSEG1_MIN_DATA,
> +	.tseg1_max =3D IXXAT_USB2CANFD_TSEG1_MAX_DATA,
> +	.tseg2_min =3D IXXAT_USB2CANFD_TSEG2_MIN_DATA,
> +	.tseg2_max =3D IXXAT_USB2CANFD_TSEG2_MAX_DATA,
> +	.sjw_max =3D IXXAT_USB2CANFD_SJW_MAX_DATA,
> +	.brp_min =3D IXXAT_USB2CANFD_BRP_MIN_DATA,
> +	.brp_max =3D IXXAT_USB2CANFD_BRP_MAX_DATA,
> +	.brp_inc =3D IXXAT_USB2CANFD_BRP_INC_DATA,
> +};
[ ... ]
> +static int ixxat_usb_init_ctrl(struct ixxat_usb_candevice *dev)
> +{
[ ... ]
> +	if (exmode) {
> +		u16 tdo =3D btd->brp * (btd->phase_seg1 + 1 + btd->prop_seg);

[Severity: Medium]
Could this Transmitter Delay Compensation offset (tdo) calculation overflow
the 16-bit unsigned integer type?

Since IXXAT_USB2CANFD_BRP_MAX_DATA is 513 and IXXAT_USB2CANFD_TSEG1_MAX_DATA
is 256, the product of btd->brp and (btd->phase_seg1 + 1 + btd->prop_seg) c=
an
be up to 513 * (256 + 1) =3D 131841. This exceeds the maximum value of a u16
(65535).=20

When an administrator configures a low CAN FD data bitrate, will this result
in a silent truncation and an incorrect hardware configuration being sent to
the device?

> +
> +		cmd.fdr.mode =3D cpu_to_le32(btmode);
> +		cmd.fdr.bps =3D cpu_to_le32(btd->brp);
> +		cmd.fdr.ts1 =3D cpu_to_le16(btd->prop_seg + btd->phase_seg1);
> +		cmd.fdr.ts2 =3D cpu_to_le16(btd->phase_seg2);
> +		cmd.fdr.sjw =3D cpu_to_le16(btd->sjw);
> +		cmd.fdr.tdo =3D cpu_to_le16(tdo);
> +	}
> +
> +	return ixxat_usb_send_cmd(dev, port, &cmd, snd_size, &cmd.res,
> +				  rcv_size, IXXAT_USB_CMD_TIMEOUT);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723072955.3257=
5-1-stephane.grosjean@free.fr?part=3D3
