Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E344DA528;
	Fri, 16 Oct 2026 13:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792157696; cv=pass; b=ilvloZS6OnTBKCn4CyFzWes8mG5BDtyWkp3fx+HK50rE+cPlc58UzgmhtRtbKuopsIVquISTQTR6nVxy3pHQVFMFN0fBHAzsT5/ubUVGLFgoZHHNfg5eyz9nH2bUHnVQdLFIKzqnO3EYzCuCgtMFDo8hv4X4Y5XIsZOPXwvVyfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792157696; c=relaxed/simple;
	bh=DhaodQ6KoIlnXsGaZAW3D6vNyIrfdUAFV6iRLiAgwv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZGcXwy9nHOemkr3nMxHQgAb14VX+oIyrPFgj4S8uEhpAwPHc+RCdOvxa5QfGTPpF7GPE//nFEdRz7dwNBn/FI78UcfndQJyzYd+8MdfaWksswcypF39MvNkrTWmTYTGSS7YPJIgW4T31UKNOOVheHOspw75IpQBRQIMd9IWI9f8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=XGT3WLNP; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="XGT3WLNP"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 82E2420280A;
	Fri, 16 Oct 2026 15:34:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792157691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nynqbi7c7C/ctSmvJecHEBxqxNFKRN1gv8jebyfIX5g=;
	b=XGT3WLNP8Wh+HLcZ6K3Yic+2i70cs8haUGJrCLeP4S/o+ahlH/hgR8zA4/sX5fs58AWlZY
	wS9Dt4syfLdbHtHuYrJCimqScQ7uUyk4V++EoCo0fm8eU4oWWDqmpE0PxBVv0LpubfADBH
	CASWYnUnlaQSXPTvFLTgOp3UiaGG64snph5984C4l5tD2ezEFCtnZAiapFM4TS+EDqK3tr
	Wfeb1P9c2hxbfdOSFVYhiZ/37mQUxMpd7JU1MSkdIcRqtTQJJSkMrIRu+UVISFRYrpcUV6
	gymteETYz3PXKOUtDO3IFe27lQsNRRpFTUYi+DkpHKD38pu8eeFsfSxnRlCHIg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792157691; a=rsa-sha256;
	cv=none;
	b=RdlSVP4IcsRHu6cgVmBYyvlaqXGdK+X3MTeP/gptW+yFIJwU5o/o6UXwTa0r1EIuCLSWvm
	VosTh5AOBBXJlnQRatrkMDTcrEp51i+jmcwr964z81REWvVqKAO4YXmUinCOSsahO/01Lh
	53urpROCIS2KsVT37tc7EHkj1n3ZurCshSEPncGvaWUduZjJEuxThhIlTnnDpnHmss3Nsx
	fkn/Ai6DWSG34x8nfS/RdSQWrf+FDaPC3bxN4FpXIE7g3m2HMmtSMkNHgsDeICtp7dbng7
	j36yjPalK5SkktLPqcBv3Gxl0Nm7NxQ/05LnGRU7UfbgGasFqI5rvJ/2sLKL9g==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792157691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nynqbi7c7C/ctSmvJecHEBxqxNFKRN1gv8jebyfIX5g=;
	b=Pg+CyPux4XaRPzfrJ50CWUWhCX69+qpCOlRBdLjzZ9Fw4BOdweIe2u+XUqjx2vlvR1iH/O
	+Ik9WQzKGcp0bvrjXvW6CQjtMS4hWroVP7YLJfvsJ3t9GtxP48tuAqJNir80hblIWwSgcq
	LCDjHXWRlKAv5w3hU/DTT1zOpmTaKvjmFc3UnEa35d/XmmJUDxfbtGWTEMEMx/76OJJ/Gu
	mBp4ObCsPFbCXbPau+xJokJF/WKEDCJlKeTnqAZvv7QsgsUqdw95dB1ISAtNJMlIDnQpQE
	Hjyx50dlQgN/6ITkoFhvrmj1BXkkUG1CvjPuxhWetk0nr1ktXoIvj1bzH3BrNA==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xHi5D-006C2j-1K;
	Fri, 16 Oct 2026 15:34:51 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 2C5065C6258;
	Fri, 16 Oct 2026 13:34:51 +0000 (UTC)
Date: Fri, 16 Oct 2026 15:34:51 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	linux-can@vger.kernel.org, kernel@pengutronix.de, socketcan@hartkopp.net, 
	kurt.van.dijck@eia.be
Subject: Re: [PATCH net-next 11/37] dt-bindings: can: renesas,rcar-canfd:
 Document RZ/G3S SoC
Message-ID: <20261016-daring-expert-ocelot-8a5c0f-mkl@pengutronix.de>
References: <20261015015336.816543-12-mkl@pengutronix.de>
 <179211822620.434549.8950926089601634766@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zlu7vaetrscfpdbj"
Content-Disposition: inline
In-Reply-To: <179211822620.434549.8950926089601634766@kernel.org>


--zlu7vaetrscfpdbj
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net-next 11/37] dt-bindings: can: renesas,rcar-canfd:
 Document RZ/G3S SoC
MIME-Version: 1.0

On 16.10.2026 02:37:06, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in ca=
se
> you want to address the nit picks below when you respin.
>
> Low priority / nit picks for your consideration:
>
> - [Low] The free-text description of renesas,no-can-fd in the binding
>   still says Classical CAN mode is available on every controller: 'The=E2=
=80=A6

valid nitpick.

Marc

pw-bot: cr

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--zlu7vaetrscfpdbj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCatIn+AAKCRDMOmT6rpmt
0qzuAP9bLK6YrBcNwQ4vvKfW9qidKdVEWYCk2f7PfRosToFPNAD+KD8KF0bFLMDG
rqv2cEgTimXGTnq2WE5Au9P+YX+vGQE=
=vCW1
-----END PGP SIGNATURE-----

--zlu7vaetrscfpdbj--
