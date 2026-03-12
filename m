Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB482E0B71
	for <linux-can@vger.kernel.org>; Thu, 12 Mar 2026 12:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773318399; cv=none; b=JZmOiMeHP3pqGUPvLK3u7W4uHLRtNgKCH+tNLtWeFUEbUI4XAWRjkSO9uD2Hek2tium+iGN7Cu1CKlfVObcNNF5s+HRR4vmUPe2t+q/TkDgIWWfodpnBR3Vh7ykjmCWFao6xz4AtjmlV2J6Mc+yTN5P43rNTiWhYMs1UZL0uchk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773318399; c=relaxed/simple;
	bh=9DXV7x0xOFuFxSFa25p1cb5fWF4XKOgphQ0U6e2Xg5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XWUiqQ0fZ4ReQbtd1iSyhRHAXQRQv6O21jKqgeE40MEMMFsMY015TP6cUu90TAGDk1QG+y/1KcwYyk8xOiReYbOB53lo+PSva4ZCr2Wj99oj3EmRsyeQpzG2fZdZP2h87ANiFLM1LrCPTXSunUOQv95qfFdjy/kjifh3qN3PwIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1w0f7J-0005LM-BZ; Thu, 12 Mar 2026 13:26:17 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1w0f7D-0051Ir-1u;
	Thu, 12 Mar 2026 13:26:12 +0100
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 934014FFA1D;
	Thu, 12 Mar 2026 12:26:12 +0000 (UTC)
Date: Thu, 12 Mar 2026 13:26:11 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: =?utf-8?B?5oKs5rq6?= <2063309626@qq.com>
Cc: 25125332 <25125332@bjtu.edu.cn>, 23120469 <23120469@bjtu.edu.cn>, 
	gszhai <gszhai@bjtu.edu.cn>, kuba <kuba@kernel.org>, brgl <brgl@kernel.org>, 
	"marco.crivellari" <marco.crivellari@suse.com>, linux-can@vger.kernel.org
Subject: Re: [PATCH] can: mcp251x: add error handling for power enable inopen
 and resume
Message-ID: <20260312-modest-adorable-oxpecker-ae6ff4-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <tencent_6A462B2C8A50BA55116D560D2FFE9EED2D09@qq.com>
 <20260312-peridot-galago-of-painting-7d6e1c-mkl@pengutronix.de>
 <tencent_BF731151571D2E5E9EBF2D7A2A448A76BB09@qq.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6yo6nu52dgrb56vl"
Content-Disposition: inline
In-Reply-To: <tencent_BF731151571D2E5E9EBF2D7A2A448A76BB09@qq.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--6yo6nu52dgrb56vl
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: mcp251x: add error handling for power enable inopen
 and resume
MIME-Version: 1.0

On 12.03.2026 20:02:16, =E6=82=AC=E6=BA=BA wrote:
> I have corrected the two mistakes you mentioned. The patch is in the atta=
chment.

Please send the v2 to the mailing list.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--6yo6nu52dgrb56vl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCabKw4QAKCRDMOmT6rpmt
0h+XAQCecCKMHC6rjOf2EIyH9iwsMXUKcoAxhHI9gR4kC8PvcwD9EeZXXkBDTQf4
Fr/qAiLLJJ4+yFGcqyMJZbAwdzfJcgc=
=s512
-----END PGP SIGNATURE-----

--6yo6nu52dgrb56vl--
