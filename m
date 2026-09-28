Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC354E36E0
	for <linux-can@vger.kernel.org>; Mon, 28 Sep 2026 16:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790613001; cv=none; b=iOrvSUxwJsChiM5HaSwIJMtatpqZVGCwHBHT2CtFzX/EKa2ztEIXIrPKLddtnYTYGBnWjT5Y48M09K/hCZ9dyRdarY3Mhvc4IZfzgy4QmbsDVjBfbDbYKo1V1nemh+APHnrWskKOajVG3bCXYstNd74d4dnQ4DDpJuQMPwo2E6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790613001; c=relaxed/simple;
	bh=H6HNvu0NqecO3gh0YzmgYFUVZlTXcPtkGEvMjcMeGVg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DjYKWR9zqIc770StlV03B0vlpnQFxuxJJ6nd69do76zKxZY7ZRqrJjEDqfC73/WkWdwaYt7A6XpB00IUPgW+DNtBko+suPoEPAw3xx1y2ns14rdBpmmho1GluoTj4LVkyrW72Qy/L0P9Ayrzv+1hLxaj2VaJm/9N+e7H6+sE/0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3F2YdLk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3F2YdLk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 253361F000FF;
	Mon, 28 Sep 2026 16:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790612999;
	bh=Uih1V4dtaQ3epJy4L4Ag/IQpx2DDbLhGAkF0+06PQ8w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k3F2YdLkSFjD/oJl9Kj7Nhg8U3+a9yw/tahJYVZ1veXiyw11hHEXjzqqQfRO05PbF
	 tV5xKLYuVebu6tIUZn0SE1TeySpyuUwpQnh+hz589zTjA+nVTZZLOlYwun1JtcM3q+
	 iBLbBChkP4jV6UsMq1lwGgtxJq1PVvoCOGXQP+PKkKJvbbPeGH4jnhtXcZqJ1D37Wc
	 TUZjoeBPkBWdiOBNe4y3bP8XXD9S81ORmmXgN5S1R2hVoTrp2OOmhfGKGTM5RWH6mC
	 HW3N53Ir4Ks5zg4bHGDmCU4ktM6SxDcOPaEW2gdZAJmN/nkgPbRu7ZVda7SZ37D4zq
	 UV+yM+iUY+BNQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH can] can: gs_usb: add workarounds for HScanT USB to CAN
 adapter
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, linux-can@vger.kernel.org, "Oleksij Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20260928-gs_usb-hscant-v1-1-42638ca0f85f@pengutronix.de>
References: <20260928-gs_usb-hscant-v1-1-42638ca0f85f@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 16:29:58 +0000
Message-Id: <20260928162959.253361F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] can: gs_usb: incorrect RX URB size calculation causes USB transfer=
 hang
--

commit d72414dd12485ded5e69be85c30c0da0f32c460c
Author: Marc Kleine-Budde <mkl@pengutronix.de>
can: gs_usb: add workarounds for HScanT USB to CAN adapter

This commit adds workarounds for the HScanT RISC-V based USB to CAN adapter.
It corrects the channel count, binds channels to USB interface 0, and
implements a quirk to allocate 512-byte IN URBs for transfers.

Link: https://github.com/cherry-embedded/HSCanT-hardware

> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index 3b9b2f104d868..ec8256b46646b 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c

[ ... ]

> @@ -261,6 +274,10 @@ struct canfd_quirk {
>  	u8 quirk;
>  } __packed;
> =20
> +struct quirk_hscant {
> +	u8 quirk[512];
> +} __packed;
> +

[Severity: High]
Because quirk is defined as a fixed 512-byte array rather than a flexible
array member (like u8 quirk[]), sizeof(struct quirk_hscant) evaluates to
512 bytes. Will this cause issues when used with struct_size() below?

>  /* struct gs_host_frame::echo_id =3D=3D GS_HOST_FRAME_ECHO_ID_RX indicat=
es
>   * a regular RX'ed CAN frame
>   */
> @@ -284,6 +301,7 @@ struct gs_host_frame {
>  		DECLARE_FLEX_ARRAY(struct canfd, canfd);
>  		DECLARE_FLEX_ARRAY(struct canfd_ts, canfd_ts);
>  		DECLARE_FLEX_ARRAY(struct canfd_quirk, canfd_quirk);
> +		DECLARE_FLEX_ARRAY(struct quirk_hscant, quirk_hscant);
>  	};
>  } __packed;

[ ... ]

> @@ -1604,10 +1704,12 @@ static int gs_usb_probe(struct usb_interface *int=
f,
>  		}
>  		parent->canch[i]->parent =3D parent;
> =20
> -		/* set RX packet size based on FD and if hardware
> +		/* set RX packet size based on quirks, FD and if hardware
>  		 * timestamps are supported.
>  		 */
> -		if (parent->canch[i]->can.ctrlmode_supported & CAN_CTRLMODE_FD) {
> +		if (parent->canch[i]->feature & GS_CAN_FEATURE_QUIRK_HSCANT_URB_LENGTH=
) {
> +			hf_size_rx =3D struct_size(hf, quirk_hscant, 1);

[Severity: High]
Does this calculate the correct size for the RX URB?=20

Because struct gs_host_frame has a 12-byte header, struct_size() computes
sizeof(*hf) + sizeof(struct quirk_hscant), which evaluates to 12 + 512 =3D =
524
bytes instead of the intended 512 bytes.

If the host requests 524 bytes for a bulk IN transfer, but the device sends
exactly 512 bytes without a Zero-Length Packet, won't the host wait
indefinitely for the remaining 12 bytes and completely hang the RX path?

> +		} else if (parent->canch[i]->can.ctrlmode_supported & CAN_CTRLMODE_FD)=
 {
>  			if (parent->canch[i]->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
>  				hf_size_rx =3D struct_size(hf, canfd_ts, 1);
>  			else

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928-gs_usb-hsc=
ant-v1-1-42638ca0f85f@pengutronix.de?part=3D1
