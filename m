Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793106677;
	b=u2e81ZvJBSyV+BsEi/++QLsBT1mnwE8oIN4RgGc4F4Bki6aOxGvk2iZoS/jWRAtn2zfV
	 gl+zvgH423qxNxZlErH0EMZqylh8jEEUN0UymGQTZvCu7K2JG/RM5TYmtMfdMFCD57meq
	 Luur1AR1pvVkvl7YaeUOA18tLpsrMYcvIXtsVLXj5O5kvmGPyf23dYJq6BhDMstd9obYl
	 g/5G3Vj791T/giSwpKrDMlyZdXIDMUwOjRjQ12gxdIYduUbLQo5Pv50YsQyCwzBwiJUD9
	 fdEZNJPhyU1xfD8iyvk6iKpaMzdS3Zb3jFO+/kE5+E9aBSI538pM1ioIdiVim+qXlbg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793106677;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=klyjUEytPdkw0KjIMHT4jXnzc0nrujGeLh7w7DP4mRk=;
	b=rEtria53wtY/KVoTVCo26mEvGnTWeOKkqsiQQah0bwlP0OZnbT6I6clck4OERCHAThQK
	 6qJ4nLWPi9bD1Oiy54z5chdeFOuzxwlijereNwkva+J6SpsyvfUnBZEN4yVArrllOP55u
	 XQALPdtkF4T0+M9QE95fGVE3V9dOMoU2pmKXMW32BVGItTCiLHMRMb9Al49AgD1uLEyOE
	 5mG24tk02L2565runnp1yfdOu1d5EPGaqMncyKpRrMEjaO7ANZtjMqT2aIDg9FN9wOTWS
	 poHVcN3tErs31b5N4FlnqNzWkcXl9kq/U5C0g5fM4aSvTpIdk1sxxqwbnsKCbKWiVnA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b="F/bjRDOO";
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C9C606A31A
	for <linux-can@vger.kernel.org>; Tue, 27 Oct 2026 13:11:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77C9C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=F/bjRDOO
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 8A958201F14;
	Tue, 27 Oct 2026 14:11:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793106668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=klyjUEytPdkw0KjIMHT4jXnzc0nrujGeLh7w7DP4mRk=;
	b=F/bjRDOOuPNqfHjoVZDpP0DBL/yEkBJ4ONx7htEgGWxvruZCUWtJK0wjfO/VPpnwdARthX
	7tUakkOolWkhQj7vD5q5m48I3IL9OpWgSNn0zbRVVZ09h0drb8ZPbAxwOMkN7HvKgP/2wb
	gJLu3xAwl/LdZMvW6iVOAA3+N1bEcZCRqDUVB+BLImA/9LOm+MwfiftMylTBn7/aAttt6w
	9EvcBs1KtMSdHguoo401/m7AFZoZ+yTq8aJh08L3zXhGLX1T6BBbUqVMVd1p+3ntblHvAy
	wNK0S+9O5vCHCTcAO+i7ZM+Sqquv/LhKr7t2MeG8FL3E6AMzJMKd9lDZdmDlhA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793106668; a=rsa-sha256;
	cv=none;
	b=Fr00dIgCAkvAcUSQFdfo/7SBcnom9jDfIOFjrKyTCO+/9Cb0qZ8kELu/yNttaVN2RBrlg2
	q6AgTVpCqBnYhYsheGs924SW6XQt8Alipf8C+orO0px4ve9MfNYAokQTHDOvfUzIZO21yd
	lmb2tlPzSnjkTAlEbBkLFRfECpbD0oOtB0Q5ydMNu1w66MvtBx/ebVvRgeHFMaE1ZYvoUx
	sW+tVnmCaYhm536rIxd2tz7yoE9yCHzmR6cJERtMTs5fbaITpxAj1pl2bQjHxQVsliVgkC
	2qflEkHBs/EjLIpHdqk7HbSWy/XZM+dVwvWrwlt/fJ3XP1jB/INwUKEDgxS7xA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793106668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=klyjUEytPdkw0KjIMHT4jXnzc0nrujGeLh7w7DP4mRk=;
	b=OOyMCIBOBhxPOKXuP+OngS/zdGpEeuLHpmvTEr9w4JEZfU6+NOJVWxL6m1Xhn2vmGqyBQM
	+ceiElJPwXYtMm6ETsvDKhie7A5OkH165A1hBI/4An50sWq7BvPiQi3Ea6LKAfhJl5zqZB
	eyELQ8wwstbz4TE1aAyTbJYZaXuIvQrG84RL/fDUUJSuFANle7q1XKccdDVHkdMlGzaCDd
	c4aIRZJv0vK1e1cXAxe56nt8jtFrviNOa8tjAXw5+gnYBMLc5OvhX1Sx28JrDhQnHpjvPL
	Xzfq/g0R/OreVed+Hp2GkwGdGerT2ayoNI/gZ2vH00lgpUTFvrM++yoU6QA5Jw==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xLgxI-001R8i-1U;
	Tue, 27 Oct 2026 14:11:08 +0100
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 18E6E5D7FCA;
	Tue, 27 Oct 2026 13:11:08 +0000 (UTC)
Date: Tue, 27 Oct 2026 14:11:06 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: zihan xi <zihanx@nebusec.ai>
Cc: sashiko-reviews@lists.linux.dev, linux-can@vger.kernel.org, 
	Oliver Hartkopp <socketcan@hartkopp.net>, Vincent Mailhol <mailhol@kernel.org>, 
	Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH net 1/1] can: bcm: limit RX operation resource usage per
 socket
Message-ID: <20261027-furry-maize-mouflon-1d2e3d-mkl@pengutronix.de>
References: <cover.1793089479.git.zihanx@nebusec.ai>
 <92fe9d7fe3a7daa2cc7de740b15ec7eaa0638b98.1793089479.git.zihanx@nebusec.ai>
 <sashiko-outbox-186443@kernel.org>
 <CAANe3eSqwdmMb43pK4cBx7syOrQkqUZSJo-WnW9iZx2Qg6BdSg@mail.gmail.com>
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7tdzpskiqlazh5pl"
Content-Disposition: inline
In-Reply-To: <CAANe3eSqwdmMb43pK4cBx7syOrQkqUZSJo-WnW9iZx2Qg6BdSg@mail.gmail.com>


--7tdzpskiqlazh5pl
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net 1/1] can: bcm: limit RX operation resource usage per
 socket
MIME-Version: 1.0

On 27.10.2026 21:08:04, zihan xi wrote:
> > Doesn't this cause bcm_rx_setup() (and bcm_sendmsg()) to return 0 to
> > userspace instead of -ENOMEM when either frame array allocation fails?
>
> valid: failures of kmalloc_array()
> or kcalloc() reach free_op with err =3D=3D 0, causing RX_SETUP to report
> success. I=E2=80=99ll fix both paths to return -ENOMEM and re-review the =
cleanup and
> error-propagation paths before resubmitting.

pw-bot: cr

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--7tdzpskiqlazh5pl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCauCi6AAKCRDMOmT6rpmt
0mKuAQD7UlEVkAGI4t2al2uM+dmwQoCdIq846kgN272Wdepr2gEA7lhfy3oJKbEi
5/Kj0T4BZu8I4y51s9t1ddXFR1aEoAo=
=k/Zo
-----END PGP SIGNATURE-----

--7tdzpskiqlazh5pl--
