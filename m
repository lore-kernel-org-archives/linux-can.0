Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794820988;
	b=wHsOze04osmXyW+/g/4U5ORxdziHfqmUySLk0Hnq149LMChdpCsb62wgpCuLe8RGuepD
	 5IJ5FvClceI5CVGpBze3tvGRkWGN92p5pVW5/5lY84zxBtks/l+7JPv4ujAULapb4Rksg
	 VgIVfrC0/SaMq+PaQfKQ7cKQTk84QvAMrk3K85XkZh9HjG3+VYEYe6srRwBUksDaJ3S36
	 lBJEI2GhfFHB91nkTPO+jtoXylVgZJn2cJ9jtt00hiJm3IC5jF777oK9948GWng7LL2bl
	 SmfsWDS2us3IWYBzecu8GIxKOYXqevxifBJ1hSBARgoMs/r8Xu5G8GydcYBfzXgwVcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794820988;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=YWhHL4Z55ZERzg9tKG/xVm8foTsP3l20UZqMYcMw7LI=;
	b=ryKGk3XpA3ACDGXlTf587JD12XwQ3/mEyPL3kiWoyQQSVleCod9ssrJxNiE62r7TH/Ui
	 UaBQWXR0qq+kMWNR+x9B1sIUtsEpdKz1uNA47iurysTmiry2OxM92FoUgxqqQutn3BUYA
	 kga9aa3OEISF4sZnbBV6B6cEaT/pwaHZGeBr/SVEpPXH9NSHPKt/j98aXbYyGfuZY8Cq1
	 sNNAnl+SXUVS8EoKSzhRJsDtYTUZHMdf16rcZ2deIIsVZT2hAgWVSt/5JomjEhpLQUeO9
	 IZQi6kKnorcGIXn/uMoPtvCH5XReirfyQgZQ5Y6DxShUrMysKDWTRsqWMNhmehbbAnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=nAAiw7Wi;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC674606A884
	for <linux-can@vger.kernel.org>; Mon, 16 Nov 2026 09:23:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC674606A884
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=nAAiw7Wi
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4bb6adaf0f1so7513215e9.0
        for <linux-can@vger.kernel.org>; Mon, 16 Nov 2026 01:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1794820985; x=1795425785; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YWhHL4Z55ZERzg9tKG/xVm8foTsP3l20UZqMYcMw7LI=;
        b=nAAiw7Wi1R/QA38fMTubTeBzg433+OcHRy+75jZ3YdzL6IIrJGXltLVkPojbMI3AYx
         a18eBxk0mQVX5cZeKg+jP5+ag2zJrfGoBXFW6h851MHNioBwGOceb6j3RaO0imoziV+a
         zcEbu3v2d+gsX1ThUj2D+Zbm4OQNJuNFXwsdFxhlEkkiSba/hZYn7o2hUk0gPIk1x4Z9
         gmbaRevUQNtJQMNPyEkBOxlsFtuqeNV36e+vbJwz0tf7C0uhS6tf24UlDkvX4UmqGQyy
         dgju1YNtM3x3zYnbefM5LD2GeSyEz4JOeykU/q0H8i8nRTJqZwixr6cgOWH2N5QCILpv
         OnIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794820985; x=1795425785;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YWhHL4Z55ZERzg9tKG/xVm8foTsP3l20UZqMYcMw7LI=;
        b=QHd3KdoCL8TwUHyeWpzV+vq4N+MPtlvpAiLeQ+cevnYCb3Ny1hhrTXT5i2WRX8g2ox
         hF4TJfMiwMbH1LOm3O/IbSmN9JmmQsz0IN4M1vidTbCslMxWrW8lMaJ+MIO9tXXKGmKw
         a1M4OZSRcsIcc3xxetMLiZmuH+Ba0JEzpCzrbSNo49Ru3L3S28HRgahavB92waLga0BV
         6GHoEB+dQSfJX1wdgqS2Fme7e0EUXnzADsDJOL6+k2TE/qgmOkIOvQi9RoKoWZrLXtLs
         bz1G2qmkeinMEUf/aqZ70MH963cHq5MAtdaC2wEJ5vCsi5NPU7oy/5+ziurmG738PokA
         grfA==
X-Forwarded-Encrypted: i=1; AL+hErFa7vYf9jEK4KFnT5ZBq19TqTLtb+1vVus0bRwRxwx3jQcoUJWMUGdCNwTsvO5/TWTC5Gu8yO+XUis=@vger.kernel.org
X-Gm-Message-State: APuU4Z8D83Ih5+CtHiIyJdvhIkjhDzI3eXfiox1VpDP9nY6l+ye352Hw
	MvXEmP7QqB8Q/5zuYP1IdXAnb0nqgKElGIMWVnNqkRYUcAnpagVKk1DD5N11UWnrH0M=
