Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792510010;
	b=3vedpkn7b/0Mac7v5F9Iu4USP/7DGNLw35y3LoVqqBsaat2qWH8Uq3SsiMg737EHrTOm
	 XtqjLKwD1qcqT4Uv7BxiZAvgofqOmvX7RWOGxnhOxVEbb5DMrDJzkYbfcU60IqA7MKows
	 LAB6agrUF7JOpeDG5MRazLz+TRlxNeMpU/FX0TJ71Dij//uX8hY8JLJgxQTprmpiUWsJA
	 SOaPs0ME8adfSZy2SnE3shE9yNp7IGX29Z+ChERAwCLLWpsncFmS2LsO69gYNYtSrPD7W
	 wGyKYUz2QjiCCw8MHiduOLkStCifrSzWPBHOTYvt7k+PlJsqsK6j0yM/6vJpFiP8TGg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792510010;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=1gabiujB4HoJ+VsWwQQ9Sx0cbtq7be2BLpzdeJzWw50=;
	b=x1Lu3I5OuPJpZccmPHtRI+ZtzHMJikIZtc7/8xMAvLS/a8j5K/eOOGZSvPnfqCT0u5jX
	 xEt2NDVGRNIHVYsD2ykdwFlCzvRlgPYgfwXlAd1zCvcLD5m7FMd8PuUzYS4ejPpKWgxaD
	 DS29QPsBltpkzkClzntN+dfgV2NfJ3kwJ463TUe08lVJD8E62H2mjPfy87XHPRxcLc36Q
	 Bzx+/SaD/IGx7XY9WravWmOUpzwWBYJ+rdiUx/04uIa6299S7FedHLWKg7zwxHgwMzMQO
	 i+oV3StmO8bocwIYYzCzDOMhiHsud18pleFwg6LSdss4RWmIAR6aIocfCQW5E8bnZYQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=fVCjhHtm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E8C606A319
	for <linux-can@vger.kernel.org>; Tue, 20 Oct 2026 15:26:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8E8C606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=fVCjhHtm
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id DBF78201EFE;
	Tue, 20 Oct 2026 17:26:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792510001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1gabiujB4HoJ+VsWwQQ9Sx0cbtq7be2BLpzdeJzWw50=;
	b=fVCjhHtmerMcx15b4mwS2qzoeNIZ1xjB9Gyk1jX4EM20HErcAzYhLiZehy+28Ay+yJRr6s
	9JPIrN4Z463uyETT1wda6OBCXFio83nOtwfsyjN7zxSAXWvASpGMoGIwjfOHCxLCkTk5Qb
	nH6TtNXICjvNIHlQ6ho74xgygDEj505mVsDjUVtN/nGSj+6kHu4jKP95rxaM+JSDh5Lm9F
	sseMqkReFNock2jW+86MGPsqwx6OqV2OQaevsqcVu3LiwzRoRiPbK8H0cQF6Zh08f4soQn
	Jvt8n/n27siDHgNEtE8FaaLCHLq9wYNR5Oo+oMwCQQR06KzUgXZdmSfXYealCw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792510001; a=rsa-sha256;
	cv=none;
	b=IRYpPlt+CbN1VbFumeZdhen91Ebp0LPKCU5xx5+6bpelRg9ZUbR/qgPNqNr05ITQj2Gqd6
	GQOh0ylqevCvfFfOWVJNi/YnX6YlunbsdGyd3vN0tXdXKSkTMh5cyHEunApsXDELEBoVVz
	c+UCi4sXs9lqPHfu0Wzt9Ixmy385k0PrmxzSXpeKbVNYuS/tfyg/OQqqS0YJNweJ6EWmZh
	73WeW3oherUhRBmSORoS0cg2VYnzBTBWShzWQd0ptyvLvq+6nvjQiPHy8voW5zoobM7KAg
	oTyHJKGYxT5ZOyi+3QbW89M9cI9bBgEBEOF5yLzZgSr35jveUOkQqf4RYDlWnA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792510001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1gabiujB4HoJ+VsWwQQ9Sx0cbtq7be2BLpzdeJzWw50=;
	b=giMa8rqVY6iqoB/D724+z3AYBI49CWDOHQ6lD5bzcNrD8ZZ5wNN6MJW2xJnEkZVkp6AJ7a
	Eme8rtibkTB1QgTHQNv5urK5sy+sZk9qHtch1/QidyyY8H5txF/xWBtusqZU1I9QB098QZ
	QrhHXDRz5k7k1tYw5x86vYvhfl71UcPOogyEtbjMJ9YFa7GAV/TyaP1VPXI4k9lYzvmQR3
	u8zJbXHVch9Moof4rweQpHegXpoZLXg9r3za7L1W4DhibiZClD06uOXk3QXRgcQmLxgwds
	kFyoufuA4qwhwceSJofMko/hWZd62/cRTo2mC+I6eJ0Yb2jB8Hhy0kcQJzinng==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xJBjd-000OOW-2X;
	Tue, 20 Oct 2026 17:26:41 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 786D15CA37A;
	Tue, 20 Oct 2026 15:26:41 +0000 (UTC)
