Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B9A4DD3AA;
	Fri, 16 Oct 2026 14:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792160221; cv=pass; b=cOvIMhVsL2UCi141R1GcB0Sr2THK5mEox9G3rrALkrvzCSWpoPWe/ykB7QFVTHlsdwubgFhLDfPavmIDmFXDI3kbGo9Z8gQFixXbO73y5U9GkfCfKdtSCc0VRRszxcJDQnm4mlkUkBj15NDtTlY2zeTx6GltKm1JPJVNanJDry0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792160221; c=relaxed/simple;
	bh=mBVO3fJ3jM9nmyMuP6oD0lbbHtep+mjEqGai9AAH+GI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bJ0N64QxjPnVUWtFCEH/6kFQAi/ENSf4Sh4MkH9gNt6Zx9DR3+G1lXOYjzHDfzgHHeoZARGmFFqHbOV+JDWsEbk+lvMDBEbJyqn6CwHKDrZ+8xviLk3M+/V0F4mY9Urq1/XqjM4EeMEJT2AVnMRzxmJQEV62cfJVZ/s08V/OZxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=V6bhu5NW; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="V6bhu5NW"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id B8A3B201260;
	Fri, 16 Oct 2026 16:16:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792160213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZUFAhs3+OhbeubqtQCmIluwXWSOTQ4ATl+7JRvKPY90=;
	b=V6bhu5NWkqhSdNNwnCgh47S8nGSgdwiLVlsOmC1vhL2V6Y69HFqwfPSo6EFaIHZRyBe+hR
	PZ0HxkkYpPCBHfk/7fo3hXXyAD+UlDE4jkh6bTSGS+/Qx6/Shwr1+1D6d+LGnLFB/P09F9
	5++LXym/+Gb6dpy1JOvS8Q9NNSoChGrV94eAfaQ/8z+FP2mx/Qdh/aP9dld4t/DHfJJ67D
	Bb6JiTCyYZXz6ymXy95FJkiwzDCXybK/ND7QxtNikRMBQzVd1PrTwu9qlH1JaxBRLTCPIC
	MFaKPQY3TLv/exiKIf0YaonflVMu2bWhHfJ5Z8aa66wIt2c5+4oxR+f61M7TMA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792160213; a=rsa-sha256;
	cv=none;
	b=QxfziLkNdC1HFGexJkFCyfuSdxoj994XaLTYVCRC3OIt/z/AMa22hcLztkt9xH5xgGGhdU
	OMaliO6WEjCheh/xUVRX/dLRBlimF3gSwcfqKy44wFxZCKs+CSKHUp7WiOMGI+pPaaBJ6Z
	BJ8AydUpgHJUjHZ2LXxrNX99D6ysbivGglN+qLn/NQfyPsogVVC0OBufZ291yQ78yfwbMk
	YFR32mPdarosowzeK3JCeWAnm1jQrU/opbMPk4u8ZZH1OD6S2SW/GRdqiDG02tgS5aYOHz
	Q9bnmfhcxDsf4sGCkZajRhXi4yc8qReFZMjWPvXG1tx9MUiBRrNYr4DlEuOXag==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792160213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZUFAhs3+OhbeubqtQCmIluwXWSOTQ4ATl+7JRvKPY90=;
	b=H+JRi6KNtGpIm/01JWimgSjpsWrEbgE5qJ7+yBE1UFF4Ez8AZASxyCXvAhENUlt3lVzryV
	nwVneHt6QVwT5FniqpJv+UEF3Lkkj3yd1/toKFFvjL18UQeGy+m6MovGg/WbKujKLw9iLO
	tEHJqTYowEDoY58BvtFxBd2/MNSwyBF1J9oWt2hsDNR0CbvLtxbBC4msEnFIJ/aXeZJqp3
	iDHZiUCN2MAjAQTjPix9GwHoBOKXybc3er4GsA65twbXsGs7wTszxkfQ0kH0/OCUpEgY3E
	vfA2MB+m4NXHV8SYvPVgWb3RuhuPpaxpWJxJf5ibOAwVbc7BdUG8ogaET1bEGA==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xHijt-006CMe-24;
	Fri, 16 Oct 2026 16:16:53 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 673525C62CA;
	Fri, 16 Oct 2026 14:16:53 +0000 (UTC)
Date: Fri, 16 Oct 2026 16:16:53 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	linux-can@vger.kernel.org, kernel@pengutronix.de, socketcan@hartkopp.net, 
	kurt.van.dijck@eia.be
Subject: Re: [PATCH net-next 19/37] dt-bindings: can: renesas,rcar-canfd:
 Document RZ/G3L SoC
Message-ID: <20261016-rainbow-nuthatch-of-satiation-52a26e-mkl@pengutronix.de>
References: <20261015015336.816543-20-mkl@pengutronix.de>
 <179211823035.434549.5570001472090611125@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ajo7seivakz3bffq"
Content-Disposition: inline
In-Reply-To: <179211823035.434549.5570001472090611125@kernel.org>


--ajo7seivakz3bffq
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net-next 19/37] dt-bindings: can: renesas,rcar-canfd:
 Document RZ/G3L SoC
MIME-Version: 1.0

On 16.10.2026 02:37:10, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 2 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
>
> - [Medium] The schema does not make `resets` or `reset-names` required
>   for the new RZ/G3L compatible `renesas,r9a08g046-canfd`.
> - [Medium] dt-bindings: missing maxItems constraint for RZ/G3L interrupts

looks like a valid issue to look into

regards,
Marc

pw-bot: cr

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ajo7seivakz3bffq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCatIx0gAKCRDMOmT6rpmt
0lujAQCds/RciAsQ3SXeM64mim3ik5Defpul7OABycHLiEG+bAEAzSMCIoMClY0E
+u2MLxk5F+tWwIwkLw44bKioWiLJ6wM=
=DJJh
-----END PGP SIGNATURE-----

--ajo7seivakz3bffq--
