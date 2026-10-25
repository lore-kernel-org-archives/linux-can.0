Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792958479;
	b=RCP7a3ZrWWDmGKgpTdbP5NdhUs3ePsnRb40tk0qF9e/hqSu3RjtWfns/U25Fr2NP5FO0
	 VH/1WOf79Lce01di9vMJvymHnFu9bS8jdhexGFdnGWSTBAqsnDEqqtwRSUpSJMQsWRDcy
	 MIcdGHnyjz5hLbaDfIQJ16gjcVchP02/J53G6+wDR1jdjIsXP2s8nfxScBUxB42b+k23f
	 VXln70dC6cdhHFyvy6CI7QCWcc1Q+C86EIJ1W1z18AztKv5ck1q/PJrz5CMQBHPNZnek0
	 FHdNnGRPbnVO70GG1LS8myxKi/STmwyoLIsQV0Wp8rXZfoetokXmw1lKdTxxyo/bhXg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792958479;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=8LEmuccskwQaQYoP/Bd9yiIg6/VOMx+8BWVcE3QHekk=;
	b=a5vXczzSH6JtWhOcdYK9oBCXWUtf73T8kK+EsMb0vVLN26LsaebvwTFDHtdmMpaGeNt0
	 aB96brCMOLI492seBQp8BD/4qMTpiIdkCC3jTRvZAmTC9yy+pdaqiIrhc+sZ1l3cG5oWq
	 Z/dZaPPCDzjmuTrxRUWNdHWjiQ//xps5ocD5BWPBFzfOH8cfaHCJvplz4xHBpc0T7bpTc
	 yXBDAjNjcfUyXYoqVyofP9BNl21XlC98H973hQv3GNM7tkjeZi034oD48P1pSMEp2trY2
	 hWvdEKB3UjNhbAmSgM2aMvO3W15PC/kVuzKD9WeWhKHUn78YqXTbGjXcUHcfv73Yw3Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=NsRt62zj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFC2606A31A
	for <linux-can@vger.kernel.org>; Sun, 25 Oct 2026 20:01:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBFC2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=NsRt62zj
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 21CD3200ADF;
	Sun, 25 Oct 2026 21:01:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792958476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8LEmuccskwQaQYoP/Bd9yiIg6/VOMx+8BWVcE3QHekk=;
	b=NsRt62zjClaL0RDcYEbRdd8gqt7D78q9x2epogJPAM+cI59PlSOvAzw94/3e2zUXMmmg9v
	gM4ql7JTosAd/8lkDQWxg4NFBaiJ0Hd8mmBdrXtJd1XjYN145dn/Jyvd2jhcxv7hj9pf+h
	1ieKgC3RLTlEgrjfo2SIRhcD5KcB3tQupRmzec+maI52Gl0mz1taj6NcdVparqP9lenaJf
	p2/lPgOdhWKekCwYcK/Cl2lGC6OT//3tDavbHLTxXmWIk/98h+31IhHjb0ZbgoLsDPZzj3
	w68g2ESlxR8ztp61Q3tmkJ0gZUQT9sGVtrhNVTkvcPeClpZZZyU2jL+Gl78MAQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792958476; a=rsa-sha256;
	cv=none;
	b=PDyn3t9QvPw7qla3qxHOV8ptjifSS2JxSPDSBhXhn8ssv1ebzrPJBEisB6gs182fIip5Ie
	8hlB0opqu+mWnS/6+4PSThm+8E/V/HgleJQOkkxmhpfO9Z0513jaRdcmGbDbimqaMzlfP5
	ZtzuTg3CWLXTihAGKLBYS4WqyMQ1YaKA6Z66GShC2rt5DLQUUNp70nSW5lwp0s/vOHEPY9
	w6vPomnMAiPFc1/N9WkGMvuowkcQnEfjlf4o/R9PpiBoO2Cddq559qbC7UjQr0JlDe4BPd
	jsvm9XVccsfnFJbv3UzFPxstBAOBuGi3i73lKZOKw2O+gOOFopqyekGdRnugkQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792958476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8LEmuccskwQaQYoP/Bd9yiIg6/VOMx+8BWVcE3QHekk=;
	b=Ls2IThxBv6SFxSKaOsLm+tKooQ77QHowxgS5ckCOX3Hdr5B1KHM9WKrkbSISGDgzsGL+2p
	h8Iw2w6ooX9x1xETV+8KedZqeBRJcr3uQc1rfkNmjqIV2ryJwROII3bKdAkIFg5PvAKSIS
	4MoBnh2bySiSASAIMwdf6bhRBK142caABzwZ8V62QQ4CHvr0wi+qi4FmtwoGDpXSxYE3nw
	VQcrJFKw8DYT/hNOkkkrNcrZOsLt1xoSV/Igwbgv2azZhqrDdcnsHcVBeBS8TUeljsyus9
	hCjr59nbIIu7v9G40+3gph7JUAtCDkKynXrkXkwAoxgyU3/IR1tXcWID79wJUA==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xL4P6-001Awu-04;
	Sun, 25 Oct 2026 21:01:16 +0100
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id BD7335D4223;
	Sun, 25 Oct 2026 20:01:15 +0000 (UTC)
