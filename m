Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A9B3B5DED
	for <linux-can@vger.kernel.org>; Mon, 20 Jul 2026 14:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784557177; cv=none; b=rMdxvekww0Qry992N+S9IDQ0benBuvHaDvgVw8wwt3XcfWOkHwBo0Jt6CPGsXH5CRDZNbDwKtITe3yzqHEL7EaDGhTxeVgXJJrQZhVwoRuBvmlC4y0CRdT5z/fpqtGp07d9UQ1Avm7TgNDv0eITEFCnsL/6pZlp084XnhhMBSwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784557177; c=relaxed/simple;
	bh=WcTPqq0RfSrAzC6GAsw+Lwf3URyT0VLBs+3YuB0yu+g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hEjbfD0jJNzFqq/W8uITn6gYajB+K+AlUzsarXjtPKgr+0wNInloVcHcsGUea2MDw/CtZME+H1IcXqrhwRDfWrqLGRDh7bMUU8IpN88EbUvzzlgvAu0OtDabq20PGfio4u9LVlJJaMwaZiOM4wW9OPODLwUjY60cTETbsC8GeUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B9SPVapA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B9SPVapA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8827E1F000E9;
	Mon, 20 Jul 2026 14:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784557175;
	bh=zHshlMYkJP0GVe/CfEw36HPMktx5j1KOsndPWi5vGtM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B9SPVapAuBqTrshPrfPEfxFLaIChp/g6EXlkH00hB11H8aPdK1aGgHU+csUgEeQan
	 3SztQgzkOBrwRWf7lyzL3AOaiJNCickH4OUrFv1RWaMmSdd5P7QIk4GVgLx3YkjzKp
	 /Y8gdaYZk2kIXwzNEUz8EE4K9q1C9zwTN33jGP/Cn+XCsuQ5weV732AvjhE1utlXZs
	 lOajVNq9rg1rXpC0WTYvaQLGiKyKlWB9V5ImyD5WaCRO4YFW+TCO9SiLMb0S6s2ERD
	 OYQbaRGIIJsIqD6upbjXstq22Urs+Vd80Vr8Ab7zQwfrfpAUUfg4eb6hvX/tcxiZIs
	 YmLmheIn0eseQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH can-next 11/13] can: gs_usb: implement
 CAN_CTRLMODE_BERR_REPORTING for devices without native support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oleksij Rempel" <o.rempel@pengutronix.de>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oliver Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org
In-Reply-To: <20260720-gs_usb-new-features-v1-11-427a8013c380@pengutronix.de>
References: <20260720-gs_usb-new-features-v1-0-427a8013c380@pengutronix.de>
 <20260720-gs_usb-new-features-v1-11-427a8013c380@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 14:19:34 +0000
Message-Id: <20260720141935.8827E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Out-of-bounds read and use of uninitialized heap memory when proce=
ssing CAN error frames with missing data payload.
- [High] The CAN error filtering logic silently drops CAN_ERR_RESTARTED fra=
mes if they lack a state change flag.
- [Medium] The new CAN error filtering logic drops hardware RX overflow eve=
nts by bypassing the overflow check.

Pre-existing issues:
- [High] Failing to allocate an SKB drops the USB RX URB permanently, event=
ually halting reception.
--

--- Patch [11]: [PATCH can-next 11/13] can: gs_usb: implement CAN_CTRLMODE_=
BERR_REPORTING for devices without native support ---
commit 53e85c22d303a201e9d9f47a5e3240bd4a9af629
Author: Marc Kleine-Budde <mkl@pengutronix.de>

can: gs_usb: implement CAN_CTRLMODE_BERR_REPORTING for devices without nati=
ve support

This commit implements software filtering for CAN bus errors when hardware
support for disabling bus error reporting is unavailable. It adds a check in
the bulk receive callback to drop bus error frames if reporting is disabled,
while still processing CAN state changes. It also unconditionally advertises
bus error reporting support in ctrlmode_supported.

Link: https://github.com/candle-usb/candleLight_fw/pull/303

> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index 186abc95c9774..bc69e6b3c512c 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c
> @@ -724,7 +724,8 @@ gs_usb_should_handle_can_error(const struct gs_can *d=
ev, const struct gs_host_fr
>  		return true;
> =20
>  	/* handle CAN bus errors */
> -	if (hf->can_id & cpu_to_le32(CAN_ERR_LOSTARB | CAN_ERR_PROT | CAN_ERR_T=
RX | CAN_ERR_ACK))
> +	if (dev->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING &&
> +	    hf->can_id & cpu_to_le32(CAN_ERR_LOSTARB | CAN_ERR_PROT | CAN_ERR_T=
RX | CAN_ERR_ACK))
>  		return true;
> =20
>  	return false;

[Severity: High]
If a frame only contains CAN_ERR_RESTARTED but no state change flag, this
appears to fall through and return false. Does this silently drop the
automatic bus-off recovery frame, preventing gs_update_state() from handling
it and leaving the interface stuck in the BUS_OFF state?

[Severity: Medium]
When this returns false, gs_usb_receive_bulk_callback() executes a goto to
resubmit_urb. Does this bypass the hardware overflow check
if (hf->flags & GS_CAN_FLAG_OVERFLOW) at the end of the function,
causing the driver to silently drop hardware RX queue overflow notification=
s?

[Severity: High]
If the USB transfer is shorter than the expected payload (e.g. can_dlc is 0=
),
minimum_length allows processing just the header. Does accessing
hf->classic_can->data[1] during the state check in gs_usb_state_get_by_hf()
read out-of-bounds or use uninitialized heap memory from the URB buffer sin=
ce
it bypasses the padding and zeroing that alloc_can_skb() used to provide?

[Severity: High]
This is a pre-existing issue, but returning directly in
gs_usb_receive_bulk_callback() when alloc_can_skb() fails leaks the URB:

gs_usb_receive_bulk_callback()
    skb =3D alloc_can_skb(netdev, &cf);
    if (!skb)
        return;

Can this lead to permanent loss of RX URBs if memory allocation fails,
eventually halting CAN reception until the interface is reset?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720-gs_usb-new=
-features-v1-0-427a8013c380@pengutronix.de?part=3D11
