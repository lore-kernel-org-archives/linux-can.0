Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD51D3A3E73
	for <linux-can@vger.kernel.org>; Thu,  6 Aug 2026 13:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786024500; cv=none; b=kVpkQR5Poq/gnYxB0yAo5mrQGv7bTpneRWZTX4hQADGHC2yn3Zi7ngu+UTvJMhmwJi4+s+Y+8gDrKFXC6B2gq1jpHjYcV1i4K91l0JUC/P2CZfmBHt290pfhL1Ltd4E+hbyy1opFThBK5GxkbP2cdlnfEmbYJTmiWV5tTUpfsnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786024500; c=relaxed/simple;
	bh=9/cbU4RNldWi0AIat3Y0PkcSYhCrEk05pZyuFBHPFZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O7eFVRkB02bFe7StKPkLQ557USuXmUE/R8iu8nikXAgm4+sZgR5PmtLiSB4Ycs6+jREGXmNX9nj5AVTkYwJ0d9zuMXuQnaH/KpVesLxuly54gYM6nf/w1R+wJOmhmQ4uX3tcCL/k9P31iVEXG9ZzcxqVLj82w3lZMqJh/2rYxV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 6CD29202055;
	Thu, 06 Aug 2026 15:54:49 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wryYb-0006FL-17;
	Thu, 06 Aug 2026 15:54:49 +0200
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 1668E57D105;
	Thu, 06 Aug 2026 13:54:49 +0000 (UTC)
Date: Thu, 6 Aug 2026 15:54:48 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: sashiko-bot@kernel.org
Cc: Filippo Storniolo <fstornio@redhat.com>, 
	Oleksij Rempel <o.rempel@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, 
	Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Subject: Re: [PATCH can-next v2 3/3] can: add can diag interface
Message-ID: <20260806-ruby-raven-of-elegance-432d46-mkl@pengutronix.de>
References: <20260806-feat-can-diag-v2-0-832597ee4cb9@redhat.com>
 <20260806-feat-can-diag-v2-3-832597ee4cb9@redhat.com>
 <20260806135125.343781F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sv2675y7ftieqnbo"
Content-Disposition: inline
In-Reply-To: <20260806135125.343781F000E9@smtp.kernel.org>


--sv2675y7ftieqnbo
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH can-next v2 3/3] can: add can diag interface
MIME-Version: 1.0

On 06.08.2026 13:51:22, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] Netlink UAPI attributes embed binary structures with implicit co=
mpiler padding
> --
>
> --- Patch [3]: [PATCH can-next v2 3/3] can: add can diag interface ---
> commit 98771deaa2e2d4a790b170eb8967f6122234dec8
> Author: Filippo Storniolo <fstornio@redhat.com>
>
> can: add can diag interface
>
> This commit adds the can_diag interface for querying CAN sockets from
> userspace using the ss tool. It defines the userspace ABI including netli=
nk
> request and response structures to expose socket properties.
>
> > diff --git a/include/uapi/linux/can/diag.h b/include/uapi/linux/can/dia=
g.h
> > new file mode 100644
> > index 0000000000000..7f99f85c42425
> > --- /dev/null
> > +++ b/include/uapi/linux/can/diag.h
> [ ... ]
> > +struct can_diag_j1939_addr {
> > +	__u64	name;
> > +	__u32	pgn;
> > +	__u8	addr;
> > +};
>
> [Severity: High]
> Does this structure introduce implicit compiler padding? With a 64-bit, 3=
2-bit,
> and 8-bit field, it appears there are 3 bytes of implicit padding at the =
end.
> This can lead to architecture-dependent layout mismatches in the UAPI.
>
> Additionally, modern Netlink design rules strongly discourage passing bin=
ary
> structures directly inside attributes. Should these structure members be =
broken
> out into individual Netlink attributes to ensure proper validation and fu=
ture
> extensibility?
>
> > diff --git a/net/can/diag.c b/net/can/diag.c
> > new file mode 100644
> > index 0000000000000..e9132ba3f8cc5
> > --- /dev/null
> > +++ b/net/can/diag.c
> [ ... ]
> > +static int sk_diag_fill(struct sock *sk, struct sk_buff *skb,
> [ ... ]
> > +	case CAN_J1939:
> > +	{
> > +		struct can_diag_j1939_addr j1939_addr;
> > +
> > +		memset(&j1939_addr, 0, sizeof(j1939_addr));
> > +
> > +		j1939_addr.name =3D can_addr.can_addr.j1939.name;
> > +		j1939_addr.pgn =3D can_addr.can_addr.j1939.pgn;
> > +		j1939_addr.addr =3D can_addr.can_addr.j1939.addr;
> > +
> > +		err =3D nla_put(skb, CAN_DIAG_J1939_ADDR, sizeof(struct can_diag_j19=
39_addr),
> > +			      &j1939_addr);
> > +	}
>
> [Severity: High]
> Does sending this binary structure directly as a raw attribute prevent pr=
oper
> validation and extensibility?
>
> Once this ships in a release, the UAPI is frozen and this layout becomes
> unfixable. Could this be changed to send the individual fields as separat=
e,
> strongly-typed attributes instead of embedding the C structure directly?

Sounds like a valid point. How is this handled with other diag data?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--sv2675y7ftieqnbo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCanSSJgAKCRDMOmT6rpmt
0h7VAP9Ih6E1S6WqXwO6uJvPL7CjjYhLMCHhwU/1GlFBQsGBTQEAtGyqGBdoWnM2
cNlaCUG7tRS0rI3eVPRzSbPjba6eaws=
=WNak
-----END PGP SIGNATURE-----

--sv2675y7ftieqnbo--
