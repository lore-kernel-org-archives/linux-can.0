Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A736554936B;
	Thu, 15 Oct 2026 15:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792077926; cv=pass; b=XEMgJWrP9Oe09vcTYvOeJSLuv9jxNEdhoztldso+R/Ywulrbwq7lNcVb32Z4cT/3vsAckbp8aer54S4B7WDLb/9pAKmSfrcLUukHb7igP6O7NqXM4R3wfQFPeC5jfS58ky5AFZD7KlETrJNAEAPMAzJM2DQP1Mm4hQFlse9u/ec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792077926; c=relaxed/simple;
	bh=RJPEHBvyeU8fIa4+jrbwkseJgF+bFh6xiAz8JUW62kA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hdp1tgD+Npc41kcW23+7ZhUOEyMAaTjd6cQxiDK/YzCg23ylUmGn6i37si5QWaxmAFFojUo5Or+kgEcR2osHeU12ENY/hnxXaFEBzMbjdKhLmZ9iY8JgYXZ3WsVlJhh4Ig5I3kr712HznV7JDci9af/Jylvz00VAVZs2qg0mYB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=DpNOPHQD; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="DpNOPHQD"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 0C743202012;
	Thu, 15 Oct 2026 17:25:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792077904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1OzZGAMgdlg5VL7TX0LnVD8RN7kLTcC2MMp1fj+YfyM=;
	b=DpNOPHQDDqEpOcWGG6fDVGZgXdRaLf4J6zmVmLhUm6Us5AgvH00r6r7NQrIwjK1h5QJ5l3
	dYY/Noss9a4dH+yAS8e9h3Q+NRAwz33qN9GXIpYwFvcjx6T8NKobR92Q+RI4Hdv46d+tgY
	OSqWwH/rYZBCHd1t8/9ZTwmbAz7mztWIq/u9+lD4vj+0ylc1IB78IVqtQW2ZGlZ78UrMXw
	yGt2AeIt8JYBPJc51v5Ynk6RMeYelds9at12ghOEGlyXheGXYbPNCNROFLyvTc01FIy5rm
	qVckD7i/bO96761PiCCxDn5CR+LKGn5xJ4kDs+qoaAGrv6i89dsoYiZBE/Gz0g==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792077904; a=rsa-sha256;
	cv=none;
	b=YTo+cb9MqG7f+6LvSqyNycito3xwrSVhqriUSBG0/2gtjrxBVIfBhWRiO6MJyjoIVoDp2O
	q5KxBiRIVWPGcO1hlE2Tdo3asiokxs4QVkJZUqh6xo3aNBWzKpkwcvgvl6gBDAepF3h2BV
	K4Uh9M7XTWIU5GoUZF36qbUfLJsVZrgMq37N0rvte0hRy/34I5uRVrtQgG36hKD8h5vc1s
	IM8HnqLXE+PBZD+/1iiiTYOWrpwg5hVBCJ4HExpayZZryfep+hZlOkrq+ffwGOgcyUWsrA
	c5NNPNt/T32ntC0khCe9AblDzubE1wwH3jpK4I/zXWf+yXpGqos2dP+zXB+c3Q==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792077904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1OzZGAMgdlg5VL7TX0LnVD8RN7kLTcC2MMp1fj+YfyM=;
	b=E5m+PVAcVLglDvMj+K1BU7SHAYRE3FqE+2q9SeDbq/o97Num9OoEjChUDhfjT7+jEUGktV
	1kM5XW8OXETvlG45IwJOhyM/OIf+e5qSRxIrwBTgEWhItTJeI0ddN9Lq22E0QhJ0Dc3FOw
	FvY4DiTAATEKoDTqg/6+Rp8RDJb05x7g9OF5tXBHP4sbVXpJZn4u6CfoLJkff9kRpwKmbX
	10Q1WtbR+10DiH+3S3CTKaay/I121kQcbrYuboOnQQk+mKmd2HDnV5XTzXok0yEEp/Zm9H
	JjvfqvTymk0Rx1nGkKiYNU3/DREZYiVK3AkTVEnXtY6JUhqVGSzhC3fFjydloA==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xHNKJ-0062qE-31;
	Thu, 15 Oct 2026 17:25:03 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A00685C5242;
	Thu, 15 Oct 2026 15:25:03 +0000 (UTC)
