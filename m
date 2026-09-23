Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2010E34D4E9
	for <linux-can@vger.kernel.org>; Wed, 23 Sep 2026 07:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790147246; cv=none; b=bXrUuCUhG13P4h6sfB57/CHiRQqTersoHd1jrzVfdEOrkH4HsVjNwMQqDTWMyWvqOGMJ6M2pbCzPpOxNYHvQw6PwV6ruSvdcvzu8gNI1ZCs5AvniYbGdyYHAbZBjnAf+zIX5aScKO0npqp+IKU6V+qCCAJ3mHiWu60rzEjin7Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790147246; c=relaxed/simple;
	bh=LYBVKkcHNGxYQtKg+Za6MkgY2pL8kFHKawgXWYzSgOc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=FhAmCTh1Yu3TroRZFRaPFtVtVUVtP0K5nw5yTXLs+BlbEgronnQG85iB3RvItNE+/+2FIO+Ue0u+f/0Ds5zQTjNI+hODkAAC/McNNS5Rf0fwDlQnzZKKwtKPz2yIUe/tlMZCViOn0sKRLf7NPZs6Pn8ncvSxMUD5hR85VdUNiE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Hsjiv4ba; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Hsjiv4ba"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-48439feca17so535568f8f.1
        for <linux-can@vger.kernel.org>; Wed, 23 Sep 2026 00:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1790147242; x=1790752042; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LYBVKkcHNGxYQtKg+Za6MkgY2pL8kFHKawgXWYzSgOc=;
        b=Hsjiv4barW4vMiXygVwX2m9gVfk9pexOJi7OOgfjoHi8W7fYUdMnkPAEhvUAW7jPPA
         AMcN3Au35cXyntKMYMHGN396UPNs7hCZdsY5hEfRg4CWxIkMGJsQtFmVmYFj1ZS2go80
         yOkVN9aC72yeBNG0CEjKr9Vn/WIQ6Sl/+0Wko6eeB8UAM0YaaVgS5ynXt2sZOC8XQpCT
         zKMfR4R+hEfqxgmON7qUtKAGiSTkFam62FNqr5cAKHawkHip7MDTH8fJ5jLT1hZ4AS4x
         o5HszoFMl0OFJczc/nqRG9amPT6/93GYlQPnuYULFlkZJO3zClFl4FA+x4Mlec5xq9mY
         QaFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790147242; x=1790752042;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LYBVKkcHNGxYQtKg+Za6MkgY2pL8kFHKawgXWYzSgOc=;
        b=FyvW3x3BuqNovtNQ5omYDcVGDACN/thfHoT5LbmvBg+P9Ppp2pn6AucAcBUXVsx/ie
         Nw1bwK489bTaRF0jQlmiMlUYZoEwMILJiKgaiAMXN1auMeS8CGxUWeT/I9QRxMkA8/aq
         jKf/rqjnC7HNZQQWXTY6t1tviJRsRxyou6yBJGxBr18dSJic6EyTFJOXPcbival2ddtM
         /YJzfW3SSVM8upW/sa6tZzskUz1JNn0x/4fqJWY1qv1gHQ5s+i80pD+nJP0+g65fi1aT
         GVyWKiR28XXDLUFe7ZEkJRumizkcovH8e8vdqUOxp1/QaoWDEAqT8mJJBUS3oHGgrayy
         umXA==
X-Forwarded-Encrypted: i=1; AKwUvBwPO2zqNHjc5iyseoSAbyXSsMkqKDscE/sVycCqKVW4F9YTAeS0Bn82dfqmGfsdH0UTWLEepJfZEGc=@vger.kernel.org
X-Gm-Message-State: AFuF++lavJRjGsynwvrjecnaquTEShdbdrePHuTs7lzKr3VpvI+njWbs
	Ie9etdr92r6nOvJWALqATHOSXMUekDUOL76xhaZzSVGlRlDSVvVgViKGYfNDY1finfU=
