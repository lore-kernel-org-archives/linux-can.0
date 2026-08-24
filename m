Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE953E7BBD;
	Mon, 24 Aug 2026 10:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787566605; cv=none; b=E3aRamWYP9LbxEQ+5FKv0EpdUkz3Xn9xRz4gNdnQaaaG58Hr3XLwrV/QRmvbGCI4qoSrHYR8jCbNyoOCRCVBX71UtT06lMYB9KgGOvYlFCQ2pX7yGV1SgHGioullryQ6usbtP9QcEhTqbD1PkyU+faQr+3eIX98FlbofLyFLRpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787566605; c=relaxed/simple;
	bh=NGwBWQrSn1f/7ALE6N0sk7ApTNXlY6dyMDSj+LRH1gA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e1UBOdFGaP4Vk+6wnhgvaYuEywgw8RqHzfrEzL/Vc/sKkg3X/JokszjrqtRBuMRMGOjPXxNiiAqiFMvAEPiPhTv3CsoTMRLeQ5JVgRKZYw2p6U1sfN+hMwIiiJXpDUU1P71tIOy5JbJt+xgkIAwCKwPbCO8vHwDqwJpXudxq4yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 25F9F2010D6;
	Mon, 24 Aug 2026 12:16:40 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wyRjL-0035Xp-3B;
	Mon, 24 Aug 2026 12:16:40 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A796258B268;
	Mon, 24 Aug 2026 10:16:39 +0000 (UTC)
Date: Mon, 24 Aug 2026 12:16:39 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Bough Chen <haibo.chen@oss.nxp.com>
Cc: sashiko-reviews@lists.linux.dev, 
	Ciprian Costea <ciprianmarian.costea@oss.nxp.com>, robh@kernel.org, conor+dt@kernel.org, Frank.Li@kernel.org, 
	Oleksij Rempel <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, imx@lists.linux.dev, 
	Oliver Hartkopp <socketcan@hartkopp.net>, Vincent Mailhol <mailhol@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 3/6] can: flexcan: split rx/tx masks per mailbox IRQ
 line
Message-ID: <20260824-mustang-of-original-fame-4b3a91-mkl@pengutronix.de>
References: <20260713085306.2643794-1-ciprianmarian.costea@oss.nxp.com>
 <20260713085306.2643794-4-ciprianmarian.costea@oss.nxp.com>
 <20260713090803.CCE2E1F000E9@smtp.kernel.org>
 <20260824101241.ysq45swzx4ihctel@shlinux89>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="23nbqcy73hx4u2kj"
Content-Disposition: inline
In-Reply-To: <20260824101241.ysq45swzx4ihctel@shlinux89>


--23nbqcy73hx4u2kj
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 3/6] can: flexcan: split rx/tx masks per mailbox IRQ
 line
MIME-Version: 1.0

On 24.08.2026 18:12:41, Bough Chen wrote:
> On Mon, Jul 13, 2026 at 09:08:03AM +0000, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential is=
sue(s) to consider:
> >
> > Pre-existing issues:
> > - [High] Concurrent execution of multiple flexcan IRQ handlers causes l=
ockless list corruption in the can_rx_offload queue.
> > --
> >
> > --- Patch [3]: [PATCH v6 3/6] can: flexcan: split rx/tx masks per mailb=
ox IRQ line ---
> > commit 9f143e05fb5957d463ce1d05d4126d168798b0d8
> > Author: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> >
> > can: flexcan: split rx/tx masks per mailbox IRQ line
> >
> > This commit updates flexcan to process split rx/tx masks based on the
> > mailbox IRQ line for platforms like S32G2. It introduces MB0 and MB1 ma=
sks
> > and passes them to flexcan_do_mb() to only process the relevant mailbox
> > range for each IRQ.
> >
> > > diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can=
/flexcan/flexcan-core.c
> > > --- a/drivers/net/can/flexcan/flexcan-core.c
> > > +++ b/drivers/net/can/flexcan/flexcan-core.c
> >
> > [ ... ]
> >
> > > @@ -1244,8 +1255,14 @@ static irqreturn_t flexcan_irq_mb(int irq, voi=
d *dev_id)
> > >  	struct net_device *dev =3D dev_id;
> > >  	struct flexcan_priv *priv =3D netdev_priv(dev);
> > >  	irqreturn_t handled;
> > > +	u64 mb_mask =3D ~0ULL;
> > > +
> > > +	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_SECONDARY_MB_IRQ)
> > > +		mb_mask =3D (irq =3D=3D priv->irq_secondary_mb) ?
> > > +			  FLEXCAN_SECONDARY_MB_IRQ_MB1_MASK :
> > > +			  FLEXCAN_SECONDARY_MB_IRQ_MB0_MASK;
> > >
> > > -	handled =3D flexcan_do_mb(dev);
> > > +	handled =3D flexcan_do_mb(dev, mb_mask);
> > >
> > >  	if (handled)
> > >  		can_rx_offload_irq_finish(&priv->offload);
> >
> > [Severity: High]
> > This is a pre-existing issue, but does this concurrent execution risk
> > corrupting the lockless rx-offload queues?
> >
> > Since the primary and secondary mailbox IRQs are separate lines (e.g., =
on
> > S32G2), they can be dispatched concurrently on different CPUs when fram=
es
> > arrive simultaneously for both mailbox groups.
> >
> > If both IRQs execute at the same time:
> >
> > CPU1
> > flexcan_irq_mb()
> >    flexcan_do_mb()
> >       can_rx_offload_irq_offload_timestamp()
> >          __skb_queue_add_sort(&offload->skb_irq_queue, ...)
> >
> > CPU2
> > flexcan_irq_mb()
> >    flexcan_do_mb()
> >       can_rx_offload_irq_offload_timestamp()
> >          __skb_queue_add_sort(&offload->skb_irq_queue, ...)
> >
> > Or if CPU2 reaches the finish step while CPU1 is still adding:
> >
> > CPU2
> > flexcan_irq_mb()
> >    can_rx_offload_irq_finish()
> >       skb_queue_splice_tail_init(&offload->skb_irq_queue, ...)
> >
> > Since __skb_queue_add_sort() and skb_queue_splice_tail_init() operate
> > locklessly on offload->skb_irq_queue, could this lead to corrupted link=
ed
> > list next/prev pointers or infinite loops during list traversal?
>
> Hi Ciprian Costea,
>
> Please double check whether S32 can generate these two mb interrupt at
> the same time, if not, no need change, just comment this feature, if
> yes, then need to add lock.

If the IRQ is delayed for some reason, mailboxes 7 (associated with
mb-0) and 8 (associated with mb-1) might be pending at the same time.

I assume that both IRQs will fire. One workaround would be to only use
the mb-1 IRQ until the rx-offloading has been fixed.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--23nbqcy73hx4u2kj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCaowaBQAKCRDMOmT6rpmt
0sLJAQDgj+mugeJoBBdtCb4CiLYS3Z0HoOdnlZYJjWCglth7ZQEA2FFoB0ldtyha
tL8E40aGkK00bWNAggsJSF+pLhnLgQc=
=Z2Sp
-----END PGP SIGNATURE-----

--23nbqcy73hx4u2kj--
