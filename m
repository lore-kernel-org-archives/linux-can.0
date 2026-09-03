Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AB0428470
	for <linux-can@vger.kernel.org>; Thu,  3 Sep 2026 08:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788425739; cv=none; b=QMiGUjb6mJrIkobur3XieDPP1abZAnHbqSui9JgCrKGBl+x4yfgitXQZ7GNV+tUccNrR/AwZqJMLck/EFiyURYraw7MBS4doonfwomPieDeVjElmPZvuIsc0G/Z8bsYQxKC8dGT13Q6kggWPNySsHtTChgcb9ZWLIVC7+XfqWFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788425739; c=relaxed/simple;
	bh=YKJfUdy5n6ffaKk39SK9sft7LcFnAbfH3T12ej/97pA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=PuyLfLhmHWOoFil3OYOpc5DLiYw1EBg23Cj89hNuVJK/BO/Lql5alc5phjjM6KBok/gCii1vkmzZ2nWmxzXRub7O+kjSy6bvpl5b8eHUbOW153zaJWHeEOecVno0tDOOmQdEYMF6cuIEdtmK8LNd/UQZJ6LUf3/JWYICQbn2/7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=UjRro5D9; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="UjRro5D9"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49b0d78a801so17117115e9.2
        for <linux-can@vger.kernel.org>; Thu, 03 Sep 2026 01:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1788425735; x=1789030535; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lSve4FkJxmYJyxkKw1zIr74/VC3uYwUbpdZi1aoEPL4=;
        b=UjRro5D9SFd8INEOr126MoDwl1jtOvp+E6FiNzMcrqm5KFD18HPXnw1KPYtyx4Zo1J
         H7RAAnW14vekCbko1DLx1/pxCkY7V5JW5b3CTNuFT4dAVw1SJIc+ANtdEIiqBMnUUu1F
         ah0sSHXZ0JaxB4BrFjMnoEEmek6vNAufCdwgh40/jpsJFSHQ5gT8UYEqzOMA8NAqFwDp
         oYIBEQe+gVW4zkK3PYjtfEvF/PJNhIkYCTzQnAe1y/zH2mJxbP0cR+1EnS4L+Z4M1SzA
         Vw8FkxeW2bpctaruOlBmaOIRm3NAARvaIoYzo8NvboOB4m3ubLuRedpVR9C0YimaJkhO
         ToDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788425735; x=1789030535;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lSve4FkJxmYJyxkKw1zIr74/VC3uYwUbpdZi1aoEPL4=;
        b=YWOd6UQogEIlMaEU5pazCU7tE7P7WpLZLM6IeAiBOmIg655EW66WBRuO9xbpJ7BMx1
         B0laQ8Nu4T5BjPOLbErTUtVmWkI6y3Zip36YciCpPgkaen3KIci6LLhzrT9ZjgulPNjx
         YjHbkouE8R9vI6ph/9Lc/u5WmflJTzfteCZYRZ/xr1Z9/dEhcdPc0xy/gTytszRad+GB
         ZVlwomQaBJrleBklbBj2hmPJGhwlI5Msk9U1ZqVqtLVGaVv/XFwlBa2pnofAF3wKsn/z
         Au/gPAoieQsHJNijJeJ17YAWIlzEn7HLcSWgArdHID1j0h6hqwjMY8du5c+Zxp+cR13l
         4o0w==
X-Forwarded-Encrypted: i=1; AKwUvBy3iwBkhtCD4AuP2hNhWUpzCPbT0BEjVmmYv2Ng8YqQbd7WTJB1QTqCXbyUAnXMUOIVgnU6BIgZ4Cg=@vger.kernel.org
X-Gm-Message-State: AFuF++mIfhMTxRiisYs0/jhO2D2A3POxYbDqmU6MdwT6G7Kr+n+vUKAp
	V/6yZXp8326mOXl+lbFmdjWYQ8jg4GvH/OxO0ULzsnHK3A1cZ6213s8pa00Iwq5ZALY=
