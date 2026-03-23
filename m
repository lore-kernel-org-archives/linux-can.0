Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7D52DC762
	for <linux-can@vger.kernel.org>; Mon, 23 Mar 2026 09:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774258983; cv=none; b=NghXPaCus8i+V6RTOaGlSmRQb9fahrsfYWggQx2CxmGZjurmCzFkZGQqB6V6G1vOprAUX3dzaMXf+I8U/FRoXrrniWFTvFIhdbIlLIICK4PxcZxJi4QBjT/QbKGYFMQ2rGRz7cq8wLTq7+J/Mo6X92VEUEkhy6J92jmHcpCVd8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774258983; c=relaxed/simple;
	bh=DphDNhRzUYgcqTkZ4lgun1WcDSkWBPfOnTCH5REvFnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iDWnJdU6WxB3xJujeBzw0icL+VD4jnjYK18j40VEcsEQ1vcZW4QYJIp7AlSINixhyAtbfySfukHl1L+d0sks619E0P9ZGDq1l46dLwX6BGom+RWGxxAGooxeTB3HIoSSDubpTJ2GTswrQy8K0V7Z+cxwesss/sEI+/E/FtgvSL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1w4boD-0000tR-R0; Mon, 23 Mar 2026 10:42:53 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1w4boC-001hhH-2c;
	Mon, 23 Mar 2026 10:42:52 +0100
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 7A64250A6EE;
	Mon, 23 Mar 2026 09:42:52 +0000 (UTC)
Date: Mon, 23 Mar 2026 10:42:52 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp via B4 Relay <devnull+socketcan.hartkopp.net@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Urs Thuermann <urs.thuermann@volkswagen.de>, Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>, 
	syzbot+75e5e4ae00c3b4bb544e@syzkaller.appspotmail.com
Subject: Re: [PATCH v3 2/3] can: bcm: add locking when updating filter and
 timer values
Message-ID: <20260323-valiant-whispering-buzzard-3e3471-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <20260219-bcm_spin_lock_init-v3-0-c61026740d7b@hartkopp.net>
 <20260219-bcm_spin_lock_init-v3-2-c61026740d7b@hartkopp.net>
 <20260302-gregarious-poetic-wasp-e73cee-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sppejaezp2yqn654"
Content-Disposition: inline
In-Reply-To: <20260302-gregarious-poetic-wasp-e73cee-mkl@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--sppejaezp2yqn654
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 2/3] can: bcm: add locking when updating filter and
 timer values
MIME-Version: 1.0

On 02.03.2026 11:21:38, Marc Kleine-Budde wrote:
> The nipa/ai-review bot found these problems:
>
> | https://netdev-ai.bots.linux.dev/ai-review.html?id=3D873e6dfb-7d8e-4f4d=
-98ef-a89fcedb701a

I think this patch is the only one of this series, which is still open,
right?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--sppejaezp2yqn654
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCacELGQAKCRDMOmT6rpmt
0tSRAP93Ggcxa9TZqgBbtamJw1j+Q0Qy8QgkabWS5/qRKbxIMgD/X77T+W/B1eaE
TuEKdJBOnctKWEzXcROORL3ckyapKgM=
=BR08
-----END PGP SIGNATURE-----

--sppejaezp2yqn654--
