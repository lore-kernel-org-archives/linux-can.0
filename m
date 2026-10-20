Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792484471;
	b=gh9iCxdNS5lP4oW5X9Dt8tnRCT+ADxQLtaNniYga6j47uf9yJzc0UiCTOc7s1K2zI51W
	 jwiHNnYYjC+fOP8n8hzdKOuU86UuEeKjaTZU8e+KQGzxbsDl5A8WS3MIn+ZcF/XpzjpAp
	 oIxNc40pXBhOUNuat4uzYNmCIh6FNN1hNaJBkY0bDLVCkP6m8fXWlE/TgitZcreBGMYKl
	 LhRRKyESQuyBwCWMIffnr8SAhh2DQ2cQvZNBmsb+6GDF0z7Z6KgQrnz1blXYaJkmBszfY
	 /MZgjea7/1bU58sqB2Rz31eWzb2Inr8tJrugv0+zUq55BdQPNxwJ82aiNubz0NHJkHg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792484471;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=Xw9S0WSiL/aIA7HCNO3ve67hb2njoysBpfIt6SzbMo4=;
	b=N+ja2UX2Qfkopzg8naabksgauinWfR2OPi31MZ8OAGrYpObkKSZGNwX7LbucnCTcu0sD
	 9lkNKMjp4/kwS7ImQsE9iERqK0w0urrfk39C8aSU59D0AElusLAlFJQWtdbEguAPeiX5a
	 k+YG3LMsQn5F4Xwi5IP4+iMnHAvLJJSJ80vaKUSDFQ6uGN6OxQ2AfkYjbhQKtUiDZUY4K
	 wvxDUW5LQl+XEaH+A5ZAopcgg/zmzjCdRr/B7eGoKZfkf1yEgyCW+KazxIHdSgfDbaWCI
	 F85KhnLThyPw872furnUAfUqScKaDDlWAUbHwLF5SB21KECt6odEfzEYZGbDIor4k4w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=aIkBYOxE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC59606A31B;
	Tue, 20 Oct 2026 08:21:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9BC59606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=aIkBYOxE
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id E2EA5200582;
	Tue, 20 Oct 2026 10:21:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792484467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xw9S0WSiL/aIA7HCNO3ve67hb2njoysBpfIt6SzbMo4=;
	b=aIkBYOxEEZf96VE6uu/R90F+1clZ6IR53CDTCJBOTH/JR6rXcr1uq7X8jjMELkxwnANcyY
	izD86ur4siPj5MEEWpk1gzJJSXi/2Wnjkq3kWxcM6vqq+vgV2DWkiGaz1mUAxxcOQ36/0m
	H8KozNNrz9SsX9nnbq5mrDtnYEXywsrA8ynNpj0GWthX/Qhk+e4iU4pmwJHmTAFZ9Z2j8I
	KpuJ+VzKpCRVjpRaLWYrLXyUklv4nKgLaJIAthIwk3Vz/jmQr3G7QiRjA4SyyUieiAJQJ2
	b88vOQbwZvWXMypIcpoR4aygiuIkYgFiDzFjU6J3IWGBhoZZEqoGwJtNr60Kvg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792484467; a=rsa-sha256;
	cv=none;
	b=bso4HCbQAX7LdTw1Vhc7HFrux4PWiU6ZqXwEByP0ZFqKkHBUDwB59op/kwMOBvtx6Nl0Kb
	EW+iDAUIUUYG4z2ZYbh7q0w1hDHc47iF3MJ1crlq7HM3Z0yw8549uHJfGCpQ3qmyA3yDFC
	n5fzIszd6GPUb3tRvYZcBXcY5UpiNL8uIxIDdkNKWwXIJMJM/e98DxJVGD9Sz+z0moq3LQ
	GneaALmhRY0/gIeqi6jFAF8S/ox3Vv71ArOgHbDVrwE2jyKWB8zmSDhprJAyR2CE60gIVc
	NnFFgzldmHITbpWfMqRHP38G3VTWfcfQ1C8WI5fj+BG7GlmXhiJ1VCgXuRKFqQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792484467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xw9S0WSiL/aIA7HCNO3ve67hb2njoysBpfIt6SzbMo4=;
	b=GFw7uJLzSle6rK0CBZ2Kia/il/JTKnr1+1kf+h7FonCqZdMo6A66WZiHRh+9HAoLx6BXrY
	v0YWeSJc6Q0aEmaa05WKYmNO/3DUGh06Nn5VjDKwbOwOoDA2FZIOEOOkfj7jbcjNKTPCBR
	iR8P7+SYEgIHAyFi7Q4E4qV+vmLzNyxaSLuFG/bQuBMntKmkHbK1G6ax62Uaqa/aH8io5j
	mwc/hKQxfL0xSthn/oxq2Enh0+KPqDC0Gkwo1Mt4QN+A53rQ6ZmhxlBMh6AKEXjxmkc9Ut
	9yofmWAFS+przCbWhGrXvTVf4xjMKHDoklnfsMh65Jhdjc46ayAyVwyFwS+TUw==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xJ55n-000LNA-2b;
	Tue, 20 Oct 2026 10:21:07 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 7748B5C9CDE;
	Tue, 20 Oct 2026 08:21:07 +0000 (UTC)
