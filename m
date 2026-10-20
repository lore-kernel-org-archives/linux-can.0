Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792506336;
	b=Qks4QEmOplGgjT7as8ltY6LAZTd/wASw7M/FJAutW/e1p6tbNtyEjVewlY6DZcTrQ+w6
	 u1pmcn0Y9PL7qLo+cwDFzp0ARgSZiVEotDTWlro8fXZVjFapkEZnbj8egmDk1lvUQUTwM
	 t8121klC2+UqlTaYH4bzX+1bErej8SMkT5jATf/yuQewnGF+vCBGkbB9E3nz/toqYI8we
	 hpQPTrdg2MWmAUAbKraedZoDRHPVbdUwOAFuNjU56mcJkqfIUQ7kkDUYcTAbcCRgRcqoa
	 1i+Ub9Zpb8Ltc1RnuS4tI2J+9+LXaSPxQu2/AhanN06yc4E4rYXE+691Lz50DRNH7Ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792506336;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=fH7uC11oan8avu344KAtHP4P50pS0c4A51vcr/6T3tQ=;
	b=DCEBevPVhAqMepQr5v349nBWSF5XTPKHh7C5QyJyPTCFnfkzbS91D0JJmRGeXz8wwOhR
	 y6W0n/EGaRVx4ONRBqneY9ajU6GlZMNYtBwr0Gg4uOfpPHQmNkZSHM9pYpbV5yh80+19Y
	 8wQys35nJ7Jdwq/1KApUuYeVGLm7ArPPoxXkf7FWfclqmDuahiUgFYP0k7K+AafZFUK5L
	 eb2cUs62QDv0nG2EYlKCHRbuzUAc3Y205to7RYKJPP+iJpE+luSskTDfxndrcuRCvZzyD
	 HyedGmIgbFNQrub0553VH+asIs4jAiHw/1BW8nGLZ9XNtCsEIVQFSr00L5iUw6cB12Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nGQrzVqN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CFF606A31A
	for <linux-can@vger.kernel.org>; Tue, 20 Oct 2026 14:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nGQrzVqN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2C991F000C6;
	Tue, 20 Oct 2026 14:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792506336;
	bh=fH7uC11oan8avu344KAtHP4P50pS0c4A51vcr/6T3tQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nGQrzVqNL8S0Af7fPgay0OWre58LyK4v8/AjagM/EHE/g1fxLik/PbKrbeA8scWlz
	 IatuRuRXAm5wrpT1Zs4FF30ga1DOFl1ugr1rTWIlRO6mKoyR1uOaXoUWpawcQsB0Bx
	 yh38i3sB/bRCgEfpQzfC+tNv9E/gfqrpAV8gy5yHlXeqTR/naLiRTLtKIvUcMkgXF6
	 QOEkPIVfem7ziR9jd3Brbf/1FXFl0zZrKAfV9CZCuEnIWYRb32R3+r29aE/n2aZg+o
	 6RmebV+OZ5hxdZueO8MYV0FYsndgdAiDjTcYvr439XXSnxymB6dyVtzJP/oQYvOMDX
	 q2WNawW5qXsmw==
Message-ID: <sashiko-outbox-179124@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 07/10] can: peak_usb: fix RX cursor desync for
 self-received RTR frames with SRR
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?U3TDqXBoYW5lIEdyb3NqZWFu?= <s.grosjean@peak-system.fr>
Cc: linux-can@vger.kernel.org, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20261020-canfd_check_channel_idx-v5-7-a62b35b867f0@peak-system.fr>
References: <20261020-canfd_check_channel_idx-v5-0-a62b35b867f0@peak-system.fr>
 <20261020-canfd_check_channel_idx-v5-7-a62b35b867f0@peak-system.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 14:25:35 +0000
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] can: peak_usb: premature rx_bytes update in pcan_usb_decode_data=
()
--

commit c248d15b40b1ad16b34ab57a3fec82b4f7b5a805
Author: St=C3=A9phane Grosjean <s.grosjean@peak-system.fr>

can: peak_usb: fix RX cursor desync for self-received RTR frames with SRR

This commit moves the PCAN_USB_TX_SRR client private ID byte skip out of the
non-RTR branch in pcan_usb_decode_data() so that self-received RTR frames
also advance the RX cursor past the trailing SRR byte.

> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/us=
b/peak_usb/pcan_usb.c
> index 93da0fd4f10e7..4c8cfed31634a 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
> @@ -697,16 +697,19 @@ static int pcan_usb_decode_data(struct pcan_usb_msg=
_context *mc, u8 status_len)
>  		memcpy(cf->data, mc->ptr, cf->len);
>  		mc->ptr +=3D rec_len;
> =20
> -		/* Ignore next byte (client private id) if SRR bit is set */
> -		if (can_id_flags & PCAN_USB_TX_SRR) {
> -			if ((mc->ptr + 1) > mc->end)
> -				goto decode_failed;
> -			mc->ptr++;
> -		}
> -
>  		/* update statistics */
>  		mc->netdev->stats.rx_bytes +=3D cf->len;
>  	}
> +
> +	/* Ignore next byte (client private id) if SRR bit is set.
> +	 * Note: this test must be done even when the frame is an RTR frame.
> +	 */
> +	if (can_id_flags & PCAN_USB_TX_SRR) {
> +		if ((mc->ptr + 1) > mc->end)
> +			goto decode_failed;
> +		mc->ptr++;
> +	}

[Severity: Medium]
In drivers/net/can/usb/peak_usb/pcan_usb.c, pcan_usb_decode_data() now
increments mc->netdev->stats.rx_bytes inside the non-RTR branch before the
PCAN_USB_TX_SRR bounds check.

If a non-RTR frame has PCAN_USB_TX_SRR set in can_id_flags and the buffer is
truncated such that (mc->ptr + 1) > mc->end, this jumps to decode_failed:

	decode_failed:
		dev_kfree_skb(skb);
		return -EINVAL;

Doesn't this leave mc->netdev->stats.rx_bytes incremented for a malformed
frame that gets dropped and is not counted in rx_packets?

> +
>  	mc->netdev->stats.rx_packets++;
> =20
>  	/* convert timestamp into kernel time */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020-canfd_chec=
k_channel_idx-v5-0-a62b35b867f0@peak-system.fr?part=3D7
