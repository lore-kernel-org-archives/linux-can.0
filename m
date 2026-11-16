Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794820462;
	b=BTB5DUqs3q/nweiymnCJxHmRCRUt0oPtf/v7r1tgQ+YbQ2Ycbc3etQnT1Gzyv2jeHdCR
	 d8Rsuvpmdrg+KLEUhxDTrTLS8oVCU0q+0HwTsej40oITTaKnX9r39oW7psChDR8vsNZYH
	 n8wsZRlMKOfiQb+6MQya3X7M+DUBIyNp5KRqjYrTufucVMArwa6B7bS7JE11GcUqUKeNF
	 4TXZEds47MKZyn4OhRVFTSn5M2Rjvdx00ZBZP5C10rfzoQgJ6ElTAd0MOFLl6R81B1798
	 GZBQ6zhVWzs7nnMqdG/hb4YC1USqFw/GatyTuDbokL5n3jql5fTyDbQOZJ1uGDxfwcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794820462;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=duB+53Rzo/I6JCkMTJRwR1f6X11DgAhC6/nYlh9cR8c=;
	b=q9/PFHbfYzxI8vE7cv/eyGHx6jV9SACwpJgtWdLx/r8poBm3LG5Kl+QJDs0hRrAib6Rl
	 1nau2sHZCpdoiPiosfe8hinSLWRmoyNeVdFVI7pRAfZojFO7MKzP9w4byo82WKgFr4Xjr
	 oomC4YZRphUasamPSDKVr57hP7O+Ds+/bHULKCOyswhq24YWPLUI9UrgFpnkF2WtlsjfR
	 OxvUpQkcbGAEc6BqkwFTI+UNknn0N4sq6jSzv871rk/fMitw93fvtU15Ny6mlpK3cyZdi
	 ubHVGTRfEG8LfYgnlffp1XmhM7sVhG5GEb4j1k113GIsfpGf5HZI2BZo66EwMEq2krw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=b0a3iGWr;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2018606A32C
	for <linux-can@vger.kernel.org>; Mon, 16 Nov 2026 09:14:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2018606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=b0a3iGWr
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a210470b49so25451025e9.2
        for <linux-can@vger.kernel.org>; Mon, 16 Nov 2026 01:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1794820460; x=1795425260; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=duB+53Rzo/I6JCkMTJRwR1f6X11DgAhC6/nYlh9cR8c=;
        b=b0a3iGWrhf0lSrT8W5PZ3apkvAjkLzovGdk1hHP6fmuZKr0QgHoQskCMS/2eXD8s1H
         KMlOrWoYP2COhV2udxBxwK3o35CxHUhhuUrA/gsxWN/ozahfqeYoF760rLEDhKWIf9J1
         qdrT6VnVDZxSlFoyG21Gp1FxTNXij99MBVUfo9iJxRy/yMfTJZPqEIGSE4gOOqSCv8iX
         ADnrBEXLVfxAyBDtPbyu8KzXQABpCjhC8TzviIGKLh6Ana7YjdzUvNiyAee/3o8oN6L3
         zijZgQpZW15/LdRnrqhdxzbIDH4YtVKirByXJQPFA2vMzaeNSUzuHGaW5+jHojV5ACNm
         NOfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794820460; x=1795425260;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=duB+53Rzo/I6JCkMTJRwR1f6X11DgAhC6/nYlh9cR8c=;
        b=vnpWRWmLgxrv3/rdeiCPPFPdAaJszrr0Pzu4aOTRBs+27VLpBQxfEOaemTf3C6bbL/
         qsaGOBCOaqKnMnQhaoIzHOmzY+RWjSOJkNxpbKUXP+WV0uLy43MkAHQHEVCMHJoopr3K
         gLgfYW4AJ5Q+fYr0rir5IHNzWqrcUCzU6wpH7sI/Hm057ssrNeKeNOPO7R1/ED6RmyGe
         bOQzJLcc7G22FtL+N/jrIwDIFZNq3tMyTsPMaPVSVtcqrFG9cvjmwefqs3WZIrACjGAv
         14prJgBEKZ5xUfHhdhXe64MxbJPXRi33oaIRt6eMDL7u+IWnbZm1n8E9VRGMof71IU7m
         kd2A==
