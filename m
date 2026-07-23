Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5637B4908D9
	for <linux-can@vger.kernel.org>; Thu, 23 Jul 2026 19:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784834862; cv=none; b=lgHIei8XSTv2FbVtGuhA1/zHzZMNSxZlG634a/kuuhouXRsvJTDLvMQFerSrJqxc7XEsC4+tKTR6qouYiI5TfYBaCn716oev7lnWap0rV2iFZ1aw0/4WrPPPbeY6rNt7WXIz0v6RQXITLctCbefsjTo57bg6D+fHTy2SkduJMdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784834862; c=relaxed/simple;
	bh=0Vgphh8GY7utSOK3JNzI4I3wafSvlTD94wMCq4UjD3s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZL0Ht+InkJavveEoGjR14Ckhe1wxzyDUonayopdmyn5fKimnv04fl2kbfq1uw2mGTebnyIwN7SvN6zwLQB1z3Hj5iJH5S9Admpqwi/DuH3Zl6f1YJCyyDImuGitbccQ1e8hNYJTt/4XZQ91eGCFBDFo+xNqla2zAKGtajmxLr80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JP1jK4XI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JP1jK4XI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8A301F000E9;
	Thu, 23 Jul 2026 19:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784834861;
	bh=iDdVXvMN4hw9LyCBmSl1x3yAaPF1CPJ+DtLeJFHjCB8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JP1jK4XIiBKf94ZZAoUqQDmHm+oABrJk4U17wkQx9Uk81ApRxmaoB6QPqdPlTv3zL
	 hg+EWoZ/jHrkYRmSIIHFp8WUXecv8XlGuIOUSEjed/SApn5ub0yM5A+0+Q6sq4Snd2
	 ZwwJnueje1EL90L4gA3hzx5Mz36FiRApCy9aj45AKWFIWmcDstYlV71+dNvXwAIzHg
	 oCobTZmPMLRC7YEycmkiLTSFdXa10d8acGceTlG3ojIMEdMcc1jGQvuBI0yIHeFIZy
	 frABwtUq0vxzb+IaRrxHB7rdBmalowze32PGIPF2x1fvWkE2t2u16x9E5S1zno1sUl
	 NZ0guMDUcLmEw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] can: ctucanfd: use self-test mode for PRESUME_ACK
Reply-To: sashiko-reviews@lists.linux.dev
To: "Avi Weiss" <thnkslprpt@gmail.com>
Cc: "Oleksij Rempel" <o.rempel@pengutronix.de>, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Vincent
 Mailhol" <mailhol@kernel.org>, linux-can@vger.kernel.org, "Oliver Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <20260722192726.230729-1-thnkslprpt@gmail.com>
References: <20260722192726.230729-1-thnkslprpt@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 19:27:40 +0000
Message-Id: <20260723192740.D8A301F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Missing bounds check on `RWCNT` when calculating RX frame leng=
th can lead to kernel heap overflow.
--

--- Patch [1]: [PATCH net] can: ctucanfd: use self-test mode for PRESUME_AC=
K ---
commit 84cf60cfa3d4dbe2be47f85be01d189d34ce05a7
Author: Avi Weiss <thnkslprpt@gmail.com>

can: ctucanfd: use self-test mode for PRESUME_ACK

This commit uses self-test mode for CAN_CTRLMODE_PRESUME_ACK so transmitted
frames can complete without receiving an ACK. It fixes an issue where the A=
CK
forbidden mode prevented the controller from acknowledging received frames.

> diff --git a/drivers/net/can/ctucanfd/ctucanfd_base.c b/drivers/net/can/c=
tucanfd/ctucanfd_base.c
> index 0ea1ff28dfce8..8e0a606f2c84e 100644
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

[Severity: Critical]
This is a pre-existing issue, but can this code in ctucan_read_rx_frame()
cause a heap buffer overflow?

drivers/net/can/ctucanfd/ctucanfd_base.c:ctucan_read_rx_frame() {
    ...
	wc =3D FIELD_GET(REG_FRAME_FORMAT_W_RWCNT, ffw) - 3;

	/* DLC */
	if (FIELD_GET(REG_FRAME_FORMAT_W_DLC, ffw) <=3D 8) {
		len =3D FIELD_GET(REG_FRAME_FORMAT_W_DLC, ffw);
	} else {
		if (FIELD_GET(REG_FRAME_FORMAT_W_FDF, ffw))
			len =3D wc << 2;
		else
			len =3D 8;
	}
	cf->len =3D len;
	if (unlikely(len > wc * 4))
		len =3D wc * 4;
    ...
}

If the hardware returns RWCNT < 3, doesn't wc underflow to a very large
unsigned integer?

This appears to allow len to become large enough to cause the subsequent lo=
op
to write out-of-bounds. Furthermore, if RWCNT is between 20 and 31, wc could
be up to 28, making len up to 112.

Since cf->data only has space for 64 bytes (CANFD_MAX_DLEN), could this copy
more bytes than allocated and overflow the heap backing the SKB?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722192726.2307=
29-1-thnkslprpt@gmail.com?part=3D1
