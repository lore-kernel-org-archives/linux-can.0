Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B634F5E1C
	for <linux-can@vger.kernel.org>; Mon, 19 Oct 2026 14:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792419159; cv=pass; b=Srsp02sQeTsZeNlzz+3P8aJs96YCXUnRAlUZ1Eb+RQNWi+crG7c2l5tKlah7SVN2i67KooaDqK/2iU00fhYl+xN1hXGenVQd0+yKA60npEYvx3H2N6rWlL8zZdN91Mq8JuWMt2pXmiQRoxJbqlvgcATuLHfqyTFCAKsJNhegOnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792419159; c=relaxed/simple;
	bh=+BG/+80/Kmw9Vt6Oy1gp4lpg2Q9A/H9i17v6f1QEsmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jbGSMY4NelQXC6qJxUuNF4ayI9aYS14IoTTvgTPxxVg8Y77u9PB98KIW/cahHw73W7CDDERDmVzJfR57AD78h/YR8DAwvAabDMEIP6L7b0KbYSA5ecTbEYZy0e2PSmuOGZghWhxpd4HZxMJjUafavcZ0rQx9FPYgiGIoDGccm5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=ORb7KVTV; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="ORb7KVTV"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id E61AA201EFE;
	Mon, 19 Oct 2026 16:12:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792419154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gJC0sIemEOQvXxAMge5TCcHF+1WApOtyqsrIWv30chs=;
	b=ORb7KVTVf+BLT8RFMEYRSuiDK0DXWIXSAoL7W8AjIWtxXJtZgjRpQKGKnLDNZ0+NrSUh8D
	sOGX1A3iJckVQq06DCwUXN2BYpxY5bT0gjWpN/wXF2hufx57cN+aATOapLcOtpzYBBBeE2
	tULOgeW0WW+/47maxk1Y6t9obr7NRWWwqpSWaFABD7e1hITfrGrWRhQMZ7XEUkOGSU5zi9
	qRqSNqEN4AELZKmP5vWZugMt4dr8qNNjWoSoxnLK32OhufsQhblwNyKN6cm5EgCFo6Bfme
	FWKj0zKL2gyXhLhjgppc9a5BbCH0NU7/ZkstU0pQmdbxfLHGEdkE+rVKyJiGmw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792419154; a=rsa-sha256;
	cv=none;
	b=QRavmMEpmMwaxqsTuLBwyNZUVQH/9WhdpzBkvbaKcK+eIyYoh1PaW8g2cC88D+ntwwhhwr
	heJz0djVWCDwH9JLBAv43J8FvG8A2EuVH3nxHIovQvYwvf6GQLXd9vmtvyP4VpX+ADu7W+
	Y4L8qEUF36gb/yRVLcJioFG+9VE8jMY8f97animxH7XUwTLvS+OxJxBhnCvc1bmT68VNib
	MTOBofwnLYzXpokSnwrLX7+9XlflU9Mat3Rl5hK/0d6oALUBlFDOzgYwPJnJIbxSxSxIHM
	2RRmoMVZRVNtimGvAzKznYlAeoITuY2MB0nL6Oxn2TstyvdXPAU567Au5bnRgw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792419154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gJC0sIemEOQvXxAMge5TCcHF+1WApOtyqsrIWv30chs=;
	b=FNM6UZ0GcqutqMGQxEX9WyEQwgmpQdBaShy7bqzLhO93M5+UDBWJX87sGfg6oUkIpO9IXo
	WAn+sRMf5GCO+R5AqH43I8v+7x5Dobq72sXlxkXKhQ2/OkL6qv1QlT4Y+F8If1tLqYq6hM
	lWy0OHMue7XbuWrso3+TPk83yz9q06bwVnfb0vVuY0+ukiM1CdeyzawSn4xy7pqAw48gag
	HlOBOgvKe+Jtcxfahf6N7ysK5Ci4Ko6hSSPoJNvxgLPMBXNrQMBY/Zb4Rx8ODvmMXm1gHW
	nWSEHkeq6F1+labC51CvRDSm23BW9fQq88qyG804AwUz2rzbTMKQ8MRE/ZAJRg==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xIo6M-000EhT-2e;
	Mon, 19 Oct 2026 16:12:34 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 900365C92C6;
	Mon, 19 Oct 2026 14:12:34 +0000 (UTC)
Date: Mon, 19 Oct 2026 16:12:33 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org
Subject: Re: [PATCH can-next v3 0/4] can: protect the receive lists with a
 per-device lock
Message-ID: <20261019-premium-anaconda-of-education-723479-mkl@pengutronix.de>
References: <20261019074244.50391-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gycphn6pomion3fl"
Content-Disposition: inline
In-Reply-To: <20261019074244.50391-1-socketcan@hartkopp.net>


--gycphn6pomion3fl
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH can-next v3 0/4] can: protect the receive lists with a
 per-device lock
MIME-Version: 1.0

On 19.10.2026 09:42:39, Oliver Hartkopp wrote:
> This series fixes a use-after-free in CAN_ISOTP and CAN_BCM that can be
> triggered when a CAN device is moved to another network namespace while
> a socket bound to this device is released [1].
>
> Only patch 4 is new. Patches 1-3 are already on their way to net-next
> with the linux-can-next pull request [2]. They are included unchanged
> only to provide a sequence that applies on top of mainline, so that the
> sashiko bot is able to build and review patch 4. Please do not apply
> patches 1-3 from this series.

This doesn't work for me.

Please post a single v5 with all of your patches based on
linux-can-next/testing.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--gycphn6pomion3fl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCatYlTgAKCRDMOmT6rpmt
0tVCAQDa49UbVxaO+cyMmZXODDb9BtImbrR1BVYd2bsKd1o88QEAvHY4PKY2KYWk
mLItQFUrCCZdFN55UEqH60hRuTcFdQ0=
=OtjE
-----END PGP SIGNATURE-----

--gycphn6pomion3fl--
