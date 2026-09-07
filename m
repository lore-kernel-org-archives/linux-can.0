Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB464EE858;
	Mon,  7 Sep 2026 13:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788789165; cv=none; b=c39cfsA+Wq2Bqa0knAbgNeCJ17ZHJk973TbItYdpxCYPeZA8qOHGDpBGQUZfd25cTSqeK5P8Kv5YTAjnZGwoAEmctaI68hLXFoqd2krv2632Tals85clhPktQsTtJ+wRjFg8BIA6OfUOhXkXt0A3n8y3ZsGSlm2ibwL9/aPUMWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788789165; c=relaxed/simple;
	bh=0bjz/3k0ABD846dQQr54nF2Hj7OJ2PwtD4QZHf9wCbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=unHCUKfD2l5d89cnajqNSVNjtTGA4dggaScrAynC0ceRQF8VO69i3O4bWwjcvKcOw9XufjYRBnd9nkhhjE3V5fSFUjsN1/6A+shNh4oaksHy1iBTufGJ82mb9xRtJ3wIvm9RV+o8vA8tEodOKGgDoWP4pfr698l3uXTNBsfUWMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
X-PTX-Original-Recipient: alexandre.belloni@bootlin.com
X-PTX-Original-Recipient: mailhol@kernel.org
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-PTX-Original-Recipient: imx@lists.linux.dev
X-PTX-Original-Recipient: nicolas.ferre@microchip.com
X-PTX-Original-Recipient: s32@nxp.com
X-PTX-Original-Recipient: ciprianmarian.costea@oss.nxp.com
X-PTX-Original-Recipient: claudiu.beznea@tuxon.dev
X-PTX-Original-Recipient: dev.kurt@vandijck-laurijssen.be
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id B59B32018B6;
	Mon, 07 Sep 2026 15:52:26 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1x3Zlq-000Xy5-21;
	Mon, 07 Sep 2026 15:52:26 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C8492596948;
	Mon, 07 Sep 2026 13:49:24 +0000 (UTC)
Date: Mon, 7 Sep 2026 15:49:24 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
Cc: Vincent Mailhol <mailhol@kernel.org>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>, 
	linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, imx@lists.linux.dev, NXP S32 Linux Team <s32@nxp.com>
Subject: Re: [PATCH v5 0/3] can_rx_offload keeps a lockless irq_queue that
 the IRQ handlers fill and that is later spliced under skb_queue.lock into
 the NAPI-facing skb_queue. This works as long as a single context fills the
 irq_queue. flexcan with FLEXCAN_QUIRK_SECONDARY_MB_IRQ and mcf5441x use two
 mailbox IRQ lines. When those are affined to different CPUs the two handlers
 can enqueue into the same list at the same time and corrupt it.
Message-ID: <20260907-lively-easygoing-groundhog-51cdd3-mkl@pengutronix.de>
References: <20260907104942.17089-1-ciprianmarian.costea@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="z3ydzlstb6mz4j6c"
Content-Disposition: inline
In-Reply-To: <20260907104942.17089-1-ciprianmarian.costea@oss.nxp.com>


--z3ydzlstb6mz4j6c
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 0/3] can_rx_offload keeps a lockless irq_queue that
 the IRQ handlers fill and that is later spliced under skb_queue.lock into
 the NAPI-facing skb_queue. This works as long as a single context fills the
 irq_queue. flexcan with FLEXCAN_QUIRK_SECONDARY_MB_IRQ and mcf5441x use two
 mailbox IRQ lines. When those are affined to different CPUs the two handlers
 can enqueue into the same list at the same time and corrupt it.
MIME-Version: 1.0

On 07.09.2026 12:49:39, Ciprian Costea wrote:
> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>
> This series:
>   1. Makes the irq_queue per-CPU so the handlers no longer share a list.

As sashiko pointed out, using per-CPU variables in a preemptible context
doesn't work. When proposing to use per-CPU variables I haven't thought
that far. So in hindsight this approach is not good.

What about following what NAPI does. Have a dedicated data structure per
IRQ. I think these ones are needed:

| 	struct sk_buff_head skb_irq_queue;
| 	u32 skb_queue_len_max;
|
| 	unsigned int mb_first;
| 	unsigned int mb_last;

And pass them to can_rx_offload_queue_timestamp() and
can_rx_offload_irq_finish().

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--z3ydzlstb6mz4j6c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCap7A4gAKCRDMOmT6rpmt
0tuZAQCogFQ+QoWQNO6hDtuUMx9jES7Eaf1siU6qm8CmFEtYUgEAjL4yL5o2L/jP
fDbWTNDMHBDKnrwVfBb55SMkxq6uAA0=
=gQZJ
-----END PGP SIGNATURE-----

--z3ydzlstb6mz4j6c--