Date: Sun, 25 Oct 2026 21:01:15 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org
Subject: Re: [PATCH v8 0/7] can: protect the receive lists with a per-device
 lock
Message-ID: <20261025-impartial-venomous-dingo-855e85-mkl@pengutronix.de>
References: <20261023121801.3052075-1-socketcan@hartkopp.net>
 <20261025-pompous-mahogany-koala-f18498-mkl@pengutronix.de>
 <ee27f899-0ac1-4059-ac74-e4ddaab61b0c@hartkopp.net>
 <20261025-unstoppable-valiant-woodpecker-20c6dd-mkl@pengutronix.de>
 <6421fcb8-beb0-4d42-b94c-6c936af3d7cd@hartkopp.net>
 <20261025-vivid-inscrutable-poodle-cf558e-mkl@pengutronix.de>
 <4dd68aae-41e8-4b9b-b520-4f281c9a93c2@hartkopp.net>
 <20261025-eccentric-sweet-hedgehog-ff4c6b-mkl@pengutronix.de>
 <7e91a6f7-7922-4964-9f96-c8e9b9f2f5f3@hartkopp.net>
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
	protocol="application/pgp-signature"; boundary="jqmo7dlvkd4n6api"
Content-Disposition: inline
In-Reply-To: <7e91a6f7-7922-4964-9f96-c8e9b9f2f5f3@hartkopp.net>


--jqmo7dlvkd4n6api
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v8 0/7] can: protect the receive lists with a per-device
 lock
MIME-Version: 1.0

On 25.10.2026 20:51:56, Oliver Hartkopp wrote:
>
>
> On 25.10.26 20:43, Marc Kleine-Budde wrote:
> > On 25.10.2026 20:22:30, Oliver Hartkopp wrote:
> > > > > base-commit: linux-can-next/main
> > >                  ^^^^^^^^^^^^^^^^^^^
> > > My question was about the tree!
> >
> > linux-can-next/main is an older version of net-next/main, so this
> > doesn't matter. Both don't have "can: raw: remove redundant NULL check
> > before netdev_hold()" applied.
> So it has to be
>
> base-commit: linux-can-next/testing
> message-id: <20260831052031.902699-1-ekffu200098@gmail.com>

No, please use:

base-commit: net-next/main
message-id: <20260831052031.902699-1-ekffu200098@gmail.com>

and check:

| $ b4 prep --check-deps
| Checking base-commit: net-next/main
| Checking message-id: <20260831052031.902699-1-ekffu200098@gmail.com>
| Looking up 20260831052031.902699-1-ekffu200098@gmail.com
| Breaking thread to remove parents of 20260831052031.902699-1-ekffu200098@=
gmail.com
| Testing if all patches can be applied to net-next/main
| Looking up 20260831052031.902699-1-ekffu200098@gmail.com
|   [PATCH] can: raw: remove redundant NULL check before netdev_hold()
|   [PATCH v9 1/7] can: proc: reset pkg_stats atomics individually
|   [PATCH v9 2/7] can: proc: skip stats calculation after reset in can_sta=
t_update()
|   [PATCH v9 3/7] can: proc: remove pointers from CAN specific proc output
|   [PATCH v9 4/7] can: replace ARPHRD_CAN type checks with can_get_ml_priv=
()
|   [PATCH v9 5/7] can: isotp: check the return values of can_rx_register()=
 in isotp_bind()
|   [PATCH v9 6/7] can: protect the receive lists with a per-device lock
|   [PATCH v9 7/7] can: raw, isotp: copy socket options outside of lock_soc=
k()
| Magic: Preparing a sparse worktree
| ---
| =E2=97=8F message-id: <20260831052031.902699-1-ekffu200098@gmail.com>
| =E2=97=8F base-commit: net-next/main
| =E2=97=8F base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/netdev=
/net-next.git main

> My current idea would be letting b4 fork the branch for my patches in
> linux-can-next/testing at commit 0c35fa862dab ("can: proc: remove pointers
> from CAN specific proc output") where "can: replace ARPHRD_CAN type checks
> with can_get_ml_priv()" would be the next commit (and the start of my
> diverting patch set).
>
> Would this work?

My idea (see above, now tested) is to use net-next/main and apply
20260831052031.902699-1-ekffu200098@gmail.com as the dependencies of
your patches.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--jqmo7dlvkd4n6api
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCat5gCAAKCRDMOmT6rpmt
0usEAP9JgDNBKs8Fv2VTeQaBhrpJFl129wfQL8daph6pdgAM3wD/YWqgB3/c66vL
5encVLYsRDjJonXdeE7H7F0duYCZ0AU=
=P1DP
-----END PGP SIGNATURE-----

--jqmo7dlvkd4n6api--
