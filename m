Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794574207;
	b=YR59ij95rmJjasQEm2lqZQOSvR8B/GgrpU9rhMHKUAR5+eKYkrcq/dAwRh43BbSvBTwT
	 cIbx7488QcGsS/ZNUQXlw9ltdeK2vJnG/QokPoOprbtjh2nqOaL58Ihw7Qog0jZ4Ajeyq
	 RS3vVUfOq8dIMcsg1ULVacKRHtUkvtWVFR4xrcfi/RvP6GRk9RVm99/cMGSl1rG96354b
	 8OlqjUojQK5B9KUJWh0zzsdmx53GB/u42SupQDcK2bEXK95heU2OvKZZi6DedfJj6/Dxu
	 +/OzhHxT24xi6ruI+LF7goxUMTbynk/1xHScUVAYxD6nQXqG07tEf0fhQSErzos1f3w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794574207;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=Hl9S2k+PAHDSXsEU2Mzj5v5py0M7YolmVm0n2k6JYoc=;
	b=mwXNTyYkZMNBK7PT0FegwQ62XkQbjf0dlLILG8fqq/uzUiTMLfqNJg3rsR0KDU1j7rfb
	 fVydUSA8WYaNhwgDRkui2r0gfPF5Ra8rNqw7K7hvzXZhjWS+SIi8PueKHI57mm/gdbxnm
	 q6bLURaI35TZhIsLStgm/k4TfVeEHxP9LU0zl+vIscvZcudTrmpRE2tbV+9HRi4BPJkTD
	 k3Fs9qz3t38XVqj36c4rlYUz3G9mOSJe14Hs96uAnAzpef2nDDBhfx6Q+A68dJ0h/0dRo
	 oAuezY5oNd+vozsNo4qvjwe8IXvHkeVxwIwsayLiDdogMoQgWgnVkKrB7qv8hiWXAjA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=DnhVlKFm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE7B6070CA6
	for <linux-can@vger.kernel.org>; Fri, 13 Nov 2026 12:50:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FE7B6070CA6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=DnhVlKFm
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 99BD8201EC6;
	Fri, 13 Nov 2026 13:50:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794574204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hl9S2k+PAHDSXsEU2Mzj5v5py0M7YolmVm0n2k6JYoc=;
	b=DnhVlKFmnKiD/f0rfz5subrkq3y2X/aMF2Wj2EP/fWRFN/iljd5QnRV+WlvwDHzQo4ASnA
	P2EBaStpRU1J9YL+tiZxroDfdAsL/Pi5EdEnyCo8+16sApXob10oFHHuuOgnN4RJo5HhlE
	nXEp+dIyKAVbPbDqLkz9vrR7i640z7dIWmuPSV+tQwnqc4JPFVvYdUvROwx4APFEbQ7Qbi
	mRAol5bW5bCLmoJ/CUVJXq511vO3AgNsIe5YuIAGCNzgKxemV92YdxFzJ9oLvYp78s2wV/
	KcvUTESokfmBsI59CIfSDj6WkwacQVTFiGZ0Q04u+rG5dDAZRtpSN7elWnOybw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794574204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hl9S2k+PAHDSXsEU2Mzj5v5py0M7YolmVm0n2k6JYoc=;
	b=RjGDWH4cHuB3VubgJof6Qbf/XELCTP8S7iisyZpkyKihItjHwBkoWyELTdXdUgMJ9/ERmi
	rFEnZsdOQrfhS5JSAtr1tgeM/02H1OHFMs06fYN5vfU2wqh5NW1pU7qLQdBz/NXjobzfDs
	VgoUx0n6mkZ0uwu9WGrZw3OZW5ZhaI409N+B8TQBOjVxgRnintyHMroBu94UBgK363011p
	+z1ALf0ifydu+VYdMp2sviv2ULLc+Il3eQBUoPxtjfmOAWr8s/8DJ3/2CaIZ8jeVTvFjZ1
	G1hZw2Z4He87k89qE88F8ufAR23dn9uC/aSPb1DBlh7VenN4ZcDN6jrWr9E3lg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794574204; a=rsa-sha256;
	cv=none;
	b=DDLmna5e0GFPUCuAfeVXz8Lm62mMtRmVt/zjRQlYhFZ2unJ1aQN9bAiITcySVPfGS5XME8
	6eDDEr041QcwrIK6o+vQBPpTZJ7a7Tps+WJJ8p1G1vwINXD3+1CdJNohVmBa3KnLJcrwYr
	HgLOMIXS6DAZBJQHGSdXJleVama3RF5Dif+z9TTv4dqWctX6beqJy3WzFdfgKNOtrbXAjl
	oNL2jVBEcZU5BjU1nFGvdgfgeFDTbYLZzhfcM5d4qIj/ci7pxEzSZh84lVqLu1BJUjBAKI
	FTGruUrUQkU3zPfyq9mcq+5cjuoNssdCtmcDQNnKqwD8KPP4bnnHgNe2uznR7g==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xRqjE-003zZD-1j;
	Fri, 13 Nov 2026 13:50:04 +0100
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 4C35B5EAA7E;
	Fri, 13 Nov 2026 12:50:04 +0000 (UTC)
