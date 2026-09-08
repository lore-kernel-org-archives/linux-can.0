Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96F64CB8A3;
	Tue,  8 Sep 2026 08:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788857924; cv=none; b=rTEDarOBkqE8Xzet45erA3pVTRhFIwgxJuVPBPXArQZ7qd+98rW6aaetAVbPEfWEHeEGdlpSjXJ1s45cr2kb6O02Vc2Zato7/qePBb7AP26o+ZOCAGh8G4cURSjWwNvek0QvjnbBwkfJYpCzZwORbfaIYsOtBxkPDKjtPQRH44M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788857924; c=relaxed/simple;
	bh=CTsQdxysntUGntTxp2s7c8/ETcCzeu8SXsWlEmKuqxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uUvikYWRFsOo5rlLiyEfDm96Bvh3jWa/o9DuA0Un+RIRBkx48Au/0eAHfLQ+Wyiy12o23KqPMJZ//MM3uTgfTj44ObA+LADrNAQ8llLfOufb45vG20hAQ2EDZ/9vWjaQEUILXeBW17hDM+1zBSNLAVeInP4KERbbzksCiXJFZ2A=
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
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id C9AEA20177F;
	Tue, 08 Sep 2026 10:58:26 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1x3res-000gXD-2J;
	Tue, 08 Sep 2026 10:58:26 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 616925972E3;
	Tue, 08 Sep 2026 08:58:26 +0000 (UTC)
Date: Tue, 8 Sep 2026 10:58:25 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
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
Message-ID: <20260908-defiant-mauve-woodpecker-0e0f62-mkl@pengutronix.de>
References: <20260907104942.17089-1-ciprianmarian.costea@oss.nxp.com>
 <20260907-lively-easygoing-groundhog-51cdd3-mkl@pengutronix.de>
 <6bdc8044-34de-4d7a-89a5-908de7f8b044@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2x5jigtab6tpbqlb"
Content-Disposition: inline
In-Reply-To: <6bdc8044-34de-4d7a-89a5-908de7f8b044@oss.nxp.com>


--2x5jigtab6tpbqlb
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


FYI: somehow the series description ended up in the subject

On 07.09.2026 18:07:42, Ciprian Marian Costea wrote:
> On 9/7/2026 4:49 PM, Marc Kleine-Budde wrote:
> > On 07.09.2026 12:49:39, Ciprian Costea wrote:
> > > From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> > >
> > > This series:
> > >    1. Makes the irq_queue per-CPU so the handlers no longer share a l=
ist.
> >
> > As sashiko pointed out, using per-CPU variables in a preemptible context
> > doesn't work. When proposing to use per-CPU variables I haven't thought
> > that far. So in hindsight this approach is not good.
> >
> > What about following what NAPI does. Have a dedicated data structure per
> > IRQ. I think these ones are needed:
> >
> > | 	struct sk_buff_head skb_irq_queue;
> > | 	u32 skb_queue_len_max;
> > |
> > | 	unsigned int mb_first;
> > | 	unsigned int mb_last;
> >
> > And pass them to can_rx_offload_queue_timestamp() and
> > can_rx_offload_irq_finish().

If the RX-Offload knows the number of concurrent IRQs, you can optimize
for the single IRQ case and keep skb_queue_splice_tail_init(), while for
the other case you should sort the skbs into the offload->skb_queue
list.

> Thanks for replying.
> Indeed the per-CPU approach should be dropped. I've also missed the
> PREEMPT_RT case.
> Your proposal seems better than even having a dedicated spinlock for
> skb_irq_queue operations as I've originally thought.
>
> One thing to confirm before I go ahead and implement this approach for V6:
> Having the following connected patchset in mind [1] which separates the I=
RQ
> handlers, both flexcan MB IRQs currently run flexcan_do_mb() over the full
> iflag. Therefore, to actually separate the producers I'll have each IRQ
> drain only its own mb_first..mb_last range into its own queue - is this t=
he
> right approach ?

Yes!

Please look out for shared ressources (read-modify-write registers,
etc..) when accessing the mailboxes concurrently from 2 (or more) IRQs.
After a quick look I haven't found any.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--2x5jigtab6tpbqlb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCap/OLwAKCRDMOmT6rpmt
0gC+AP0XJdF0jo1CfnOQqWOPjOdZRSTRYgJxQ/iIjLgdE84A3wEAyf2YhGx0Gr5s
CMrG0nCwwLxVzMmHBw9CJ51rtQbPXAQ=
=hr1P
-----END PGP SIGNATURE-----

--2x5jigtab6tpbqlb--
