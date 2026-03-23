Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4C838552C
	for <linux-can@vger.kernel.org>; Mon, 23 Mar 2026 09:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774258560; cv=none; b=MVHyiVd9ruML4yOvYv1lZYkrK58DSAtNTDVoRmlnMJc3Ummicz2KtyeRN28/g/1CobW4lpvH2FR6DEQhs9+Al0UuIU4QnCYove7D/aEAXT9sK7lUlmizLNqHE55UPO38rfRhYUb5ER0JvpZpnqOSw9wdy1/4RSrK86zwINuBAqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774258560; c=relaxed/simple;
	bh=lvv0qab2qAMTkXTukf0fzH//09xq2p+fNlIJJfhQeGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mr8kiCh4gOscJ5hBjBicAEXa1fjfxXg+sv3/pS5iD19vSIeCIlpZ4MFo7lLjdGfyKl5zGxlNgUdRnO0cdUGmpTUZzEHC2VOORHx8Bxy+uLmXY6XhH2BZgalrgrtn9cQCDS7vJbNSPIsH4SLDsNx08RI3k7t40ENKc9a3mij5Hfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1w4bhT-0008Su-6Z; Mon, 23 Mar 2026 10:35:55 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1w4bhS-001hfq-1C;
	Mon, 23 Mar 2026 10:35:54 +0100
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 1569D50A6D1;
	Mon, 23 Mar 2026 09:35:54 +0000 (UTC)
Date: Mon, 23 Mar 2026 10:35:53 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Ali Norouzi <ali.norouzi@keysight.com>, 
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 2/2] can: isotp: fix tx.buf use-after-free in
 isotp_sendmsg()
Message-ID: <20260323-carrot-tuatara-of-masquerade-3563d2-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <20260318165120.17560-1-socketcan@hartkopp.net>
 <20260318165120.17560-2-socketcan@hartkopp.net>
 <20260319-dashing-scarlet-angelfish-dfaa67-mkl@pengutronix.de>
 <DM6PR17MB2874C391FCF90B09562B4F52934FA@DM6PR17MB2874.namprd17.prod.outlook.com>
 <77a79f13-8ef0-4768-9d73-993e7fd46bbb@hartkopp.net>
 <20260319-fuzzy-premium-mole-4031d8-mkl@pengutronix.de>
 <0f635f0b-6380-47e0-959c-b887461c15d3@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ximrl6ikjmqasz7y"
Content-Disposition: inline
In-Reply-To: <0f635f0b-6380-47e0-959c-b887461c15d3@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--ximrl6ikjmqasz7y
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/2] can: isotp: fix tx.buf use-after-free in
 isotp_sendmsg()
MIME-Version: 1.0

On 23.03.2026 09:47:44, Oliver Hartkopp wrote:
> > Thanks Oliver, thanks Ali!
> >
> > To keep confusion at a minimum, I've send a v2 of this series with Ali's
> > S-o-b and the corrected Fixes tag
> >
> > | https://lore.kernel.org/20260319-fix-can-gw-and-can-isotp-v2-0-c45d52=
c6d2d8@pengutronix.de

> Do you expect some additional Acked-by or was this just an informative
> message?

I'm going to upstream this series, unless I get negative feedback.
Positive feedback is always welcome :)

> I'm definitely fine with it. It can be up-streamed as-is.

Thanks :)

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ximrl6ikjmqasz7y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCacEJdwAKCRDMOmT6rpmt
0kRIAQCS27mw5JG+jl9mfoWPMTT+ofrXUPbW8Y2lvfLwK3RJXgEA/nRcbM80iXLR
wsXpEP6MszL2j68qEY4WxiZZm6ga6Qc=
=Z9kw
-----END PGP SIGNATURE-----

--ximrl6ikjmqasz7y--
