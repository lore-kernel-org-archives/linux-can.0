Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF00D381EB0
	for <linux-can@vger.kernel.org>; Tue, 14 Jul 2026 11:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784029279; cv=none; b=OpkwpnB5CTVxgFdAuJeBfa7vk+RUyFn2YjFuxWQX8h4oUY4JJt7qhq487TBxIENjWgMc/qbzG5sDx7y7ZP1F+Xv+tl0FGa3rnncjuxRMVNeugIQ5q/Qz1t15NeMDGaR4xNy4hps/vhseB4FdZ86K3DBYkoCtOw8wWysf3vW5kh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784029279; c=relaxed/simple;
	bh=e9ie2++O17/2VsJs45NMWpbGyEMrtX5HgOp1uHeudlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=grEjUrTWszVTaoiOry/pd60XwdmEwL45moTKiyL+se4pyfK/Epp0bX3655K5NCKiBWKeuXOeozMVmo8jiISkGzZfcNEXolrrktuVEOyZWrBd6C7Onsd3oPDvk/Mod/ukPQuW4uxrkLgOrz9HkLTn5/BGExmwEF72h9L4n4Os0DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id A11A920220C;
	Tue, 14 Jul 2026 13:41:13 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wjbVh-001lPl-1f;
	Tue, 14 Jul 2026 13:41:13 +0200
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 3EE13568AD0;
	Tue, 14 Jul 2026 11:41:13 +0000 (UTC)
Date: Tue, 14 Jul 2026 13:41:12 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: sashiko-reviews@lists.linux.dev, 
	Oleksij Rempel <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, Vincent Mailhol <mailhol@kernel.org>
Subject: Re: [PATCH v13 09/11] can: bcm: fix stale rx/tx ops after device
 removal
Message-ID: <20260714-towering-phenomenal-nyala-ad406f-mkl@pengutronix.de>
References: <20260714-bcm_fixes-v13-0-fd667c61099a@hartkopp.net>
 <20260714-bcm_fixes-v13-9-fd667c61099a@hartkopp.net>
 <20260714104431.65C751F000E9@smtp.kernel.org>
 <2c2bc659-fd26-4c48-a5f4-e9e6a3c43003@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qa6k2nuxrgbfho5b"
Content-Disposition: inline
In-Reply-To: <2c2bc659-fd26-4c48-a5f4-e9e6a3c43003@hartkopp.net>


--qa6k2nuxrgbfho5b
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v13 09/11] can: bcm: fix stale rx/tx ops after device
 removal
MIME-Version: 1.0

On 14.07.2026 13:24:17, Oliver Hartkopp wrote:
> On 14.07.26 12:44, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential is=
sue(s) to consider:
> >
> > Pre-existing issues:
> > - [High] Unprotected concurrent access to op->rx_stamp and op->rx_ifind=
ex in bcm_rx_handler causes data races and torn 64-bit reads on 32-bit arch=
itectures.
>
> Fixed in patch 10

Pre-existing issues are not a shot stopper, _new_ issues for a patch
series are...usually are.

Hopefully upstream will accept that you fix issues in a later patch that
sashiko claim to be introduced by a patch in the series.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--qa6k2nuxrgbfho5b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCalYgVAAKCRDMOmT6rpmt
0lNSAQD6GfIEjXJHGYZqTyGmtHCfVPtPBOYWpgzZ3UTec0b0EAEAtn3WIp88WKz7
1SrSo+BgBDk7E+Lg8fxp8rNhf+WyowE=
=jZXP
-----END PGP SIGNATURE-----

--qa6k2nuxrgbfho5b--
