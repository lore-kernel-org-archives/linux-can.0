Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140F0521209
	for <linux-can@vger.kernel.org>; Tue, 29 Sep 2026 14:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790691305; cv=none; b=YWSc7ggMtCuohjPUdR69UdESowJvaxF7HuRLuerO9IVYYQzqPRbGSqBKVs6chmh+QHrIxlvaEjgE3PUcGpajMVthifGWr5NU4B0kez/xscRwyhu0rGdi0jIlWB9/I/1vIIih9WXWk89hDkhX6GhWs9W4MoS62MgqshGM/dZb8Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790691305; c=relaxed/simple;
	bh=VpdAHOia1lh5pk2EW1AmTzA5aPYW4H5I6zWekHNwbEo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tbTgyQDyGJgaG+Q4CF4BUf1niC6wNBX1gywft+qVLfkgkMR0qOWIKiVq7koFmg4baoVx72MjkhdLDLVKScLmg5I0imMcbBudv9+yDKsLeZYTALxukgRx2wAcvE0oBHc7CKd9FIbqIwQPNdg2YBCV4/W6kSey4A65nfuf93XqDaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aR8+4q5P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aR8+4q5P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 645871F000FF;
	Tue, 29 Sep 2026 14:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790691303;
	bh=2GHZQpA1bav5h6y+Y3S5fqrNhFzcz5pz8zvhD6d6lh4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aR8+4q5P7iqaqaNHleigLOJC2t5hgFfAb8CPlL/ylMmlv3ec99aRQeFdPGrgS47el
	 VSnuZORuy5q1WO1ZMsmztFWKby8v+F8kM3C0u28mnf5p9aQsaIiY4wHh3gejsz69aw
	 BqhRJzbr/JVlsBJ5YaZEM+lSu1Hfw7t5Kb50KwdIlgXGXJa1jiZA3K7GK51Qb9AFeZ
	 MdYPRT0KkWCv+zK3qsD5cMXV+0KCh+MmCCMrrMW967QvnO2d2NS37ZTS2qwW2WMLJ+
	 EnSMM6q/YkboyAIZ91ppeCmfc1gEp46wop1d59jvNu/fTqw9h6rBAqeylSsiSguVs9
	 3mQzK9pMahaOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] can: peak_usb: Add bus error reporting for the PCAN-USB
 FD family
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?U3TDqXBoYW5lIEdyb3NqZWFu?= <stephane.grosjean@free.fr>
Cc: linux-can@vger.kernel.org, "Vincent Mailhol" <mailhol@kernel.org>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20260929-peak_usb-canfd-berr-v1-1-7abd585f877f@peak-system.fr>
References: <20260929-peak_usb-canfd-berr-v1-1-7abd585f877f@peak-system.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 14:15:02 +0000
Message-Id: <20260929141503.645871F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] can: peak_usb: NULL pointer dereference in pcan_usb_fd_decode_erro=
r()
--

commit 19614d59ec182f3f690df8a2b9505f478b56815e
Author: St=C3=A9phane Grosjean <s.grosjean@peak-system.fr>

can: peak_usb: Add bus error reporting for the PCAN-USB FD family

This commit adds CAN bus error reporting for PEAK-System USB-to-CAN FD
devices by enabling firmware bus error notifications per channel.

> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can=
/usb/peak_usb/pcan_usb_fd.c
> index 0d46f4ce5dca7..fdd38908b4c37 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> @@ -661,6 +661,9 @@ static int pcan_usb_fd_decode_error(struct pcan_usb_f=
d_if *usb_if,
>  	struct pucan_error_msg *er =3D (struct pucan_error_msg *)rx_msg;
>  	struct pcan_usb_fd_device *pdev;
>  	struct peak_usb_device *dev;
> +	struct can_frame *cf;
> +	struct sk_buff *skb;
> +	u8 can_err_tx =3D 0;
> =20
>  	if (pucan_ermsg_get_channel(er) >=3D ARRAY_SIZE(usb_if->dev))
>  		return -EINVAL;

[Severity: High]
Does this bounds check adequately protect against accessing an uninitialized
channel? Since ARRAY_SIZE(usb_if->dev) is statically 2, if an untrusted
single-channel adapter sends a PUCAN_MSG_ERROR message with channel index 1,
the bounds check passes but the fetched usb_if->dev[1] pointer could be NUL=
L.

> @@ -672,6 +675,53 @@ static int pcan_usb_fd_decode_error(struct pcan_usb_=
fd_if *usb_if,
>  	pdev->bec.txerr =3D er->tx_err_cnt;
>  	pdev->bec.rxerr =3D er->rx_err_cnt;
> =20
> +	/* ignore non-CAN error notifications */
> +	if (PUCAN_ERMSG_TYPE(er) > PUCAN_ERMSG_OTHER_ERROR)
> +		return 0;
> +
> +	/* update other errors counters */
> +	dev->can.can_stats.bus_error++;

[Severity: High]
If the fetched dev pointer is NULL as described above, will this addition
cause a kernel panic when dereferencing dev? Could a maliciously crafted USB
peripheral exploit this to cause a denial of service?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929-peak_usb-c=
anfd-berr-v1-1-7abd585f877f@peak-system.fr?part=3D1
