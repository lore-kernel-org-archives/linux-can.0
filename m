Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792511415;
	b=gXgx24AcF0UEqMHcZb59OcyJg2lTBoEFkb5R7Wbapf+8rdQVB6DJHbWxNkRA7A1zyBJ5
	 RaUpltpObsxVYjbtnMH7+sDhHlxCKQBo1LVYx6tHVFcrTKZSTosBhnoAhF/SB0RiOHgrb
	 rI3CLs/1EP1mkGGxRuyrmyP1A6bmavUq2NvsC1GAU3cCUdDg31b89S8q56JA2EJmtQbVU
	 ZQcA7QGUbkMdlzEepTz8HgjM0OkZUUxkvNdx/8WhlGH1APnwWAMH9gqLozeIR/ALc5r2p
	 mSzSpIpt08bOMkHytHXB02YzkQmjJI8Yaz4wBWu0mADym3zRST4Zuc+hdNLtMmZ42HQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792511415;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=YEwPuEDW/aWcWWBs5o6JMj5ppTFEKPiLqquTluIHQHw=;
	b=r08Zna7ReK8GSxNZstMakaielE5JFKV32iYok6q6SnDZleF3XMZ9tlf/rJg3iRt0ZlgF
	 fONwgf/VupUvCAyaibdFKWav3Hjd6rd/il4R1NfJy4SDuvX0KdT8KB1mF69Xp4Nhvb8K5
	 UBFwrAoN2sWeoVoWfiyJzF3fQpp/CJ8vRROyBl1bykR2kvex6THUKRpqs+863DiYfLxT8
	 WwEE35wA+QaWQuT59c9/fMWpRj7e75XKNhTbIDB2NyIIwFPfcwWGsSciUGVNl6hk9nYN2
	 2K9eRV0fNXx0wre+ds9xomb/eDDF4uqb+3ZZKaP0YC9WrSnhP6BRzXj0ApUtGkxa4ww==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=JWQCHz7t;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF49606A31F
	for <linux-can@vger.kernel.org>; Tue, 20 Oct 2026 15:50:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CF49606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=JWQCHz7t
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id AC90A201EDB;
	Tue, 20 Oct 2026 17:50:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792511406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YEwPuEDW/aWcWWBs5o6JMj5ppTFEKPiLqquTluIHQHw=;
	b=JWQCHz7tTf9UFrha2GV0LGTg4SQl+t0rNxfS5QLhh6CEz4E8DUDVslxMXNCw8WIrON2+jI
	ueGXL9OmgubefKtuNIFP4l1P5V6WRG/UVwcA5Eei+f/fJAh+VSySzetpwAL0U3b8uvadTu
	uprWvDA27H+Bfj8+HxO56BVTIGV0dLQ4binCAbxeNvk8wPEyOsKWTuwbWuHi+vJ+VV+3kE
	kSHUhTWs/BbzwoE4jjxt1NhewSgbLOcxZNvKkQcpuQdSMb6ulKT585RfJOatet03Aj0MMR
	/K8+SzJx0RZu8eVcA+1pc4PZiRk0P4a5wn2peSPcJrazcbeAYsYlelb+KikJwQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792511406; a=rsa-sha256;
	cv=none;
	b=YG4RSZ8tW5EZMjbrO3L/gPwSUO7bXpxEIQxaueMZqwC9g9EN1cJcen8D6jb+Ytx0jW1HSx
	gLouUpZk1oXzIWol2pW1ZAUUoRCl6adRSc3+GN+f0eTeBfLNrrM6af2+8UDALX24qQ27Lt
	Mb7/KtIQxLsYd/hoPtGNRh6VgDRwZesOdHu9nnv30fytrGMh0GgxXuzJniPrdoKzDyj8jr
	+ZJ9CUDvhXFZq2/cm+duX9XOSeBQZI3Zcva3LhV+wE82X7w4i8B4cBgmZClqEFlsOcbAr1
	t6zo69Oh0vuqa6gssgcK/pH2X5l0CTefN+gzJYt1495FZqSKOmyIp/VD9V+Ahw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792511406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YEwPuEDW/aWcWWBs5o6JMj5ppTFEKPiLqquTluIHQHw=;
	b=B5o+fAZ0MR1fEp2tl8da895Q6uohIibaRL6H/DzW/UPZWUBpPabU2y3A+biNiYtwKqb8Ro
	ESOHgu6CrqSm9yGK66YzOw4JV9oc/STMU0tuhBXrdHQVt5IHg9fxlrY68PT7FXuQ1UOMTS
	W4AiPW5oBKAFDOaGYYZvIJ8MSRrieTDWdhzrHFkhdVncZ9GJnIi7i+FRBNdJBbm74DGyC9
	IgcIsqZNeXMME753PO9/DgBYPcRS3KiuR3uh7c4uV5dhBzLmt037FsLzYsJ2UYlfpEU2ms
	4ZaQNgO5piSyZJzR2dXSGHSU16kJ2CHutDojTmWsu8naYfE97GU4mNDCXH5EtA==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xJC6I-000OTz-1q;
	Tue, 20 Oct 2026 17:50:06 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 4695A5CA3CE;
	Tue, 20 Oct 2026 15:50:06 +0000 (UTC)
