Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1529C3EB0E1;
	Wed,  5 Aug 2026 12:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785932711; cv=none; b=DNd8M4Yi2tJ0+VeDlbyzuSi4W/S+h9cbZSHlauHzwoXRHHRm0IGqvCWzJyXxAkft3AJEaY1WZsSXU4vJ5XGRAdcM12rr8cqFv6eCClWgJs3V1t4TtLix4vSNm0lQfSqKrXvsnLgfHBu7j76wKKr4cat2npc5oHHCmho17yeSgVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785932711; c=relaxed/simple;
	bh=GHn+T5JjtsUn6uP7XY8IRRVWRDXGbgPqLnxmcN49mT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CmojiDWHMewkdSDn12iADjEVXpscheHuqW6KMt1fDllaLGTnHncioqL5h8caRRmItGgg5c/2cyzZedKz/IRvDm3kMCgGPmwuOyyvtl7klnPJzy03Ste3R/UC0CRjzvwb4hwW7Q0fs3RbZmu2pwO/lHrOJ4t4VJT4UkVelq3bbaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 02EFF2006B4;
	Wed, 05 Aug 2026 14:25:06 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wragD-0036Yg-2q;
	Wed, 05 Aug 2026 14:25:05 +0200
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 98EA557C3A6;
	Wed, 05 Aug 2026 12:25:05 +0000 (UTC)
Date: Wed, 5 Aug 2026 14:25:05 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Sean Nyekjaer <sean@geanix.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>, 
	Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] can: tcan4x5x: put tcan into sleep when removing
 driver
Message-ID: <20260805-musical-carmine-poodle-51b0bc-mkl@pengutronix.de>
References: <20260805110708.3220251-1-sean@geanix.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fwxktq2d5b5xryto"
Content-Disposition: inline
In-Reply-To: <20260805110708.3220251-1-sean@geanix.com>


--fwxktq2d5b5xryto
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5] can: tcan4x5x: put tcan into sleep when removing
 driver
MIME-Version: 1.0

On 05.08.2026 13:07:07, Sean Nyekjaer wrote:
> Put the tcan4x5x transceiver into sleep mode when the driver is
> removed, instead of leaving it in its current operating mode.
> This reduces power consumption(3mA@12V) once the driver is
> no longer bound to the device.
>
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>

Thank you for your persistence. sashiko is finally happy, and so am I,
added to linux-can-next.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--fwxktq2d5b5xryto
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCanMrnwAKCRDMOmT6rpmt
0g1qAP0dRS6ZBvtCPyMCEWmdQ1g0kBj+t3H7jpKY8hD8GLL5nwD/UlDx1/qiU8jE
gHcIcyTslFXvVuqDjuP8a17Z0PDgrwU=
=oEfg
-----END PGP SIGNATURE-----

--fwxktq2d5b5xryto--
