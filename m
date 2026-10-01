Received: from mail-wr2-f42.google.com (mail-wr2-f42.google.com [74.125.225.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363275187D9
	for <linux-can@vger.kernel.org>; Thu,  1 Oct 2026 12:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790858660; cv=none; b=tPkas9yda9vQ8clRgISzGqVbbpfdf7mDMrmBYOy9K77gJlGvvSebTeZc7tqpyx8LmzFl6mvNQtQqbUz1OKdnMnQaiLbxxy8DXltMFp/zft9IbFDq+tcFeD9E6Ldc+ioPhAhR42gz4tM3xdLnAo8DJYuV9OcmvynNUNVJblij3XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790858660; c=relaxed/simple;
	bh=CyaT7Eha1UHGqmbjZC/CgiFY0Dea+vx2szTRHYofhE4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=D5VcFB03G47RQuvg4ucVt3/251mdneBpMkJRmF3YizhwGp0uk3EyhjpFKCZC2ejGw6fonqvAQnji2vtJsOv7h2dI5QyVKUiwQDXg4A/MBWCE132wvAWQLUAt+MOB9RdIDQgqVK/wp08iJoDvaVmRQoZDm1/SGupAV5K73Xi39Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=WKzS0gDy; arc=none smtp.client-ip=74.125.225.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="WKzS0gDy"
Received: by mail-wr2-f42.google.com with SMTP id ffacd0b85a97d-48b0622cc90so593967f8f.1
        for <linux-can@vger.kernel.org>; Thu, 01 Oct 2026 05:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1790858655; x=1791463455; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HcYIhGVNk/zbHIagQ1IY3MOoqw6vea1dLEuZJv721xk=;
        b=WKzS0gDy0kW7rCCWyI+X/chFklJNK2CnwxrGn8hiFU6+MumQR3bcC5jNtAvSLLa2c4
         ioL9Sye3azkR+FnfLC1oXdEdDxtUFZsKl7GRBv125SQyDrahTL75lfY9KjtZNq0YN1Nw
         Ra5P4l4xn3erjAZ3SbVXVrha6upMzQREwW5N5thpw4eTJJY8fVTYwrhEeBlBHvlP2u3l
         +E0s3RoCtOJT4eKCeIexS66Sf9htyOGYL1rVWdC+rdfm23SMiTKiIBtgC1TyiBrB8RT8
         b9HRWkEbqPsJGPkMsuI+QsWV6QR/RriCqfbf0lUu0gROzTmEUElG2BcOhEXIaS6nz8MS
         LiKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790858655; x=1791463455;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HcYIhGVNk/zbHIagQ1IY3MOoqw6vea1dLEuZJv721xk=;
        b=hw9FVrmb2zFEBwiYVFPwa7B3dwqFUF/PmThmEHeGIJAT/snnqhCPTEJq/wInfShXSZ
         T10/SY9PkClBLqJur1mquzebblCeKLtYjlcFuMhWFqb0Zj9SxTiLsZTz8G8/ESHBPx7l
         F/ybvHuPOiLtRSogfUE1AjuveTjZ89LDsa4ShvWCprK+yCcSBhXUo/Tup/QFX6cH/z8h
         vib0kina+F/FXUv5pDMd/djhAepPIXN+0LVeX8SLbCjWor9kLJfaqFzo1nD4L3CiIU+I
         vD4pKv3pAw5Ho7n+8h7xL/4qGUTtF5oK/+kRZeSdsesC4XUQ35xZtmJUXnkUWP+Lpfo+
         OGng==
X-Forwarded-Encrypted: i=1; AKwUvBwtWlb6xAoMoC5hTt4PH1sIOR2grg3wCwTVxxqWd/PHoSQvZ/B04cRlCBbkUqDuTSctssr2+stNhDI=@vger.kernel.org
X-Gm-Message-State: AFuF++lIp94gGukh8vPVbIB0FZvmtm3lEBKpoIxee1RfjusuHoJGbh5Z
	mrYeeGOqbUS0HLjeX+YEt5vmgu0J0fenJf8yfP6T79YkhsnhHtqsbDIFViV9C7jNLYw=
X-Gm-Gg: AYBFou0R6h97BWpJsKnDlag5Felj8j+/Xc3PiA+B3viN3FIij0Dj0qMkk6CDRpnnn7V
	tx2k2vbJnrFntqgbOu2RE4iT7Rabhnwne/BjmAvqU9l9UJnxQR0kSurpN8iY9hIV9McSYMWmtAD
	wHDyrje4Nfz399HIpzAt2iwxkBEYMOMzcKHI3gR9ovQQ/UjVzra9LUrZRdtDiK6lWkNVyotor1p
	J4kAoC7NDKPtuB6pjaNptBmUqG5oj0U8QK8dlqXI/if5WHVGzEurFRBsotgd8hsXdLFQ9DGQtp0
	N5vId0aP6gQyt44IFF9d+5f4CXgyykRN2sxSY/W6uSWICyRHmdzlyWO9LBlVD0EAg4LKnbyc1zf
	qqAWigFO3mWvKoojJNSK4oGLpeRkVN3c99HPexJwUPwNLect19mH0Xl93yrNUXKBYwG/oIZbEuF
	Udl2FeHtW897nkJmu8uRND1g0Cwy3Nt5FsJWWa4Yo/S4OM2NQj/7K7jezSe1ajNh3L
X-Received: by 2002:a05:600c:3b23:b0:49c:fa20:cbfc with SMTP id 5b1f17b1804b1-4a01b119661mr81670925e9.19.1790858654980;
        Thu, 01 Oct 2026 05:44:14 -0700 (PDT)
Received: from localhost ([2001:4090:a244:8223:c4e6:4d28:61c:74bb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01fa137basm63397565e9.1.2026.10.01.05.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 05:44:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=5c66bdb554b501bc94f93cc3800ef51d1e57ebd970d2c2d36d4735e742b9;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Thu, 01 Oct 2026 14:44:07 +0200
Message-Id: <DLTIEP75FV1D.1V01M5U0KJVL8@baylibre.com>
Cc: "Oleksij Rempel" <o.rempel@pengutronix.de>, "Vincent Mailhol"
 <mailhol@kernel.org>, <linux-can@vger.kernel.org>, "Oliver Hartkopp"
 <socketcan@hartkopp.net>
Subject: Re: [PATCH net 12/22] can: m_can: m_can_class_suspend(): fix
 suspend deinit() error path
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Marc Kleine-Budde" <mkl@pengutronix.de>, <sashiko-bot@kernel.org>
X-Mailer: aerc 0.21.0-146-gb5c16ebe1835
References: <20260928193312.553632-1-mkl@pengutronix.de>
 <20260928193312.553632-13-mkl@pengutronix.de>
 <20260929193336.D5E721F00893@smtp.kernel.org>
 <20260929-utopian-adventurous-jaybird-e6678f-mkl@pengutronix.de>
In-Reply-To: <20260929-utopian-adventurous-jaybird-e6678f-mkl@pengutronix.de>

--5c66bdb554b501bc94f93cc3800ef51d1e57ebd970d2c2d36d4735e742b9
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Sep 29, 2026 at 10:34 PM CEST, Marc Kleine-Budde wrote:
> On 29.09.2026 19:33:36, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 3 potential iss=
ue(s) to consider:
>> - [High] can: m_can: data race on active_interrupts between suspend erro=
r path and ISR

This is a good point. I think I will leave the active_interrupts as they
are and instead re-enable the hrtimer. That was one of the two solutions
I was thinking about. This should also fix the last point sashiko made.

>> - [Medium] can: tcan4x5x: unbalanced enable_irq_wake() when m_can_class_=
suspend() fails

True, should be a follow-up fix. This is already what happens now
without the patch. The patch doesn't change this behavior but also
doesn't fix it.

>> - [Medium] can: m_can: polling hrtimer is permanently disabled on suspen=
d failure
>> --
>>
>> commit c427425150087d727cfdd3220f1be90e0a87c37e
>> Author: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
>
> Markus can you comment on these? I'll drop this patch for the net PR for
> now.

Thanks I didn't get these.

Also I am wondering why sashiko didn't flag any of this on my patch
submission...

  https://sashiko.dev/#/patchset/20260918-v7-3-topic-mcan-suspend-fix-fix-v=
1-1-e24fa70c754e%40baylibre.com

Best
Markus

--5c66bdb554b501bc94f93cc3800ef51d1e57ebd970d2c2d36d4735e742b9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCar5VlxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlNu
SwEA1gSSOQwmZDahxj1C0VVLpFfzBfA+hJtl2UvIuR1N7PEA/0cBObPee2WQfHbt
aD0AR48M55LDI+nxCas/NGQbtX4D
=pFQ4
-----END PGP SIGNATURE-----

--5c66bdb554b501bc94f93cc3800ef51d1e57ebd970d2c2d36d4735e742b9--