X-Forwarded-Encrypted: i=1; AL+hErG6zlhUIJPyE70kGUfpguo6VGuABckSxSt/N+2DfpHyBzxFhdKVrNdlylrACsZ9dT2MWyfo8fUw+yg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/e1zE5G6aBaMfPe72PFz15ykOD4/H+2vzDqf0XgLiQ6QNW//9d
	snMuK2Z6sl76OIy48c9vjq/1QX2RHZ0ZtPFBH+9mgGy17BZ+cf68j9Lkg6IZLhKr1Is=
X-Gm-Gg: AYBFou23hPHdSsIpGz0iWMNp5AsiM4w7E/bS4SpcNExkbT56DIt76X/En7KYhjQmlm7
	H6Ed8IEwywC3lamWpyFo+6TnKVehwmKYcu8o72r8cDNu02n8Yo/jPDT35IKfyqHVDus4SWBq8aG
	+L7nOw1mPPJMDMbTTUwSbiObzrlmB8Y89QgDEBjFW/j6N7Kd/6Ht5SLL1yhyQAPgcf+xZZqnbts
	l+lXwvfoG41lOhtoLZA/tKAvueJS6CJvOtEfwItymf50P1wgIE7C0W1X8z73+RHSBNio57ezZ42
	oYE/K1g+PUCJcz7bH624yXrd9N7RhzySIBX8P2Vg+9hrMnr6CH9qRh/rq268eheYHD9D5Iocpw3
	+cn3XucEI4l2R0kk/aD1FCVwTjBX6vo8iMtEnY2xQg6Kf1YRTpHz94YBKUuhypR3Bwm95Zwm1JW
	3ZJLR9g3Di+T5yyvgwhT7BBGoNXLpDTBjC+G4VZYHC4BPW5QHt0JruedQB8BotB8W9mB8bVJwO/
	/DJyPvGFFv0WbPVWjUzKwkD8KLPz6OG136T8F0j7FpNmEArD9UY7aBl117sBIigryVRL0RRR/KS
	rofoFM+G4cBeV8VrRZRfbaprlco76LD4k4lq4CXsSHHxSd97PlwWHUGvR24lKSiZR4sZvd4wkYs
	Q5QBNQqL4Zzp3TFktcw==
X-Received: by 2002:a05:600c:1d10:b0:4b2:3c81:d1 with SMTP id 5b1f17b1804b1-4bb55a65ea5mr192703955e9.5.1794820459865;
        Mon, 16 Nov 2026 01:14:19 -0800 (PST)
Received: from localhost (p200300f65f19a9042c263c0c153a4e28.dip0.t-ipconnect.de. [2003:f6:5f19:a904:2c26:3c0c:153a:4e28])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4bb5faf05f8sm159998655e9.10.2026.11.16.01.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 01:14:19 -0800 (PST)
Date: Mon, 16 Nov 2026 10:14:17 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>, 
	Harini T <harini.t@amd.com>, Michal Simek <michal.simek@amd.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, kernel@pengutronix.de, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH can 2/4] can: flexcan: flexcan_probe(): fix probing for
 m68k/coldfire and reject devices without match data
Message-ID: <avrHkaYw-De6nv8B@monoceros>
References: <20261114-fix-device_get_match_data-v1-0-2d82025e9646@pengutronix.de>
 <20261114-fix-device_get_match_data-v1-2-2d82025e9646@pengutronix.de>
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
	protocol="application/pgp-signature"; boundary="3kbn6dvhzgm4gtvf"
