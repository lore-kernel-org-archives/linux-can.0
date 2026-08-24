Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF5E3749F5
	for <linux-can@vger.kernel.org>; Mon, 24 Aug 2026 15:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787584308; cv=none; b=oTLVZhifA55kij7thXDWiyBLEqpP0IDs3VVUFI7G3OsaNcPskX8TIYMDJSsype4/zNnbMIyuBl5T/0cmQzzgzARUCeHASrL5yRAFD3+PiI5eDuJRpHfzVVGod75yTFFCNGV/2C74Zy5+U50oI3LgoNjr4VoOEUSx2+Owow2McD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787584308; c=relaxed/simple;
	bh=wbD9Of0j9/IzpiuhZMx7viu/5zY5QQiGAgFm6ILfa5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IWf/QyGH5Cp/gXyRZBUk9KUTwASTczvLvDRlPc1Pj67QxoqlLaz18GutWPJ/umNLfexeAROHEeaWR6alT+UAPpjN8p57a3U1hVwwwdK0P3Svt0Ky3duyC/hA/zWCzHIt1nhu88s9tVzYKMKMDwzktDepUgy9BjcCrMjBDydHy8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 0222B200FF9;
	Mon, 24 Aug 2026 17:11:39 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wyWKo-0037ur-2j;
	Mon, 24 Aug 2026 17:11:38 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 8FA0E58B62C;
	Mon, 24 Aug 2026 15:11:38 +0000 (UTC)
Date: Mon, 24 Aug 2026 17:11:38 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: sashiko-bot@kernel.org
Cc: "Ji-Ze Hong (Peter Hong)" <peter_hong@fintek.com.tw>, 
	linux-can@vger.kernel.org, Vincent Mailhol <mailhol@kernel.org>, 
	Oliver Hartkopp <socketcan@hartkopp.net>, Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH v2] can: usb: f81604: fix struct f81604_int_data size
 mismatch
Message-ID: <20260824-rainbow-marigold-scorpion-d95c6b-mkl@pengutronix.de>
References: <20260824-f81604-fix-v2-1-fc9be5581394@fintek.com.tw>
 <20260824133009.CF85A1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="67xjzqldny2modo2"
Content-Disposition: inline
In-Reply-To: <20260824133009.CF85A1F00A3A@smtp.kernel.org>


--67xjzqldny2modo2
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] can: usb: f81604: fix struct f81604_int_data size
 mismatch
MIME-Version: 1.0

On 24.08.2026 13:30:09, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [High] Improper teardown order in `f81604_close()` allows asynchronous =
work to be scheduled after `cancel_work_sync`, leading to a Use-After-Free =
on device disconnect.

Can you take care of this issue, too?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--67xjzqldny2modo2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCaoxfJwAKCRDMOmT6rpmt
0gbAAP9/nuwRyqgK5b6NlemL0kXk3wVg6cGhMK371PkUVnpOHAD+OgJPl4L195zB
APUd5I6sriB6/A0QK6iIs0xZS8Zh6AA=
=MeN3
-----END PGP SIGNATURE-----

--67xjzqldny2modo2--
