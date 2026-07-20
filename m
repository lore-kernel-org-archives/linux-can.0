Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834CA42B30D
	for <linux-can@vger.kernel.org>; Mon, 20 Jul 2026 14:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784557713; cv=none; b=s8YNREbXC3Za193OmSFAlm5JSwI/VWcVHD1rK8l6BHqFubN1nXEYYJ6njWk1B1tJZAaz4y3LvypegciM6W+m1e534PKe4PwGBos+0XCHqgwVcMsLF7U6oP+3MjvaQclDE1pTV8Z5C2P6+4AcV7ZzBlshIwIdK5L91UzRdrRH92c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784557713; c=relaxed/simple;
	bh=vIgjC1R1im03YPHX9UXxHQ1SllpnnPn7w0sHGnY32hw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=szaS2YzX92Xr4vdRDUjgM8VKumacF4tENHRH7k7C2259Nb2PG3o+qALMLR1TakrAHWYjGst23yXeqotHf+U0kYvEPo2F4hWzq9d7xF11mA4Rwcspu9RPYFKrifQU/v+VJuVvZxD1rPjclAnUu5wu97L6c73ZWHBWl8jiFPBKHdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ok85aKqF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ok85aKqF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B766D1F000E9;
	Mon, 20 Jul 2026 14:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784557712;
	bh=YVQMxXs3QGvFi4c9rmi4SS3xblcBtXl/MorE/MTWO1w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ok85aKqFbXyrVLMk5EZmSvkO1aOsecj77wKt4TQU7xmkK+MSFmTiU1iATBqy5/D61
	 gB90IO0dIv5qvVrBCQ5PXLvGixzb1PCJKkI9BSwPeP++4yOquRrNsoh/S9wxMryX67
	 4FStE8aVOLMsi36pTEbiWRAd/wOyRJ06CEfX/WPpNQ6kyizt4b55fDxmYnEGqoS/x0
	 ApmJJMgfwa1Iq082L9AwiQwZSdLKZyAgy1gCGQ3kQYZrfEpV5E5FFGyNwKn3VboVgp
	 yEBHyeK4UgBcoPkUrws8v0cdUsi55t4ygmdgjJu5wEQsb0IDNnj3zO0i1RqRJsM6rT
	 CWc8OWcCDCPsQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH can-next 13/13] can: gs_usb: implement CAN bus off
 recovery
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, "Vincent
 Mailhol" <mailhol@kernel.org>, "Marc Kleine-Budde" <mkl@pengutronix.de>
In-Reply-To: <20260720-gs_usb-new-features-v1-13-427a8013c380@pengutronix.de>
References: <20260720-gs_usb-new-features-v1-0-427a8013c380@pengutronix.de>
 <20260720-gs_usb-new-features-v1-13-427a8013c380@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 14:28:31 +0000
Message-Id: <20260720142831.B766D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The CAN_ERR_RESTARTED bit check in gs_update_state() is always f=
alse because the bit is unconditionally cleared at the beginning of the fun=
ction.
--

--- Patch [13]: [PATCH can-next 13/13] can: gs_usb: implement CAN bus off r=
ecovery ---
commit 7b5dd8a47b695ccb806d9d65e91f427368f07215
Author: Marc Kleine-Budde <mkl@pengutronix.de>

can: gs_usb: implement CAN bus off recovery

This patch implements manual CAN bus off recovery for gs_usb devices that
support the GS_CAN_FEATURE_BUS_OFF_RECOVERY feature. It allows the USB host
to control bus off recovery instead of relying on the hardware's automatic
recovery.

Link: https://github.com/candle-usb/candleLight_fw/pull/317

> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c

[ ... ]

> @@ -573,14 +579,22 @@ static void gs_update_state(struct gs_can *dev, str=
uct can_frame *cf,
>  		return;
> =20
>  	/* some firmware does automatically CAN bus off recovery, account for t=
his */
> -	if (cf->can_id & CAN_ERR_RESTARTED ||
> -	    (dev->can.state =3D=3D CAN_STATE_BUS_OFF && new_state < CAN_STATE_B=
US_OFF)) {
> +	if (!(dev->feature & GS_CAN_FEATURE_BUS_OFF_RECOVERY) &&
> +	    (cf->can_id & CAN_ERR_RESTARTED ||
> +	     (dev->can.state =3D=3D CAN_STATE_BUS_OFF && new_state < CAN_STATE_=
BUS_OFF))) {

[Severity: Medium]
Will the check for CAN_ERR_RESTARTED ever evaluate to true in this
condition?

Looking earlier in gs_update_state(), the CAN_ERR_RESTARTED bit is
unconditionally cleared from cf->can_id:

	cf->can_id &=3D ~(CAN_ERR_CRTL | CAN_ERR_BUSOFF | CAN_ERR_RESTARTED);

Because of this, the check for CAN_ERR_RESTARTED here appears to be
structurally guaranteed to be false. Could this cause the driver to miss
bus-off restart events if the cached state was not already CAN_STATE_BUS_OF=
F?

>  		can_stats->restarts++;
>  		/* some firmware doesn't set CAN_ERR_RESTARTED, fixup */
>  		cf->can_id |=3D CAN_ERR_RESTARTED;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720-gs_usb-new=
-features-v1-0-427a8013c380@pengutronix.de?part=3D13
