Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA493AA50B
	for <linux-can@vger.kernel.org>; Tue, 29 Sep 2026 08:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790670400; cv=none; b=Axx7jfoKIqKClnK9yXFPnVvEMoVvMl1CBdcDsujzybnttmjowVcmsbcfTXK4+7BYDm/EvDC5s70EUdWARcFA5SE5KoUUrrGpziXepTxmbdkfceIWF0pJwH3WlGK1UkuN8MWU01tnAWLutengYrKPk2HNuAG6Mox26xWywAJgkyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790670400; c=relaxed/simple;
	bh=c/YAoCkqI5uJ0uIcLZRtRK48iXLk9E8C0EfmVs86n88=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=TiSp/WcKmYxubL1wONonK5FrL94XbgZs1PKK4/kT7/PnUPugJj1GxWM/CxQlN8xPpNT4KkBwbn29Y/R0DvxZhMyZ6Eegl+gQutCUOaa6NzaDpZ9lyyTjSqcH1ErBOKKVAg+G0jlXcEQrnkyO2koeScHzgdU2inIwW5bxKqtP9mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=BZFBLzOy; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="BZFBLzOy"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843796e373so2207088f8f.1
        for <linux-can@vger.kernel.org>; Tue, 29 Sep 2026 01:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1790670396; x=1791275196; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=c/YAoCkqI5uJ0uIcLZRtRK48iXLk9E8C0EfmVs86n88=;
        b=BZFBLzOy4OYtGLOiu+O6qtQrUuU9Ia2mvkJBQ3ExKxQreDg8RUb58h65p+22CK+U79
         DhhXyYD3+qEE6mB0Ev1gnTseE7f0JQm3SOhuT+g/aGp+oyl1xySVe2+VsUzCiEuZh3yN
         h7ZxlHdOTg4FwUsCMv5IKgjqBHtoUYuLzhNQeXsw8QjK40U4DNi/7p9yv7DZIIpjlxS4
         yBmcsaoyMbe2brApO3JoGFeDpnc15MRgfobY9aBASDBY6oXBlMKzCG51+cAymTd7wlw+
         T4c4IktmC6WKXmf7q1YWaeePgktoLXkw28b2TQV3EI6DJoF0z5Aj5blZpC56SXNBUB7p
         5eQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790670396; x=1791275196;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=c/YAoCkqI5uJ0uIcLZRtRK48iXLk9E8C0EfmVs86n88=;
        b=vFajHNiSJka5Sj1BBmRwNuDcB4Wx81oIEmIh6GkN9vyoYkQyvQeQEO7wvvdce/WjdU
         PAiojUypAPBWvTtLk9PeUAzSqa9YW0xL6jHjtkqOZ7fH+39ov3RN4Nyy3ENw22lSt1X3
         lKYis296al4hK1py80GgZCaKGEB/p+L0Zks6cZNdwQlgpTejEA49PhXa4/gbcPYceXvC
         foQOZ4fzTe38mhr0iBGQzK4sJ4UgoA6XOXreQYX7E32wDuFf+AgF6Z/giTQlHb0JuYsc
         b6aeOg6sKObikWJ6xpeMvJqAwYzdUDAU2wlPiMAJ2nmgMhK2SFNATw4svGjQsVUPLv95
         fIYQ==
X-Forwarded-Encrypted: i=1; AKwUvBw3jWe9kEuV9ILzQceHIs1sqmvG/Mb41PZgujX1a4Ty/r86dLEUpp3CR9SYuyf6Sxj2yARz1BM/9a0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIqJuTfjWGohTgnztz4ZcpJsWsafTZeb8rP8SPHCzsas49A1jJn
	2BPtLfS3ayDmZaRnjds9TObunuMGo5FUkoYfKvUYKeHEP82vJBP2/79lsR40MUFGx+A=
