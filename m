Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9706A353A80
	for <linux-can@vger.kernel.org>; Thu, 24 Sep 2026 15:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790262140; cv=none; b=DMtzqMtrGgXkpEuarvsWntasksFSAnu2BH4ZmuUPUEAOtDGMN/X0Pur7jJhRrgmFd74L5YkVR12lh0jHvhX/dhfc+hNdHd7tAlf5rORP0n2WJ19CQiQXL7UyDNa/qXQbnBND23SRq5+3KI9csLw0s+6DcBvnsjMU/eodfBAgjVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790262140; c=relaxed/simple;
	bh=66EixHdViA0EkDglif5uTgvqwXTBE9WbibN3zStCe/c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Fa71xJZM43VEErqDMO17a4xPyhhqY08xip2U63nrNCAvUx7vHtt1GN4qALw3bFw7F6lLZ5GI21EI5fri698lAqNnxo7LuirHl+kn1PeFZsQCF35kVYQhJ68hJKK2+JpQBZgxgDc187GwHfTaXa1I3YyDnFiaA1fwriw3dQA5blE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EfKcEklV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EfKcEklV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22DD91F00893;
	Thu, 24 Sep 2026 15:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790262137;
	bh=8OIixdXrDU+bHsyt3M00xu6rgdU3Qjwj//sfVrgUOac=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EfKcEklVFQ3hW5KIl4G/wkNdPqw9FCYhJVW2HC1NQoAySiNWWmdnZ0C4xgB2bwqWk
	 Vx2o6ydyAS9NOQ1nVLNK/684XWKd7GxNWAQBKHdCzSxw+XluTPJGkZA3XI1Udk4Ob2
	 7zTR9LeKzNtdOmvgA1JIRu5FCGpcX8Lvj+MKtLvEmsgl1v55KwzvW8/kBF9twYKMhV
	 tb3XT+ybE73HZf79Z+MTJ7SWq64fEywoD8kJyT9El/TrUouz9mJgzOirxdwKsWM8hT
	 LnXR6WLUym7fi71RXRi8yNPq8aplDsPMqrf5ggljIm1bdrk0XVs2ALg/79Dj2X0NOZ
	 eTn9V1gqVz0vg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] can: peak_usb: Add PCAN-USB bus errors reporting
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?U3TDqXBoYW5lIEdyb3NqZWFu?= <stephane.grosjean@free.fr>
Cc: linux-can@vger.kernel.org, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20260924-peak_usb-v1-1-d48875169a59@peak-system.fr>
References: <20260924-peak_usb-v1-1-d48875169a59@peak-system.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 15:02:16 +0000
Message-Id: <20260924150217.22DD91F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] can: peak_usb: out-of-bounds read in pcan_usb_handle_bus_evt() due=
 to delayed bounds check
--

commit a04e1603d8018a183d7ea3984b27c9b6064aa261
Author: St=C3=A9phane Grosjean <s.grosjean@peak-system.fr>

can: peak_usb: Add PCAN-USB bus errors reporting

This patch adds CAN bus error reporting to the PCAN-USB driver by decoding
the bus error interrupt payload and submitting it as a CAN error frame.

> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/us=
b/peak_usb/pcan_usb.c
> index 8fd058c328564..e5be07f3dd54c 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
[ ... ]
> @@ -569,6 +584,83 @@ static int pcan_usb_handle_bus_evt(struct pcan_usb_m=
sg_context *mc, u8 ir)
>  		break;
>  	}
> =20

[Severity: Medium]
This is a pre-existing issue, but looking at the switch statement just above
this new block, if a USB packet arrives with ir =3D 0x80, both
PCAN_USB_ERR_CNT_INC and PCAN_SJA1000_IRQ_BEI equal 0x80.

The switch statement executes first and unconditionally reads mc->ptr[1]
and mc->ptr[2] without checking the payload size:

