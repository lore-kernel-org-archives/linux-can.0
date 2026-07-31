Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E0B3EB0E3
	for <linux-can@vger.kernel.org>; Fri, 31 Jul 2026 11:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785495779; cv=none; b=F/w9qhG0y4v5MeBrpkIp83M3UAZ0/TvtLX/b+6d+fp/LP/quJRB1Uy8I8YcZVuQ0iJMs7wJ9ZiU4TFZRTgRWGCdGSTocEVXVbYD3zNW69fKHHjQCZqHyHLEZYehF4S3/ytfHkVpKrLW/y0ySnum8mrJaa9QYK8lKQ21vQIEKEEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785495779; c=relaxed/simple;
	bh=HE7h1P0LrfVUY/LnJu9va9oAPx2pPyeK2brdVO+KDvo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Azdf9XR/LxQpYCaLLAlDF8Wrq1nIJijZqCUlWrNpAE0MSwGZmmGBYt1+tePAfT8d0ObtsmopWdEpHeMsjnnz41yWYZ2eBehGcZvZ187RUiX4ZU3so0px4jYNKQa3lc3KkCa6dpYN5vCHUeqPuVRbPEVsLRkBuhyPYvKk4z2F1js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id A73DE20005A;
	Fri, 31 Jul 2026 13:02:53 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wpl0v-002CQD-1s;
	Fri, 31 Jul 2026 13:02:53 +0200
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 4EDE7577F4F;
	Fri, 31 Jul 2026 11:02:53 +0000 (UTC)
Date: Fri, 31 Jul 2026 13:02:53 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, 
	Oliver Hartkopp <socketcan@hartkopp.net>, sashiko-bot@kernel.org
Subject: CAN-XL frame to not CAN-XL enabled interface
Message-ID: <20260731-agile-electric-cockatrice-295bb8-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oonlxdoc2sbdefr6"
Content-Disposition: inline


--oonlxdoc2sbdefr6
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: CAN-XL frame to not CAN-XL enabled interface
MIME-Version: 1.0

Vincent,

does the current code check if you send a CAN XL frame to a CAN XL
enabled interface?

On 31.07.2026 10:54:02, sashiko-bot@kernel.org wrote:
> This is a pre-existing issue, but does this code properly handle CAN XL f=
rames?
>
> If an ETH_P_CANXL frame is sent via AF_PACKET, can_dev_dropped_skb() curr=
ently
> lacks a check to drop CAN XL frames for devices that don't support CAN XL.
> When such a frame enters rkcanfd_start_xmit(), can_is_canfd_skb() returns
> false, causing the driver to treat it as a Classic CAN frame.

> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731-master-v=
5-0-5b27029dee20@qq.com?part=3D1

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--oonlxdoc2sbdefr6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCamyAzgAKCRDMOmT6rpmt
0sWIAQDbpl55NjZVEbYx2injOW5yFoMmmiO8oXxJrYlL3Yc6UwEA37vK7AA0h8hW
CdyNnehNmWHMFJmqoapy0hFcXaNAeAU=
=j6Nq
-----END PGP SIGNATURE-----

--oonlxdoc2sbdefr6--