Date: Tue, 20 Oct 2026 17:26:41 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Filippo Storniolo <fstornio@redhat.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
	Robin van der Gracht <robin@protonic.nl>, Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, 
	Urs Thuermann <urs.thuermann@volkswagen.de>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-can@vger.kernel.org, Davide Caratti <dcaratti@redhat.com>
Subject: Re: [PATCH can-next v3 1/3] af_can: ensure sk_protocol is always set
 on socket creation
Message-ID: <20261020-versed-moose-from-hyperborea-cdf670-mkl@pengutronix.de>
References: <20260904-feat-can-diag-v3-0-bdcebf07b373@redhat.com>
 <20260904-feat-can-diag-v3-1-bdcebf07b373@redhat.com>
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
	protocol="application/pgp-signature"; boundary="ovgiikwcrr36o3yh"
Content-Disposition: inline
In-Reply-To: <20260904-feat-can-diag-v3-1-bdcebf07b373@redhat.com>


--ovgiikwcrr36o3yh
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH can-next v3 1/3] af_can: ensure sk_protocol is always set
 on socket creation
MIME-Version: 1.0

On 04.09.2026 16:12:55, Filippo Storniolo wrote:
> From: Davide Caratti <dcaratti@redhat.com>
>
> Currently, only j1939 assigns a value to 'sk_protocol'. As a prerequisite
> for the implementation of CAN sockets diagnostics, AF_CAN sockets need an
> easy way to determine which protocol is on top of an existing socket.
>
> POC test using can-tests:
>
>  | # perf probe -m can_j1939 --add "j1939_sk_recvmsg sock->sk->sk_protoco=
l"
>  | # perf record -e probe:j1939_sk_recvmsg -aR -- ./j1939/tst-j1939-ac
>  | [...]
>  | # perf script
>  | tst-j1939-ac  5807 [002] 322767.312599: probe:j1939_sk_recvmsg: (fffff=
fffc0b29a14) sk_protocol=3D0x7
>  |  ^^^ 0x7, that's CAN_J1939
>
>  | # perf probe -m can_raw --add "raw_recvmsg sock->sk->sk_protocol"
>  | # perf record -e probe:raw_recvmsg -aR ./netlayer/tst-rcv-own-msgs vca=
n0
>  | # perf script
>  | [...]
>  | tst-rcv-own-msg  5816 [001] 323173.651122: probe:raw_recvmsg: (fffffff=
fc0b20154) sk_protocol=3D0x1
>  |  ^^^ 0x1, that's CAN_RAW. It was 0x0 on unpatched kernel
>
> Storing the "protocol" value in can_create() fixes the problem. This also
> fixes AF_CAN support for the following system call:
>
>  | getsockopt(..., SOL_SOCKET, SO_PROTOCOL, &proto, sizeof(proto))
>
> that was assigning 0 to 'proto' since the earliest kernel versions.
>
> Fixes: 0d66548a10cb ("[CAN]: Add PF_CAN core module")
> Signed-off-by: Davide Caratti <dcaratti@redhat.com>

Filippo, when you re-spin, please add your S-o-b here.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ovgiikwcrr36o3yh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCateILgAKCRDMOmT6rpmt
0ijSAP44r2VNvOLRZMZrc8/Rn48yso0A/tft4YxDjONtuvevoQD/W5+1xXtvJMMg
O5un8SBFXH8/egQew1X63bosQrTzxAA=
=gey9
-----END PGP SIGNATURE-----

--ovgiikwcrr36o3yh--
