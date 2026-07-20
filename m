Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867633FE34D
	for <linux-can@vger.kernel.org>; Mon, 20 Jul 2026 14:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784556959; cv=none; b=SLb4Kz9RqrQiuAsJioqwS9BdDNfJN2hMHkeXyHoFPU0qA3PIdPPpzRGXAyZmMIGaJ7XIoGZSzbSMeV/6/FB1VyJAkNYqtzdel9RdhnLVgrDq5xLTZEs8SastRgyl7UePanYkPhdm/YCffGCj4or266JE4G8E5xIh3X0FyVVUmAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784556959; c=relaxed/simple;
	bh=FwVXe76OAlig9iXCKIlr5cDLGHH7gfyWg4gFjRymav8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ffhW4oJ6R37QVR9OcixOIRUE6qUUlW/jR0dBKvMwnPp98gCJt5DLa95j+uzcudvhYRJVWgFs8+Vt9t3c6IgMIfugk9oWeJlc2Dvw9z1Z60Xa3W//wcKU7RxKRKYDq2zdywQCk5qnmz+fvZ7TlS+9jUSKhbwUXhWJqCFTuUjyU2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mzDEq895; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mzDEq895"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B2961F000E9;
	Mon, 20 Jul 2026 14:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784556958;
	bh=QTBlc9H1xtBCh9Ijqa2A3bT/oVndY75kvnztUdncVyw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mzDEq895VsuuAXOCkIhQovaYlfeA/8Qa1DyqlnhCwQqPRIjx9WE2PWh7gI5bS0NCO
	 vQwZ5VMpZpQdl/dSn6KsElwEW5w51p/7YGWywkMuj94nuole9NwIJlpYRAOvj81F7Z
	 PSKtvGVmrIGwmSqW0tyyQS4UBWX3irXsP943+WZAGnsa3LZ3JtrDbC8ZbgF8OuqdnE
	 6ZqYhT0b9ggyKMRWFgGwSRVc6q3d7/2d+VWtStfS4IEksq9FJMTxuw7/2uW1byZ6GD
	 lid20phrnQv+SLzq7JW6MPLlbRm8wf4LICS6cK6peG+e7PUA170pddd3jvrRGQmTPZ
	 BTh9ifFkKDW2A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH can-next 09/13] can: gs_usb: gs_usb_state_get_by_hf():
 optionally print recived CAN error frames
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, linux-can@vger.kernel.org, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20260720-gs_usb-new-features-v1-9-427a8013c380@pengutronix.de>
References: <20260720-gs_usb-new-features-v1-0-427a8013c380@pengutronix.de>
 <20260720-gs_usb-new-features-v1-9-427a8013c380@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 14:15:56 +0000
Message-Id: <20260720141557.8B2961F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The driver reads uninitialized kernel heap memory or stale URB d=
ata from `data[1]`, `data[6]`, and `data[7]` when processing short CAN erro=
r frames.
--

--- Patch [9]: [PATCH can-next 09/13] can: gs_usb: gs_usb_state_get_by_hf()=
: optionally print recived CAN error frames ---
commit f418a47ba868ccfb1b18e7b941a14de6bd026311
Author: Marc Kleine-Budde <mkl@pengutronix.de>

can: gs_usb: gs_usb_state_get_by_hf(): optionally print recived CAN error f=
rames

This commit introduces a netdev_dbg() statement in gs_usb_state_get_by_hf()
to parse and print the current CAN error state and error frame payload,
making debugging easier across different gs_usb compatible implementations.

> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index e41f91b56ab82..2848cb1a75f03 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c
> @@ -670,6 +670,21 @@ gs_usb_state_get_by_hf(const struct gs_can *dev, con=
st struct gs_host_frame *hf,
>  			else
>  				tx_state =3D CAN_STATE_ERROR_ACTIVE;
>  		}
> +
> +		const u8 tx_err =3D hf->classic_can->data[6];
> +		const u8 rx_err =3D hf->classic_can->data[7];

[Severity: Medium]
Could this lead to reading uninitialized kernel heap memory or stale URB da=
ta
if a device sends a short CAN error frame?

If a malfunctioning USB device sends an error frame where CAN_ERR_FLAG is s=
et
but specifies a can_dlc of less than 8, gs_usb_get_minimum_rx_length() might
calculate a small minimum_length based on the untrusted can_dlc.

This allows short packets to bypass the bounds checks. When
gs_usb_state_get_by_hf() unconditionally accesses data[6] and data[7] here,
it can read beyond the actual received payload length.

> +
> +		netdev_dbg(dev->netdev, "host_frame: TX-state=3D'%s/%u' RX-state=3D'%s=
/%u' %s%s%s%s%s%s%s",
> +			   can_get_state_str(tx_state), tx_err,
> +			   can_get_state_str(rx_state), rx_err,
> +			   hf->can_id & cpu_to_le32(CAN_ERR_BUSOFF) ? "bus-off " : "",

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720-gs_usb-new=
-features-v1-0-427a8013c380@pengutronix.de?part=3D9
