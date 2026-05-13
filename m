Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576CB381B0D
	for <linux-can@vger.kernel.org>; Wed, 13 May 2026 14:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778681867; cv=none; b=cTtEQ5ktC3hjQ3jl74haIgH7cZybIcz/rvbl/Z3nkA+HcNh+4OMbjnMusYKxsNYYxkpjKoeZN1plSSXC+A5onDmFNJ0zbybRsq6GMMhNhnB1Rvrh6FOQsMLrScZOZk6eWjx+xv9uHWX04FlOqrupOV4I/+HoRVMKZdotJ4MCNow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778681867; c=relaxed/simple;
	bh=zRoVPx6EDfKiQbyjHvKFD2ORBtA51hWVhfOUNdBjmbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IXVeNmC7LAOTpvqsDhdu5M4/I9PW+HnyYU07dibNqIN2q3hmrLieb2WXgfwnghEVUMD8wtFhVR1i1Ss0h0RDLpRdLe9UjJyrT/9tmYIUFNN2xSaX5TBUTder9P8YyBf9HuNvRSWXm7b5UAYvC3U8nuz8tE3uEiOnLigZ+CDhXlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=fail smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1wNAP3-0007lX-AV; Wed, 13 May 2026 16:17:37 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wNAP3-000c0m-0O;
	Wed, 13 May 2026 16:17:37 +0200
Received: from pengutronix.de (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id DEDA9535C3C;
	Wed, 13 May 2026 14:17:36 +0000 (UTC)
Date: Wed, 13 May 2026 16:17:36 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, linux-can@vger.kernel.org, 
	kernel@pengutronix.de, Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Subject: Re: [PATCH net 6/6] can: flexcan: disable all IRQ lines in
 flexcan_chip_interrupts_enable()
Message-ID: <20260513-crouching-rhino-of-expression-082dcb-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <20260507112321.439968-1-mkl@pengutronix.de>
 <20260507112321.439968-7-mkl@pengutronix.de>
 <20260508151159.71fa563a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="n5wfuoyphpq6y34j"
Content-Disposition: inline
In-Reply-To: <20260508151159.71fa563a@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--n5wfuoyphpq6y34j
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net 6/6] can: flexcan: disable all IRQ lines in
 flexcan_chip_interrupts_enable()
MIME-Version: 1.0

On 08.05.2026 15:11:59, Jakub Kicinski wrote:
> On Thu,  7 May 2026 10:22:28 +0200 Marc Kleine-Budde wrote:
> > flexcan_chip_interrupts_enable() disables only the primary IRQ line whi=
le
> > writing to the IMASK and CTRL registers.
> >
> > On multi-IRQ platforms (S32G2, MCF5441X), the additional IRQ lines (bof=
f,
> > err, secondary-mb) remain active so their handlers can fire while
> > registers are inconsistent.
> >
> > Disable all registered IRQ lines around the IMASK/CTRL writes. This
> > also fixes the resume path, which calls this function.
>
> Sashiko points out that the driver is requesting those IRQs with
> IRQF_SHARED, I think you should also clear that flag if the QUIRK
> is necessary.
>
> Marc, sorry for the delay LMK if you prefer follow up or respin

Sorry for the delay, I prefer to re-spin, so drop this PR.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--n5wfuoyphpq6y34j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCagSH/gAKCRDMOmT6rpmt
0m0UAQD/XJkjMkx2Fuqr7TyYsjzKsXaK4lRj365tebvw9KD5QAEAoxNV/83rYa2u
cQkSbH449Wy1YC9cksne8Z0I0GHn6gM=
=YiZO
-----END PGP SIGNATURE-----

--n5wfuoyphpq6y34j--