Date: Tue, 20 Oct 2026 10:21:07 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Biju <biju.das.au@gmail.com>, Vincent Mailhol <mailhol@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, linux-can@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, Chris Paterson <Chris.Paterson2@renesas.com>, 
	Biju Das <biju.das@bp.renesas.com>, Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v5 0/4] Add support for Renesas RZ/G3L CANFD
Message-ID: <20261020-bold-wealthy-wyvern-891012-mkl@pengutronix.de>
References: <20261019120220.166163-1-biju.das.jz@bp.renesas.com>
 <20261020-auburn-kangaroo-of-diversity-dbd8e6@quoll>
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
	protocol="application/pgp-signature"; boundary="bb3562xeknxs3abn"
Content-Disposition: inline
In-Reply-To: <20261020-auburn-kangaroo-of-diversity-dbd8e6@quoll>


--bb3562xeknxs3abn
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 0/4] Add support for Renesas RZ/G3L CANFD
MIME-Version: 1.0

On 20.10.2026 10:13:13, Krzysztof Kozlowski wrote:
> On Mon, Oct 19, 2026 at 01:02:12PM +0100, Biju wrote:
> > From: Biju Das <biju.das.jz@bp.renesas.com>
> >
> > Add support for Renesas RZ/G3L CANFD.
> > The RZ/G3L CANFD IP has 3 channels and 11 interrupts compared to 2 chan=
nels
> > and 8 interrupts that of RZ/G3S. RZ/G3L has 288 buffers compared to 192
> > buffers on RZ/G3S SoC.
> >
> > This patch series depend upon [1]
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.=
git/commit/?id=3D2b4a5055d517b11bf4a5671cef32e4d77bc45626
> >
> > v4->v5:
>
> b4 diff '20261019120220.166163-1-biju.das.jz@bp.renesas.com'
> Looking up 20261019120220.166163-1-biju.das.jz@bp.renesas.com
> Checking for older revisions
> Grabbing search results from lore.kernel.org
> ---
> Analyzing 5 messages in the thread
> Could not find lower series to compare against.
>
> I do not get why you keep making things difficult for review, but it's
> your right. I'll skip the patch for some time.

If you use b4 [1] for sending patches, you make things a lot easier for
the reviewers (and yourself).

regards,
Marc

[1] https://b4.docs.kernel.org/en/latest/

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--bb3562xeknxs3abn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCatckcAAKCRDMOmT6rpmt
0nT5AQCJjSrakBP6meeNrxrUnR/IwmbbFq/gpUd5C484uZfrjgD9GeJWB9cDXTpS
PqI0T1asCFE4/STL3FU22J3qwUIG3wA=
=UQOI
-----END PGP SIGNATURE-----

--bb3562xeknxs3abn--
