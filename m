Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A823DCD9A
	for <linux-can@vger.kernel.org>; Thu,  9 Jul 2026 08:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783584318; cv=none; b=dYY0bkulz5ISLiRV6QHsEIGVfaiPaTpK1bndEIaGkpjflS6R4QkHIy89yycP7z2JoMyG+mL1o/G+KquEaMX+ordulqSJgnh17jKOiOyw8udVRioqWyLrVLg+BjJYqDxjFJJ7CQmfONlJHc3rB4vCye+E12CwNotGC8As6X69DoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783584318; c=relaxed/simple;
	bh=G5IktrfobO9380fkb2w/Hfel8OLSMEZkeDdiZGvGZd8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=vB9Vx9b6xQavi9AhSxdTbF2orZY/TQgiBv9JtF+XtKpF24alIBXA/PMcE8aySo3INhrtUZ76Wi4OS13rPFwfJyfUltN5XqQBQ4Od8RKhpOpGsdNroiqVlMXPG1ZFezSgu1FJ6dOupMhNRJPS5UOq6qadwX1xy5nJ1P4t0w1Rpqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EeuWwHDN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EeuWwHDN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D38A1F000E9;
	Thu,  9 Jul 2026 08:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783584317;
	bh=nBWIQsXehKiUD+XTcC7pqwIjsaxk4/yUOGrQ6GGFCD0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EeuWwHDNz0rbjCMyQIzVuWJI1duzlw3IWhiVfUfZwPAtR3KiyhIaXvYbyaCG6u8+c
	 ri7aaTg0Em6sIR+E6yONP97I5B1J10db3IRVMPZwhHIzkwKkBpeqdNIikK8EC0uva0
	 XYR5UuyLSVq0nUEKKdiZSsLZMiyPo/d9Ba8973Msj+jl2nCwWoJSqmutQ4IhqUH9+e
	 gQF/fD5vAGtChGLYNLqkU1cficlg+tWjR9CphpJmdPGih7RQU8xya3J0mAWzdKJ+TE
	 Nx7Q9ohaFmfBqtHL4ezsQ7YizlMRKeXY/ut8zYA+OBZusQU7Glq5p3wxjlAZWGmXT9
	 7J4gZYecPfJOQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] can: gs_usb: gs_usb_receive_bulk_callback(): resubmit
 URB on skb allocation failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: "Vincent Mailhol" <mailhol@kernel.org>, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org
In-Reply-To: <20260709-gs_usb-resubmit-urb-v1-1-4dd40030cc84@pengutronix.de>
References: <20260709-gs_usb-resubmit-urb-v1-1-4dd40030cc84@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 08:05:16 +0000
Message-Id: <20260709080517.1D38A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Concurrent execution of TX completion and RX echo processing l=
eads to a Use-After-Free of the echo SKB.
--

--- Patch [1]: [PATCH] can: gs_usb: gs_usb_receive_bulk_callback(): resubmi=
t URB on skb allocation failure ---
commit bae50a2d39a4f003135f3c48bca851334bf95f56
Author: Marc Kleine-Budde <mkl@pengutronix.de>

can: gs_usb: gs_usb_receive_bulk_callback(): resubmit URB on skb allocation=
 failure

If the allocation of the SKB in gs_usb_receive_bulk_callback() fails, the
driver returns from the callback without resubmitting the URB in order to
receive further USB in URBs. This commit changes the behavior to try to
resubmit the URB instead of returning.

> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index ec9a7cbbbc696..82508a8650959 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c
> @@ -674,7 +674,7 @@ static void gs_usb_receive_bulk_callback(struct urb *=
urb)
>  		if (hf->flags & GS_CAN_FLAG_FD) {
>  			skb =3D alloc_canfd_skb(netdev, &cfd);
>  			if (!skb)
> -				return;
> +				goto resubmit_urb;
> =20
>  			cfd->can_id =3D le32_to_cpu(hf->can_id);
>  			cfd->len =3D data_length;
> @@ -687,7 +687,7 @@ static void gs_usb_receive_bulk_callback(struct urb *=
urb)
>  		} else {
>  			skb =3D alloc_can_skb(netdev, &cf);
>  			if (!skb)
> -				return;
> +				goto resubmit_urb;
> =20
>  			cf->can_id =3D le32_to_cpu(hf->can_id);
>  			can_frame_set_cc_len(cf, hf->can_dlc, dev->can.ctrlmode);

[Severity: Critical]
This is a pre-existing issue, but is there a use-after-free race condition
in this function regarding the echo SKB?

If the USB RX and TX completion callbacks run concurrently on different CPU=
s,
and a TX URB fails (e.g., due to disconnection), gs_usb_xmit_callback()
locklessly frees the SKB and sets the slot to NULL:

gs_usb_xmit_callback()
    can_free_echo_skb(netdev, txc->echo_id, NULL);
    gs_free_tx_context(txc);

Concurrently, if a device sends an RX frame acting as the TX echo for the
same echo_id, gs_usb_receive_bulk_callback() could fetch the txc via
gs_get_tx_context() if it hasn't been freed yet.=20

The RX callback would then locklessly read the SKB and pass it to
gs_usb_get_echo_skb():

gs_usb_receive_bulk_callback()
    skb =3D dev->can.echo_skb[hf->echo_id];
    stats->tx_packets++;
    stats->tx_bytes +=3D gs_usb_get_echo_skb(dev, skb, hf);

If this read occurs just before the pointer is cleared by the TX callback,
but after the SKB is freed, does this cause a use-after-free when applying
hardware timestamps in gs_usb_get_echo_skb()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-gs_usb-res=
ubmit-urb-v1-1-4dd40030cc84@pengutronix.de?part=3D1
