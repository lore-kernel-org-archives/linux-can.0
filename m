Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5CF411671
	for <linux-can@vger.kernel.org>; Thu, 30 Jul 2026 11:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785410754; cv=none; b=uQQlyMFO4mqOl8iOfXu1fju+avBCDBRr42TU/xIp5NG2a9K5QKh3ZxOutQr52Sg7WB5MtYxP+RDidNzji4pq+bP539bW3QJJlx3qZdoZ+dhySdAsb/ETZ8+N7FQieLusGoKbd4EHedGjSxRBZDLQ+3Fpt3v6cnconAghQNk185k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785410754; c=relaxed/simple;
	bh=pnxHPrDd8MekEcekfVo0RbRpyLQ5bY+q2nb6Zxx77v0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SQmIVmb5N9yU9+3yARB/YEhegWMOmgjy+hsZdmIvwJuFWHXDRctiYbLcTo35HACEkYdtYKHIVSXBLDzkPFs2BJgw7VRhjUIYcWbh1ul/dvr6XX4W1HtC1IQieTS29CzK2KXczoFhdEBhiSQH3A8IyWe+SdaL4t28ZJhJLcd908Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 9B789202C45;
	Thu, 30 Jul 2026 13:25:49 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wpOtZ-0022OB-1e;
	Thu, 30 Jul 2026 13:25:49 +0200
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 3CC68576E8B;
	Thu, 30 Jul 2026 11:25:49 +0000 (UTC)
Date: Thu, 30 Jul 2026 13:25:48 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: sashiko-bot@kernel.org
Cc: linux-can@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>, 
	Vincent Mailhol <mailhol@kernel.org>, Oleksij Rempel <o.rempel@pengutronix.de>, 
	Pavel Pisa <pisa@cmp.felk.cvut.cz>, Ondrej Ille <ondrej.ille@gmail.com>
Subject: Re: [PATCH net 08/20] can: ctucanfd: use self-test mode for
 PRESUME_ACK
Message-ID: <20260730-amphibian-honored-mongrel-2ca176-mkl@pengutronix.de>
References: <20260729102802.505168-1-mkl@pengutronix.de>
 <20260729102802.505168-9-mkl@pengutronix.de>
 <20260730102951.110641F00A3F@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bxdexexnolebiwve"
Content-Disposition: inline
In-Reply-To: <20260730102951.110641F00A3F@smtp.kernel.org>


--bxdexexnolebiwve
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net 08/20] can: ctucanfd: use self-test mode for
 PRESUME_ACK
MIME-Version: 1.0

On 30.07.2026 10:29:50, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [High] NAPI poll loop permanently deadlocks on SKB allocation failure b=
ecause it returns less than `quota` without calling `napi_complete_done()`.

Should be fixed in a follow up patch.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--bxdexexnolebiwve
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCams0ugAKCRDMOmT6rpmt
0pwPAP0aaCCuFH2dtwwyCCTlAgvnGt7/tyR/1dbT8ZlTzE7tDQEAxvBM9Npa83PC
hk1Nna3GYan3OnGQ6qqy6tSDeHZCIg0=
=wFf9
-----END PGP SIGNATURE-----

--bxdexexnolebiwve--
