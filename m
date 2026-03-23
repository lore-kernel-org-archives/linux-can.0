Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8BA33D4E5
	for <linux-can@vger.kernel.org>; Mon, 23 Mar 2026 09:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774258636; cv=none; b=kbmVCUIcElXeYi3I4IrqjUx2JbtNMCcmAy+pcilPUzYeIeR0KtLNMSSJXdl4JWxUeE5JUglC2ql9I5xS4snySGN5KQQgrQWNA4rjS25QUdyRj2CflTEv9BEtFlCnlHut/ElH9k/N7nWUuuf7bbvti5pI9fUdk16xO5zkvixMWig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774258636; c=relaxed/simple;
	bh=IBBlYZNdxpGz628jyx8C5dckBVYSgeI5iIN9NCIEdZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oDedTcywiPpg30B4xC8td53KFRn+pLdaEs2oTxE1LITPIrmFTgAHHUv+n5boW04W2zqFJEpo9s+/U2u5INXKt14EqMWBm40DamQMHlgWLLOcBcLNU4pr44x/xN9+vQFlPaOBD8YiVB6C6+KvkqD7O8rdMhBS4oF46dZDHSwZ2WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1w4bii-00009T-Ku; Mon, 23 Mar 2026 10:37:12 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1w4bih-001hg5-2v;
	Mon, 23 Mar 2026 10:37:11 +0100
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id ABD8950A6D8;
	Mon, 23 Mar 2026 09:37:11 +0000 (UTC)
Date: Mon, 23 Mar 2026 10:37:11 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: kernel@pengutronix.de, Ali Norouzi <ali.norouzi@keysight.com>, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH can v2 0/2] can: fix can-gw Out-of-Bounds Heap R/W and
 isotp UAF
Message-ID: <20260323-essential-goshawk-of-triumph-ccea83-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <20260319-fix-can-gw-and-can-isotp-v2-0-c45d52c6d2d8@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="va3cmvgfkyhn67up"
Content-Disposition: inline
In-Reply-To: <20260319-fix-can-gw-and-can-isotp-v2-0-c45d52c6d2d8@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--va3cmvgfkyhn67up
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH can v2 0/2] can: fix can-gw Out-of-Bounds Heap R/W and
 isotp UAF
MIME-Version: 1.0

On 19.03.2026 16:47:43, Marc Kleine-Budde wrote:
> This series is by Ali Norouzi and Oliver Hartkopp fixing a can-gw
> Out-of-Bounds Heap R/W and can-isotp UAF.
>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Applied to can-testing.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--va3cmvgfkyhn67up
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCacEJxQAKCRDMOmT6rpmt
0qRHAQC5wYuGzPT8x1yMrmuM1C5Ck7prZlfGojAEbDFtwtFpKgD/SgCaC8iGgW0t
yna3rlca1Aty/KQkKPkhAIJEWXHhIQQ=
=gygf
-----END PGP SIGNATURE-----

--va3cmvgfkyhn67up--