Content-Disposition: inline
In-Reply-To: <20261114-fix-device_get_match_data-v1-2-2d82025e9646@pengutronix.de>


--3kbn6dvhzgm4gtvf
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH can 2/4] can: flexcan: flexcan_probe(): fix probing for
 m68k/coldfire and reject devices without match data
MIME-Version: 1.0

Hello Marc,

On Sat, Nov 14, 2026 at 01:56:15PM +0100, Marc Kleine-Budde wrote:
> When determining the device details was reworked in commit 5e6c3454b405
> ("net: can: Use device_get_match_data()") there was no replacement for the
> previous handling of non-of instantiated devices via the device's id_entry
> which then results in a NULL pointer exception. The only in-tree provider
> of such a device is arch/m68k/coldfire/device.c.
>=20
> Restore retrieving the devtype_data via platform_get_device_id().
>=20
> Also a device bound through driver_override need not match an entry in
> of_match_table or id_table. In that case device_get_match_data() returns
> NULL, but flexcan_probe() dereferences the result.
>=20
> Reject devices without match data before continuing probe.
>=20
> Fixes: 5e6c3454b405 ("net: can: Use device_get_match_data()")
> Cc: stable@vger.kernel.org
> Reported-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> Closes: https://lore.kernel.org/all/20260618140147.142489-2-u.kleine-koen=
ig@baylibre.com/
> Reported-by: Marc Kleine-Budde <mkl@pengutronix.de>
> Closes: https://lore.kernel.org/all/20260528-fluorescent-sage-ladybug-432=
61b-mkl@pengutronix.de/
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  drivers/net/can/flexcan/flexcan-core.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/fle=
xcan/flexcan-core.c
> index 86b40abe9e76..2bb9e4184eb5 100644
> --- a/drivers/net/can/flexcan/flexcan-core.c
> +++ b/drivers/net/can/flexcan/flexcan-core.c
> @@ -2148,6 +2148,11 @@ static int flexcan_probe(struct platform_device *p=
dev)
>  		return PTR_ERR(regs);
> =20
>  	devtype_data =3D device_get_match_data(&pdev->dev);
> +	if (!devtype_data && platform_get_device_id(pdev))
> +		devtype_data =3D (struct flexcan_devtype_data *)
> +			platform_get_device_id(pdev)->driver_data;
> +	if (!devtype_data)
> +		return -ENODEV;

My stance is that the ability to bind an "unexpected" device via
driver_override is something that should be handled in the core, see
https://lore.kernel.org/all/0f7446324f6a0c8f0153d6532d92a6eeecd6a308.179061=
2298.git.u.kleine-koenig@baylibre.com/
for the latest patch to address this. I'll work on this patch to
hopefully get it into v7.5-rc1. IMHO it's ok to not fix this in a driver
specific way now. (And then my patch referenced above in the first
Closes:-trailer is IMHO better than this patch.)

Best regards
Uwe

--3kbn6dvhzgm4gtvf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmr6yV8ACgkQj4D7WH0S
/k4KnAf+I1gQa7nnydreBqpl18qr3bjlMpNbM/wcIEtGP3xMBPkpDX2yJFljOI8k
9TayfHIOvCINmFKVvL4sioue78+dQP56QUAmZGMHZNnQd4W/38CNi+PxKIqgsV74
yoJHlZhYsHSMLMsf8oAIKAGhkVtpziLJ88i2Yc2ghjZ7erYkKrSuBc+jFTFzI4tM
OknkKdfObSLN1TAr5lJYpnpvCn6HNJOkz//vLAgu6wAYdV9WtAd0wrkm/4tFcfir
MpB/Cw/PNtHNAZWiKPL50rum+ferNUNUzHrRAEx38UA5Sj1Nz4MQonl0UUVFoPIr
tgcOC5iCUQKdoIJu+AnDEx5AuRV1Dw==
=98Fb
-----END PGP SIGNATURE-----

--3kbn6dvhzgm4gtvf--