X-Gm-Gg: AYBFou1dI8v/nAyGYLjRtk2iXqElwDe/3EycUywz6jGhxQ793rQYn7rGHTAipfxsVxh
	cwaNzMkcRb0H7XVD4l2xrzpV/FsaDKhToP3FmGghnfybBwWGuZFbC353t7zWOQuTXIuSrHAFDtK
	tToaylmuHRgFvzopUcmlX+U3UZakyudeMqwCa3wKiQtWanNDMjk7njcbsY9IoDa8DLJw1EgOb8X
	VDCj8UD686q7vFaVhWJCNqindwjcdFupgNK8y8CSqGbNv7ruQNMeD92SdUO3UDviLqWZLdIuhtt
	/JL20ghthgGyF3SjuWeMwXgLyfFIK8zKDDotZ4zQgtuzvUTA6wCM7epwWrXxeAz9v2c8uasqUaJ
	F5AB51OQyWwO5MsoIxKlX3ptj2uX2xyfJCvmMBBxx15/uyZDFMiXViJbPO5FHonkoX+ME++O+Kr
	B1TBftVh+y3TFQnv8kmP4+ScVYmB21IkZurG7sK+VeYVpp/TAGdUkatSH5
X-Received: by 2002:a05:600c:a00a:b0:49c:f4e1:3135 with SMTP id 5b1f17b1804b1-49cf4e13cb7mr4646545e9.14.1788425734899;
        Thu, 03 Sep 2026 01:55:34 -0700 (PDT)
