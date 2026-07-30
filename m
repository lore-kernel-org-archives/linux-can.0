Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE123B27FA
	for <linux-can@vger.kernel.org>; Thu, 30 Jul 2026 10:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785407392; cv=none; b=ttBjv9Xze5t5esVo3IOkbe7MELdEsXwVTp7JtTJWAsjuGBQK24weSJL2dzX9VmWMRXoeYrSxhCVpm4DwIdz+qQkL+XnLFHADdas9SLO8Dbv93EefIxZoVL23XLU97L/EkrjpCIlXdJatFlng5KcXK8rfvQoLjRVpjCR8sgw/xWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785407392; c=relaxed/simple;
	bh=fn6KzkaDth5+Me5LsFf4BDdnWknoEs2hvXPsSfD0aok=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mAygVgNjEipnN9KXRv+tFpdQDk9sVnPM0BG1JDNGVxlUNggBQA8xkAX9qFAoiztKw9dHLjhOWIJgek4vQP9rI+KSKpwKnyI8Rb4wXgOu1Hd8EjRLXXm/kQalcdR3J7G08OdLPkEuIIoPRQdlusccCtDgQZOgL2n1dVO65mKYEyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CrMglCH/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CrMglCH/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 110641F00A3F;
	Thu, 30 Jul 2026 10:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785407391;
	bh=r7/fn/nDyoyXZ18NHpqEe5BinctKJW3NQy2cKObxARE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CrMglCH/OgIiG8ceQZf1vqQJ3rbbF32ms/IJtI9ZAH99F8n/tPoFL/9Md0+9uvv+N
	 e25gx9CJ8MSgPqfQZycb1P8kA7nTnFATROAyCUI3jBMlTLvMc958xpN4Q2UZnckxJb
	 OqKsIrhqD54hAL/JyxOOfkxZ76WR/1KnZR1IRWs6TZl9ov0q1V0i+H/PsWE3uNCwxT
	 PMdzFkhXN/I/Gwwxb6zqjx+aROSUCUIJzagYRxAa45w9LvS+F3rDs2ZMJbzYwy0M8t
	 Ut5OxWM2sVH7OPuDWIKCuLhG3EYjjuSHCRKvwrRN6EFt/dtsZYc+Fx1ju3OnOhJgS9
	 9zQg1gkS7Z9bA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 08/20] can: ctucanfd: use self-test mode for
 PRESUME_ACK
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, linux-can@vger.kernel.org, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20260729102802.505168-9-mkl@pengutronix.de>
References: <20260729102802.505168-1-mkl@pengutronix.de>
 <20260729102802.505168-9-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 10:29:50 +0000
Message-Id: <20260730102951.110641F00A3F@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] NAPI poll loop permanently deadlocks on SKB allocation failure bec=
ause it returns less than `quota` without calling `napi_complete_done()`.
--

--- Patch [8]: [PATCH net 08/20] can: ctucanfd: use self-test mode for PRES=
UME_ACK ---
commit 2ad480a34ed756c09679dabe564744f0df8a351d
Author: Avi Weiss <thnkslprpt@gmail.com>

can: ctucanfd: use self-test mode for PRESUME_ACK

Use self-test mode for CAN_CTRLMODE_PRESUME_ACK so transmitted
frames can complete without receiving an ACK.

ACK forbidden mode prevents the controller from acknowledging
received frames and does not implement the presume-ack behavior.

Link: https://patch.msgid.link/20260722192726.230729-1-thnkslprpt@gmail.com

> diff --git a/drivers/net/can/ctucanfd/ctucanfd_base.c b/drivers/net/can/c=
tucanfd/ctucanfd_base.c
> index 10ebcc13ea656..07d4aa43c700a 100644
> --- a/drivers/net/can/ctucanfd/ctucanfd_base.c
> +++ b/drivers/net/can/ctucanfd/ctucanfd_base.c
> @@ -340,8 +340,8 @@ static void ctucan_set_mode(struct ctucan_priv *priv,=
 const struct can_ctrlmode
>  			(mode_reg & ~REG_MODE_FDE);
> =20
>  	mode_reg =3D (mode->flags & CAN_CTRLMODE_PRESUME_ACK) ?
> -			(mode_reg | REG_MODE_ACF) :
> -			(mode_reg & ~REG_MODE_ACF);
> +			(mode_reg | REG_MODE_STM) :
> +			(mode_reg & ~REG_MODE_STM);
> =20
>  	mode_reg =3D (mode->flags & CAN_CTRLMODE_FD_NON_ISO) ?
>  			(mode_reg | REG_MODE_NISOFD) :

[Severity: High]
This is a pre-existing issue, but I noticed a potential napi deadlock in
ctucan_rx_poll() when reviewing this file.

If skb allocation fails due to memory pressure, ctucan_rx() returns 0:

drivers/net/can/ctucanfd/ctucanfd_base.c:ctucan_rx_poll() {
	while (framecnt && work_done < quota && res > 0) {
		res =3D ctucan_rx(ndev);
		work_done++;
		framecnt =3D FIELD_GET(REG_RX_STATUS_RXFRC, ctucan_read32(priv, CTUCANFD_=
RX_STATUS));
	}
[ ... ]
	if (!framecnt && res !=3D 0) {
		if (napi_complete_done(napi, work_done)) {
[ ... ]

When res is 0, the loop breaks early and work_done is less than quota. Howe=
ver,
because res is 0, the check if (!framecnt && res !=3D 0) evaluates to false,
which prevents napi_complete_done() from being called.

Does this leave the napi instance in the scheduled state without being
on the core's poll list, permanently deadlocking the receive path until the
interface is restarted?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729102802.5051=
68-1-mkl@pengutronix.de?part=3D8
