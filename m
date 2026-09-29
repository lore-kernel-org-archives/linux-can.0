Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F8D52FE35;
	Tue, 29 Sep 2026 14:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790692200; cv=pass; b=eg8+iKtmg3TfSZ2ba5jF8POhI27ICUbniK1PVr161tRwr3/Yn6oJdsR97C2jGF87Pg9a2sKn5oI4cIYLrKvG+NqLvwvNpcninEdOax9udGLdoagQazqoO/W4HGy5E8OoZqeVtA/tIh7rxTJpXpFCDfk2J+/dem4VQHRftaxoRMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790692200; c=relaxed/simple;
	bh=Ki4ULZKZjqspZRw97qDNSKKTQp2s50rHsTN5bA4ahoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SrhPhheWBxGBKbaBXovnlnU/QPPWtSM2mQ5pRquXj/HyGySYE1qk3PDYOEJDpCDpKIIz5M5hyBriIr7U87miIFhUX/tfmC1AfWxkmbfA2LKf+HEWikOwT9mZ4PXzAf1klNGfyWpVX8jK8Z2v/1GYsTJkg4c1maOJcTSanUStYDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=Rz+luffq; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="Rz+luffq"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 8E2E5200C22;
	Tue, 29 Sep 2026 16:29:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790692185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ESYwkv4SShJfcI2nL14NiF76xciBBpPOBuVmMxwjXdw=;
	b=Rz+luffqDrJm1juCbeN06twCQ6Ws1mvHFUnL+m4hkjAEF73NyHDSwAWBtDN6nqOjznGMRb
	qVEC6q6zRS8RRiMIq5+SANCf3SaCupVsZnzMpqX6nJKUHFyPesgXdvK1LzjKCxFRie1CKB
	LkyJOHAHLNLD80OhCO1GHdyGANMrTu/u2nFLzayiY3GSLjcSa2+HCcbD9BRs4n4wf+MFjN
	PxFfkiCfPsKxaxFMdhoDPB5YKbj4SC7gNn/35CWE87FkIQQJxkOf1eHuPpZeGStkGzt0Am
	mt+eXZgv4efs/pC2ZqqCzKmqBkjzXxRf3SSGibL6OK7rQ8kNgNbirF8fnNcypQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790692185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ESYwkv4SShJfcI2nL14NiF76xciBBpPOBuVmMxwjXdw=;
	b=CQpTz+NK3mHvJxdEBy2u45bz+5qZ8U7XRG/jz/akRNV8yHWp5HwNjJPTTOlqxV2s6XhUqZ
	XKx0K/+H+dJ+EM2rqeQogeNLuaGmj9A8TNOXVHVu6JXwP5b822cZylWqTketoiwin9X9j8
	l6FdIR1fg5khEQBkA328Q8T8QiJncrupA42coZ9h6PQ5jc1OryVfXcbwBW3YHUhCJhCMmu
	ARfitzX3AAqAIK7MIId2PkXBfgoF3xmZj20TFiuNWywXdlwn336pqKOXPQv58KqRAqtVmd
	3BYPI0lsCxiHwXok00BN43P723N2aMbeX7xAQP5af5tlRpTd8RjYEYkTAiSNpw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790692185; a=rsa-sha256;
	cv=none;
	b=HkuhBqu77SBsGRtm1gXWyDTbUfrMu0+Nla92PTW9NY2nVnDFVq2UyxYQ+uRDpSoDYeUIuI
	F+W/0RnQ88JEFys+ivCxUQvXBOp8po2NEKwh2atUxNkso0OoMFsOfQzQEEjKL2gjHwWmob
	83d1T8sZK4Fw9MFuRlSfp/femj3QcBzwzpzXacs1y2GRbu7t6KFt9EyJnltay0cJsqbPMJ
	dcJb3MdMr4RsrA/UkMdysBl3trH61zWASzaFkJShThObSfyyTOds2xjDhwoZJ1sKsKmu3l
	tvF3OKlODZVk6a66RH2O+iUBj75/It2AQEIDQKhBG6I68rfv0l/bHNkV8cKiWw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xBYq1-003PHT-1Z;
	Tue, 29 Sep 2026 16:29:45 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 2AB1A5B4955;
	Tue, 29 Sep 2026 14:29:45 +0000 (UTC)
Date: Tue, 29 Sep 2026 16:29:44 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Kendall Willis <k-willis@ti.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>, 
	Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chandrasekar Ramakrishnan <rcsekar@samsung.com>, s-kochidanadu@ti.com, a-kaur@ti.com, s-tripathi1@ti.com, 
	vishalm@ti.com, linux-can@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v7 0/2] can: m_can: introduce ti,am62-mcan compatible for
 out-of-band wakeup
Message-ID: <20260929-nondescript-statuesque-oarfish-434a76-mkl@pengutronix.de>
References: <20260924-temp-v7-0-f40defe5957f@ti.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="z5qi2oiwqkx6wtbs"
Content-Disposition: inline
In-Reply-To: <20260924-temp-v7-0-f40defe5957f@ti.com>


--z5qi2oiwqkx6wtbs
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v7 0/2] can: m_can: introduce ti,am62-mcan compatible for
 out-of-band wakeup
MIME-Version: 1.0

On 24.09.2026 16:54:30, Kendall Willis wrote:
> This series introduces the "ti,am62-mcan" compatible which adds support
> for out-of-band wakeup capability in m_can devices.
>
> A corresponding DTS series enabling this feature on TI K3 AM62 family
> of devices has been submitted separately:
> "arm64: dts: ti: use ti,am62-mcan compatible for m_can devices"
>
> Rebased on top of "can: m_can: Fix suspend deinit() error path" [1]

This should go mainline with the next can-fixes PR. Please ping me after
net has been merged back to net-next.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--z5qi2oiwqkx6wtbs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCarvLVgAKCRDMOmT6rpmt
0r7OAQC2Jh+BqZKOA005Z4hDQY//PPSadQL56mizBWLOT7OBhQEAw4wtlcnn7tC+
+slwly4+tSuMAZOQhCYqi3qeLlG2NAM=
=dWOn
-----END PGP SIGNATURE-----

--z5qi2oiwqkx6wtbs--
