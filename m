Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794387433;
	b=ejJL46h4mNP+pbl0/Ij8Newi5xNq49XixywjXqf6ehp8HYolQVHD2akVj5Exu4uH/2S/
	 Vav0BTHhC+qQAIYsL6SCSSUJgHGThibhWm81PTxjS8aeQbvlrkQtnvIZ9m6/F1dhQ/nxU
	 4pvOp/LBr4Io1bEHufJ8HU2eJhPYKXd1cwu6c1SRrLO+bDETEpoa9cD/OHIgXqGSd2Mt3
	 rapdoj+Fqc8UGa1pyad9EYOzYzdefO4mFCu+M1JaahAKwOmxAguxRxzM5XYlsZttgVvrs
	 eLzJozFGusZuald9LLNImPd3meq7sy3UWqTGwL0YL9BuypS2vb4hsRSw6VCJDuvO+cg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794387433;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=PRnxO+a+pYeSt21P/+Tse3S0HEVKviZ1BH+xPZwTjmI=;
	b=XEoUjPZJzQaRMSqtspILtvV+aga7UoFpOXk09/OLLkwKSCsvmNkRG6ZRp4agk9+DsuNz
	 tInufeLCmrafSyvRv6Baa7DpT42dkTqhv/lbDJli9coyLINjCh6gTl6Rb1xGFTtitjquA
	 JU9azHOeu4cFWAdT3wT+oQYnL3EFPe8K/lx9AflKFgo7zOUPGYQz854LNaoeM3JqtJEN+
	 CrZuyJ59l5u6F74iR66rmQT7sUAywzyzbh/HE8qdgw1fgBpxyb+OAFmC6KJJUXWg62phf
	 XnaHsMfIOdNa8wyaAeH3D1eKPaIVaI6oeG4SqGJD/QAJLNkWrVlicgCjmeGC79Fy0Kw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=TussZq7x;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649BD606A335;
	Wed, 11 Nov 2026 08:57:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 649BD606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=TussZq7x
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 4D036200F26;
	Wed, 11 Nov 2026 09:57:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794387430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PRnxO+a+pYeSt21P/+Tse3S0HEVKviZ1BH+xPZwTjmI=;
	b=TussZq7xZTN0xKKhpm1LfuOtwg7TJXbMJpNF3reNKhYPNxsZMY+zverp2F3M4cWrz30vlM
	gFA3d9R3VnPe2WqJ2S6/LRe+XnUKyn4XThrKb9QIjyMN3iiA7xpU7FKIAC6icyA6j8ArJI
	a9ycum+u47BzZwmycCtu0LIVa6yLwqz7d5hiS0LVMMU9wtQDj2BuekL4rC+AylDwx9jqC2
	M1rcJBzJbt7pBxTWvG0jDbfM5ik/8M1wsVAq8ILV49Hcbl4yitN1qCdUEBmcNiwRgC0bTL
	ACqb0vL77RbN5atDVnBzDPz1YtL8goEWAKIo6LvwU9mOKVdFkBHndHmUrIYjlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794387430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PRnxO+a+pYeSt21P/+Tse3S0HEVKviZ1BH+xPZwTjmI=;
	b=hHtjyRtLktODyaGozMcSQNRS+4IK0AMgBj6zJ8wFx3Nx7UofNAXFNSxXGkWZYHacrXlbXw
	3DOrJroSRg87kKpK3ijGrmliWaGBpy95OvF1uPSKn6K+sv/jdlIrK0oad5zwJmfMTZ9w3i
	q5xNbWQjoMDWAfFL1H3mwICCYcJsagKMXKgW9Fc93/EzH5RQBNLtADya/OOoTIP/jRZN05
	Do8CsF5l41T2+6kD3EtS4RB6/BhjAhvVyDvuI7hck73Y7G9TCFTXr+Tmrq5CbIVmeOZIPm
	L9KGb+fRssalqQyhAw9tUVkrRSg4e22LTs1d8UQIGdAsuv6wbGhLmhE0lhLIvw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794387430; a=rsa-sha256;
	cv=none;
	b=Zlckp/TCPnQQB3Gr9X7I62+xDd8s2PUn2X+nVdqBWJUrmLXJQutN6YI3xtEvLLmLqjkCLE
	xClTYDEBTtbDgfwVplDBS2fcmQZUsLtqcLyiTdXzaC8IzBAsKTG/BvKyXF0PNiCsGRXuca
	7YvscbQcjZtXPC4X/AaL6SfCZ0d/xtVvWpcXw4l9J4vLpiSIFJWRu3YMp/H3mpwdcvOjq1
	D6OGJv46kLmQnD7xdtN8Gcd2SerUbc6CUwEzhMdPqe/oyL5Gmsjs+ZfzbEw0rWleDauWwj
	6KQmrDWOHz3RqEE9Nq38cpcjf2z4rZ7xboDn7pNDfOCkC9Q4Ni9mtVmcs2sqLA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xR48k-003car-0i;
	Wed, 11 Nov 2026 09:57:10 +0100
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 7BE365E7902;
	Wed, 11 Nov 2026 08:54:34 +0000 (UTC)
Date: Wed, 11 Nov 2026 09:54:33 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Chaosheng Qu <quchaosheng000406@163.com>
Cc: Robin van der Gracht <robin@protonic.nl>, 
	Oleksij Rempel <o.rempel@pengutronix.de>, Oliver Hartkopp <socketcan@hartkopp.net>, kernel@pengutronix.de, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v8 0/4] can: j1939: fix the abort timer and bound EDPO
Message-ID: <20261111-daffy-bright-galago-0e3bd2-mkl@pengutronix.de>
References: <1794300100.11111.1000000@163.com>
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
	protocol="application/pgp-signature"; boundary="nspqpwstdznlaixi"
Content-Disposition: inline
In-Reply-To: <1794300100.11111.1000000@163.com>


--nspqpwstdznlaixi
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net v8 0/4] can: j1939: fix the abort timer and bound EDPO
MIME-Version: 1.0

On 11.11.2026 15:20:00, Chaosheng Qu wrote:
> v8 addresses the three findings from the sashiko review of v7.

Your cover letter should provide a brief, informative overview of the
series. In addition, a brief, concise change log in the form of a
bulleted list should be included.

All patches should be a reply to the cover letter.

Consider to switch to "b4" using the "web endpoint" to send your
patches:

https://b4.docs.kernel.org/en/latest/contributor/send.html#configuring-the-=
web-endpoint

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--nspqpwstdznlaixi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCavQtRwAKCRDMOmT6rpmt
0q7LAP0Qg+N7m9FXZP6QF+fZH9gSQ3IG0JrSM3+V6C43+yOLxwEAhS0tVoYc0ElN
M1Z1YZ8df9lT1cNAf3hhL8Y1WkSR0Qw=
=K5t0
-----END PGP SIGNATURE-----

--nspqpwstdznlaixi--
