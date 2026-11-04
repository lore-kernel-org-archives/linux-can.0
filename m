Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793790733;
	b=BswGjiNlaYMTggvHnGaEQmR6BxaJiuyhuansj0TNGV6ECPg0X3+r+MnaRXP6YxVZRxm0
	 TAOfHMyUiKhOQXTAG97FHXefbhrWI34SSi1GHwjoiyNMBEf7q/bWORFBkN93u+XOqaUFF
	 EavYw8ChVHbYdnlULiMxozLW/HmwhcvtxBIYmh0eYS9EGnruIUCCbesWuQDs7Cn9syavT
	 emDPazg46iYTEAvosi1SVW4BDvnQdefFrNQPKtrk8IzklcXvsvi+Es6L8r9EQKWVgmjYZ
	 TsUPxOdSWr2iX5MY7gdICgI7fRiN0a7BFtq8s8fsXJxVhguQzh2/AoQ03Tkhyae+5AQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793790733;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:X-Mailer:
	 References:In-Reply-To;
	bh=JXUkcfVdYHLS91Uwpurj9n2UACTGti9F49kfa1ZCWrU=;
	b=oIEZwrYYRSLVpksTjozl5gJHeqmkeZ9328PVu53ZGoFGn/P3jmqhmKj6j+7D77p95ayz
	 /I0Oh5zXtAwCH649vv5VKZxe33Qr3DeqGcZb1e8VO0iRW5QRS9e+z2GsGhFieIL9JWdzH
	 yPExFUmIKwomdt7CXKeufgspp/7NMOR+LE7jvnDLxMdktbzfYiHAm1l+034ZiKdGqTvrX
	 iZyUlqwQ6fOUXuH12BvljGrrwHvH8246dRlak6W12aoA4ql89clhmSd/EcMOf3Ep6DaFj
	 QDopcyr8S4euYySDbvcSxxoYvaCoYwJdjkT342/sZZENWhvuXFSf8HTX9C8o2EoUdCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=JWOpqRwe;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB31606A328
	for <linux-can@vger.kernel.org>; Wed,  4 Nov 2026 11:12:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DB31606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=JWOpqRwe
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a2069b9710so4632555e9.2
        for <linux-can@vger.kernel.org>; Wed, 04 Nov 2026 03:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1793790731; x=1794395531; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JXUkcfVdYHLS91Uwpurj9n2UACTGti9F49kfa1ZCWrU=;
        b=JWOpqRwecaopor8yH0ZefUJnXs5kKZeycMNKPt5Ui5Eg2fVW6tAtCKrb5rRUcgrXBD
         8uJIxtHhhpRbn50+INj6AHW75qtRtdXLPaT91ZgN6nZTNl8+IWWmDlnQSSP3sMOhzksT
         3Ryi9R/M0KH93x8QtwCpuCp4Lq1tthpgfNafQ+MYg28KRs28IVviCFXz3CKAKu26bkVB
         +kLa1w3eHYUfumKIySZo0FJYRP5AGAB+7m86Iu4bor0bZVu8oDC3YGMf8PpeN8GnUAQ6
         mdftDgku7QnpdqbjF1R0cJ79LW7Jm6U2A1vZ4PfZdFgBZHpZVe8b3YFwnVyiyqewsN3M
         IgBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793790731; x=1794395531;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JXUkcfVdYHLS91Uwpurj9n2UACTGti9F49kfa1ZCWrU=;
        b=xqsTR1aPnZxZJ4nBbfcqQE4Nitm5Ujk647ICLiGK0QYqVquqzqKhgFZOx1YgBh2Ov4
         IHiLRhoggU0h/S4N/EHQOG1vC2ZAUQY3Llwjm0sOTNZjBZ/iA/kYRb7gBCld9eszNJeX
         FBw+wICsEz2u54JG2kMvV18LRyrBNoOA1c7M6Pckk+80zj0yUF+2ibCZXiR+b2gnJDYf
         8m4wBnpzLjmJ0nKmzoLAmSd8HukO/Zij7dwR7YMoDX/grkNg9iTA68q7KF/JoTTvJYTt
         w8oPZ+26TlZBrkqr9aW0uowQZUNKs8MsYHtCbV63DL5v1v8GXBLmias7FrFWx6cSaGYG
         1kXQ==
X-Forwarded-Encrypted: i=1; AKwUvBwamV2Cr/j78+PzR2ioPPEYGlAdQfCxWU8GSbnvScG9w0yNvUOl55gEZud0VXu7/tUfJ9saxnzlmNM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+VNemlPO7FlfpvZE5xWdc05kxUWoJWX698pddnk47m5Af4NiNv
	8mcUkkPlPjTec422f5yxYQnjPqDKKYhUjrwrTBdlXXm7Fc/zrhciMMXzy3TLmfetzsk=
