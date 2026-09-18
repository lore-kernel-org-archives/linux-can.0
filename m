Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD8F391513
	for <linux-can@vger.kernel.org>; Fri, 18 Sep 2026 09:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789723460; cv=none; b=oLl+AcIrLTxB5CfztMTQZ/neHSokzhK1+F4HndjCTRrmo+BHHwyPynlvtJnvVUksgPgU7YE9i48YuNfdkgowxoGZNUSpk/VTyF0LK91oKfkDrNx+vG+pV7ITWoDUKFjBMNvC8EzRw62ubH/rz2+G1MnnoE8F+wVc7QJk/sbJtLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789723460; c=relaxed/simple;
	bh=Qm7bjiKhFqbIFmiNskPuXrImM93JStnXHBKSIQsraOg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=CWchEjjQlBtIPQBsBojJSWZoDzPuyQcoBslrbsvYOYkOm2s34G19YTTkh11PHfXOjMGD0Gze56VxPdZ9WVn/+Kw8Nmk3iyYgnN1bCnAKxSmqYP++E3mTMatmcYLiB+Tv6gecZ812HYWe3PCP2Z/Gq0txv+MsZtZCbHiXEfwO9Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=LMJK0OLM; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="LMJK0OLM"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e6c0fce17so2677925e9.1
        for <linux-can@vger.kernel.org>; Fri, 18 Sep 2026 02:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1789723456; x=1790328256; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Qm7bjiKhFqbIFmiNskPuXrImM93JStnXHBKSIQsraOg=;
        b=LMJK0OLMidDI3v6RZkuK1KA2UxQgmPg34zBLfv/cahiohQyf5z52b9OgiTHQQAiwrA
         m/9E8aD0Fuv2/xPZYSLGRd0qz9zl9Wqgzi8tlKLEuwsOiFioVouX/kSqMrGQ3k8hgVBu
         JfWuIvTg6+HRlHckPWBQ29Wj76hcOnsvZnImoaaNVDGQnJ2ZZkFrVk2hNugo5KKrVGcK
         rFJvxypj9ypvpeMyw+VIp0RqqFG+6Y37Ez2FT7Sp52fu4I1I9xQXEx6Pf2N2ghrogUTj
         BowrxxUiCkd5LhYPdfJlgAiVGvU9ek+jih4bGfvxrg5gThQxTGNKeqnF+VCaMQvTyAB9
         Ykjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789723456; x=1790328256;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Qm7bjiKhFqbIFmiNskPuXrImM93JStnXHBKSIQsraOg=;
        b=uxvTPOfRIRlQOTh+NNWn2Q8H+ZzoamRCyG/emXcug9DSqyqS6+q0mu6siIFFbWRJ44
         Ad7QADluHUu+DyRBV1/2SC2OgMnTO8hVwmF8sheao6LEn1qbc/ygnfiB32yLhPXa1lA3
         Myu+bAKOulU/S+GQEUNUcDRtYUvWUWB1Sy/x8f7rH+sKYmWvf9GSroJQW0o6+EBLl3ZJ
         A0z7taOqDhe53nsYCGGfqvzNi8ZYNyxMnFFU7KeGtU53bCWwUnBVFAgLrbmmZ1SeQvQn
         Z+KyJ+j69onsopl10PJrOjpFoNPla6oD4IuF37LiYhT3q0lHn2kSE33P/4NgMumdMty3
         Q13Q==
X-Gm-Message-State: AFuF++moiq3BTvcG5ytnKH2mc4+/ch3t1NTfHFtCB/GENl0YOKlJxb21
	xDDWRonG97A7glh46h+LiISdjoYF/ZkEqDKlK/nuHvttDW9V/hZi4YVp36j+aEAGS6eCdalz+4x
	ie+ep
X-Gm-Gg: AYBFou1Dz1+0MhlJBSdjaxP0ZvROnXBSsiqaLcWTuo4mz1to2oevH31Aq2ZnQz/Tar5
	gopudiTGdDmBDw9c98+uiPQJ53vmdDxo6zeOGCf+tDpTuuXjZKJX3zJfRvJZOeTrBhrev0Xlhvh
	56wsoug+X00JJJMre5mylBAPnQr0GFj4ZCvhbJNuUGJi04NP22io0CpOqrxYKs23+1GybSn3HIF
	6P8SpbGQjlR3fUUmqWcfZZ2ib+5hkCM2xDAJ3aZWGRtNyepe0PuphN0xio7k29flZtwlQBovxAu
	+DtkK+uAr7++RCfcbTxmnikt/ZM7Wz3aIF4OE/2yxmfqH5dthH5+OPzLRvK+zZ6fM/VqgJONikT
	HaJaZu10PYh1qSJThgJcZemQsL1ma8+Vgufd0ufsdOYpWT+AD0HnxwHwRTPmwfyor8ZpuiId2PG
	GJzPhxy7TulnAhmNekaGYuCLLt5ZnOXMeM6UyT4QqvQf3empgm/HucIvkma5SiGlGm
X-Received: by 2002:a05:600c:19d1:b0:49c:fc6e:a3d6 with SMTP id 5b1f17b1804b1-49fc574ef3cmr20370365e9.21.1789723456007;
        Fri, 18 Sep 2026 02:24:16 -0700 (PDT)
Received: from localhost ([2001:4090:a244:8223:c4e6:4d28:61c:74bb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fc7ce03e7sm43132485e9.3.2026.09.18.02.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 02:24:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=493b123f8147839c0c2aaec039714385462bec8d85bf63ca694b6cf1d34d;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Fri, 18 Sep 2026 11:24:09 +0200
Message-Id: <DLIC0I1VQLHE.13KVAJJ5FUYZN@baylibre.com>
Cc: <linux-can@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] can: m_can: pci: add missing
 pm_runtime_dont_use_autosuspend() call
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Joshua Crofts" <joshua.crofts1@gmail.com>, "Markus Schneider-Pargmann"
 <msp@baylibre.com>, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Vincent
 Mailhol" <mailhol@kernel.org>
X-Mailer: aerc 0.21.0-146-gb5c16ebe1835
References: <20260916124236.1389-1-joshua.crofts1@gmail.com>
In-Reply-To: <20260916124236.1389-1-joshua.crofts1@gmail.com>

--493b123f8147839c0c2aaec039714385462bec8d85bf63ca694b6cf1d34d
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Joshua,

On Wed Sep 16, 2026 at 2:42 PM CEST, Joshua Crofts wrote:
> m_can_pci_remove() forgets to call pm_runtime_dont_use_autosuspend() on
> teardown, even though autosuspend is enabled in m_can_pci_probe().
>
> Add the missing function call.
>

Can you please add a Fixes: tag?

> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>

After that it looks good to me:

Acked-by: Markus Schneider-Pargmann <msp@baylibre.com>

Best
Markus

--493b123f8147839c0c2aaec039714385462bec8d85bf63ca694b6cf1d34d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaq0DORsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlP6
wAEAlbqVje7vDQ6PkvR3bLgVahwVoaHyE3uBno9sF8mhjf8BAOI7P2SACAlwIUSF
1cmXTEydsjoErRK2ZYT9NAYgiqYE
=c5vM
-----END PGP SIGNATURE-----

--493b123f8147839c0c2aaec039714385462bec8d85bf63ca694b6cf1d34d--
