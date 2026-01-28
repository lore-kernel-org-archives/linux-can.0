Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30852F1FDB
	for <linux-can@vger.kernel.org>; Wed, 28 Jan 2026 09:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769591240; cv=none; b=XyWKbkY2rnYrtxc+XlUYrF1iBChCGiGljnOsARuY7ksLrczcBY0SGayH+flq9x+fUh1EiIZKtdZr2ohFK+3IgTjSh+rJ69DtdmZjLuMmGB2e7WTQkUUmf/0+jv6WzQR++Ts9yQGigWCf+L5WiX9zgFT1dLREBkphPG/g9dGVJNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769591240; c=relaxed/simple;
	bh=q20nxD76+Q+wL9SPZdlE5mMCzD15ljcJ64PXAESkvD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gr81XF/njsI7m1GjwcRzYt6CHnZE3/CTAtr7PkWMg7pxZQUlOniOUVF0vc9V6XSZ3L+C0bpQZG3oHJWxABk9E4m1N7h/b1bJNE30uN0ISnSdnWLja6Kn0xPdpEYizRD1K7hUYgdSWUzjHwa0N4gqpQff7TR7xpwd6d7XCDhv/pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vl1W6-0005SR-Ez; Wed, 28 Jan 2026 10:07:14 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vl1W6-002tBa-2d;
	Wed, 28 Jan 2026 10:07:14 +0100
Received: from pengutronix.de (p54b15bf8.dip0.t-ipconnect.de [84.177.91.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id D0BC14D9FDC;
	Wed, 28 Jan 2026 09:07:13 +0000 (UTC)
Date: Wed, 28 Jan 2026 10:07:13 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	linux-can@vger.kernel.org
Subject: Re: [net-next 0/6] move CAN skb headroom content to skb extensions
Message-ID: <20260128-booby-of-phenomenal-proficiency-4db5ab-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <20260125201601.5018-1-socketcan@hartkopp.net>
 <20260127174937.4c5fc226@kernel.org>
 <67cb17f4-2f72-4847-aa04-3633f3d8df33@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oecpvtn4tbaqv6yo"
Content-Disposition: inline
In-Reply-To: <67cb17f4-2f72-4847-aa04-3633f3d8df33@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--oecpvtn4tbaqv6yo
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [net-next 0/6] move CAN skb headroom content to skb extensions
MIME-Version: 1.0

On 28.01.2026 09:42:14, Oliver Hartkopp wrote:
> On 28.01.26 02:49, Jakub Kicinski wrote:
> > On Sun, 25 Jan 2026 21:15:55 +0100 Oliver Hartkopp wrote:
> > > CAN bus related skbuffs (ETH_P_CAN/ETH_P_CANFD/ETH_P_CANXL) simply co=
ntain
> > > CAN frame structs for CAN CC/FD/XL of skb->len length at skb->data.
> > > Those CAN skbs do not have network/mac/transport headers nor other su=
ch
> > > references for encapsulated protocols like ethernet/IP protocols.
> > >
> > > To store data for CAN specific use-cases all CAN bus related skbuffs =
are
> > > created with a 16 byte private skb headroom (struct can_skb_priv).
> > > Using the skb headroom and accessing skb->head for this private data
> > > led to several problems in the past likely due to "The struct can_skb=
_priv
> > > business is highly unconventional for the networking stack." [1]
> > >
> > > This patch set aims to remove the unconventional skb headroom usage f=
or
> > > CAN bus related skbuffs and use the common skb extensions instead.
> >
> > This is fine. Wish we could make md_dst work, since skb_ext still burns
> > a bit in the skb (last extension bit in fact, next user will have to
> > bump the filed size). And you very much do not route these frames,
> > so dst would work perfectly fine. But whatever.
> >
> > lore never received patch 6, tho, you'll need to repost.
>
> Thanks for looking at it.
>
> In fact patch 6 stuck in my providers mail system which responded this to
> (only) patch 6 =C2=AF\_(=E3=83=84)_/=C2=AF
>
> 5.7.1 Refused by local policy. No SPAM please! (B-EX
> 155302::1769588601-AC38E895-223F95BA/10/71040183929) see https://www.stra=
to-hosting.co.uk/faq/product/why-are-my-emails-not-being-delivered
> [MSG0011]
>
> As this could not been solved since Sunday I'll kindly ask Marc to send t=
he
> attached v2 patchset (including your __u32 remark) to the mailing list, so
> that also the AI bot can take a look at it.

I'll do. In the mean time, please have a look at b4, it has support for
sending patches via a web hook.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--oecpvtn4tbaqv6yo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAml50b0ACgkQDHRl3/mQ
kZygZgf/VWTJ2JkoEt/40+QxwYk9FrPmBoGP/kAPdwGnUlTbInH9pGSHi3xYgl/H
pFASJ2WVslfXsb2I7pNAMbAzgWu8G3ze1ZHU1hPFBFNElKRrKtu4GvJZItrb7cgK
vXkCrvdefN3F3EpcE4vnRPo2+rY0zz662VUN1NMVYNY3Sy42DaR4qNqC/a+PVSzf
M/rip52cYRhohIZr0YdR8tphKKi3vHx22EveK7e74oEW53UbpWjLnaCGUe6vCOKN
Mx9g/T6cKMEw3mfG1DvsXiUvd9QzuXcvJpmf8Vf9KLi2ty7AawoTWJ2ZbNj3yUZ+
gWIrxF+LOXQ3FCta5qJEFFeSUTtLmw==
=y1V3
-----END PGP SIGNATURE-----

--oecpvtn4tbaqv6yo--
