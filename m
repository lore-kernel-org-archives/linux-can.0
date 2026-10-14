Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4924EC65A;
	Wed, 14 Oct 2026 23:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792022033; cv=pass; b=jrsr9u8IgiJyzzyAY7rpFdsiaUZzglm7SZHG6r/GnASVDbNeKaHUgs2JSjiIutsJzdfxyG1FjHkBDaVut7NAWUiKojDB7TNS+dgU2E+F+NDVzI05Kk94A1hJiSjLwx9ijH2xpY1Bnd1C1vl9LFAthUoAKwNF8t/i7wa/ENgIdtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792022033; c=relaxed/simple;
	bh=K7spC93yJPVuKc70Lmxf16pLFaMTb6PQF11kAN4MVxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hqHcRqoHkwUlosuJpEsfGHp1UppxfQcx3sTRX35eIMiGFUkcpVcbBsoe0kvROSHQ4pR2N5c6nEw99U3MmaISvK8OerIus0MUA9RCU97nfoEypM9JKkJx6R2UaOQdNEm8MOiEbBtxxFQHOvu6heBViZOUdeHdZL6VsX0TDgZ4ClE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=UiKR7Xzw; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="UiKR7Xzw"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 55742200467;
	Thu, 15 Oct 2026 01:53:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792022024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xbQ2tmFekSANRJTrBJ0BwongNv+WUIZenWQDBJ6VEl4=;
	b=UiKR7Xzwd1vo7B+naXmhwmpkzxWIV80UD9WETNeR+H4kD5dehz0PXHmtcRrDXDYaBX7ye9
	7MbMrpysMa2GIj6RzJ+fcZ+bDroJ5B5L1ZK0hwW8DhsEh4q8KfLe/qcXbvbMqK0WNUssCa
	iYL9w6nGJtnuAy6TmhvgRTHO9w1WzX+X9xunpGe0UjCUnvYjWGD6JxhgZ2/vOlup2wL2RE
	wzNL5AOHIgWhxLEvlOtL2qcVeN+bOb4EHxQvRPf7UOUwTQ7AaBXa3BNtwlji1+GiTbyOPK
	2L4wS8x8nVDbKSM1hnpk+h+ClsoA/6Y/kaDHUECBoHSQLAygZVnZdCsTWXD+6A==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792022024; a=rsa-sha256;
	cv=none;
	b=O1936JxKRAcF1ctiuLWa477aBzkCLIkGTmu2/II4jcjj7pQ7OPa/E0ETYLLh0MgH1wXQ7e
	eimNQjfHXsQ5Az/QEcfNf4Jb0uHfQUAkghCh11ySUNcLCzlOzKpdaKfi1d8uCSYwpBa+Tl
	LCnainI6+50utA286cy1cotw1Ghwu0V+zXbVCZvt8lBP5pdXcENxBtUIc8LYvShSl0T5GZ
	5S9300/Xf9RH7gE3FeRrmqAj8sB/H9ZeF5oYxd2/sLJ7cISTQlRHPE8GJiYChcxSCbIuZq
	xAchZUtlcUH/8WpJzPrn80WepUtKbRbYuRfojFeduAisFc2AL4sepp69IfzVAg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792022024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xbQ2tmFekSANRJTrBJ0BwongNv+WUIZenWQDBJ6VEl4=;
	b=GCUIqWfrgnu9oSlwiU6/Cvi9OoN/uEaTcYrlA57GBT7o16Nsc0vBg1kWA7W+HrpKz3hVZK
	JEJlxTodz60Hh8j8WEpVdYjX/behcXo3oNVmtDhOCkYOEZ9GY+Zf0yO1RNZ1T+6FmumdhN
	9yIFVVebhtVVuHr3rHM+bi2eEltHzZgKddvTWWa/hMyUoFhzrgiEHp/g+PG8uAUyC2r24b
	FHqMlSa/q3KTuzOMxM/zY/gZrPTrQ26mWAosBau9uyIVoGJ/7qq0nML1OKzjuR5q5kK1Jm
	Zu8p22W38vzf1yiwCYbYcppULE2exnJGIyU1uKrIHUOUbJ3gYuBCW7SbraR8xQ==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xH8n2-005w1I-0e;
	Thu, 15 Oct 2026 01:53:44 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id DCC165C4643;
	Wed, 14 Oct 2026 23:53:43 +0000 (UTC)
Date: Thu, 15 Oct 2026 01:53:43 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev-bot+sashiko@kernel.org
Cc: yogeshgaur.83@gmail.com, mailhol@kernel.org, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzbot+937a3a1fbfbc99d6fcaf@syzkaller.appspotmail.com, 
	kuba@kernel.org
Subject: Re: [PATCH] can: vcan: use per-CPU device stats
Message-ID: <20261014-splendid-faithful-gharial-52564e-mkl@pengutronix.de>
References: <20261007113611.2082-1-yogeshgaur.83@gmail.com>
 <179150583668.1406898.16297101260619649490@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mtyba5ntcu76odir"
Content-Disposition: inline
In-Reply-To: <179150583668.1406898.16297101260619649490@kernel.org>


--mtyba5ntcu76odir
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: vcan: use per-CPU device stats
MIME-Version: 1.0

On 09.10.2026 00:30:36, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 (1) =C2=B7 Low: 2
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
>
> - [High] The fix is incomplete.
> - [Low] The commit message gets the cause wrong: 'vcan does not implement
>   get_num_tx_queues(), so rtnl_create_link() honours IFLA_NUM_TX_QUEUES'.
> - [Low] The patch fixes a syzbot-reported data race (it has Reported-by:
>   syzbot+937a3a1fbfbc99d6fcaf and a Closes: link) that loses tx/rx=E2=80=
=A6
>
> Pre-existing issues:
> - [Medium] This problem wasn't introduced by this patch, but the sibling
>   driver vxcan (drivers/net/can/vxcan.c) has the same multi-queue stats=
=E2=80=A6

pw-bot: cr

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--mtyba5ntcu76odir
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCatAWBQAKCRDMOmT6rpmt
0rmCAP0SGabOcVBtJWjv1MVIvMbEjQFqRGJx/Twvf/R6JQ6lggEArtQWMe+FHlx+
C5y/7ziOiNZMwgF6AOrRZBuNxan7Dws=
=G/K9
-----END PGP SIGNATURE-----

--mtyba5ntcu76odir--