X-Gm-Gg: AYBFou2u6imXK6SQa9FRac2a+WlZn9slNJ7kgD8xo3DaLL4hZspe9QZGZs22fsvx4jK
	PZdva/pjtBiakmw3kisNqmVfypDQcF+KzoxRDD6iL1VKCzvb6ufQn7nnxV5BndXa280IVrepgEf
	l5QQVtOrrcpmVPoOrUTcPZRL02lD8otqBAE+UoQU4Y0XzyL1LuIGeycfJ7P8bUxI08gXO+SacrZ
	IaylRhMksfc5StyfkBYfrRGobiUvjHOBidK2vp7DEioh19jg8/lu4gREA1ly6FKv2JYaSoR9oXS
	Gg6Xa0o9GowDGz/KsSpCJQKLBjgLKvsOEg7Ayk9FWAO5TUn6lPZBbnm6bIyTQ7MLIYQoz3+nNWh
	WfiQY72xEaccF1juomoFuW00VdnbfpFVt2+ais2potvaaHfSI69FhC7vmjMJpqS+g3zCZpRc6Qi
	7Vnx45x4QB7QT10iJIRa5BrG0QZI6u5dBYLZwssirf2AB8ECjVgTRZtshEPybtUrKUVsO0zIML3
	qq+fmepZGY796GqhTGhBAUXrG6H8/tR2rzDr69cXAjowGDT5ChZtit40zfnyB9xsCiiXJsM8YJL
	Q8cs5bdJyDINSir/8FcTHFYN
X-Received: by 2002:a05:600c:4f55:b0:4a3:d327:6ed with SMTP id 5b1f17b1804b1-4ac182dcba3mr394806835e9.17.1793790730347;
        Wed, 04 Nov 2026 03:12:10 -0800 (PST)
Received: from localhost ([2001:4090:a244:81d0:bc85:7836:468a:a1a8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2ab010a66sm180489085e9.13.2026.11.04.03.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 03:12:09 -0800 (PST)
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=1a89969498c359d1a140827ed6acbf92f89987135f1280b4d5669bb50fa6;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Wed, 04 Nov 2026 12:12:04 +0100
Message-Id: <DMMDQQGAJSRP.2RFOOW1YOKT8F@baylibre.com>
Cc: "Kendall Willis" <k-willis@ti.com>, <linux-can@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] can: tcan4x5x: Add suspend error handling
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: =?utf-8?q?Martin_Hundeb=C3=B8ll?= <martin@geanix.com>, "Markus
 Schneider-Pargmann" <msp@baylibre.com>, "Marc Kleine-Budde"
 <mkl@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, "Sean
 Nyekjaer" <sean@geanix.com>
X-Mailer: aerc 0.21.0-146-gb5c16ebe1835
References: <20261016-v7-3-topic-mcan-suspend-fix-fix-v2-0-7efa2b172cce@baylibre.com> <20261016-v7-3-topic-mcan-suspend-fix-fix-v2-2-7efa2b172cce@baylibre.com> <9aba5682e371f5969d3ddca1c6a763485bc25285.camel@geanix.com>
In-Reply-To: <9aba5682e371f5969d3ddca1c6a763485bc25285.camel@geanix.com>

--1a89969498c359d1a140827ed6acbf92f89987135f1280b4d5669bb50fa6
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Martin,

On Fri Oct 16, 2026 at 12:04 PM CEST, Martin Hundeb=C3=B8ll wrote:
> Hi Markus,
>
> On Fri, 2026-10-16 at 11:57 +0200, Markus Schneider-Pargmann wrote:
>> diff --git a/drivers/net/can/m_can/tcan4x5x-core.c
>> b/drivers/net/can/m_can/tcan4x5x-core.c
>> index a5b8829aa519..b69312413d62 100644
>> --- a/drivers/net/can/m_can/tcan4x5x-core.c
>> +++ b/drivers/net/can/m_can/tcan4x5x-core.c
>> @@ -575,11 +575,20 @@ static int __maybe_unused
>> tcan4x5x_suspend(struct device *dev)
>> =C2=A0{
>> =C2=A0	struct m_can_classdev *cdev =3D dev_get_drvdata(dev);
>> =C2=A0	struct spi_device *spi =3D to_spi_device(dev);
>> +	int ret;
>>=20
>> =C2=A0	if (cdev->pm_wake_source)
>> =C2=A0		enable_irq_wake(spi->irq);
>>=20
>> -	return m_can_class_suspend(dev);
>> +	ret =3D m_can_class_suspend(dev);
>> +	if (ret)
>> +		goto err_disable_irq;
>> +	return 0;
>> +
>> +err_disable_irq:
>> +	if (cdev->pm_wake_source)
>> +		disable_irq_wake(spi->irq);
>> +	return ret;
>
> Wouldn't this be better written in the shorter form:
>
> 	ret =3D m_can_class_suspend(dev);
> 	if (ret && dev->pm_wake_source)
> 		disable_irq_wake(spi->irq);
>
> 	return ret;
>
> ?

Thanks for your review. I personally prefer the variant with a goto. It
is not as compact but it is extendable if this function needs another
instruction with error handling at some point.

Best
Markus

--1a89969498c359d1a140827ed6acbf92f89987135f1280b4d5669bb50fa6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCausTBBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlP6
PQD+LtlVjH3/wReXE9RPzwo6wtqTfo+QNCgoDCb1Raz8jGcBAPtyCB2nUPxKiL0p
tOVeJ7sfKgFNAASX6epFGzYIeAkP
=tpW6
-----END PGP SIGNATURE-----

--1a89969498c359d1a140827ed6acbf92f89987135f1280b4d5669bb50fa6--
