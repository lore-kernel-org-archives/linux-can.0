Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794743726;
	b=Kq73LfL6U1kS7buiiwr/pDpjDIAmrjPOFfuY83Y7d93digKJ805HB4QO8P4pbCTOxciC
	 v2sl9wbjN/BINwbGfvdAgtBCiasJeWq/unjUEW6sHHMc5SKCBR76s8yvsRH2tGy1gb8Cy
	 HPQc7M/1tgj4pgpUcC9PX/isiS2mFGMCyLPgXAmG6YPoKnVumzMjAYihx3YbDvVHEIrTQ
	 LEXxb6xY/Q/c4zXtlUcsjjWRCh09HLjiClsmxWcjSySG7wR+T2XDS2zQTN/8PQ5O0ojki
	 noORf10f1x/SY4HW16ewQeRTUhYwn8Xw8ZagcgMo+0bX63SojKMa65ZgcWwgCmwyiWg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794743726;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=b0eGFIX/6uoUZeRa1M1W5P5iJHYrKtJzm9/hzLAT3yM=;
	b=WhionMePgDp0MJeIOqgjQwqyVu0NGRVU3BwFx9p73hCn1I+Pv2KC6f1bp/kCprE0tshX
	 9dn5o2M3tJLRDXO5aDnlgeAaYk3PdMe/EkGfd/uZgrDoUCSNw2MtNBZJb+yJNbrv4b8jz
	 Po7b88mu1GyDrXs8FKn4qrxAoZwVHrws2VO2zdRSbWGVKoKQYU/dWGSgay8Yn7xv1D4Xh
	 Z95vF6/eqGI5so2i6al3txT9YW+AcCdJtf/QEoSW8E5x1rxsIPmTIozWpXU+qOM0lK89A
	 rQMlcU42ONDLqo5Z28tuJJghVhUElsWmsDBEGD05V+2LCIO1eq6ml2FU4aB76qawFvA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=gSkMjB11;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC893606A31D;
	Sun, 15 Nov 2026 11:55:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC893606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=gSkMjB11
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id B4CF9201BC8;
	Sun, 15 Nov 2026 12:55:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794743723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b0eGFIX/6uoUZeRa1M1W5P5iJHYrKtJzm9/hzLAT3yM=;
	b=gSkMjB11VhG08Uy9HHFzb2c+cDvDtTFOsiRcH4+R7yajH3I1Qz+UB5+h0ZvLm6xdWs73vx
	qVNv8SZfkCfQj6nUhOJq03q864DPVF2CbXms7MMjSQjv0PKTQgn0kvSerGny5X6jAwYcqu
	/90BAvJKY7Ch4KHLSBnqbat1bfELr+5/WJz72O8l+RZIVyBWA93WdytktjhXVw8S8NI1VC
	LEYVt5UUCAwe3nwtW76mKrK81jkE8UyOyB1CRwIIgYtHOkaLk6pBWPU9tuAcF3RnmQ3u1Z
	DuT0esn5UDNNLzhx1pz6jTqYJwQeh4tbgChmuqCiSpswbiC8mFNoCovv6EdD4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794743723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b0eGFIX/6uoUZeRa1M1W5P5iJHYrKtJzm9/hzLAT3yM=;
	b=WV9TXnZKOfrOLdKOlFysGcFNpWMvd/nBadZxYAx4sUGgeYk3Q3WRrONBY6aELeRlN7WHKZ
	oyB0axTxTLhguEMzgdpcb1x2bL5CAFPM0RT+l2Dv4fK1fBkmupN57u3bSEYYmbOOjzxab9
	DvPMOWQB/iBHt+EKYecK0l0JjiXpLwEKd9GiMoMDUf0ZLZvNLg9+xJs9Ba9lKsS/2oncE1
	PNYMy33YTvd0UPe7/7eqvpEuZYwq8M8p4CnXt5baGy/CnfpMqpmVj35q/DKeKUd7NK0I/7
	cPpwMDgvL1a3P2xJhuhlWf9ye8x/eAdChJ4tDIUbwXSp6f6e8MpvuY3rUokluQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794743723; a=rsa-sha256;
	cv=none;
	b=W/ag6xoCdxgULcI9eogkEQs4Q9Ui2XdkD6XAdHIqapkpGtAdG1/ZsfstSj5de4IYF8qP5C
	gicmsr7517AOBxzOdnz4z3tdlKJWKPFHzwY3PCYJvcFKqUN/JsstlI+g2WiMC1mwwBrR6h
	FQIb2HHj1US+TcMUAzP7Z2+b/+yl/7UOG8JrM5N/lMhSCzj5fdOCgdJddLtJoJ8Le4rzPe
	jAfkyuCbk5P3umtth3XHLhwM0rl40NSj4Ak00Qt4bDcCQrqySqFUhS0QInf6xzF8dY4yQs
	dFs3Sj0Wae03Vh3gRPqKTn5uSRoIL6VFmpz/u4kklmAZJeVVpNOItRgNxO89Ig==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xSYpP-004HEq-1y;
	Sun, 15 Nov 2026 12:55:23 +0100
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 4A1165EC3DA;
	Sun, 15 Nov 2026 11:55:23 +0000 (UTC)
Date: Sun, 15 Nov 2026 12:55:22 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	linux-can@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH net 0/9] pull-request: can 2026-11-15
Message-ID: <20261115-muscular-expert-kelpie-9706be-mkl@pengutronix.de>
References: <20261115095746.709371-1-mkl@pengutronix.de>
 <20261115-musical-garnet-turtle-de4539-mkl@pengutronix.de>
 <bb2a488f-5734-40e6-b673-84612f6173f1@hartkopp.net>
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
	protocol="application/pgp-signature"; boundary="b6mukjhabdvhctf3"
Content-Disposition: inline
In-Reply-To: <bb2a488f-5734-40e6-b673-84612f6173f1@hartkopp.net>


--b6mukjhabdvhctf3
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net 0/9] pull-request: can 2026-11-15
MIME-Version: 1.0

On 15.11.2026 12:23:39, Oliver Hartkopp wrote:
>
>
> On 15.11.26 11:18, Marc Kleine-Budde wrote:
> > On 15.11.2026 10:54:51, Marc Kleine-Budde wrote:
> > > Hello netdev-team,
> > >
> > > this is a pull request of 9 patches for net/main.
> > >
> > > this first 3 patches are by Zhu Ling and fix problems with the CAN
> > > netlink handling.
> > >
> > > A patch by my fixes a kernel memory information leak over USB in the
> > > gs_usb driver.
> > >
> > > The last 5 patches are by Oliver Hartkopp and avoid RTNL stalls in
> > > CAN_RAW, CAN_ISOTP and CAN_BCM protocols.
> >
> > I described patches in topological order, which is intuitive when
> > looking at the git tree. However the linearized order of patches in this
> > email patch series is chronological :/ - Sorry, I've added the missing
> > "--topo-order" to my git send-email script.
> >
> Funny :)
>
> Anyway the current patch order is correct to be applied.

The netdev people usually merge the tag, the emails are relevant for
review.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--b6mukjhabdvhctf3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCavmdpwAKCRDMOmT6rpmt
0lyEAPwNbq0e8SB6/YoLl9pIwm0s2IiXm3IkF0c22koqunSe9QEA5yn/CjHM4KfI
cgjKAoXyOuADKwRCfeIhNWX2Ij3dbgI=
=t6Ne
-----END PGP SIGNATURE-----

--b6mukjhabdvhctf3--
