Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484CB3DDAFC
	for <linux-can@vger.kernel.org>; Thu, 30 Jul 2026 10:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785407397; cv=none; b=dSm3Lyl/PJG9wBkOEdHSSNFHzsFvv/INx5zYBIgJrdk8luFk2SXaivDi0eXIT235YneGRTBjDY2xu4ezssdWoE5y9pOlASVwDESCTPK6DPQrv0MYqBkvznDE/Yq6HeCMmCEMVi+zPrEX42ncOCvTR1qVJKuWWRzDQ58zsDc5H0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785407397; c=relaxed/simple;
	bh=XADRYSkxJzl1Ooq6X9Bd4G4EVyKsFd2aDaZxnlFqHp0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cgndKtgPf4prEWy6hNNPmyLS5SxVysKOD/mLJLsQjeiq3twZaybvMfEZxW84QnVRf76RyrEizq9bQh3C3r9zriTBbKvrfyM4PpLtFjXuKsLVXXP3XjHZg5rm7a4WDmnXcrEjqG/q7gEAV3qPOWLVc5T7vYTcRVW6fvtLTrdu4GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=haMwH9VB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="haMwH9VB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACD311F00A3D;
	Thu, 30 Jul 2026 10:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785407396;
	bh=zwx+KKhRSGs8dqoXMqeUwb1DyAj7ZRjkTYR47ZoZ3HM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=haMwH9VB1b36Tz3zFB1/dqHehR5DOqa8EPMfzDrui21nWgOHaRUqNrsDjWK02ORmm
	 4AyPCGkXXqywAfq+0YmF4Dn28D1OMpiLWIBX2rEObJ9rcbMpYWUzkfsNcfWFVf2B3X
	 wJUb32sL0gEIl7l224e8vXIOcb16UUJsMIqfaXKuXIWgEaR+mVuwNd39Q/990hksWO
	 jRT8zXRVba6tdfv3mPbvf0Ow63h+PvgOCAXlJG/b/uQuxCIobsdMXdLg92q4HsbySZ
	 hZQnZSgmDL4djiN1PHNFPodzJbD6lsfCx86EDfJ5dyyLTX8/3RNw46gcKX+YD8dVcb
	 DqqGYHivR3DFg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 14/20] can: kvaser_usb_leaf:
 kvaser_usb_leaf_wait_cmd(): validate received command extents
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <20260729102802.505168-15-mkl@pengutronix.de>
References: <20260729102802.505168-1-mkl@pengutronix.de>
 <20260729102802.505168-15-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 10:29:55 +0000
Message-Id: <20260730102955.ACD311F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Processing a zero-length extended command or encountering a bulk e=
ndpoint with a zero wMaxPacketSize causes an infinite loop and CPU soft loc=
kup.
--

--- Patch [14]: [PATCH net 14/20] can: kvaser_usb_leaf: kvaser_usb_leaf_wai=
t_cmd(): validate received command extents ---
commit ad6fd8163961ebd7ee69b192c06c6c10803d720a
Author: Pengpeng Hou <pengpeng@iscas.ac.cn>
Subject: can: kvaser_usb_leaf: kvaser_usb_leaf_wait_cmd(): validate receive=
d command extents

The wait and bulk receive paths walk variable-length commands from a
USB buffer. A nonzero command shorter than CMD_HEADER_LEN can still be
dispatched, and the wait path copies a matching command into a fixed
caller-owned struct kvaser_cmd using the device-provided length.

Link: https://patch.msgid.link/20260722042221.44066-1-pengpeng@iscas.ac.cn

> diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/n=
et/can/usb/kvaser_usb/kvaser_usb_leaf.c
> index df737cfc5ea0c..a876c7819b81c 100644
> --- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
> +++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
> @@ -691,13 +691,22 @@ static int kvaser_usb_leaf_wait_cmd(const struct kv=
aser_usb *dev, u8 id,
>  				continue;
>  			}
> =20
> -			if (pos + tmp->len > actual_len) {
> +			if (tmp->len < CMD_HEADER_LEN ||
> +			    tmp->len > actual_len - pos) {

[Severity: High]
This isn't a bug introduced by this patch, but might the logic directly abo=
ve
this bounds check still allow an infinite loop?

If a USB device provides a bulk IN endpoint with wMaxPacketSize =3D=3D 0, t=
he check
for tmp->len =3D=3D 0 behaves as follows:

			if (tmp->len =3D=3D 0) {
				pos =3D round_up(pos + 1,
					       le16_to_cpu
						(dev->bulk_in->wMaxPacketSize));
				continue;
			}

Here, round_up(pos + 1, 0) evaluates to 0, which resets pos to 0. Since this
executes before the new tmp->len < CMD_HEADER_LEN check, the loop would fai=
l to
advance and hang the process.

This same pattern appears in kvaser_usb_leaf_read_bulk_callback() modified
later in this patch.

Additionally, a similar pre-existing issue seems to be present in the
kvaser_usb_hydra driver variant. In kvaser_usb_hydra_wait_cmd() and
kvaser_usb_hydra_read_bulk_callback(), if an extended command specifies a l=
ength
of 0, kvaser_usb_hydra_cmd_size() returns 0. The loop then increments pos b=
y 0,
failing to advance and causing a soft lockup.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729102802.5051=
68-1-mkl@pengutronix.de?part=3D14