Date: Fri, 13 Nov 2026 13:50:04 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: sashiko-bot@kernel.org
Cc: linux-can@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>, 
	Vincent Mailhol <mailhol@kernel.org>, Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH can-next v6 2/6] can: gs_usb: gs_can_start_xmit(): don't
 leak uninitialized memory over USB
Message-ID: <20261113-strange-dangerous-kestrel-dddc36-mkl@pengutronix.de>
References: <20261113-gs_usb-fixes-v6-0-0c039e1bfd74@pengutronix.de>
 <20261113-gs_usb-fixes-v6-2-0c039e1bfd74@pengutronix.de>
 <sashiko-outbox-212616@kernel.org>
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
	protocol="application/pgp-signature"; boundary="xa24eztricemh353"
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-212616@kernel.org>


--xa24eztricemh353
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH can-next v6 2/6] can: gs_usb: gs_can_start_xmit(): don't
 leak uninitialized memory over USB
MIME-Version: 1.0

On 13.11.2026 10:18:21, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Low] can: gs_usb: inaccurate Fixes: trailer in commit message
> --
>
> commit ad35ba4588d5d85da58395d08e3738d74f314193
> Author: Marc Kleine-Budde <mkl@pengutronix.de>
>
> > can: gs_usb: gs_can_start_xmit(): don't leak uninitialized memory over =
USB
> >
> > The driver allocates the transmission buffer using kmalloc(), which mea=
ns
> > the memory remains uninitialized. Then various headers are filled and, =
but
> > only the actual CAN frame data payload (of length cfd->len or cf->len) =
is
> > copied into the buffer, leaving the remaining buffer uninitialized.
> >
> > Fix this information leak, allocate the buffer with kzalloc().
> >
> > Closes: https://sashiko.dev/#/bug/linux-0a8c0e8a-c623-426a-8db3-f55111f=
6cd84
> > Fixes: 26949ac935e3 ("can: gs_usb: add CAN-FD support")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>
> [Severity: Low]
> Should the Fixes: tag point to d08e973a77d1 ("can: gs_usb: Added support
> for the GS_USB CAN devices") instead of 26949ac935e3 ("can: gs_usb: add
> CAN-FD support")?

will fix

pw-bot: cr

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--xa24eztricemh353
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCavcHeQAKCRDMOmT6rpmt
0qQ7AP9BjUdlFCgTU08rXo71tYlk26I0iXswUNahA+65SWaS0AD8C+iWPCLF2mmU
eoAegIz4Iw11UZ+Pz2CANykAyX4QxQk=
=NgYk
-----END PGP SIGNATURE-----

--xa24eztricemh353--