X-Gm-Gg: AYBFou2qbk//lzoy+sCwspIkRhSov2OWCGzTS9mtnqP182tAcKUco0yFSkWTt5CEs+7
	0TraZmAP+IcreihGoEMWZb84X8NXqmMyrOhV2/VYddT2zHkGW0xBO4bXCDwtGSwuJ6CjiBFRb+R
	6DbzkyO6Ollzeye9fkpcKE337xhTRznKGU1GAa2fL5kL99/1pPWJtPNjFFocyAI7UijLp+C9Kf2
	7sm5rGUm4c9I7qKBvcUY4ZsfpL7araZXkZ7mdz9XAG+SLFeWJibj97rByBHCDpE2OIda3XN/P+6
	aTOBEMeFSQdxreEGGVDCaWdIZVG8FYYAouIT0kVR/aRdMW2dhU8HSBgCSp34DSCrgS3N0buHv+X
	EwvzNJpz+f9aqA8LGOnnUdTzKGVYEgCTqJDMs7GOEvuJ6Hgi9wCQNCqxjdHAJ9GFVpK0xN8jQ8O
	puR+Iv12PC73D3H4P7xvX54rmdxwFQ1wmVpOJULSDGsfRT5xXcHAgDDyhzjdMPmPCjwOYB/FTq8
	KqmGqASOSJ4fAeJfZ00NfAbTqiseGk/JinBrXFfe5TA65OGynMfunjDqGU5vTFVthpiUOY7xlO+
	+xrJYdgUTYoxQk8czfVGbJd4Yww8Hij7oSzfYGvZbaX3sfRg6aiGfhrKeb07KBX1kiknBUQK4BL
	6V5Uj92EH/9i9vgp9
X-Received: by 2002:a05:600c:8b82:b0:4bb:6814:7391 with SMTP id 5b1f17b1804b1-4bb681476a8mr117276055e9.25.1794820984666;
        Mon, 16 Nov 2026 01:23:04 -0800 (PST)
Received: from localhost (p200300f65f19a9042c263c0c153a4e28.dip0.t-ipconnect.de. [2003:f6:5f19:a904:2c26:3c0c:153a:4e28])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4bb69ac4e16sm101563665e9.0.2026.11.16.01.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 01:23:03 -0800 (PST)
Date: Mon, 16 Nov 2026 10:23:02 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: sashiko-reviews@lists.linux.dev
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org, 
	Oliver Hartkopp <socketcan@hartkopp.net>, Vincent Mailhol <mailhol@kernel.org>, 
	Oleksij Rempel <o.rempel@pengutronix.de>, wsa+renesas@sang-engineering.com
Subject: Re: [PATCH can 1/4] can: c_can: c_can_plat_probe(): reject devices
 without match data
Message-ID: <avrJ54bCPy5K1QcJ@monoceros>
References: <20261114-fix-device_get_match_data-v1-0-2d82025e9646@pengutronix.de>
 <20261114-fix-device_get_match_data-v1-1-2d82025e9646@pengutronix.de>
 <sashiko-outbox-214574@kernel.org>
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
	protocol="application/pgp-signature"; boundary="3pek2dbhbnp6trdu"
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-214574@kernel.org>


--3pek2dbhbnp6trdu
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH can 1/4] can: c_can: c_can_plat_probe(): reject devices
 without match data
MIME-Version: 1.0

On Sat, Nov 14, 2026 at 01:33:34PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] can: c_can: c_can_plat_probe() rejects c_can_id_table matches
>   with -ENODEV
> --
>=20
> commit e910ae3e03adb41c30f60d29d9b4c11824109fe5
> Author: Marc Kleine-Budde <mkl@pengutronix.de>
>=20
> can: c_can: c_can_plat_probe(): reject devices without match data
>=20
> This commit rejects devices in c_can_plat_probe() when
> device_get_match_data() returns NULL.
>=20
> > diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c=
_can/c_can_platform.c
> > index 75607b1afd2e9..b6012cd713cee 100644
> > --- a/drivers/net/can/c_can/c_can_platform.c
> > +++ b/drivers/net/can/c_can/c_can_platform.c
> > @@ -266,6 +266,8 @@ static int c_can_plat_probe(struct platform_device =
*pdev)
> >  	struct device_node *np =3D pdev->dev.of_node;
> > =20
> >  	drvdata =3D device_get_match_data(&pdev->dev);
> > +	if (!drvdata)
> > +		return -ENODEV;
>=20
> [Severity: Medium]
> Does this reject non-fwnode platform devices matched via c_can_id_table?

It does, however there are none of these since commit 17b6e0280f31
("ARM: OMAP2+: Drop legacy platform data for am3 and am4 dcan") from
2019. So a useful followup cleanup is to drop c_can_id_table[].

For now I suggest to mention that in the commit log. (Though if there
was such a device, the patch would make the probe function return
-ENODEV instead of dying with a null-pointer exception, so it doesn't
break anything that worked before.)

Best regards
Uwe

--3pek2dbhbnp6trdu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmr6y3QACgkQj4D7WH0S
/k5RWwf9Gv31XqqZPH4JwPX0KHpiAWhemgaE+bJBp8OfyB7SHjLqs+vVF4f0k9xR
tB6TOxR2DgleZZtVTyGND0yJZBnAPUZ3dEdtpO/iPvw5cQuDpvXa6WrfPxfWXwdj
sorQpgF3MTv+tQZPqnSgDPeiFe51IYOlBffvNgc8dt8Gz/S4r56KuU/QvgDRPITL
137TDJ1YIEvnBZLUTSHdiuqP9P71IxU/JOqrfXjPHaxv/T4GfnzE8d+KJJ4QufF1
zNkvP0MYgOTGc+m2sM7RtAfjmNwH1KI3twQ85DLU/eRYk16XdCAyHd5NuBKY1+tg
AYWr48nYYZ4s9jRhPmcwSFNkjHQbrA==
=wbMo
-----END PGP SIGNATURE-----

--3pek2dbhbnp6trdu--
