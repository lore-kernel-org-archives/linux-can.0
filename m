Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501A51A9F97
	for <linux-can@vger.kernel.org>; Sat, 31 Jan 2026 15:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769873149; cv=none; b=TYkXOiRSdsakjsMjOUp6jyZsTJSRzAbE3B9U1vziigCXSFUGxgQBimJVPVCAgGVaUkiqsF0hXIm5k7NVfqFQ9xVqG65rjAoIUtyKE3cZAWsaPctvydSqwtSYQHJiQQOvDfMhnhZgdzHRPKSQdroSzXbvxxa933Sx0zQKP8tia8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769873149; c=relaxed/simple;
	bh=BdovoKI6OG7sW+h/gQpv1pby9Qx5VlZ16fPfUttnzLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EYUiB1xy5J2QqRnPCIDmIdOJcYz2po+JrnJGKu1Dp7v5UTySpKEJk+NsVejs573XQ3zsiZjHmFh1cwCZVGFjWGDKnHtO3x6rOs98ACHa7m1KioOcg5wxjpBPiWu2fXWV3syiT5PqAo8sLSSgiXw3CqZ9AS8n5h4hlSodUBxUogk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vmCqz-00050f-FB; Sat, 31 Jan 2026 16:25:41 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vmCqz-003QhL-1w;
	Sat, 31 Jan 2026 16:25:40 +0100
Received: from pengutronix.de (unknown [IPv6:2001:67c:1810:f051:561c:856e:5964:a6ed])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A4EB34DC703;
	Sat, 31 Jan 2026 15:25:39 +0000 (UTC)
Date: Sat, 31 Jan 2026 16:25:36 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org, 
	Pavel Pisa <pisa@cmp.felk.cvut.cz>, Ondrej Ille <ondrej.ille@gmail.com>, 
	Vincent Mailhol <mailhol@kernel.org>
Subject: Re: [PATCH net-next] net: can: ctucanfd: remove useless copy of
 PCI_DEVICE_DATA macro
Message-ID: <20260131-placid-porcelain-mandrill-9cb027-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <20260130114134.47421-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="htmvnm2vu23qyowl"
Content-Disposition: inline
In-Reply-To: <20260130114134.47421-1-enelsonmoore@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--htmvnm2vu23qyowl
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net-next] net: can: ctucanfd: remove useless copy of
 PCI_DEVICE_DATA macro
MIME-Version: 1.0

On 30.01.2026 03:41:33, Ethan Nelson-Moore wrote:
> The ctucanfd driver has its own copy of the PCI_DEVICE_DATA macro. I
> assume this was done to support older kernel versions where it didn't
> exist, but that is irrelevant once the driver is in the mainline
> kernel. Remove it.
>
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>

Added linux-can-next

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--htmvnm2vu23qyowl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAml+Hu0ACgkQDHRl3/mQ
kZzV+Af9HZBrRyGfjocuz4rpY6n4QSWZDeQuOFHG6UEaaQAaNXR23ebz1OMZfeZN
oZme1LP2mTB1C4tbQX5HXudVp/wiJdX2JZB/I9gwB1xsLCO2ImBBiZePlVjvjP5b
k+xiKcS8I4BfmfRiBmT9CwqFnOfzICOVflgp7TGa061Qf96LnnMy/HWHCLQ+eYmO
0XbgLSUn712qHi/ProratJMqaj6qgwFK4X6lBmWpOlOMlXqrdSDGXPXCnAT+Udv3
4qHc3uE7Urv/nRi8tRvKLn+RICYrJevTcalvG3RPQttVuH1FOzr/id4/Rz9J73HB
tFhTXKjvcqfG00BHiNK0bNeDXfJGBQ==
=usAq
-----END PGP SIGNATURE-----

--htmvnm2vu23qyowl--
