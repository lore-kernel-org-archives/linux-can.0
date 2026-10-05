Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD863806AD;
	Mon,  5 Oct 2026 21:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791236755; cv=pass; b=DCr3FpAaiFiVeKs5PAtlnCE4+Yu9bZoIPGui4ur8omtB+XteQnPUPaMRwjbiRyNr+tgEM5/r5y1NrSGxQoNObloRxKnEeAuxgZjkBWhdKOHFetx9nE8YTyXJ4ddz8dH2rmxI15pGKuDlnjpTMDyKrLqTY1QhczsDTHnx2cfBAjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791236755; c=relaxed/simple;
	bh=2MTwAY9VqPBFTxx8gXlu7wj72CYKWUjkAGlMf2bz+GM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r3Oebf9QX6wWkKTzT6tPsXQjVFdR/2JaQlEBMGvXlLSdFcYAtmBBGDrzJjbDKGrMzd/EbsyA7VL30acqsOCcSBJQPH5H1uWDTFlOyXaJ+ToBZf/IdOfFSbGGBGOEEwhe6aC9qrrA5JShyohae2K8NP5EymIYA6RRFVMxkQeNUAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=RWOlNcnf; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="RWOlNcnf"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id BA1FE201C87;
	Mon, 05 Oct 2026 23:45:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791236746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M2Kgy4yTi5RM8CpV2xL3SMstzRy/ZLl0saPpkIunVPU=;
	b=RWOlNcnfxJxY4D30d/zKsw/wneK6erMv7eW804Ps+YXxKXpF2K6dSURN0OTKHiMtcUAe4I
	tazZ20zOFZMoPAj03r8uj6vH6/6BPRTWg7ZqOzOWunevKsSYP9DXvme8mZ4aNaL58VGpTU
	gLy9GId74gRM30ju/Uoh3BDZgXu+57yQa48Bb12Rb4S3fKyaleXoYQzsIuW4Rf+3Y/8A8q
	HWrxu50MGmQBR6FLOcryIqNMCuzeSmsev1MdHA+YNwMsdMMs+8oCse1lKK3FMCLSJND5r1
	Z9R9JAsRf0tRlLkwPzklJJs8CtJlMLp2Ef/7lCbFm1K6lkbYLRZ/5q9XQVso2w==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791236746; a=rsa-sha256;
	cv=none;
	b=V9iwWyBXMZeNiDCRCSqUiGyHT+UdiTlCx3dC80sLGQ/cmgzNL8JorehLILbogsWNlynQgG
	YE8TxiP0RRmKv/dkg8IddoxPIfH8yArQ0sWxTgTwMSRPz0iMqoDXsCk6EkL92qEAjYiu/v
	JPaHaGzwahibtJBTUfRcm0V8lpC4dAiWgqOrvs/ysTYmIUOtmLVKttnPs8sdKfNAUNeJsF
	eB7qX/Jyw9JWBvtmUE81xKDP7dmR+dfSKn1FmcrbSBuZ+yAW0gtQfd/BoAdpyUBsCNdBhl
	8OzdfQ64vgcZdbm1mtvq57jeIoNhC0iAvIciuIvwBqQ9ZRzGcZbgMKumnatQDg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791236746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M2Kgy4yTi5RM8CpV2xL3SMstzRy/ZLl0saPpkIunVPU=;
	b=J8vNz+4HSyuvt3MCJsCAexvwTYsArHdO4VPch6nF6wqELR5xIQudDbL3L0s+Y7eNNBYfE1
	s+VIBZ7utZVJv+hlFMGstRNVjBYMScfxpL/XdZemsMhXc+fHxrI7ZKNEsa0jOW9/Q723Tp
	SEqPtiEtQpXDZd2oxNfjUOK8WHy2LmOd99YqYj+kNrRhGVx7WivEgYP4rDIPmzBJPCjACh
	99B1bpWHRAvXYLxGE2fv3tWOpz/F5gdiY2BwVLDpOCkz/Id+xFj+71A3Y2qYmAuODbI4WQ
	Q9bS+18LxKufqQY01Gww9pWy8cJqKiQaINShtuU6S0/1MxqPFd0kiacS1Sq08Q==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xDqVG-004RkN-22;
	Mon, 05 Oct 2026 23:45:46 +0200
Received: from pengutronix.de (unknown [185.249.113.225])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 0D4D15BA6E9;
	Mon, 05 Oct 2026 21:45:45 +0000 (UTC)
Date: Mon, 5 Oct 2026 23:45:45 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: =?utf-8?B?U3TDqXBoYW5l?= Grosjean <stephane.grosjean@free.fr>
Cc: mailhol@kernel.org, linux-kernel@vger.kernel.org, 
	linux-can@vger.kernel.org, kernel@pengutronix.de, s grosjean <s.grosjean@peak-system.fr>, 
	kuba@kernel.org
Subject: Re: [PATCH can-next 6/7] can: peak_usb: Add bus error reporting for
 the PCAN-USB FD family
Message-ID: <20261005-ancient-viper-of-swiftness-c884c3-mkl@pengutronix.de>
References: <179106844116.1406898.10605612528694983606@kernel.org>
 <1730786945.910525984.1791210132571.JavaMail.root@zimbra65-e11.priv.proxad.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wbgkbrp2rld2sxso"
Content-Disposition: inline
In-Reply-To: <1730786945.910525984.1791210132571.JavaMail.root@zimbra65-e11.priv.proxad.net>


--wbgkbrp2rld2sxso
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH can-next 6/7] can: peak_usb: Add bus error reporting for
 the PCAN-USB FD family
MIME-Version: 1.0

On 05.10.2026 16:22:12, St=C3=A9phane Grosjean wrote:
> Can you let me know if I need to make changes myself to these patches
> you sent,

Sure!

> and if so, how? (Should the new requested changes=E2=80=94which are
> unrelated to the original patch=E2=80=94be included in a new version? Or =
in a
> different series?...)

As I'm not planing to work on this series, feel free to take it
(including my patches), add your changes and send a v2.

FYI: you can import the series to your b4 with:

| b4 prep -n peak_usb_enhancements -f net-next/main -F 20261002-peak_usb_en=
hancements-v1-0-50e965755c06@pengutronix.de

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--wbgkbrp2rld2sxso
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCasQahQAKCRDMOmT6rpmt
0oirAP9772cdydlnoqi2h6jO4aCq62wegPxwMRiKbrTCcFMxuAEA/Bu2pSBHSQHz
SK50i3qJLXIEkR29If0xeGUZQY6RiQI=
=CW2k
-----END PGP SIGNATURE-----

--wbgkbrp2rld2sxso--
