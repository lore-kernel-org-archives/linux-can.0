Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA993AFAEB
	for <linux-can@vger.kernel.org>; Thu, 30 Jul 2026 10:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785407404; cv=none; b=HaRYJ+80vqS1p9Fwjc5OkhhLKGXVkTRblBnor+lPa0L5vGb5ETR3VqKQ7MFLIZXqMJ9Ze3SoqYs/JP+TdhClHZhOqXxv/4r3i8zgo5LrKigUyn6u19YHrusZAJUvOoVAHuW2v5tQzbTY+Ma5zeKwqYrtrNWyj8bKhEfGzzoeKTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785407404; c=relaxed/simple;
	bh=m2S50Rcz8v8aEad7m8sPn7qP4Iues+B6PAcsYLgf/iY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RV6K/IovgsSEVEzwSCO4qwGrQgeraCZ2atNYoJZJnH5cfmskyvWYmEpx0a6G5czYpGT+jlpc1uMtMK9SqeyCli9xBP/zkep2qFaHKcEmY/Y5sW9U9Y6f4ysFpt34KL3KuaNhTaOw9lmARUX3XQRJbQUCnGdHo3Tk8AJF4qwASYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D1HY7r/T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D1HY7r/T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B04DA1F00A3D;
	Thu, 30 Jul 2026 10:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785407403;
	bh=3FmpBJ43aHHgs4pVaYJPzilWRmYLmUpvBDqK9Tke+xw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D1HY7r/TrK4pOLLQgmdimG87zi2hg/tx7TM/V2cbh2W0C8vFCcYgnqhjX90zjo3/w
	 Q4aIbk/RmwaANG+nU+tn+bHl/oS2Wwx1Ns9KMNRNwmxN20s0+gUh3/J5kZZ9FvEam0
	 MRrVBRLLP0JJrYiKpLBgyVpQth6NRhm1CP9cBTF8/IZ43FUJHhZJXb7tL0c0fOBUeQ
	 YJXfnp2jCABt+opfZbx6rcwGoT3KfaDhUtG6ZpOUEre4dTuP6VVtzts6YEgN0iYLwT
	 Co736IqA/46Ubi+fvMBK/h0JGttCeofvs72qcEP4q9WGP+EU3kjvr2sAb1zr1B9Ggv
	 FxXq5o7g+5NFg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 20/20] can: ems_usb: validate CPC message lengths
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>
In-Reply-To: <20260729102802.505168-21-mkl@pengutronix.de>
References: <20260729102802.505168-1-mkl@pengutronix.de>
 <20260729102802.505168-21-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 10:30:02 +0000
Message-Id: <20260730103002.B04DA1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] TX context leak in ems_usb_start_xmit() error path.
--

--- Patch [20]: [PATCH net 20/20] can: ems_usb: validate CPC message length=
s ---
commit 2db7f239e46ba1c12e2761c8d9fa8b163a632adc
Author: Pengpeng Hou <pengpeng@iscas.ac.cn>

can: ems_usb: validate CPC message lengths

ems_usb_read_bulk_callback() walks CPC messages packed in one USB
receive buffer. Check that each declared message fits in the URB payload
and require type-specific payloads to cover the fields used by handlers.

Link: https://patch.msgid.link/20260706092752.79600-1-pengpeng@iscas.ac.cn

> diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
> index 9b25dda7c1838..24cf8f651f8f1 100644
> --- a/drivers/net/can/usb/ems_usb.c
> +++ b/drivers/net/can/usb/ems_usb.c

[ ... ]

While reviewing this patch, I noticed a pre-existing issue in the
ems_usb_start_xmit() error path:

drivers/net/can/usb/ems_usb.c:ems_usb_start_xmit()
>	err =3D usb_submit_urb(urb, GFP_ATOMIC);
>	if (unlikely(err)) {
>		can_free_echo_skb(netdev, context->echo_index, NULL);
>
>		usb_unanchor_urb(urb);
>		usb_free_coherent(dev->udev, size, buf, urb->transfer_dma);
>
>		atomic_dec(&dev->active_tx_urbs);

[Severity: High]
This isn't a bug introduced by this patch, but does this error path
permanently leak the transmission context slot?

If usb_submit_urb() fails here, it cleans up the URB and echo_skb, but
doesn't reset context->echo_index to MAX_TX_URBS. After enough failures,
could this cause context allocations to fail and wedge the transmission path
indefinitely, causing the driver to always return NETDEV_TX_BUSY?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729102802.5051=
68-1-mkl@pengutronix.de?part=3D20
