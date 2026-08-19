Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0753BED75
	for <linux-can@vger.kernel.org>; Wed, 19 Aug 2026 16:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787156771; cv=none; b=V4nhuHhMXrF6sXqgZMDwwJSaPKAye/PyvZvSeS1lWP7VHcno/N0Sk0N2aK8cODLQCkNaT/l0BQ26B5u9rJF848teCIttTAhmfDtlHnBdLU9QF6sBKyi03B/hbO1+3OYJEGmAGAr/xHfd6ayG6zbiL1J4XCvkM3yZHjXeME8Pg2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787156771; c=relaxed/simple;
	bh=BIZEHCtIhdiCq7AQrpGY9/pp3rGt6/FZyZ6SnaNGO+E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Gp4fMVluE7SbX01WoKEbM2r5hGkKvhPzVm9bt3o0OEkf86wGItvxba2Fl2913bGKgnBS9fM0DPH4BAL8+1d2FmrTivL0/BbhG0j2VPb6A0LrRXg6M9ie1RvWFDCEYtR0yvo6vIk536FziP95HDChmVVhi3F5s4+nURnmMqcrwWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M0GoyjXT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M0GoyjXT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EF0E1F000E9;
	Wed, 19 Aug 2026 16:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787156769;
	bh=T1x/QBiOYnsymjizeFng7xchJXrRlWpjMTmfdJoQSIk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M0GoyjXTDSeT4UV/o0pOyUFNGMDN5cVspbmKQCEwxHKqj3vbqrdPgJgUJluWKTgY6
	 2kbSc83qyBh51EX0rL2W4LFR1RX+O4Y4puqWtqgIsJgYgFwzu2yG+oGCNgfNJUU0Zy
	 QlVsAYrjYMD7WMvGgLmgyashsP32D8Ij3H3rrLXAO+NbxwEtamn6nKseoUMx7SZDFH
	 g+K+kQnMHow//FbktN3V4A11KZYXNgTP3j6ERUhzlh1BqLUyIjV2UQWT1NiJCwvaA/
	 MQoavzZfJtIGZmvoOgbKEDgGOehh8zQeWhDDheh1XJAqpkbbPs1K8mmryv05U44IZ9
	 91t+B3IkmkkYw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] can: convert unreliable ARPHRD_CAN type checks to
 robust can_get_ml_priv()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Oleksij Rempel" <o.rempel@pengutronix.de>, "Marc Kleine-Budde" <mkl@pengutronix.de>, linux-can@vger.kernel.org, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>
In-Reply-To: <20260819160822.8256-1-socketcan@hartkopp.net>
References: <20260819160822.8256-1-socketcan@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 16:26:08 +0000
Message-Id: <20260819162609.2EF0E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Data modification of shared/cloned SKBs in `can_send()` causes pay=
load corruption for concurrent users.
--

--- Patch [1]: [PATCH] can: convert unreliable ARPHRD_CAN type checks to ro=
bust can_get_ml_priv() ---
commit 57320b2cc995d1852816aaacf79460f42c05858d
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: convert unreliable ARPHRD_CAN type checks to robust can_get_ml_priv()

This commit updates the CAN subsystem to use can_get_ml_priv() for
identifying valid CAN devices instead of relying on ARPHRD_CAN. This
prevents issues with TUN/TAP devices that might overwrite their hardware
type without properly initializing the midlayer private data.

Cc: stable@kernel.org
Cc: Oleksij Rempel <o.rempel@pengutronix.de>

> diff --git a/net/can/af_can.c b/net/can/af_can.c
> index 7bc86b176b4de..ef435f22ac933 100644
> --- a/net/can/af_can.c
> +++ b/net/can/af_can.c
> @@ -226,7 +226,7 @@ int can_send(struct sk_buff *skb, int loop)
>  		goto inval_skb;
>  	}
> =20

[Severity: High]
This is a pre-existing issue, but can modifying the SKB payload here cause
data corruption for concurrent receivers?

Earlier in can_send(), the SKB data is directly modified without checking if
it is shared:

	} else if (can_is_canfd_skb(skb)) {
		struct canfd_frame *cfd =3D (struct canfd_frame *)skb->data;

		skb->protocol =3D htons(ETH_P_CANFD);

		/* set CAN FD flag for CAN FD frames by default */
		cfd->flags |=3D CANFD_FDF;

When routing frames without data modifications, can_can_gw_rcv() creates
a cloned SKB using skb_clone() and passes it to can_send():

net/can/gw.c:can_can_gw_rcv() {
	...
	nskb =3D skb_clone(skb, GFP_ATOMIC);
	...
	can_send(nskb, gwj->limit_hops);
}

Since skb_clone() shares the underlying data buffer, wouldn't modifying
cfd->flags directly in can_send() corrupt the payload for other concurrent
users of the original SKB?

> -	if (unlikely(skb->dev->type !=3D ARPHRD_CAN)) {
> +	if (unlikely(!can_get_ml_priv(skb->dev))) {
>  		err =3D -EPERM;
>  		goto inval_skb;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819160822.8256=
-1-socketcan@hartkopp.net?part=3D1