Received: from localhost ([2001:4090:a244:80d4:489b:7642:1b32:84d6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee5dec54sm65075855e9.12.2026.09.03.01.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 01:55:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=5beb2c8dd38bb5ac7bdc9d94a1236578ac7d8d30c9e1c9ad030b45675f0b;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Thu, 03 Sep 2026 10:55:27 +0200
Message-Id: <DL5K0CZS9PDB.1HD8YBEQOUABU@baylibre.com>
Cc: <s-kochidanadu@ti.com>, <a-kaur@ti.com>, <s-tripathi1@ti.com>,
 <vishalm@ti.com>, <linux-can@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] can: m_can: add ti,am62-m_can compatible with
 out-of-band wakeup support
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Kendall Willis" <k-willis@ti.com>, "Markus Schneider-Pargmann"
 <msp@baylibre.com>, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Chandrasekar Ramakrishnan" <rcsekar@samsung.com>
X-Mailer: aerc 0.21.0-146-gb5c16ebe1835
References: <20260902-temp-v4-0-3896f7d16ce8@ti.com>
 <20260902-temp-v4-2-3896f7d16ce8@ti.com>
In-Reply-To: <20260902-temp-v4-2-3896f7d16ce8@ti.com>

--5beb2c8dd38bb5ac7bdc9d94a1236578ac7d8d30c9e1c9ad030b45675f0b
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Wed Sep 2, 2026 at 11:03 PM CEST, Kendall Willis wrote:
> In TI AM62X, AM62A, and AM62P SoCs, the M_CAN controller is a part of
> the MCU power domain which is OFF in the deepest low power states.
> However, the m_can pins are able to wakeup the system from states where
> the MCU domain is OFF through its out-of-band wakeup functionality.

There are m_can devices in the main domain as well. Does this apply to
these as well?

>
> Introduce the ti,am62-m_can compatible with match data to identify the
> out-of-band wakeup capability for TI AM62 SoCs. During suspend, set the
> out-of-band wakeup flag when the device is configured as a wakeup
> source, the "wakeup" pinctrl state is present, and the match data
> indicates out-of-band wakeup support.
>
> Signed-off-by: Kendall Willis <k-willis@ti.com>
> ---
>  drivers/net/can/m_can/m_can.c          | 7 ++++++-
>  drivers/net/can/m_can/m_can.h          | 4 ++++
>  drivers/net/can/m_can/m_can_platform.c | 5 +++++
>  3 files changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.=
c
> index 16f80607e150e2ca2950616ff2c39b7aa13710b4..0788816d881ef8ba84ad5a84a=
6d2d3e60517ea7a 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -2598,6 +2598,7 @@ int m_can_class_suspend(struct device *dev)
>  {
>  	struct m_can_classdev *cdev =3D dev_get_drvdata(dev);
>  	struct net_device *ndev =3D cdev->net;
> +	const struct m_can_pdata *pdata =3D of_device_get_match_data(dev);

The core m_can driver works for all m_can forms, tcan, platform and pci.
I think it would be cleaner if you parse this in the platform driver and
set it in m_can_classdev instead. Otherwise of_match_data has to be the
same for all drivers which is not obvious when you are editing tcan for
example.

>  	int ret =3D 0;
> =20
>  	if (netif_running(ndev)) {
> @@ -2622,8 +2623,12 @@ int m_can_class_suspend(struct device *dev)
>  		cdev->can.state =3D CAN_STATE_SLEEPING;
>  	}
> =20
> -	if (!m_can_class_wakeup_pinctrl_enabled(cdev))
> +	if (m_can_class_wakeup_pinctrl_enabled(cdev)) {
> +		if (pdata && pdata->out_band_wakeup)
> +			device_set_out_band_wakeup(dev);
> +	} else {
>  		pinctrl_pm_select_sleep_state(dev);
> +	}

I just noticed these are called even if ret is not 0, so suspend failed.
This shouldn't happen, but not a problem of your patch. But you could
add a fix for that.

> =20
>  	return ret;
>  }
> diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.=
h
> index 4743342b2fba3823819b9e2bc5b085cc0fe6d1e2..486d808bc677482acf446b145=
0c3a9b6b7405178 100644
> --- a/drivers/net/can/m_can/m_can.h
> +++ b/drivers/net/can/m_can/m_can.h
> @@ -134,6 +134,10 @@ struct m_can_classdev {
>  	struct pinctrl_state *pinctrl_state_wakeup;
>  };
> =20
> +struct m_can_pdata {
> +	bool out_band_wakeup;
> +};
> +
>  struct m_can_classdev *m_can_class_allocate_dev(struct device *dev, int =
sizeof_priv);
>  void m_can_class_free_dev(struct net_device *net);
>  int m_can_class_register(struct m_can_classdev *cdev);
> diff --git a/drivers/net/can/m_can/m_can_platform.c b/drivers/net/can/m_c=
an/m_can_platform.c
> index 56da411878af0185ff9cc512e325137428a68255..ae2d89b65fe8da65b1ca73cbf=
80cd8ee8483e2e8 100644
> --- a/drivers/net/can/m_can/m_can_platform.c
> +++ b/drivers/net/can/m_can/m_can_platform.c
> @@ -218,8 +218,13 @@ static const struct dev_pm_ops m_can_pmops =3D {
>  	SET_SYSTEM_SLEEP_PM_OPS(m_can_suspend, m_can_resume)
>  };
> =20
> +static const struct m_can_pdata m_can_plat_am62 =3D {

I don't like the pdata name here, this suggests to be platform data, but
this is of match data instead. Maybe of_data?

Best
Markus

--5beb2c8dd38bb5ac7bdc9d94a1236578ac7d8d30c9e1c9ad030b45675f0b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCapk1/xsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlOE
MgEA8suKsDAHr3gSYHcmzdKhgj4B1EP8BSKlE5dnGrdEz5IBAPey/srPEYR3ifbs
3kCo0FftLDoUSFKkYXGhEArbs10O
=uRnq
-----END PGP SIGNATURE-----

--5beb2c8dd38bb5ac7bdc9d94a1236578ac7d8d30c9e1c9ad030b45675f0b--
