Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E20D27E
	for <linux-can@vger.kernel.org>; Thu, 19 Mar 2026 15:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773935419; cv=none; b=l8htHhHF9dsKnLkDZFIYMbzkIIhRyFBtnFVjAqdPatH/P37YkDqg89bCD62C/pNFpsFwaWWYw/zFH3ncyHY7jKahDY32Pe6IX3RJw0VAdTpnaO2oTmCAPxM78+k5KNUGCqIGIrmODJa0GvG0bNcCnW02vVOuNgR1A7kCco0GgEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773935419; c=relaxed/simple;
	bh=Gx6NMe+CaG3jHIILWIKBRzTpY+M++/oYrpG4x6TT0a4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z8dfROncFfsDh4ybMi9uYwaDRd0LUsC5UQNqMg41tXW4pLH1IMQvX/YDkdrLCO3k2ICVNOypAiiz8bqBZZ11HCQdIKnK9g/3lpxRzNjDPC1rM3iQfJTGWgp3qTJ6VNRhdA2TzlCzBb5eT/sUXqWX+GreZqtRAdt3Y/CdmYDEhJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1w3FdY-0002tK-GY; Thu, 19 Mar 2026 16:50:16 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1w3FdX-0016Fa-2R;
	Thu, 19 Mar 2026 16:50:15 +0100
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 7748F5086B2;
	Thu, 19 Mar 2026 15:50:15 +0000 (UTC)
Date: Thu, 19 Mar 2026 16:50:15 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Ali Norouzi <ali.norouzi@keysight.com>, 
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 2/2] can: isotp: fix tx.buf use-after-free in
 isotp_sendmsg()
Message-ID: <20260319-fuzzy-premium-mole-4031d8-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <20260318165120.17560-1-socketcan@hartkopp.net>
 <20260318165120.17560-2-socketcan@hartkopp.net>
 <20260319-dashing-scarlet-angelfish-dfaa67-mkl@pengutronix.de>
 <DM6PR17MB2874C391FCF90B09562B4F52934FA@DM6PR17MB2874.namprd17.prod.outlook.com>
 <77a79f13-8ef0-4768-9d73-993e7fd46bbb@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mebrmfvvun54ntya"
Content-Disposition: inline
In-Reply-To: <77a79f13-8ef0-4768-9d73-993e7fd46bbb@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--mebrmfvvun54ntya
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/2] can: isotp: fix tx.buf use-after-free in
 isotp_sendmsg()
MIME-Version: 1.0

On 19.03.2026 16:27:35, Oliver Hartkopp wrote:
> On 19.03.26 16:10, Ali Norouzi wrote:
> > Hi Marc,
> >
> > Sure
>
> Btw. I'm fine with it too.

Thanks Oliver, thanks Ali!

To keep confusion at a minimum, I've send a v2 of this series with Ali's
S-o-b and the corrected Fixes tag

| https://lore.kernel.org/20260319-fix-can-gw-and-can-isotp-v2-0-c45d52c6d2=
d8@pengutronix.de

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--mebrmfvvun54ntya
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCabwbNAAKCRDMOmT6rpmt
0jCOAQDih6QhWePBeI+yxSps2v56B1QDyC1IeOGq6RFTZicUugEApYSHuUzP5FpQ
9nTsL6xbW2dhWtATRf0GpRVJ32SPdgg=
=fB8m
-----END PGP SIGNATURE-----

--mebrmfvvun54ntya--
