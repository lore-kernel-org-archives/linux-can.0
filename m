Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38E974BE1
	for <linux-can@vger.kernel.org>; Mon, 20 Jul 2026 14:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784556025; cv=none; b=KfcuHs4Dz7IMaSOvdo3mJDHJ0U4oH2GM2K68syQ20BHqllvgf7J2D0UyY4i4+NFz2goQOB9cPf+COiD56S4a0GaTIk8Wn9ZavMoRoZD7Py2SvSTk+wG6XnfSI2ZL4i5N2Km/waeixPoziunMnJ8ncV2QuEU/utS6PUme9YCfp7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784556025; c=relaxed/simple;
	bh=+sSkvYiC6wmIZNt2se+021REsQ29dFKHSQteMKVFmIs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=C6ZNAldVNq8+WrgQxuYAX1Ef+0y6t7af2Ca5JalDjXA8eTy8NB2cUh8i4tunyMsrWV7HzlbfY1x+x6gJ2/XhZnLGa0mZCHHTalAz835Nv/LPaqA6L5G/DxjOFiQN0Re4i7qcDh9bfxZUCm3z7LMnytADFxVeaAg0LgFMOVZhjBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BxSOLasR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BxSOLasR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 368601F000E9;
	Mon, 20 Jul 2026 14:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784556024;
	bh=2qB33dZmOq35aMI7B7w9LDsXwUSf5iGtuunwZX584e8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BxSOLasRX7X+BFUvxU2/YndK/mboSjwrgCSm2x/VNt/mT/JTOI/IROW8gWAtHsOQz
	 r1e3iXXBilX1d2vYVz9SjFUsWn+amTCZ1RXtXdkbvOYBpxBjXd/bXa715c4keTpwXo
	 OpdJK57q6dF+xmNzwn5HAptiWhWLFSrmf+m2dyo5J1MZA6vpH9hH6KKnJruHqeypZH
	 62Fg93NlhWJAzLBtjpSrn28gVj6gh8lAf9UQKSFPcpbNheRFs9f1lVTNlr+5mMrAo6
	 nmFzIb8ZQMQnEgFZ+7vGjxUIMlwo8FlGYkXjhwvvRQX832o4vIyNfbNJkW/GiCPphb
	 rVtJgewmpUdcQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH can-next 07/13] can: gs_usb:
 gs_usb_receive_bulk_callback(): reduce scope of several variables
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Oleksij Rempel" <o.rempel@pengutronix.de>, "Vincent
 Mailhol" <mailhol@kernel.org>
In-Reply-To: <20260720-gs_usb-new-features-v1-7-427a8013c380@pengutronix.de>
References: <20260720-gs_usb-new-features-v1-0-427a8013c380@pengutronix.de>
 <20260720-gs_usb-new-features-v1-7-427a8013c380@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 14:00:23 +0000
Message-Id: <20260720140024.368601F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Returning directly on SKB allocation failure drops the USB URB ins=
tead of resubmitting it, permanently reducing the RX URB pool and potential=
ly stalling the receiver entirely.
--

--- Patch [7]: [PATCH can-next 07/13] can: gs_usb: gs_usb_receive_bulk_call=
back(): reduce scope of several variables ---
commit 2f6b205703c7b1ac4e58ba90c1e5b7687566e6e9
Author: Marc Kleine-Budde <mkl@pengutronix.de>

can: gs_usb: gs_usb_receive_bulk_callback(): reduce scope of several variab=
les

This patch improves code readability by reducing the scope of variables
txc, cf, cfd, and skb in gs_usb_receive_bulk_callback().

> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c
[ ... ]
> @@ -705,7 +701,11 @@ static void gs_usb_receive_bulk_callback(struct urb =
*urb)
>  	}
> =20
>  	if (hf->echo_id =3D=3D GS_HOST_FRAME_ECHO_ID_RX) { /* normal rx */
> +		struct sk_buff *skb;
> +
>  		if (hf->flags & GS_CAN_FLAG_FD) {
> +			struct canfd_frame *cfd;
> +
>  			skb =3D alloc_canfd_skb(netdev, &cfd);
>  			if (!skb)
>  				return;

[Severity: High]
This is a pre-existing issue, but does returning directly on skb allocation
failure drop the USB URB instead of resubmitting it?

If enough skb allocations fail under memory pressure, it seems the RX URB p=
ool
will permanently decrease. Could this eventually stall the receiver entirel=
y,
requiring the interface to be brought down and back up to recover?=20

Should this failure path go to the resubmit_urb label instead?

> @@ -719,6 +719,8 @@ static void gs_usb_receive_bulk_callback(struct urb *=
urb)
> =20
>  			memcpy(cfd->data, hf->canfd->data, data_length);
>  		} else {
> +			struct can_frame *cf;
> +
>  			skb =3D alloc_can_skb(netdev, &cf);
>  			if (!skb)
>  				return;

[Severity: High]
This is also a pre-existing issue, but does this allocation failure also le=
ak
the URB by returning directly rather than resubmitting?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720-gs_usb-new=
-features-v1-0-427a8013c380@pengutronix.de?part=3D7