Date: Tue, 20 Oct 2026 17:50:06 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Filippo Storniolo <fstornio@redhat.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
	Robin van der Gracht <robin@protonic.nl>, Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, 
	Urs Thuermann <urs.thuermann@volkswagen.de>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-can@vger.kernel.org, Davide Caratti <dcaratti@redhat.com>
Subject: Re: [PATCH can-next v3 0/3] Introduce diag support for CAN
Message-ID: <20261020-funky-buffalo-of-progress-fa4bf9-mkl@pengutronix.de>
References: <20260904-feat-can-diag-v3-0-bdcebf07b373@redhat.com>
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
	protocol="application/pgp-signature"; boundary="moffe2jguazdbuck"
Content-Disposition: inline
In-Reply-To: <20260904-feat-can-diag-v3-0-bdcebf07b373@redhat.com>


--moffe2jguazdbuck
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH can-next v3 0/3] Introduce diag support for CAN
MIME-Version: 1.0

On 04.09.2026 16:12:54, Filippo Storniolo wrote:
> In the current state of the art, it is not possible for userspace to use
> tool like ss(8) to query open AF_CAN sockets.
>
> This patch series adds the netlink can_diag interface for AF_CAN. Userspa=
ce
> is  now able to send a netlink request to request information about open
> AF_CAN sockets that are retrieved by the can-diag.ko module.
>
> Patch 1 is a fix that is mandatory to the correct behaviour of the diag
> module: the field sk_protocol is not assigned during `can_create()` inste=
ad
> of being assigned only in case the CAN socket belong to the j1939 transpo=
rt
> protocol. This is needed to the correct filtering of the can diag module.
>
> Patch 2 introduces a list per network namespace containing open CAN socke=
ts.
> The list is protected by a mutex.
> CAN sockets are added in `can_create()` to the list and removed from it
> in the `release()` calls defined for each transport protocol.
>
> Patch 3 is the core patch that introduces the userspace structures to que=
ry
> and receive netlink messages for CAN sockets and the actual CAN diag modu=
le.
> The latter will use the userspace structures defined in <linux/can/diag.h>
> to filter and retrieve open CAN sockets.
>
> In the current implementation, every CAN sockets in the list is
> returned to the userspace, however a filtering could be implemented:
> Userspace could possibly request only bound CAN sockets or CAN sockets
> belonging to a specific transport protocol (raw, iso-tp, j1939, bcm)
> and so on.
>
> An example of the output given by ss -cpe:
>
> Netid                     Recv-Q                 Send-Q                  =
               Local Address:Port                                   Peer Ad=
dress:Port                 Process
> CAN_ISOTP                 0                      0                       =
                       vcan1:1110                                          =
vcan1:291                   uid:1001 ino:50324 sk:0 users:(("can2",pid=3D92=
10,fd=3D4))
> CAN_ISOTP                 0                      0                       =
                       vcan1:291                                           =
vcan1:1110                  uid:1001 ino:50323 sk:0 users:(("can2",pid=3D92=
10,fd=3D3))

Nitpick: can you remove the most of the spaces from this output, so that
it fits better on the screen.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--moffe2jguazdbuck
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCateNqwAKCRDMOmT6rpmt
0gEAAP9lvjJ0mz4sU2Tx9sNtPscDhDIU4LeZaQEbzzztwvZ5vwD/b7gBZFtxFIPV
hN1iYIoL8v2uCCtZdovy6V3l8wuxiQI=
=+xM6
-----END PGP SIGNATURE-----

--moffe2jguazdbuck--
