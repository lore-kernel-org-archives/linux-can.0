Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11035395240
	for <linux-can@vger.kernel.org>; Mon,  2 Mar 2026 10:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772446162; cv=none; b=eqmwj3MWIF3jIsgHC2YET0XHt34hAfoRl9UlYQucemrryc5zemBsDO0CsH7tXk2haXHEf+MIoIDoCMSPbTYvvti+F/pHqRdO/5XzH3I/VKafqcrbNBNF+O7CiYRv0Xpl7+XDrXja68UVEJidjiuy15BEyCo4m6Vgha1I7wa5dAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772446162; c=relaxed/simple;
	bh=lPeSRkCzJbIg5VAn2GHET0sY0AopXD9RWY+CMdBVj6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+uQCP+5ywqtOeF0j1TNvjQFpZYSiRZGT/r3WWGmE5hDTReNkd5IsNeRDY2pw+v3lAyxyrvCXq38wJoF55n/UUcq1kOuR7RUaY/zQdjeAQ6tt0BVrievGWShCR16bmFm0GKmrM1ojSD144knigki7RNcp2eoUhT2Mn/7FGyn140=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vx0DC-0000pr-3q; Mon, 02 Mar 2026 11:09:14 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vx0D9-003MXL-0h;
	Mon, 02 Mar 2026 11:09:12 +0100
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 41C644F5037;
	Mon, 02 Mar 2026 10:09:12 +0000 (UTC)
Date: Mon, 2 Mar 2026 11:09:12 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Ziyi Guo <n7l8m4@u.northwestern.edu>
Cc: Vincent Mailhol <mailhol@kernel.org>, 
	Frank Jungclaus <frank.jungclaus@esd.eu>, socketcan@esd.eu, "David S . Miller" <davem@davemloft.net>, 
	Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] can: esd_usb: add endpoint type validation
Message-ID: <20260302-brawny-goat-of-temperance-27a9f7-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <20260213203927.599163-1-n7l8m4@u.northwestern.edu>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="l63jqokvsrbmhhee"
Content-Disposition: inline
In-Reply-To: <20260213203927.599163-1-n7l8m4@u.northwestern.edu>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--l63jqokvsrbmhhee
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] can: esd_usb: add endpoint type validation
MIME-Version: 1.0

On 13.02.2026 20:39:27, Ziyi Guo wrote:
> esd_usb_probe() constructs bulk pipes for two endpoints without
> verifying their transfer types:
>
>   - usb_rcvbulkpipe(dev->udev, 1) for RX (version reply, async RX data)
>   - usb_sndbulkpipe(dev->udev, 2) for TX (version query, CAN frames)
>
> A malformed USB device can present these endpoints with transfer types
> that differ from what the driver assumes, triggering the WARNING in
> usb_submit_urb().
>
> Use usb_find_common_endpoints() to discover and validate the first
> bulk IN and bulk OUT endpoints at probe time, before any allocation.
> Found pipes are saved to struct esd_usb and code uses them directly
> instead of making pipes in place.
>
> Similar to
> - commit 136bed0bfd3b ("can: mcba_usb: properly check endpoint type")
>   which established the usb_find_common_endpoints() + stored pipes
>   pattern for CAN USB drivers.
>
> Fixes: 96d8e90382dc ("can: Add driver for esd CAN-USB/2 device")
> Suggested-by: Vincent Mailhol <mailhol@kernel.org>
> Signed-off-by: Ziyi Guo <n7l8m4@u.northwestern.edu>

Applied to linux-can

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--l63jqokvsrbmhhee
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCaaVhxQAKCRDMOmT6rpmt
0kRYAQDcHocssUt8mOUcuOIwdOme6TExkrUiuu4yoSVhdaN3jAEA0NsZ1cekcZDB
HFG+5Os6JqL3G+B32wY/9+7UK2iXqQI=
=YACM
-----END PGP SIGNATURE-----

--l63jqokvsrbmhhee--
