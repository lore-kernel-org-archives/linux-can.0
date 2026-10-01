Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21DF531612;
	Thu,  1 Oct 2026 15:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790869074; cv=pass; b=ANitn6wglhkd2GSmOuk6nvSXY6GstI/NcVYMi/TecfXU7C3X3+Wy8U5QB1id9LFNisIVQPYh1Wx6OubIVQK1ZkCE5WPk9/yzYTHxJTOLZtr/XYdKDIl1ZBywIA6yhnOWH1vAV1TtK8qfZ8Citspe1GCIw89i+HrVBmksrIzNs24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790869074; c=relaxed/simple;
	bh=t1IrpOQuXV7QP82kGU/efthLR85YibMK/jxBL0JK7dQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TIFGibAfryRLYtlELvkAshRvW6Usn050PzfUeqOh9WB3zhi6rCD+OvVzvam3n8IDtCJaKKl2NNVR2vs3/Iud/0gAlhionV33k5g+r96S8KdWNMEILFPt7lFSqIKdLlXzvA2y1t8PPd4sdp+hM5V5eO9+MMEAceezx1EjMI9CS2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=U/0Pdq4a; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="U/0Pdq4a"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id ABC5D200758;
	Thu, 01 Oct 2026 17:37:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790869065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n9RBmNx5zeqUMXYXXlyHqZhPF8uWWhj7beBIzjXq550=;
	b=U/0Pdq4a85jaBjNZ7AMbn9X4yRB5+J8ISBO84Nrf7apxl0jWUv+PzPS8yKFN47a2JGBWSa
	P4OAWQkzQbGuC0M8Jnf+JqV1iGyIBOcChuEil/2ex7N6IL8ICdmTWzIxP8LRIHbuUNiz2t
	IcToHVG66ns3hxG0WaXjXmUBrPhZje7en2vDms+ljFa1Ma/sAWaCQJuABh4qxUbF05JjH5
	GzlIDrhLZONTY4AK6oiSRjWHeUFV/3alq16WHNCgE24M9uUGs0BN7JH6br5TmilSNv0C+c
	Rri3LgDM8OoR64wdcGjkxtkOpfndh1lg8QAs7M0c4+b/bgaU67hY+5gHUh3l6Q==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790869065; a=rsa-sha256;
	cv=none;
	b=f4w5ABKrDZal6QHk6kkcaWdMST9GVHw35YKFDslRRUtkMod4Ucz32FsFWR2OF7DwyXphNT
	lUQzS7C16Bd+QEPKHHJtDlC5OciBT01EoUOHgYyOZh0SLNCxwqWeQY5WWNXYlKKKkwzKwe
	3F3lttLXU335oQfDorhlTRZFGfJVIMrPLrGUBXVdlR8DHcOFOMbAQMEQrne7aI6ClKGVIk
	HnSp9BVQqHqDP5dhQjtjBto5vjYl6Fz/ue86KpL+3fPUrfHordgivlvc/vshTzJ9NnPm76
	U9wP8S2/A6+USJdsorLTNFbGOTTikPd2+5GEZ/lMxeI1K57d1zJ1vUKuSgvppg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790869065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n9RBmNx5zeqUMXYXXlyHqZhPF8uWWhj7beBIzjXq550=;
	b=VZrux4cMA5aU2DX8xQPgFllQg4Bb8xpqbOYOWWeAX9tYAPpa5qzdqCzd/658NK1I7gClAO
	6WL4wMPuBaV5rW4bR94BUD1b+oO6MGv4PUoASHfhU8GnnFv0PRHqUoToYgReDfIGi3+BOt
	U2LZR4ehl1NS14SA0lMkRi8LGIx1F+Xad3AFjCHyLnaSsrEjjnXHPV1q+GkNNCKanHYrS2
	L2vMKEVTf3/Ius9/xR9pZMR7LHn8xCfEXhUVD6JVEQFTvbZHqeez4z63sVl/wCE5F6fMvO
	PhZapm8sfTM8G3P5r38NN3jcTIcxYWYWJnUQQr/S3fXTrA3jdehe+A3D+1nZdA==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xCIqv-003kYp-1t;
	Thu, 01 Oct 2026 17:37:45 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 4F9135B79CE;
	Thu, 01 Oct 2026 15:37:45 +0000 (UTC)
Date: Thu, 1 Oct 2026 17:37:44 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, linux-can@vger.kernel.org, 
	kernel@pengutronix.de
Subject: Re: [PATCH net 0/16] pull-request: can 2026-09-29
Message-ID: <20261001-viridian-jackdaw-of-might-4be3ad-mkl@pengutronix.de>
References: <20260929210700.1183036-1-mkl@pengutronix.de>
 <20261001082850.754ca22f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="f7szyp6tsyhillau"
Content-Disposition: inline
In-Reply-To: <20261001082850.754ca22f@kernel.org>


--f7szyp6tsyhillau
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net 0/16] pull-request: can 2026-09-29
MIME-Version: 1.0

On 01.10.2026 08:28:50, Jakub Kicinski wrote:
> On Tue, 29 Sep 2026 22:43:50 +0200 Marc Kleine-Budde wrote:
> > Hello netdev-team,
> >
> > this is a pull request of 16 patches for net/main.
>
> AFAIU there will be a respin here, and it's hitting:
>
> net/can/bcm.c:944:2-12: WARNING: NULL check before (net)dev_{put, hold} f=
unctions is not needed.
> net/can/bcm.c:1312:2-12: WARNING: NULL check before (net)dev_{put, hold} =
functions is not needed.
>
> so dropping from PW.

Thanks. Meanwhile I've send a new one:

https://lore.kernel.org/all/20261001151905.1556270-1-mkl@pengutronix.de/

Marc


--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--f7szyp6tsyhillau
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCar5+RgAKCRDMOmT6rpmt
0t54AQDdY8fK3D8AsaTx+C+vdX/yw+WxDVYSoBaoMWqdX5oH9wD/amV3/4r1ZEaR
8ZDeYNfo8nXMaSB9IoNzoUbgK0VF6Aw=
=Y1se
-----END PGP SIGNATURE-----

--f7szyp6tsyhillau--
