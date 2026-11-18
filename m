Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794989168;
	b=WxLaaeZdT9hnyFqEpc2Ace7+6SPZL7XQU/lByD2PXcrPgy9r1Fig/HMwOZYpInRTRmx0
	 g3E0CJPK9P/Hh+5dbW9KOrIu7jSrHy135gD6dKdKFg/nwuhX88IxK7h6qluTmOkTPuUe9
	 Jr10b1K7yc5986/9E6nTKD65ye+7QrSBN1mmMX+BUEgB56793aYaJ2RG7dGxNQM7GYqxN
	 t8mTYkwLRTkiDysRbrs6SKO0sSQUFS2gQgXYInoCqySLFuRZ1jhIFK5unIViVt9gzj/Wu
	 G0RmBk9YLvdd7+KAOgdp2Te82cgdHmTu4x7Y/sgVlJFaWeZYf/A/gbQIHz94YpQaFnw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794989168;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=GenKSHxC1MEchwaGwaotaBU/VZbPmxb7mMna98PjhTM=;
	b=P08rnijqrjCQbVLFXdRsNcv6whsnVIK76P7oeVmGE8suM4dJy9V5jvAadMJKpnQ7heWF
	 +8BqkAh4pdwW2w9w3n6F7+chsoqHClMsegfU4Z+wF83w1mPLHWie9j93w01ByMvSeQWFd
	 54IDWIsfNS+9pxAy2QuYJiMHbWB5J8N0GgkmFT742BWCaxM/1JatUyk7WbcOHb1r9uMu8
	 gmVXUFeFR8K0o+lPztcS2NNJm+08sHfHxN0JnoGkuULel/Pz5XhecYK4b1RZ47V5Q9IIK
	 c1HloQNK9Mmzhid1tUOfd3DaRRM51oanbdePe+kJAtMfgrK9DgLVsyh7aa6hItk3BIw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=NSKhnFp0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DF3606A325;
	Wed, 18 Nov 2026 08:06:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4DF3606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=NSKhnFp0
Received: from pengutronix.de (ptz.office.stw.pengutronix.de [IPv6:2a0a:edc0:0:900:1d::77])
	(Authenticated sender: mkl@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id A1FE1205A67;
	Wed, 18 Nov 2026 09:06:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794989164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GenKSHxC1MEchwaGwaotaBU/VZbPmxb7mMna98PjhTM=;
	b=NSKhnFp0VJlsLaqr3UXe4KDvN8PLVHoCdutIHSH1Py7+A+l3h6o5Pl4QFFDXojsWBE6XZM
	tZtU0ugs2XFXz+Gey4igUryJpXEnrkyZZMhvelf1hw4PTRQdLTgz/hiBAflRR0tf+tBzGG
	UUWIbsCBTGr31x8A9Mvsg4oiXSNmNSf7KXTH5oib8MQBMw0tXo1UHsgIPXtxwryrz1jv6i
	F8CrIitBypL5U6gmkbvnldgFEgjmlR+oDfQYkWm8P+0UW39dt4qcKn6myC3MYGyfQLDFKh
	PIghlnBua4J2Zb0bGlZJX+O8js3Vzk5epdYL91dCDyuxdQhIG4rUmRn4D8eUXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794989164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GenKSHxC1MEchwaGwaotaBU/VZbPmxb7mMna98PjhTM=;
	b=WDAHGSdSNMOgVv3fa263YShUabz3uPMfQpMpLhnwtV6o9TPcEpTwI3siZn3ZSUPnpo/vA5
	Y1SVtsC8evm9WjKfXgzqbvsNM0sQRbrESDzRQT9Bl7zChh73/JEU6EuvZ3l2x0pdnOhEFH
	/PYm/b3gL5P2r29vtllTOrJFkOxUcCjTD8cnK8mvcVOPpF4LIkRAhuhwDM6hqdUBl1qwTJ
	KxYIwfZA63mNVJ/naweMmUJpB3Yu4Va9gHuIBKB0reuMsjzDm4/2a2HBj/Gse8f3X/CJid
	D/YxrR0xkDxe+2iBXtk955qZIH6pBAhdtlZ5gql1+dAywZXbzy2leAwsaR2eBA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794989164; a=rsa-sha256;
	cv=none;
	b=PBep9h1E0QHvnJ9nSzkX3g3Gd+ATB6OOIHVLt9c8VtVpbN83TSiE6q8CbGb1SCw700yrRf
	4nmxxGzi5l9G2qcvFlNnYpMGdb+uU0bsylMieT0NKCoFXQka1HqGpFiR6ZnilOXDnxClVK
	f8uxUu6LFCOsPyrojeDaIw2efzhL0Neu8YxZb9JFQAwWwsIKcm9WEDi3ZyZ3YWavTbOj2p
	Ct3K6RtELRYqXDxRy+c5v3bxBdWbZaMoNvNetpkg/jvXXmTlJefC+UrWkC0xN1gjhmzyB9
	bpN5YIjBF2fDVxC6azmi+sckVhHFpwHmRiPyCNUWNQ30ZedkvqHs7kvche+7nQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=mkl@pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Date: Wed, 18 Nov 2026 09:06:02 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Jiale Yao <yaojiale02@163.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, 
	Thomas Kopp <thomas.kopp@microchip.com>, Vincent Mailhol <mailhol@kernel.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] can: mcp251xfd: reject devices without match data
Message-ID: <20261118-chicken-of-unreal-progress-07585b-mkl@pengutronix.de>
References: <20260925133716.2230252-1-yaojiale02@163.com>
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
	protocol="application/pgp-signature"; boundary="ahs4mkuzz6i5yngn"
Content-Disposition: inline
In-Reply-To: <20260925133716.2230252-1-yaojiale02@163.com>


--ahs4mkuzz6i5yngn
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] can: mcp251xfd: reject devices without match data
MIME-Version: 1.0

On 25.09.2026 21:37:16, Jiale Yao wrote:
> A device bound through driver_override need not match an entry in the
> driver tables. In that case spi_get_device_match_data() returns NULL,
> but mcp251xfd_probe() dereferences the result while copying the device
> type data.
>
> Reject devices without match data before continuing probe.
>
> Fixes: 9cdae370c4ec ("can: mcp251xfd: simplify with spi_get_device_match_=
data()")
> Signed-off-by: Jiale Yao <yaojiale02@163.com>

This problem will be solved by Uwe's patch:

https://lore.kernel.org/all/20261116110853.3418077-2-u.kleine-koenig@baylib=
re.com/

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ahs4mkuzz6i5yngn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCav1caAAKCRDMOmT6rpmt
0s/nAP9bWQSlIHO6y2wS/kSEUBcTVofQvdHms5he8lovLi607AD/eyi1+aKIKMcV
QQhqx2NxuLYeV3+ZxCv9iuMnhVYANg8=
=gwHx
-----END PGP SIGNATURE-----

--ahs4mkuzz6i5yngn--
