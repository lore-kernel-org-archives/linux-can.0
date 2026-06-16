Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B5C42B74A;
	Tue, 16 Jun 2026 10:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781606148; cv=none; b=uRYZmykZJ/zQPI94sSc9S3sZEQAGASmwG4g1UnU16HMn0Ct/en4IxUbvG2XxvQT/tjWyNlehB9aQXjkd+6h5x0l2T07NHKe1VP33h2V/qGbfrlAdSIxpyfPbTAUThvRjYGv09UHRUUh1MHrcD53HgyWeo9AopGaomraMTRFi+Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781606148; c=relaxed/simple;
	bh=q6GMZ8l6dmAW9qA/mMYBaPem5kkLiWzFwyAP7rClnxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uQTfO9MhJg9ygkJTWW4ppg2KAGZ8NjDKcG3XlCEyuO7hm273L8529U0l0RRW4aDWHpM2vSxPnKixg2kaDWO4jSSH0d1/+xcC8iGhJYEUtyb7hmdJ/+Hbuqwe+vxGN5IWCxI4Of/66ZLy+KhC8shEtG7QYBwGAmdEcnsWvYtg7QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZKvuAqm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZKvuAqm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 295AB1F000E9;
	Tue, 16 Jun 2026 10:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781606146;
	bh=XJRIemPytV1aguctNVZZ7Efd5w5Kogtqo/i30RRjt0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gZKvuAqmubQT8pWMQdfmuJz4HqNW46GbKO74ppRYG1KaAyHsYESgJkp+o7Lt81Dk5
	 +0BIplzvolOB85QK49K9ssXVvKuw58FJdV4nVX+0bVj8zBeJwL6pNmvd1czu8SFTgc
	 5mE9eu7fqqdcIBtA5qLVJ++3ywCKFnDkNikUSXIEcfIsYrSVoyWUNol18qik7xmIRQ
	 m57AWP8eLozyWm5SSQ/CaNkLL+Qr+VtZZEh8tGPQIxCKnb+1+I2rEs/v/Zi4f9prOn
	 6HOIpCcb730w/dH52JS6ZbP5qdDYp4iOJ7cWYIwVz9cb8W73F2uPn+X1h77fl5SXOk
	 uXE/umqtZ96bA==
Date: Tue, 16 Jun 2026 11:35:42 +0100
From: Mark Brown <broonie@kernel.org>
To: guoqi0226 <guoqi0226@163.com>
Cc: sashiko-bot@kernel.org, mkl@pengutronix.de, linux-can@vger.kernel.org,
	mailhol@kernel.org, o.rempel@pengutronix.de,
	sashiko-reviews@lists.linux.dev, socketcan@hartkopp.net,
	linux-spi@vger.kernel.org
Subject: Re: [PATCH v4 0/2] can: mcp251xfd: Add ACPI device ID table for
 MCP251XFD
Message-ID: <997991e6-0e09-47eb-a6ac-5f455ddc250a@sirena.org.uk>
References: <20260616092614.00ED51F00A3D@smtp.kernel.org>
 <20260616103018.105612-1-guoqi0226@163.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yFb1XlutYJnaVOoW"
Content-Disposition: inline
In-Reply-To: <20260616103018.105612-1-guoqi0226@163.com>
X-Cookie: Password:


--yFb1XlutYJnaVOoW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 16, 2026 at 06:30:16PM +0800, guoqi0226 wrote:
> hanges in v4:
> - Split into two separate patches:
>   1. SPI core: add internal NULL guard for spi_get_device_match_data()
>   2. mcp251xfd driver: cache and validate match data pointer in probe
> - Remove duplicate spi_get_device_match_data() invocation and unsafe dereference

Why is this a series, are there any dependencies between these two
patches?

--yFb1XlutYJnaVOoW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoxJv0ACgkQJNaLcl1U
h9BVAQf+LlIoxb9QviU7zuSrpS6s2Qar3R7TbO12N2S/XcjwYnU7kEYRqBCgYaxh
2SGHOFcfkUu7pmIVDHXFA0K2DX0BDHDoah3LPH5CtfCHU8XJfWoqu5YMlk5P5eni
wSyc/IlDO02PzXAIwFXN2i3fcqtmtBLD1Gn1UHtyrmtT5fcN+VNXK+dczDuOxH6g
fpT+WZfpz/Zq0E/FOmTgk2Ntf27kyzHuHWSd3/AdFYCPrZ01RQJVIOtuvJVCaoF8
NTViKsVfgcm9KNAloZlXuM5ZiaDTEAkwjrj50w+VQOuwCxCIBcTDGnxSLN2Uk20m
gR1vF+4R+QjFa7fmWiXoKub3WThYRQ==
=nd1y
-----END PGP SIGNATURE-----

--yFb1XlutYJnaVOoW--
