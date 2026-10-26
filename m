Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793015415;
	b=gYF1LHLm+7WW6UhS5OX8SDP/g6KqKvxnWK8Bq/TCEn3qzW58ER6JSNXTQt92UgtHMzFS
	 NKNzV0ZorOjFtgzgNCNvUEaFc1L9CADKA1Mggt3/33idB1YRFxeSyTAFcGwgcgasZKWh8
	 oYnC2beDcKe32yx5dTW8sN3IQ6RmqWBg1wAsivzmNdn4epr3TgNdNwGfI2GlM3aQQBfng
	 LGB13j/WcG+pzockzAl/VmJWt+1h54nYiLBzR+nb6AbbhkkTGtwABJdBcfyGmphVpchyp
	 nPdk4RJ+YAXtNr3jFIlqnW7+q+cFYgh6thNyQvpePce3LN7ItChVQ+FQjkTwsO2Felw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793015415;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=28+IOt55aTcG3RauIdXGCoVJ57MQArstQcRiMCkLGCc=;
	b=ZzN2dL7KT7go5/AqqLx1lhDniwsI+szyqUuzclJv4aBSODRKa7B9h2FeWQHzDTjQMTWs
	 pPaWknPGf5+LbtA+zhFCGIZcjpOGdsQjAE0yPXh6j9DC053FW1JRkbVrDfMCuuuf3UZHV
	 uiu5SGiS/WL6vGMHBgp1RakVPJ059DeCXMuwWCy9nH1UfP2kxGt0/JlzbHdU9QU4WvtN0
	 AoHknVY16P7ArDRU1Xz3G/tFxQiMffevjbw1E6mroGckbinzV15jLcQJGRkxloL2/pS47
	 u/OKD1TwW/6z3V/Yk9W7hf4ELqeQfiqw88h/v75dWjkr5hq22Y4UPgUWZfUehqaaLkA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Qq6G2yPP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26474606A333;
	Mon, 26 Oct 2026 11:50:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26474606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Qq6G2yPP
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 590CF2022DF;
	Mon, 26 Oct 2026 12:50:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793015412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=28+IOt55aTcG3RauIdXGCoVJ57MQArstQcRiMCkLGCc=;
	b=Qq6G2yPP14Qq828/hdaEsr6x57ZpWAAtFa5OEOpSL/jqsohtlnykVbmGvYNrtXtLCGpewi
	2JFEkUcSIBCWXmYUZpDly+vA7xPIGJdxquirB6y2HGKj3UkCgutUPwDlLVCajeOU+cFdTH
	Ol+UeyOEu5Fz9FtTwDMrlR5jj2qZdhIIbv8HmLAPERVMtwMWgH6I7FRoC0Gt1ve1NqAkdg
	fbln3UxQO7uO8cFnXKuZKtUr57ImrMdM37Y3g8DWJLwyeCxh2dSpVcFpxQQIq8nH0N8ato
	khd01plT+RfzgdJeqgz5Y1i1k11OeFQ3VtoETKp1TMDNgu6P2ALWmCmmfHdRTg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793015412; a=rsa-sha256;
	cv=none;
	b=M+hwbLUlezTAnyVUr+tduDZ+aidqI6SAu2U7Sloo9eAOcrb9tgF26Wu5dndoLXKQzW1hg1
	+g92YhaiOT2CTMJD8Qqm80Sc/Qsh5nHtn6kt42UpeiDvuvkI8d1oV0J9L+XFNBRQ8hofWy
	RwoeLC9BxdQBrPqxtALhed6CnpV9j+5EJvUShZJgxiKlC42rBN8Eil+pyIyPqIffd/AyJO
	TEgXWnoViVcbtD+YALh9Wa00CiL+wqs0Az/RFSPx+DVhDFG3DxHfi4EYLu6Nd8OXaQvFXG
	3NyBWJriw/HM0PLtZw4PJAakF4el9j0jYTudkkLPhYAAs+G7ukOCAJaaUU0bXg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793015412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=28+IOt55aTcG3RauIdXGCoVJ57MQArstQcRiMCkLGCc=;
	b=OCvTjbjj3H+5VJ0Aw4HpCiAhSkvkrFh+DeK9p2Ecah35henZD63bnFOlbZ93IiD6aXVLVe
	IUt5vKn73UNACPErz9j2qDyRvCKRokp0QD1ddao2w/qEZiddWsfMaQjw1ypr1LnhXJXc9K
	UezVdZufEe2SkbXcX9btLjfi2U6xFjHDFeRPyYpKlF97jmO2iwCzp8ftK2JO7HEXAAtdOY
	VefuK/mj0A9KX7lp2WdbDB/tfBQJIbGpbYXfcUpT5B/GIhwqbTXYrS/hro1P768Ryjdfp8
	kTEfDnWzM5GulXEtrw9DTvBXHYZTtTbB0UIKGsvh2/bwGONMe6kumFrEgRvKYg==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xLJDQ-001H7v-0k;
	Mon, 26 Oct 2026 12:50:12 +0100
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id EEFBC5D6CE8;
	Mon, 26 Oct 2026 11:50:11 +0000 (UTC)
Date: Mon, 26 Oct 2026 12:50:11 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: linux-can@vger.kernel.org
Subject: Re: [PATCH net-next 0/11] pull-request: can-next 2026-10-22
Message-ID: <20261026-slick-wealthy-quoll-bbd53c-mkl@pengutronix.de>
References: <20261021231130.2085690-1-mkl@pengutronix.de>
 <eb3b2eee-3460-4b03-a180-1d3806a7f8f7@redhat.com>
 <5fdffd4b-7f80-471b-93b3-706c00cb51da@hartkopp.net>
 <20261022-unique-famous-dachshund-f51d3d-mkl@pengutronix.de>
 <00ecd34e-9296-4db0-b78e-49b4f9440db5@hartkopp.net>
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
	protocol="application/pgp-signature"; boundary="zgpvsebbusxkuhc7"
Content-Disposition: inline
In-Reply-To: <00ecd34e-9296-4db0-b78e-49b4f9440db5@hartkopp.net>


--zgpvsebbusxkuhc7
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net-next 0/11] pull-request: can-next 2026-10-22
MIME-Version: 1.0

pw-bot: cr

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--zgpvsebbusxkuhc7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCat8+cQAKCRDMOmT6rpmt
0kssAQCbnBlvajK4Aysw4G14H560r2fo1yUKcVdgJlJvNqaZ7QEA9IszWpFC/uR8
sCHya4e56mQze6vG2BX5ot3SfN25Cwo=
=oePA
-----END PGP SIGNATURE-----

--zgpvsebbusxkuhc7--
