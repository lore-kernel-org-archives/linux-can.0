Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBD8369D5C
	for <linux-can@vger.kernel.org>; Fri, 25 Sep 2026 10:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790330697; cv=none; b=pHRYrFn0/Cyhw9TltdpB8SEce+tgo/RIkLvmr5pa4K4fIjtttTXR5mSk9CNP7MxYhngq/mj2b1NQ4FbF6rXs0XzIZmXlmvb9paAtsfI5ps5r1rbEv+0vxhSy2Yh+VgtGiRykdM9J32t0NbnU5wG52OwnIJTfV7UO8LXHNgCNe14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790330697; c=relaxed/simple;
	bh=Ww2Nqs6a9ulMQ0fctWvq/PbF/Yi2WjLWixzdc75UWCA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iTIdj7F3jWOg/t2PMgPe2R2CNvtKsLFMUPDSo6CunJ72aErCWctuq0FuwSxHiNbBgoBAzQ0ufvTh06cS2G4fJBDezHuD5tBulx1Ec+RbbuVSL15h6cprN+Dcwts107wwJshIYWbia9aqq05Q0W+vPxLUcLNtArvgXQB2lc7vh0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mktZfxAH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mktZfxAH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3C4A1F00898;
	Fri, 25 Sep 2026 10:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790330696;
	bh=3kilONXY8ydGah0o0CkD1EP+0/zcEMbq7+a+YX6qV2I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mktZfxAH8ZImpcPV16kiyTEW8IJVqtfrOCw2l2ffWa3bqpHwx5Rvi5PqjXmTomNMW
	 e/doA+7WRqvWyKGeX68Z7ts3eP0X2lkddarmjgFWaVGneEZiCxFmDMIXPDOlHHB18W
	 nlYa42rUD6qdC6w8rhqig/l2G0mv+Id2Qm4mtNCwXms46S/Ie9B/O3WiKT7Li988Q7
	 1RJ8eb+ltVoG9AQaFIG8QKglJ11xNWsOVI1BjF8OFKor8dZv1Y42gkVGhPBbd/tC7n
	 5JXjwvT2Q57TynnY2GX1M6GgUrQlKguLxglNQ+iNZM5WTnPc+cNGg4m0COv+pV6bFv
	 8l11mbPnaUNyg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] can: peak_usb: Add PCAN-USB bus errors reporting
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?U3TDqXBoYW5lIEdyb3NqZWFu?= <stephane.grosjean@free.fr>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, linux-can@vger.kernel.org, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20260925-peak_usb-v2-1-f3257bdeb7e6@peak-system.fr>
References: <20260925-peak_usb-v2-1-f3257bdeb7e6@peak-system.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 10:04:55 +0000
Message-Id: <20260925100455.E3C4A1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] can: peak_usb: Stale error counters due to missing decrement updat=
es
- [Medium] can: peak_usb: OOB read of 1 byte in pcan_usb_handle_bus_evt()
--

commit ea2fc1382b5e301ffcd1133cccb20af80b430884
Author: St=C3=A9phane Grosjean <s.grosjean@peak-system.fr>
Subject: can: peak_usb: Add PCAN-USB bus errors reporting

This commit adds PCAN-USB bus error reporting capabilities that were
previously missing. It modifies the driver to decode bus error interrupts
and forward the resulting CAN error frames to userspace.

Link: https://patch.msgid.link/20260924-peak_usb-v1-1-d48875169a59@peak-sys=
tem.fr

> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/us=
b/peak_usb/pcan_usb.c
> index 8fd058c328564..786f6600a5bfa 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb.c

[ ... ]

> @@ -550,23 +564,92 @@ static int pcan_usb_decode_error(struct pcan_usb_ms=
g_context *mc, u8 n,
>  /* decode bus event usb packet: first byte contains rxerr while 2nd one =
contains
>   * txerr.
>   */
> -static int pcan_usb_handle_bus_evt(struct pcan_usb_msg_context *mc, u8 i=
r)
> +static int pcan_usb_handle_bus_evt(struct pcan_usb_msg_context *mc, u8 i=
r,
> +				   u8 status_len)
>  {
>  	struct pcan_usb *pdev =3D mc->pdev;
> =20
> -	/* according to the content of the packet */
> -	switch (ir) {
> -	case PCAN_USB_ERR_CNT_DEC:
> -	case PCAN_USB_ERR_CNT_INC:
> +	/* process bus error interrupt */
> +	if (ir & PCAN_SJA1000_IRQ_BEI) {

[Severity: High]
Will this discard valid counter decrements when the Bus Error Interrupt flag
is not set?

The parsing of rxerr and txerr was moved entirely inside this
if (ir & PCAN_SJA1000_IRQ_BEI) block. Since the BEI (Bus Error Interrupt)
flag is only set by the controller when an error occurs (increasing the
counters), status updates during successful transmissions that decrease the
counters will be ignored because they lack the BEI bit.

This leaves pdev->bec artificially high, which can cause
pcan_usb_decode_error() to incorrectly evaluate CAN_STATE_ERROR_PASSIVE
instead of CAN_STATE_ERROR_WARNING, breaking the CAN state machine.

> +		u8 rec_len =3D status_len & PCAN_USB_STATUSLEN_DLC;
> +		u8 *pd =3D mc->ptr, ecc =3D 0;
> =20
> -		/* save rx/tx error counters from in the device context */
> -		pdev->bec.rxerr =3D mc->ptr[1];
> -		pdev->bec.txerr =3D mc->ptr[2];
> -		break;
> +		/* Check for potential out-of-bound accesses */
> +		if ((pd + rec_len - 1) > mc->end)
> +			return -EINVAL;

[Severity: Medium]
Does this bounds check in pcan_usb_handle_bus_evt() allow an out-of-bounds
read?

If a device crafts a PCAN_USB_REC_BUSEVT record where rec_len is 1, and
pd is exactly at mc->end, (pd + 1 - 1) > mc->end evaluates to false.
This permits the code to proceed and execute:

        if (rec_len >=3D 1) {
            ecc =3D *pd++;
           =20
            /* save rx/tx error counters from record data bytes */
            if (rec_len >=3D 2) {
                pdev->bec.rxerr =3D *pd++;
                if (rec_len >=3D 3)
                    pdev->bec.txerr =3D *pd++;
            }
        }
       =20
        ...
        cf->data[6] =3D pdev->bec.txerr;
        cf->data[7] =3D pdev->bec.rxerr;
        ...
        netif_rx(skb);

This leaks the out-of-bounds byte from the kernel heap into the cf->data
payload via the netif_rx() call.

> +
> +		if (rec_len >=3D 1) {
> +			ecc =3D *pd++;
> +
> +			/* save rx/tx error counters from record data bytes */
> +			if (rec_len >=3D 2) {
> +				pdev->bec.rxerr =3D *pd++;
> +				if (rec_len >=3D 3)
> +					pdev->bec.txerr =3D *pd++;
> +			}
> +		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925-peak_usb-v=
2-1-f3257bdeb7e6@peak-system.fr?part=3D1
