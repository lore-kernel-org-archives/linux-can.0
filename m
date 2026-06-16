Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896BD316192
	for <linux-can@vger.kernel.org>; Tue, 16 Jun 2026 07:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781593841; cv=none; b=NH7xPB1k5yvY/w8jyUrNC4Foqe6P5BNKK4ie6u1iKq9kfdm9KdqsLiqh8aZKx06/CDJFwE2tsxYHxW/kzGg7cA2W+CcRIaBFoC94Pt4htawOdPR24J3NGYtPSmKZ+8znjoqBJy1m4St+XuKaU07vt9U9rxh89uERdTmrUBDiQ34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781593841; c=relaxed/simple;
	bh=Jafx1DDWkA1svLKy8axEt8Ve1pVmzkZtqmosXBsTxb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gW8XRuWgPav6YoqmFJDCXpDaYKwahPGGjTETv45e/esk7zO0D1q1wyLEN1BfcS9wmCCNtGPiaj7yBWdqZMKE6AzhLQvbk3BHlG2cGjwmb7gg1wpFDFyMYOXigeMFpZ1KX6aHnfxCWPj3yKlv16nJufNZfC+BnUJf8N24IAPCFxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1wZNwG-00026X-0n; Tue, 16 Jun 2026 09:10:24 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wZNwC-002zbf-2f;
	Tue, 16 Jun 2026 09:10:20 +0200
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 7E1225516BF;
	Tue, 16 Jun 2026 07:10:20 +0000 (UTC)
Date: Tue, 16 Jun 2026 09:10:20 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: guoqi0226 <guoqi0226@163.com>
Cc: Vincent Mailhol <mailhol@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Thomas Kopp <thomas.kopp@microchip.com>, 
	linux-can@vger.kernel.org, cuiguoqi <cuiguoqi@kylinos.cn>
Subject: Re: [PATCH 1/2] can: mcp251x: Add ACPI device ID table for MCP2515
Message-ID: <20260616-teal-wrasse-of-conversion-348af0-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <20260616030019.35845-1-guoqi0226@163.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qmt6cbqrmgc6o4zy"
Content-Disposition: inline
In-Reply-To: <20260616030019.35845-1-guoqi0226@163.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--qmt6cbqrmgc6o4zy
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/2] can: mcp251x: Add ACPI device ID table for MCP2515
MIME-Version: 1.0

On 16.06.2026 11:00:18, guoqi0226 wrote:
> This patch adds an ACPI match table for the MCP2515 CAN controller,
> enabling driver binding on ACPI-enumerated SPI platforms.

Thanks for your contribution. Have you successfully tested both drivers
(mcp251x and mcp251xfd) on real hardware with these ACPI bindings?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--qmt6cbqrmgc6o4zy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCajD2zAAKCRDMOmT6rpmt
0ni1AP4nRRqnsn4yj7H8KEUgj4MOSsO5YeimLyC8KTwIkR4ycAD8CGlCAL34a/xS
7SiojBr4nWAYLPxCs/345s4SI7Zr7Ao=
=YGkB
-----END PGP SIGNATURE-----

--qmt6cbqrmgc6o4zy--
