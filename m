Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F5941169E
	for <linux-can@vger.kernel.org>; Thu,  9 Jul 2026 11:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783597773; cv=none; b=Bcy5hn4+q91SC4etgKZpZDVS1AXQ92CxNpobH7UE0pkhVhDg3DBYfPf2ZmwUin1FrupIdvLxAaz2v2PN/yaNx8a2yWMA+pUfb6FdwY71AKomtUtWefbbrYR0UJndxz8Flrt0dS6SlhcwsYRXDa00sh5tbdALnCZtprrdamxsQRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783597773; c=relaxed/simple;
	bh=MT186h/RB2KxCewTPRsm0FHr1o/yYA2Yxg43HD18v/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sKVoJWrZXQ4GZz+I8wuukc+Ln+9mMP38dHAImhtnNVUKrxfHaICOjDEoOB52qkXAFVasbyK1znHucYXQhZzi5Mr0+H2l89bmLC0/Zo6VeBddTHxCIPNt2Fpcc0lbgnV4zzsbmFoO/y9pn7/JAUUuOBZKUPNtiX+Za4z9/KcUItE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 4D0AA202773;
	Thu, 09 Jul 2026 13:49:29 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1whnFx-000uTK-0d;
	Thu, 09 Jul 2026 13:49:29 +0200
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id E136F56406F;
	Thu, 09 Jul 2026 11:49:28 +0000 (UTC)
Date: Thu, 9 Jul 2026 13:49:28 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp via B4 Relay <devnull+socketcan.hartkopp.net@kernel.org>
Cc: linux-can@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>, 
	Lee Jones <lee@kernel.org>, Feng Xue <feng.xue@outlook.com>, 
	Ginger <ginger.jzllee@gmail.com>, syzbot+75e5e4ae00c3b4bb544e@syzkaller.appspotmail.com, 
	sashiko-reviews@lists.linux.dev, sashiko-bot@kernel.org
Subject: Re: [PATCH v10 00/10] can: bcm: collected fixes - final5 :-(
Message-ID: <20260709-amorphous-able-quetzal-37e437-mkl@pengutronix.de>
References: <20260709-bcm_fixes-v10-0-57fff38e34ce@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vn4pasornjpeh34t"
Content-Disposition: inline
In-Reply-To: <20260709-bcm_fixes-v10-0-57fff38e34ce@hartkopp.net>


--vn4pasornjpeh34t
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v10 00/10] can: bcm: collected fixes - final5 :-(
MIME-Version: 1.0

On 09.07.2026 12:24:14, Oliver Hartkopp via B4 Relay wrote:
> as there were different patches flying arround to fix CAN_BCM issues and
> AI assisted stuff pop's up again and again, I've created this collection
> to be applied.

It seems the sashiko-bot only claims to find per-existing issues. I'll
take them and send upstream.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--vn4pasornjpeh34t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCak+KxgAKCRDMOmT6rpmt
0mk0AP9EFf8FgfeB0ySe1ETAb+kLlWuaVcmDtVDwfVOajrU+lAEA9jn8yE5SqT+H
IJ8OaBZglcyNnvy4tP8W/Irml7JJGAc=
=Jix9
-----END PGP SIGNATURE-----

--vn4pasornjpeh34t--
