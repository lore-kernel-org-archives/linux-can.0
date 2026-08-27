Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48ECF43E4B1
	for <linux-can@vger.kernel.org>; Thu, 27 Aug 2026 12:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787832658; cv=none; b=L3Boe/GxVcSm2fp4nlsC9KzJMRAHmQ8K6tjnzs7Z9FmFVPkqSousTW2y9sVCO8rYJx3F66ippXFgNxuxozTbriQj1wFxSj5hPYyToNzgoUpp3XThWRPxp2H+nsbAbtrdAdD+/BuEKEoDQ0D4qy9hBd1v+x4RW884r9w0EFRgF7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787832658; c=relaxed/simple;
	bh=TpoVdTy3fTIMjVFrgqDYxmgWrC7A1LcwCQ9PJaCM+YE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EZVvdreY6d6R46yzPUeJyl63dfxZmrE1AXeWPSJwK0ar44lhig0bbF6IqdYi2qRUGCWuuncplDa9rsUazdR3x0oZCFWM0VAxx9ZzUvckjBtjX+1GB84U5YfEyCRckYhJsXyLYUkm/ywDF8o3y0goyH8nNVnhDcKTSTeJvo7qHrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mj+HLXdR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mj+HLXdR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDFB01F00A3D;
	Thu, 27 Aug 2026 12:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787832657;
	bh=LJazyV0IQhdBcvk9hhH/CrpFFjnV2jWAaQrH5DAuIFc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mj+HLXdRBUDJJvgvMIV/8N3m6jp8/Edz08m3dH6NZ6rw3IQRmD4A2w03GB+6q1OLA
	 j+99Vq9lR0elDHSuP5nG6C+Zg2hx7qOLIaP1oJiEUq0eqatWeNLbR8H1u8BpPazf6z
	 oawrupLYqwZsZbwIu7osCriF8HH3vuKhy4IWvWmEci25t3CKX+lUXDTBHStt5+/WUL
	 MqbjI870W5ZLu8mstFpJR8tm98gz5pEzL0UL83J6+TNJnV55xyXifREYRgwfh9ACJn
	 glAW8zTRrfCl4r0VKyrwqjnQx3AOSz2o7a9dMpsK83uk3awMYTyhM4rx080Eyg09Z7
	 V9wJ6TND/Wt4A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 13/14] can: usb: f81604: fix struct f81604_int_data
 size mismatch
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, linux-can@vger.kernel.org, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Oleksij Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20260826121036.2706424-14-mkl@pengutronix.de>
References: <20260826121036.2706424-1-mkl@pengutronix.de>
 <20260826121036.2706424-14-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 12:10:56 +0000
Message-Id: <20260827121056.CDFB01F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incorrect ordering of URB length and status checks causes fatal UR=
B errors to be bypassed, leading to infinite resubmission loops or spurious=
 warnings on device disconnect.
--

commit 7de2dcdbebd610316c61044116af8d2dda19bd1f
Author: Ji-Ze Hong (Peter Hong) <peter_hong@fintek.com.tw>

can: usb: f81604: fix struct f81604_int_data size mismatch

This commit removes the __aligned(4) attribute from struct f81604_int_data,
changing its size from 12 bytes back to 9 bytes. This ensures that the valid
9-byte interrupt URBs sent by the hardware are no longer incorrectly dropped
by the short URB check.

Link: https://patch.msgid.link/20260824-f81604-fix-v2-1-fc9be5581394@fintek=
.com.tw
Closes: https://lore.kernel.org/all/A3834A07-5639-4779-844F-C5843DFC3928@dy=
netrex.com/

> diff --git a/drivers/net/can/usb/f81604.c b/drivers/net/can/usb/f81604.c
> index f12318268e46b..4c147b9d6d690 100644
> --- a/drivers/net/can/usb/f81604.c
> +++ b/drivers/net/can/usb/f81604.c
> @@ -169,7 +169,7 @@ struct f81604_int_data {
>  	u8 rxerr;
>  	u8 txerr;
>  	u8 val;
> -} __packed __aligned(4);
> +} __packed;

[Severity: High]
This is a pre-existing issue, but I wanted to ask about the ordering of
the URB length and status checks in f81604_read_int_callback().

When a hardware error occurs or the device is disconnected, the USB core
completes the interrupt URB with a fatal status (like -EPROTO or -ESHUTDOWN)
and sets urb->actual_length to 0.

Because f81604_read_int_callback() checks the length before the status:

	if (urb->actual_length < sizeof(*data)) {
		netdev_warn(netdev, "%s: short int URB: %u < %zu\n",
			    __func__, urb->actual_length, sizeof(*data));
		goto resubmit_urb;
	}

	switch (urb->status) {
	...
	case -ESHUTDOWN:
		return;
	...

Will this cause fatal URB errors to bypass the intended abort logic and loop
infinitely into resubmit_urb, or produce spurious warnings upon device
disconnect?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826121036.2706=
424-1-mkl@pengutronix.de?part=3D13