X-Gm-Gg: AYBFou3n7AV2OY+leoFM2dJSH4bXjmVaTi4wrZt/t0FKCq7CHYDluXzEZeXTmZFuAhS
	/RA4kZ2x/JVUfp0o8BarFyYHCkqk50WTcMEWl64BYaOxF17R+qTsipxrFEPSboUcocY+8GLnRwQ
	1Kh8r+dRFyhqiyNSZ3jIc0Md78QGWG44hs6jakAg1T0xPx6Z9Te47/AEhSdGW3z1TgVQDBXWLQu
	9ssyIW8XkIdG+kLoglNMynEyIa49ZGQdFlW8cbrzgacZn6I6AmMSWLjN2bmgodP4K+Cmwb1oPZe
	BUwWLYh7lHOFNBTYKbsqZ4CeVfipade0c9BMTHK+ThohZUXlWS+PcSMHL68H5zei/BZwWrAqfSb
	U1TaxOXMAxYi1PGTaoJPt5C1OW4Ep8qlF+0fBt5ju/rsLTZnjHX3V8UGHtOJliuLjq0gO7D0//K
	oiwMFqWQKJRXMuAjeAsSRArGx7FSAfmHlOJViADZJwAFsxQQ2T/Qu8Ak23IIV1RjY+
X-Received: by 2002:a5d:5849:0:b0:487:489:7af0 with SMTP id ffacd0b85a97d-48867065ee4mr2508662f8f.17.1790147242310;
        Wed, 23 Sep 2026 00:07:22 -0700 (PDT)
Received: from localhost ([2001:4090:a244:8223:c4e6:4d28:61c:74bb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-488688893a0sm4833745f8f.32.2026.09.23.00.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 00:07:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=b597186e58e521a28c53b6ab6430a085a4a819c333318ef3f8c1713c2dac;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Wed, 23 Sep 2026 09:06:59 +0200
Message-Id: <DLMI87KFXHTQ.SWLSTWGCM2T4@baylibre.com>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Vincent Mailhol"
 <mailhol@kernel.org>, <linux-can@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] can: m_can: pci: add missing
 pm_runtime_dont_use_autosuspend() call
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Joshua Crofts" <joshua.crofts1@gmail.com>, "Markus Schneider-Pargmann"
 <msp@baylibre.com>
X-Mailer: aerc 0.21.0-146-gb5c16ebe1835
References: <20260916124236.1389-1-joshua.crofts1@gmail.com>
 <DLIC0I1VQLHE.13KVAJJ5FUYZN@baylibre.com>
 <20260918131504.00005d2a@gmail.com>
In-Reply-To: <20260918131504.00005d2a@gmail.com>

--b597186e58e521a28c53b6ab6430a085a4a819c333318ef3f8c1713c2dac
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Fri Sep 18, 2026 at 1:15 PM CEST, Joshua Crofts wrote:
> On Fri, 18 Sep 2026 11:24:09 +0200
> "Markus Schneider-Pargmann" <msp@baylibre.com> wrote:
>
>> Hi Joshua,
>>=20
>> On Wed Sep 16, 2026 at 2:42 PM CEST, Joshua Crofts wrote:
>> > m_can_pci_remove() forgets to call pm_runtime_dont_use_autosuspend() o=
n
>> > teardown, even though autosuspend is enabled in m_can_pci_probe().
>> >
>> > Add the missing function call.
>> > =20
>>=20
>> Can you please add a Fixes: tag?
>
> I guess it's not a problem, however we had a discussion in the
> USB subsystem whether this type of patch is a fix and ended up
> agreeing that it's more hardening, hence no Fixes tag.
>
> Alright if I just append the tag here for b4 to collect?

Yes, that's ok for me.

--b597186e58e521a28c53b6ab6430a085a4a819c333318ef3f8c1713c2dac
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCarN6kxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlPK
EQEAq8JaGnwxat9Mrazio0Qlb2f3n/P8XpRz+jp0ri+EmqYBAJ134slplunVJ/tr
MN1cdvAnOLCqJhrhtWIARmgt3DkH
=mE+2
-----END PGP SIGNATURE-----

--b597186e58e521a28c53b6ab6430a085a4a819c333318ef3f8c1713c2dac--
