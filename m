Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0063793DE
	for <linux-can@vger.kernel.org>; Tue, 17 Feb 2026 21:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771362543; cv=none; b=OcQttBq0WARwD9odGEp8bjA5GfoYDCYlDISAGg3Urx7YbN+sE0Elf5ZHx/CGvPl9K7N74tPv8uqx33oLXnQaxCvgvNg7RDND2tTs+hJo+CE8xCwKG484KmTEuvi+JT+KJbKcQIx/2+ad1X+VX+L2aTidlxLzwS6bYH8tdxvX1xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771362543; c=relaxed/simple;
	bh=e6+dqjG0FwAKBPXyplI7v5OJSYF8AV7w31eqiKCtbTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cG6vFq++PSt9TarZgFNfZX87GOBgD0bHq1Y7qIxTmgNs7dmqZBy7BrIcowki6BHetWLjiJbXYuzWb/FTMvGzmllosr2iCrFeklNWwtRh1zKXHKqLNb8LpKAXPCckFyzs/mwZnV7zgQIWpWB8rWnmfYpJEspj4JReGXltB9Y6Duc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vsSJN-0006FO-5B; Tue, 17 Feb 2026 22:08:49 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vsSJK-001IWu-2Z;
	Tue, 17 Feb 2026 22:08:48 +0100
Received: from pengutronix.de (p54b15bf8.dip0.t-ipconnect.de [84.177.91.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id D2F934EB3E8;
	Tue, 17 Feb 2026 21:08:47 +0000 (UTC)
Date: Tue, 17 Feb 2026 22:08:47 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Kendall Willis <k-willis@ti.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>, 
	Vincent Mailhol <mailhol@kernel.org>, sebin.francis@ti.com, d-gole@ti.com, vishalm@ti.com, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] can: m_can: set out-of-band wakeup if wakeup pinctrl
 exists
Message-ID: <20260217-remarkable-jasmine-sturgeon-3edb31-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <20260213-mcan-out-of-band-v1-1-af68d4c570b3@ti.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tybv63gxeb4ognni"
Content-Disposition: inline
In-Reply-To: <20260213-mcan-out-of-band-v1-1-af68d4c570b3@ti.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--tybv63gxeb4ognni
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: m_can: set out-of-band wakeup if wakeup pinctrl
 exists
MIME-Version: 1.0

On 13.02.2026 12:08:19, Kendall Willis wrote:
> In TI AM62X, AM62A, and AM62P SoCs, the m_can pins can act as a wakeup
> source in the deepest low power states. However, the m_can pins are a part
> of the MCU domain which is OFF in deeper low power states. Since the m_can
> pins continue to be ON even if the MCU domain is turned off, set
> out-of-band wakeup for CAN device if `wakeup` pinctrl state exists and
> device may wakeup.
>
> Signed-off-by: Kendall Willis <k-willis@ti.com>

@Markus, can you review the patch?

To both of you: Do we need a fixes tag?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--tybv63gxeb4ognni
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCaZTY2wAKCRDMOmT6rpmt
0h/lAP4g3dfbpEldjEcj1+BPMjcw/v9fv3MUmzRTAEQlItZ4vwEAm03b3a1BikGV
EeyLGBDuCRzCfQWjfBX+D7deoz5pDQY=
=KF0U
-----END PGP SIGNATURE-----

--tybv63gxeb4ognni--
