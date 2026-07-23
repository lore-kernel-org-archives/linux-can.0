Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC0533689A
	for <linux-can@vger.kernel.org>; Thu, 23 Jul 2026 07:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784792897; cv=none; b=G+KUzpIol3binbNRfZ+YVfS36B5gTIlIXQDRp7O/ponqa9JaRYrtNdMlw4ipVI14bOhRNfiAzNcnSCxQDsKJvHxH83GfC2BVIETGqu2mTfhzhSUamDT0pS/Kx+3hGLeTGf3uVq/JekF1heydyGV4xJf7+34s52JH05r76WaZFiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784792897; c=relaxed/simple;
	bh=+yKPqACv0DfeesAuFrlGY+C51xNZpxXI0cy2lGSTb0E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=X6YtFZm03ybHMlmi8IrBt5MXFSxd5ykbHO/VWYZwdwC01lfuyOpHRpaJePS5UQVnkeiRg9hUgdGjoAXettxVhL8v352UCCqRs/xSyOOkCsddALLyzjazlVcXyK8RKKPLwVi7Liz1/VzaxlAZzoIyaucr3V/rwM2dg0YcNZLbTL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/O8F567; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/O8F567"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 007591F000E9;
	Thu, 23 Jul 2026 07:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784792896;
	bh=0QVP4NwWjiS53ZRHhExpw90JtoNhOjnqKN1ppDLuWEE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h/O8F567oiKSHNZvrYY4KR+FFeI76tLoCedJ17DFilRO0mWPOL8kqh049Xbf6GOPK
	 IuJagvqVRtVyEhLgDwnAgxOMdGrpgEbWtubl3hzGEg1dn+mY2t9fzouW7qmxVi/L66
	 RxMN3CUPnsX6YWW4N2nnJqftBGXnsNaZAV//0nSe0CxGtmELlOj6i16WUl4jiA/6sM
	 D0Ty8iT7OMhhlM9I/h9YfxtW3lAXl/QeLuKyVgy8FfPM8j5iok7zHoPWwu0BAPVGZb
	 PeNGP+hkNTFrYuvZjdL+50LhEUfZajUqGc04cp084mjELSwtBLxjSC0GN03lnRIico
	 86Y8dli2NM0Yw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] can: usb: ixxat_usb: add shared header
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?U3TDqXBoYW5lIEdyb3NqZWFu?= <stephane.grosjean@free.fr>
Cc: "Oleksij Rempel" <o.rempel@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org
In-Reply-To: <20260723072955.32575-2-stephane.grosjean@free.fr>
References: <20260723072955.32575-1-stephane.grosjean@free.fr>
 <20260723072955.32575-2-stephane.grosjean@free.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 07:48:15 +0000
Message-Id: <20260723074816.007591F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Low] Mathematically incorrect formula in timestamp documentation.
- [Low] Struct field documentation mismatch and missing kernel-doc features.
- [Low] Duplicate USB Product ID macro values.
--

--- Patch [1]: [PATCH 1/4] can: usb: ixxat_usb: add shared header ---
commit 9b5608c77a4fdbba5ae14afe4c9f4c448d769837
Author: St=C3=A9phane Grosjean <s.grosjean@peak-system.fr>

can: usb: ixxat_usb: add shared header

Add ixxat_usb_core.h, which defines the data structures, constants and
USB wire-protocol layouts shared by all three IXXAT USB communication
layers (CL1, CL2 and CAN IDM).

> diff --git a/drivers/net/can/usb/ixxat_usb/ixxat_usb_core.h b/drivers/net=
/can/usb/ixxat_usb/ixxat_usb_core.h
> new file mode 100644
> index 0000000000000..62799d8040b1c
> --- /dev/null
> +++ b/drivers/net/can/usb/ixxat_usb/ixxat_usb_core.h

[ ... ]

> +/* supported device ids: CL2 */
> +#define USB2CAN_FD_COMPACT_PRODUCT_ID		0x0014
> +#define USB2CAN_FD_EMBEDDED_PRODUCT_ID		0x0015
> +#define USB2CAN_FD_AUTOMOTIVE_PRODUCT_ID	0x0017
> +#define USB2CAN_FD_PCIE_MINI_PRODUCT_ID		0x001B
> +#define USB2CAR_PRODUCT_ID			0x001C
> +#define CAN_IDM101_PRODUCT_ID			0xFF12
> +#define CAN_IDM200_PRODUCT_ID			0xFF13
> +
> +/* supported device ids: CL2 */
> +#define USB2CAN_FD_PRO_PRODUCT_ID		0x0010
> +#define USB2CAN_FD_STANDARD_PRODUCT_ID		0x0011
> +#define USB2CAN_FD_STANDARD_CARD_PRODUCT_ID	0x0012
> +#define USB2CAN_FD_PRO_MODULE_PRODUCT_ID	0x0013
> +#define USB2CAN_FD_STANDARD_MODULE_PRODUCT_ID	0x0014

[Severity: Low]
Is this duplication intentional? Both USB2CAN_FD_COMPACT_PRODUCT_ID and
USB2CAN_FD_STANDARD_MODULE_PRODUCT_ID are assigned the same constant 0x0014,
which might create device ID collisions.

[ ... ]

> + * To correlate the start timestamp to the host clock we determine:
> + *
> + *     t_host_C =3D (t_host_B + t_host_A) / 2
> + *              =3D t_host_A + ((t_host_A - t_host_B) / 2)

[Severity: Low]
Is the mathematical simplification in this documentation correct?

The formula t_host_A + ((t_host_A - t_host_B) / 2) simplifies to
1.5 * t_host_A - 0.5 * t_host_B, not the mathematical midpoint.

Should it be t_host_A + ((t_host_B - t_host_A) / 2) instead?

[ ... ]

> +/* struct ixxat_tx_urb_context URB content for transmission
> + * @dev: pointer to the IXXAT USB CAN device
> + * @urb: USB request block
> + * @urb_index: index of this URB (used to mark the context as occupied)
> + * @msg_index: index of message (client_id)
> + * @msg_packet_len: Data length code (only used if no loopback is enable=
d)
> + * @msg_packet_no: number of packets (only used if no loopback is enable=
d)
> + *
> + * Contains content for USB request block transmissions
> + */
> +struct ixxat_tx_urb_context {
> +	struct ixxat_usb_candevice *dev;
> +	struct urb *urb;
> +	u16  urb_index;
> +	u16  msg_index;
> +};

[Severity: Low]
Are these docs out of date? The fields @msg_packet_len and @msg_packet_no
are documented but missing from the structure definition.

Also, it looks like this header uses standard types such as spinlock_t,
atomic_t, struct urb, and struct can_priv without including their respective
headers. Does it need the appropriate #include directives to be self-contai=
ned?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723072955.3257=
5-1-stephane.grosjean@free.fr?part=3D1
