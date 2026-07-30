Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8950738C437;
	Thu, 30 Jul 2026 06:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785391988; cv=none; b=o71RgVsVe7idEanZex4PsZanW3ad6HyRHIVUi+j53pSVYjHd1Bn5hAM6gj1yY+FXfaGW22uC0S2jS521wyBRRDMFmRumWH0v5Xun+oWfgWsZgyNKg2tj9xXiJRcWipVpX7bqQp21bDfpB6z0BJZCj+CNppcFhQNTmuIr7X0A/mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785391988; c=relaxed/simple;
	bh=oXwzlkQ5reAxnefWPDhQIUAXrMLkP6IQPSWG+fSVhik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W3g9YPkrZJ8gqslUsZRq5MY7Gl14YXmrucwTTHdWl0OLOWWK1gacnoB9z7x8ih+teH57Q53VML0Sa37Voj2OyQJWrMqmslUV9dQRloG9raeJwhLc58B/e/qEkhmTccYJs0J2U5J47FUh4GlkZ20BF2tCeyfTg6oLJRaXY5+LvvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id B2953201DCE;
	Thu, 30 Jul 2026 08:12:47 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wpK0d-0020Cb-21;
	Thu, 30 Jul 2026 08:12:47 +0200
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 4142957698A;
	Thu, 30 Jul 2026 06:12:47 +0000 (UTC)
Date: Thu, 30 Jul 2026 08:12:46 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: haibo.chen@oss.nxp.com
Cc: Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, linux-can@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	imx@lists.linux.dev, Haibo Chen <haibo.chen@nxp.com>, qijian.guo@nxp.com
Subject: Re: [PATCH 1/3] phy: phy-can-transceiver: default silent GPIO to
 high during probe
Message-ID: <20260730-debonair-artificial-meerkat-0a5ea2-mkl@pengutronix.de>
References: <20260730-can-share-silent-v1-0-63fd603f943d@nxp.com>
 <20260730-can-share-silent-v1-1-63fd603f943d@nxp.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cv6imrgcjwgjm3dq"
Content-Disposition: inline
In-Reply-To: <20260730-can-share-silent-v1-1-63fd603f943d@nxp.com>


--cv6imrgcjwgjm3dq
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/3] phy: phy-can-transceiver: default silent GPIO to
 high during probe
MIME-Version: 1.0

On 30.07.2026 12:33:26, haibo.chen@oss.nxp.com wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
>
> The silent pin of the CAN transceiver is active high, asserting it puts
> the transceiver into silent (listen-only) mode where the transmitter is
> disabled.
>
> At probe time, and before the PHY is powered on, the transceiver should
> default to silent mode. This is the correct and lower-power state: the
> transceiver should not actively drive the CAN bus until the PHY is
> explicitly powered on. Requesting the silent GPIO as GPIOD_OUT_LOW leaves
> the transceiver in normal mode by default, which is both incorrect and
> wastes power.
>
> Request the silent GPIO as GPIOD_OUT_HIGH so the transceiver starts in
> silent mode, and let the power_on/power_off callbacks manage the mode
> afterwards.
>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Reviewed-by: Marc Kleine-Budde <mkl@pengutronix.de>

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--cv6imrgcjwgjm3dq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCamrrWwAKCRDMOmT6rpmt
0u8cAP9IaDtkB+9JcxG6xg6iqgxUcAFmEOBlmqkqjP4MmECpEAD/Z7sg4KtbWKiz
yFHLst8QIG+JGAxoKnUMPsx2stUMxws=
=NLw1
-----END PGP SIGNATURE-----

--cv6imrgcjwgjm3dq--