Date: Thu, 15 Oct 2026 17:25:02 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Quchaosheng <quchaosheng000406@163.com>
Cc: Robin van der Gracht <robin@protonic.nl>, 
	Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, Oliver Hartkopp <socketcan@hartkopp.net>, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH net v3] can: j1939: validate the EDPO packet number
Message-ID: <20261015-bald-green-condor-34e3fe-mkl@pengutronix.de>
References: <20261009105559.301873-1-quchaosheng000406@163.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="h742i33bbtuzgwvl"
Content-Disposition: inline
In-Reply-To: <20261009105559.301873-1-quchaosheng000406@163.com>


--h742i33bbtuzgwvl
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net v3] can: j1939: validate the EDPO packet number
MIME-Version: 1.0

On 09.10.2026 18:55:59, Quchaosheng wrote:
> From: Chaosheng Qu <quchaosheng000406@163.com>
>
> ETP.CM_DPO is peer controlled and its packet number is accepted without
> any validation.  It names the packet a transmission window starts at, and
> j1939_xtp_rx_dat_one() places incoming data at "dat[0] - 1 + pkt.dpo", so
> a value past the end of the message moves pkt.dpo beyond the reassembled
> buffer.
>
> The transfer still completes normally in that case.  With
> pkt.dpo =3D=3D pkt.total, a closing ETP.DT frame with dat[0] =3D=3D 0 eva=
luates to
> packet pkt.total - 1, which is the last in-order packet, so pkt.rx reaches
> pkt.total and the receiver emits its own EOMA.  The local loopback of that
> EOMA runs j1939_session_completed(), which asks
> j1939_session_skb_get() for offset "pkt.dpo * 7" -- one full packet past
> the end of the queued skb -- gets NULL, and passes it straight to
> j1939_sk_recv(), which dereferences oskb->sk.
>
> Reaching the dereference needs two things, and this patch keeps them as
> two separate changes because neither is sufficient alone:
>
>   - the range check in j1939_xtp_rx_dpo_one(), which stops pkt.dpo from
>     leaving the message
>   - the NULL guard in j1939_session_completed(), which covers the offset
>     lookup coming up empty for any other reason
>
> The reproducer in the link was run three times in each configuration: the
> unpatched kernel panics 3/3, a kernel with only the NULL guard still
> panics 3/3, and this patch gives 0/3.  The middle result is the point --
> it shows the guard does not close this hole on its own, so the range check
> is not redundant with it.
>
> Nothing on the path checks a capability: net/can has no CAP_NET_RAW check
> at all, CAN_J1939 does not require one, and the only capability gate
> nearby is SO_J1939_SEND_PRIO < 2, which asks for CAP_NET_ADMIN and is not
> needed here.  The vcan interface used by the reproducer has to be created
> first, which normally needs privileges; given the interface, any user can
> reach this.
>
>   ETP.CM_RTS (size 1786)  -> total =3D 256 packets
>   ETP.CM_DPO (packet 0)
>   ETP.DT seq 1..255       -> packets 0..254, pkt.rx =3D 255
>   ETP.CM_DPO (packet 256) -> pkt.dpo =3D 256, unvalidated
>   ETP.DT seq 0            -> packet 255 =3D=3D pkt.rx, completes the tran=
sfer
>
> J1939_XTP_ABORT_BAD_EDPO_OFFSET and its "Bad EDPO offset" string are
> already in the tree and have no caller; the range check uses that abort.
>
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://sashiko.dev/#/patchset/20260928193312.553632-1-mkl@pengutro=
nix.de?part=3D3
> Assisted-by: LLM
> Signed-off-by: Chaosheng Qu <quchaosheng000406@163.com>

I you send another version of this patch, please use v5, as the
automated tools are confused.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--h742i33bbtuzgwvl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCatDwSwAKCRDMOmT6rpmt
0k6UAQCNibdl87b3M7Aee2GbYtspHW2gnFHNHeKDXDHSFMDmfwD/S6LErYWd1yN6
XTnq5jTRSRKw/AZBbe+MgdBt34xLfwo=
=umYT
-----END PGP SIGNATURE-----

--h742i33bbtuzgwvl--