switch (ir) {
case PCAN_USB_ERR_CNT_DEC:
case PCAN_USB_ERR_CNT_INC:
        pdev->bec.rxerr =3D mc->ptr[1];
        pdev->bec.txerr =3D mc->ptr[2];
        break;

Does this result in an out-of-bounds read in the switch statement for
short packets before the new if block executes?

> +	/* process bus error interrupt */
> +	if (ir & PCAN_SJA1000_IRQ_BEI) {
> +		u8 rec_len =3D status_len & PCAN_USB_STATUSLEN_DLC;
> +		u8 *pd =3D mc->ptr, ecc =3D 0;
> +
> +		if (rec_len > 2)
> +			ecc =3D *pd++;
> +
> +		if (rec_len > 1) {
> +			/* save rx/tx error counters from data bytes */
> +			pdev->bec.rxerr =3D *pd++;
> +			pdev->bec.txerr =3D *pd++;
> +		}

[Severity: High]
Here rec_len is used to read up to 3 bytes from the buffer using pd.
However, looking at pcan_usb_decode_status(), the bounds check against
mc->end is deferred until after pcan_usb_handle_bus_evt() returns.

If a malicious USB device provides a status_len indicating rec_len > 1
but a payload shorter than rec_len, does this read past mc->end?

> +
> +		/* create an "bus-error frame" skb if any bit is set in ECC */
> +		if (ecc) {
> +			struct net_device_stats *stats =3D &mc->netdev->stats;
> +			struct sk_buff *skb;
> +			struct can_frame *cf;
> +			u8 can_err_tx =3D 0;
> +
> +			pdev->dev.can.can_stats.bus_error++;

[Severity: Medium]
This isn't a bug introduced by this patch, but this increments network
statistics directly. If multiple RX URBs complete concurrently across
different CPUs, can updates to bus_error or rx_errors race and drop
increments on architectures without atomic increment instructions?

> +
> +			/* Error occurred during reception? */
> +			if (ecc & PCAN_SJA1000_ECC_DIR) {
> +				stats->rx_errors++;
> +			} else {
> +				stats->tx_errors++;
> +				can_err_tx =3D CAN_ERR_PROT_TX;
> +			}
[ ... ]
> +			/* set error location */
> +			cf->data[3] =3D ecc & PCAN_SJA1000_ECC_SEG;
> +
> +			cf->data[6] =3D pdev->bec.txerr;
> +			cf->data[7] =3D pdev->bec.rxerr;
> +
> +			if (status_len & PCAN_USB_STATUSLEN_TIMESTAMP) {
> +				struct skb_shared_hwtstamps *hwts =3D
> +					skb_hwtstamps(skb);
> +
> +				peak_usb_get_ts_time(&mc->pdev->time_ref,
> +						     mc->ts16, &hwts->hwtstamp);
> +			}
> +
> +			netif_rx(skb);

[Severity: High]
If the bounds check hasn't occurred yet, ecc, rxerr, and txerr could be
populated with uninitialized bytes read past mc->end.

Does placing these out-of-bounds bytes into the SKB and passing it to
netif_rx() leak heap memory to userspace?

>  	}
> =20
>  	return 0;
>  }
[ ... ]
> @@ -627,7 +719,7 @@ static int pcan_usb_decode_status(struct pcan_usb_msg=
_context *mc,
> =20
>  	case PCAN_USB_REC_BUSEVT:
>  		/* bus event notifications (get rxerr/txerr) */
> -		err =3D pcan_usb_handle_bus_evt(mc, n);
> +		err =3D pcan_usb_handle_bus_evt(mc, n, status_len);
>  		if (err)
>  			return err;
>  		break;

[Severity: High]
Is the bounds check for this packet deferred too late?

pcan_usb_handle_bus_evt() is called here and uses the unvalidated rec_len
to process the packet, but the bounds check ((mc->ptr + rec_len) > mc->end)
does not happen until the end of pcan_usb_decode_status().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924-peak_usb-v=
1-1-d48875169a59@peak-system.fr?part=3D1
