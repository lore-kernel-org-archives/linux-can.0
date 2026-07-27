Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2E43DD500;
	Mon, 27 Jul 2026 10:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785148807; cv=none; b=DkH750WxzpGksahRdTxPdIh8Te15guprJPRtKhenJ6lqnU5XUbEbciaGF7iA02MNoJYmrhhR63sFcyY6JAAzqsgOFpFNGj+HtUF0ndd01/SDfPkE/me1wjcsE0BqjdokouF2Y+vBfSBi80Ntu28PdKIhyioN7W649so87w0i/PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785148807; c=relaxed/simple;
	bh=JYC5/0XE63uQUKagbd4swqsnyV2mB3tSUtuZyo5mjdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eBTch4oVmi09B7vv+QzDKJbu+E/yYBe7vqw5joP9QMpQ82u2LDvtaWxfHiqCgjMQ/OwEUCnnHpjzWyiaDMozvUQutGoaUTxHNLMCIxtMVRM632gkULbLd3WXVojhA8idMao33ddu2J/ZcRfDmHiajK258bzLKNSCgNwIgI6pu2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 0B260202054;
	Mon, 27 Jul 2026 12:40:01 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1woIka-001Wpu-30;
	Mon, 27 Jul 2026 12:40:00 +0200
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A43B45742F1;
	Mon, 27 Jul 2026 10:40:00 +0000 (UTC)
Date: Mon, 27 Jul 2026 12:40:00 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Sean Nyekjaer <sean@geanix.com>
Cc: Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] can: tcan4x5x: put tcan into sleep when removing driver
Message-ID: <20260727-exotic-loose-tench-5537a5-mkl@pengutronix.de>
References: <20260727094900.1214157-1-sean@geanix.com>
 <20260727-merciful-unstoppable-pigeon-4286de-mkl@pengutronix.de>
 <79jbRkghpsRXohQwvs2lpvzMHo7eTeLspkjBRCa2Mlc02VkFu1jP8j0xJZP86-teeiqJroLBaM5D2PgvneSZs5iiWJGQPsXu9u7xGm41WTk=@geanix.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vre3am5nw2w7sw7e"
Content-Disposition: inline
In-Reply-To: <79jbRkghpsRXohQwvs2lpvzMHo7eTeLspkjBRCa2Mlc02VkFu1jP8j0xJZP86-teeiqJroLBaM5D2PgvneSZs5iiWJGQPsXu9u7xGm41WTk=@geanix.com>


--vre3am5nw2w7sw7e
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: tcan4x5x: put tcan into sleep when removing driver
MIME-Version: 1.0

On 27.07.2026 10:34:06, Sean Nyekjaer wrote:
> > Does it still work, if you move the regmap_update_bits() to
> > tcan4x5x_power_enable()?
>
> In our use-case, we don't have control over Vsup. It's directly wired
> to 12V from the car. But toggling Vsup will get the tcan4x5x into
> standby mode again.
>
> Maybe:
> if (priv->reset_gpio && priv->power =3D=3D NULL) ?

Yes, something like:

 static int tcan4x5x_power_enable(struct regulator *reg, int enable)
 {
-        if (IS_ERR_OR_NULL(reg))
+        if (IS_ERR_OR_NULL(reg)) {
+                if (priv->reset_gpio && !enable)
+                        return regmap_update_bits();
+
                 return 0;
+        }

         if (enable)
                 return regulator_enable(reg);

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--vre3am5nw2w7sw7e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCamc1fgAKCRDMOmT6rpmt
0qmvAQDk9pFCmPFfZ+teG6ZrBqAx8gJEunLO1cBcNLxA7jI6lQD+LY6n2yw5TDs8
4b68P4abMTOBiAKs5ZF1WWIEDLRfgA8=
=QiJo
-----END PGP SIGNATURE-----

--vre3am5nw2w7sw7e--
