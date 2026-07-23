Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C261470EAD
	for <linux-can@vger.kernel.org>; Thu, 23 Jul 2026 07:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784793104; cv=none; b=Ml7ED0bpQtc6uU/hDhFOezMeIU6eIYPR4v9GOGAIxVOAFmoZjwkdncJJk00OWSat27yV1dA0LwWOP5qL+rj6JywBVp5aFJiQBYqr26BNboREO2v5MR82b4KzxR21pcUErqhFVJylpAbEDscU+FIz08OqnqcyR9SkjqHeTC1KvBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784793104; c=relaxed/simple;
	bh=wDzqGmJZ7xr9y3aP6fweXUq7TCPPCD3K6egKtUWbd24=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HSHAeWjDvj2Rn8I8hDyOlM3JSVJyEkxpuAmkG1IMb05U1mWNg1DYY4oVyv3OjLEL5bNA3AVM0Cx0i2eYTnbhmTCgteYyk/jW8UzY//gqAyI8hBF0icMBDrVdR/hq0+qL/bkDQqmaYdD+ZD7wL4Pwj2CsZmI9t/d0dmTnLO843hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 692B61F000E9;
	Thu, 23 Jul 2026 07:51:42 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] can: usb: ixxat_usb: add CL1 legacy protocol layer
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?U3TDqXBoYW5lIEdyb3NqZWFu?= <stephane.grosjean@free.fr>
Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20260723072955.32575-3-stephane.grosjean@free.fr>
References: <20260723072955.32575-1-stephane.grosjean@free.fr>
 <20260723072955.32575-3-stephane.grosjean@free.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 07:51:38 +0000
Message-Id: <20260723075142.692B61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The commit message claims that the adapter descriptor references=
 open, close, start, and stop callbacks, but these are neither implemented =
nor present in the adapter structure.
--

--- Patch [2]: [PATCH 2/4] can: usb: ixxat_usb: add CL1 legacy protocol lay=
er ---
commit cf00ec1244509265defabbebdffce90e57fb3e67
Author: St=C3=A9phane Grosjean <s.grosjean@peak-system.fr>

can: usb: ixxat_usb: add CL1 legacy protocol layer

This commit implements the CL1 communication protocol for early firmware
versions of IXXAT USB-to-CAN adapters. It adds support for classic CAN 2.0b
frames and sets up bittiming constants and control modes.

>     The exported usb2can_cl1 adapter descriptor references the CL1
>     open/close/start/stop callbacks and the CL1 bittiming constants.

[Severity: Medium]
Is this description accurate? The commit message mentions that the descript=
or
references open, close, start, and stop callbacks, but looking at the
definition of usb2can_cl1 below, only get_ctrl_caps and init_ctrl are prese=
nt.

> diff --git a/drivers/net/can/usb/ixxat_usb/ixxat_usb_cl1.c b/drivers/net/=
can/usb/ixxat_usb/ixxat_usb_cl1.c
> new file mode 100644
> index 0000000000000..c1e337fc3b912
> --- /dev/null
> +++ b/drivers/net/can/usb/ixxat_usb/ixxat_usb_cl1.c
[ ... ]
> +const struct ixxat_usb_adapter usb2can_cl1 =3D {
> +	.clock =3D IXXAT_USB_CLOCK,
> +	.bt =3D &usb2can_bt,
> +	.modes =3D IXXAT_USB_MODES,
> +	.buffer_size_rx =3D IXXAT_USB_BUFFER_SIZE_RX,
> +	.buffer_size_tx =3D IXXAT_USB_BUFFER_SIZE_TX,
> +	.ep_msg_in =3D {
> +		IXXAT_USB2CAN_EP1_IN,
> +		IXXAT_USB2CAN_EP2_IN,
> +		IXXAT_USB2CAN_EP3_IN,
> +		IXXAT_USB2CAN_EP4_IN,
> +		IXXAT_USB2CAN_EP5_IN
> +	},
> +	.ep_msg_out =3D {
> +		IXXAT_USB2CAN_EP1_OUT,
> +		IXXAT_USB2CAN_EP2_OUT,
> +		IXXAT_USB2CAN_EP3_OUT,
> +		IXXAT_USB2CAN_EP4_OUT,
> +		IXXAT_USB2CAN_EP5_OUT
> +	},
> +	.get_ctrl_caps =3D ixxat_usb_get_ctrl_caps,
> +	.init_ctrl =3D ixxat_usb_init_ctrl
> +};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723072955.3257=
5-1-stephane.grosjean@free.fr?part=3D2