X-Gm-Gg: AYBFou2VaeogQufHNq61zJ4ocpJmSYACtuv4UdtKZQqDaMgErxUFWHVHLJ3SYJ873dI
	U6SxhM1S7QySVeZoJuufJias/o3gzN1F64qi8J1UTkgKWTgFtxTTvUxSRtFiOSyZL08ohg8SHGM
	i8NI/T+R103kudqtzixfyMM8IV68baozxGx82LrvIBjmVvNECumDzWoYhKAKVXPzi6VJ983WIKk
	M7ED/aa56O1a8fjcmZOw2GqQ5e5ny4HdXG2PW0WNyPaOK6X1+1mWjQEKitepEqXw2/LfKT/CilT
	759AwQK6tR3SsMp9zzAaBB9u4ogAqczOIDTojWpIshDud7N6S0bJHHFQO4yyrt19iqDNZ+05Dy3
	lvTU3kIRBeGZ/EAEEoUEt4UmABXJShR+3BVwSwcIAaQgRJH8m31e3o8105s3gLFPts5iCIyjRrW
	S9uDzKaGp22P5NEObcrvniw7clqkKNdjetRtYMfNesNZXSBHiiVvaAmQIZRB0DGsd+QHLxSq0LY
	Es=
X-Received: by 2002:a05:6000:288e:b0:488:80d4:754d with SMTP id ffacd0b85a97d-48880d47663mr22980780f8f.40.1790670395994;
        Tue, 29 Sep 2026 01:26:35 -0700 (PDT)
Received: from localhost ([2001:4090:a244:8223:c4e6:4d28:61c:74bb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48af4f88b37sm2458205f8f.5.2026.09.29.01.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 01:26:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=b85174839f920e7485dc2924fcc56e243020d2d5778e725847992da712cb;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Tue, 29 Sep 2026 10:26:26 +0200
Message-Id: <DLRNOB4Q83KI.3U2QE8AP2P6JB@baylibre.com>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Vincent Mailhol"
 <mailhol@kernel.org>, "Sean Nyekjaer" <sean@geanix.com>,
 <linux-can@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] can: m_can: Fix suspend deinit() error path
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Kendall Willis" <k-willis@ti.com>, "Markus Schneider-Pargmann (TI)"
 <msp@baylibre.com>
X-Mailer: aerc 0.21.0-146-gb5c16ebe1835
References: <20260918-v7-3-topic-mcan-suspend-fix-fix-v1-1-e24fa70c754e@baylibre.com> <20260918192125.yjbqjwivucj5wyuf@uda0506412>
In-Reply-To: <20260918192125.yjbqjwivucj5wyuf@uda0506412>

--b85174839f920e7485dc2924fcc56e243020d2d5778e725847992da712cb
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Fri Sep 18, 2026 at 9:21 PM CEST, Kendall Willis wrote:
> On 10:29-20260918, Markus Schneider-Pargmann (TI) wrote:
>> When suspending mcan, deinit is called and its return value is returned,
>> but nothing is restored. Returning an error in the suspend function will
>> stop suspending and resume the system immediately. So on error the
>> device should be restored to its previous state.
>>=20
>> Fixes: ad1ddb3bfb0c ("can: m_can: call deinit/init callback when going i=
nto suspend/resume")
>> Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
>> ---
>
> Separate from this commit, but does cdev->can.state in
> m_can_class_resume need to be moved to outside the cdev->pm_wake_source
> conditional since in the suspend path it is only in the
> netif_running(ndev) conditional?

Thanks for the review and pointing this out. But m_can_start() in the
else case sets cdev->can.state as well. So I think it should be fine.

Best
Markus

--b85174839f920e7485dc2924fcc56e243020d2d5778e725847992da712cb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCart2MhsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlMx
UwD9GSqOWoi5O3M1pa2dRkPw2+hSeP8+zmA2nvPc3QxKri8BAKez0OtgPTAITNxR
mr4Ji+RS8Ij/Uw9heQuqW6t+g0gG
=rENn
-----END PGP SIGNATURE-----

--b85174839f920e7485dc2924fcc56e243020d2d5778e725847992da712cb--
