Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C0E43E4B1
	for <linux-can@vger.kernel.org>; Thu, 27 Aug 2026 12:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787832656; cv=none; b=EJ5kOTB153PLxaNQHu+KK0l+YlSjEIk2oGJvcE5tRjwkcTDcIqdF+DF/vPoHyxW+4YC313riMqucadVkpL/HlWOwPRu3QcZvDX9Yg67nraV/B5eJhvBCxlHTWHriepxw6cC+akAZ15ud0EM0MfSNlEM5lY5XPD1YwK2SbKRkQ5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787832656; c=relaxed/simple;
	bh=wTRcIim8oHVCxIzo5t/7MMYjgRtFy3u+WzmNgULcwDA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d6lUIKFEe7Lw9m5IQcIZnWBjFcywqyeb9MWzzH63Tzwi4ji0+yd7fPL7QDgCNdlGt/Z0KXc6J/QpidUD659fFB912l9C3tlZYU8TZBU8+I+AjbEJaXAS1RXxHnM5gaYQ2I8gx9GAxHvvqhT5zwHAeigMDl6lEN2Bkvd3HDKzPGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n6yKEv3C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n6yKEv3C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 141C21F00A3A;
	Thu, 27 Aug 2026 12:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787832655;
	bh=cdpAqEhynTG419mDkTaqf7hevqdqhkHLc37f6XKW/g8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n6yKEv3CM5zyC4s5xMgtecn9JIS/+XNbCQ4sxEicItB7rLZfLFfIiJbk/6JctFWm5
	 FDfqcGWMNuVyVY/bruYoPvyMbuKS+NxnJbUTT52JUrfRoKpi30M/ytQsaxGGv1EoBy
	 OIgRv7d3zdngY5BeRM4jkDP7wV0quwLRLsePlqh4SXUuTe1e7wd8shK2EDDMmpq+V8
	 wxtVeWu9mEymqE2FusHahJd0axJMD4bWcZcLtR5Ypl5cXUbkJnyy5Aax0uHt+8ZHl0
	 xvI5TnFNerYa4gws6ovk5LNVyv8mZKTNyRoGiu1nhCraFnwSZQURZbmWja37XBe9qZ
	 R9SCCDFCUrJPg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 02/14] can: convert unreliable ARPHRD_CAN type
 checks to robust can_get_ml_priv()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org
In-Reply-To: <20260826121036.2706424-3-mkl@pengutronix.de>
References: <20260826121036.2706424-1-mkl@pengutronix.de>
 <20260826121036.2706424-3-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 12:10:54 +0000
Message-Id: <20260827121055.141C21F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Modifying cloned SKB data without unsharing causes data races and =
potential silent data corruption in shared CAN FD buffers.
--

commit cd014a29d1194dd4eff54897a5d2062f2ec32a0c
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: convert unreliable ARPHRD_CAN type checks to robust can_get_ml_priv()
   =20
This patch converts unreliable ARPHRD_CAN type checks to use the robust
can_get_ml_priv() function. This prevents TUN/TAP devices from spoofing
their hardware type to bypass CAN device validation.

Link: https://patch.msgid.link/20260819160822.8256-1-socketcan@hartkopp.net

> diff --git a/net/can/af_can.c b/net/can/af_can.c
> index 7bc86b176b4de..ef435f22ac933 100644
> --- a/net/can/af_can.c
> +++ b/net/can/af_can.c
> @@ -226,7 +226,7 @@ int can_send(struct sk_buff *skb, int loop)
>  		goto inval_skb;
>  	}
> =20
> -	if (unlikely(skb->dev->type !=3D ARPHRD_CAN)) {
> +	if (unlikely(!can_get_ml_priv(skb->dev))) {

[Severity: High]
This is a pre-existing issue, but while reviewing the changes in can_send(),
I noticed a potential data race when handling cloned SKBs.

When the CAN gateway forwards a frame without modification functions,
can_can_gw_rcv() forwards a cloned SKB:

net/can/gw.c:can_can_gw_rcv() {
    ...
    nskb =3D skb_clone(skb, GFP_ATOMIC);
    ...
    can_send(nskb, gwj->limit_hops);
}

Then in can_send() just above this diff hunk, the SKB data area is modified
unconditionally for CAN FD frames:

net/can/af_can.c:can_send() {
    ...
    } else if (can_is_canfd_skb(skb)) {
        struct canfd_frame *cfd =3D (struct canfd_frame *)skb->data;
        ...
        /* set CAN FD flag for CAN FD frames by default */
        cfd->flags |=3D CANFD_FDF;
    }
    ...
}

Since skb_clone() shares the data area with the original SKB, does modifying
cfd->flags without unsharing the SKB first cause a data race?

On architectures without atomic byte-store instructions, this performs a
word-sized read-modify-write operation. If the original SKB is concurrently
processed by other receivers, could this silently corrupt adjacent fields?
Given that an unprivileged user with CAP_NET_ADMIN in a user namespace can
set up a virtual CAN interface and trigger this path, is this safe?

>  		err =3D -EPERM;
>  		goto inval_skb;
>  	}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826121036.2706=
424-1-mkl@pengutronix.de?part=3D2
