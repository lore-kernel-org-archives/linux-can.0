Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBFF3812DA
	for <linux-can@vger.kernel.org>; Mon, 28 Sep 2026 18:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790621049; cv=pass; b=nH6dsGJ8iyl3mJbrc5Jwc0UzJMT3oGk/SDODX3ieiHdj5wjWDTQrus9/j/phv8OdQlDkaSMGrKeMm0otD1YAhZBt1IeP6J8i7uCHhsFojcRagElbRXYDv2uGzcS4mh8jOqFb5X9Cfas1DavlAnNkQFVpR4Nfn2AikiAbqM6Y56Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790621049; c=relaxed/simple;
	bh=/9cgzDSSeniLiolFdfCa0yx0zyesVHQMXowPDSZDweA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SQlBO+NuiYS9pYm56s8XjTSdGE/t01iKPdMqz6t8NyOs9DQGUOVuVgkaLjeTik/nLTFyTeItA67+So+FQx8biLPfSw7Bm2Xv8iYytGqR1Q+iawykwqCMSB9CznoeEwYNZd6MDjmoYwnBEfcWkEjWLTAq8KZ/i3Qs6qQCvnlnLyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=YJR7sF+w; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="YJR7sF+w"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 58CE6200044;
	Mon, 28 Sep 2026 20:44:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790621040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=faA5pIe0mY2Db+bVBgRfWzNtVKYZ8aH2Y/t+UlHrp7w=;
	b=YJR7sF+w9wwrpUQhLdeCrsMtosZ6TaluUGvnhs+SO0pU4hsYQya7vguih6xWysSUuXZXZz
	4tlxz4ZYhvzROK9kNwRkUchbcxVDzebc1AvNlgf6QzRxA/k67QDc9IQmkv5wEWZTpbVqzX
	nviC1EME02lUgVKCj4HjQbNnm3YenrGhsoCro9dNR3TwjKourFbxC76iAi43TxZxDD/rpS
	WDfgQw9gnKlryi8MZzyF2devFEQCI0EyzSP1r0RDUI0hGSxqo8IrnnEKh/Tgxgli816Fr8
	uRiXXKTrZWiv6xEH422yskrgQEBLlAg1cPPMeHShT9kW/L/KS3RwUcBQLUEzBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790621040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=faA5pIe0mY2Db+bVBgRfWzNtVKYZ8aH2Y/t+UlHrp7w=;
	b=OEDKO09w0p6owlGHlF2sI47Xdnl57pUCVm7kpjN2r6TKdBlzW/PnBAZNv7qY+rAaQvW5C1
	L5x6GfPyx5SSZLbk1d7M9h5p4u9I8psgfyk4BszstsqTwgvBWTM0ZFeJ8PZpCvqSXKAZKF
	o6LbCXET3+J54wi2jmDqgU/KavldictmJAF4Tgl2qo9VL1bPw8K/GUdpM1ZYbxPsnHFEog
	i5FUmI7kc3mAW88TcbU0tChOtuwFy2gYIPn5YJQz6bRuMVcj24CdFGysDdvI3Kn7UKezoK
	S7PMAN4syEBYmBmroNTB8ZcuCa09cPGOv+ji53LauMbj3cjQuUUSDEqYL1C1eA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790621040; a=rsa-sha256;
	cv=none;
	b=ZzTD6Dsl1a0Pg5GSR1zCAbtD+HsDEiLwQ8yjdO5/lwrSfHEvT6DwXNrAMAXofyWiMbVTMq
	f858Nkc72xXeZfTxRYYdXySPJWx9SWaKFVxJS3BdEGpXASV7OPqtNJxMVGf6SOscIvKQJ5
	NopnEn7pT7SWenHfxaJ8iowHAmZvj42f7amakmSVPfc9QOe3XbgWoNnUAj02U2zKL/R62Q
	KwykikDtaYTdtmKFR70FSsWmQBt4nQJImew2TPUD33P1HzG3HmZzknLdhd/kdBeUqdMP+v
	bUeHJN6/XTxYVJtMpY8x8yrm7uDMaX0Aqa+jLl5Wm0nREkkQ5/56rGSFZmAf5A==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xBGKW-003GmG-0c;
	Mon, 28 Sep 2026 20:44:00 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id E8B745B148D;
	Mon, 28 Sep 2026 18:43:59 +0000 (UTC)
Date: Mon, 28 Sep 2026 20:43:59 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org
Subject: Re: [PATCH v2 0/3] CAN netlayer fixes for stable
Message-ID: <20260928-rhino-of-marvelous-honeydew-7abf71-mkl@pengutronix.de>
References: <20260928173105.51765-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="obeoc3qireo6nvhq"
Content-Disposition: inline
In-Reply-To: <20260928173105.51765-1-socketcan@hartkopp.net>


--obeoc3qireo6nvhq
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 0/3] CAN netlayer fixes for stable
MIME-Version: 1.0

On 28.09.2026 19:31:02, Oliver Hartkopp wrote:
> This patch set aggregates the open stable fixes for the CAN netlayer.
>
> v2: restore non-zero UID value generation for isotp cfecho handling

I'll send a PR soonish. Once this series is ready, I'll send another PR.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--obeoc3qireo6nvhq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCarq1bQAKCRDMOmT6rpmt
0to9AQDF9GsRB9qth/m/UGIwsMON6vhTyyMf50tp273XsnopcQD/X/QzqJiCx1ku
ukVTHGdfkHBaqM5VU+3g7pdpXGrH0wg=
=mQJw
-----END PGP SIGNATURE-----

--obeoc3qireo6nvhq--
