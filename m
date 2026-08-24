Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289DD3F077C
	for <linux-can@vger.kernel.org>; Mon, 24 Aug 2026 09:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787562879; cv=none; b=VLu1TR/VE4LLVjLvKx1G+ZL6LDk/q2rHdlB8sBMSpq8yLaiuGcm34zimxmpNgkPKTCgIQVK0eqEQBfO9RWsTrludpaZa+Gp4RMLXyf1JQuFnqT5SbxaXGQpcZj1swz2JhmKUizA9RIjXIT6LCYkGos/h5mWQWNevwkbPFMsmwWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787562879; c=relaxed/simple;
	bh=2XXyFWbZhG92dW9Q6xP4gXx1BdG6SBJq2JLxyq/1wK8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=W156LqgL0+8p9InTNvEYT3vK8QSHQpdEp1aSGcUj8B2z8Z7yfuNBERkjeKO/WF97qykQxJzPMjpigJdI4c3AZgOdDCRvDG7WVAoo78tLn3vxP4jFtJaxcWH0A4I9saO7EdqWgFt1JcDAexQjRrrSaKkHdmLv2a2jdVhBTMJSJPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dynetrex.com; spf=pass smtp.mailfrom=dynetrex.com; dkim=pass (2048-bit key) header.d=dynetrex.com header.i=@dynetrex.com header.b=Qc1epuwh; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dynetrex.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dynetrex.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dynetrex.com header.i=@dynetrex.com header.b="Qc1epuwh"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84a4d8fd6ecso3278149b3a.1
        for <linux-can@vger.kernel.org>; Mon, 24 Aug 2026 02:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dynetrex.com; s=google; t=1787562877; x=1788167677; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UeBCWVbEudvEl41PR+joNkWxWngRqSWwRQTBI46CPOQ=;
        b=Qc1epuwhx5K3V4hXvvqA0SD7UFXkC+6SGmd9H6LOcNRHK9m/KiMMKKmz3x45T2exdF
         MS4JnKFWH9mIeEeaLNJbbgJNfzBlNCzwO9aEJ/mpTx9lZJiKnshv5FelatbZfh4TWnwY
         NJ+zTbLlF1DyClyfSnlFi5UzxtieZfCn2zHC8i4GaXwRoLIpLYBFYaUGMo94NWBcr4xk
         pZrokACk+WODx9xAFhjXWJqDohT2YTrmnXR4HRwWHMPWtltpq0WhaIs/oHL800npAvf0
         Sxxo7E6KfucDy3ZRg7XspUmH70nbffK6FVweO6x1QRt5jO3iIspKfb9tnBam/TSiG5L/
         6WQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787562877; x=1788167677;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UeBCWVbEudvEl41PR+joNkWxWngRqSWwRQTBI46CPOQ=;
        b=WAAgoJhnPNK2OIwoxH9S4D8o8tJEYQwYz/PMWBnLmzBURSAtVt+MwiM3DAJ58DI1/2
         jA2osAPE2QRq+RKA9T8P5Bfa8zpfVhbdPfMke1JHkttK22JOPnsGHC4swgezhcNosdmU
         y95mfv2Na4BAqprrkk5NCm1zsK3vyeg1C2266z2SyRshCLzHaTLKl7jSS0oaBAELFo60
         dPkvcIouSsdHMZwIkMAm9D3Zo5wed+116cOvEXFjQhPrmdXvjuu9OHg/8ck9NoLZb9nF
         e1sVqeH5dCkrkbe33ilAjwVYJdV7hHaLFld1h7PPy/HsyyojgJPnKrkefmEt5Wxxdi9F
         VAhw==
X-Forwarded-Encrypted: i=1; AHgh+RreTWrSbEBhXvVRJVmVD0L/BmesIosr300+w0yx0oh3t+3Rvvb1WBl8uNNTn0N7rP9Mne/eRSNuB8g=@vger.kernel.org
X-Gm-Message-State: AFuF++lnIXGgrM+7rzbMj09XlAN1yTMwHX2dPNYKZj8Bwvn5C2mVzJle
	XQnBZMrYeX4DUvnVLGVRjep1NVWKr2UTStE+1wurmhyPPrzR7PHSmkENzqghb0Gx2vw=
X-Gm-Gg: AR+sD10xJVfDjxYoKxu8f996K/oJ6WXcaUJVvZGw6QOJsYs6rtKAqUz0DmG4DqZ+JS0
	3eiMs0pPgv4t9FZjnZd+qIs7S8yDLNTB2WL8QW2knnLf3A+uygkj1YlZL2U7d4aBTJkuFe2Vc2b
	2tCWsCzAW0haCCzIFrwEu3lJFtGRiV0NnY9TFBillB1BxvBjhMlRrpCqHNwlrYQjnS+RvMT6uJC
	y2UeoOjMrmXfZbjUBVMJT9GYW824zGDG0VMiGMfwKG1RDThZhpLna8jsII/WKrXVhwq8t6gzfBN
	O1S5tKz/EfYcAh5+NpMkTR6ABELyQU6+1Jf8HqsYo5jr85seK+I5ywxEJvEyqF/zKFzxBP19rCM
	NNrVpHPq7nbmWGvDVh86K2e07m3T8LR4ZrFQ+SlOcO2RyQxj/mXdZOCmi/p8EOlagK8uzNx4hGY
	QUwPF3jJy4nt9EV+lrPBHKFHZAsn7DDrX0iSDT/DA1bzKFVgXvVoyUe7kKNVst3Pzzdvoq0xRr8
	v8+w1fl9P49rC9iUNeWV8E=
X-Received: by 2002:a05:6a00:1d8f:b0:84f:a7bf:8fb9 with SMTP id d2e1a72fcca58-8520b9c6cfemr29972177b3a.3.1787562877515;
        Mon, 24 Aug 2026 02:14:37 -0700 (PDT)
Received: from smtpclient.apple ([2001:569:7376:ff00:b4d9:d700:848d:c08f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8520eed2293sm1628001b3a.2.2026.08.24.02.14.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Aug 2026 02:14:36 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [PATCH] can: usb: f81604: fix struct f81604_int_data size
 mismatch
From: "Dynetrex, Admin" <admin@dynetrex.com>
In-Reply-To: <2026082433-dynamic-overspend-8f32@gregkh>
Date: Mon, 24 Aug 2026 02:14:26 -0700
Cc: =?utf-8?B?UFMxMCBQRVRFUiBIT05HIOa0que5vOa+pA==?= <peter_hong@fintek.com.tw>,
 mkl@pengutronix.de,
 mailhol@kernel.org,
 linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <597D8628-7241-47FA-B692-FEB66360EF3D@dynetrex.com>
References: <20260824082758.9118-1-peter_hong@fintek.com.tw>
 <2026082433-dynamic-overspend-8f32@gregkh>
To: Greg KH <gregkh@linuxfoundation.org>
X-Mailer: Apple Mail (2.3774.300.61.1.2)

Hey Greg,=20

This issue was reported by me about a month and a half ago, however, I =
did not have an environment setup for kernel development in order to =
submit a patch.

I appreciate Peter taking a look at this.

Kind Regards,
Alex

> On Aug 24, 2026, at 2:08=E2=80=AFAM, Greg KH =
<gregkh@linuxfoundation.org> wrote:
>=20
> On Mon, Aug 24, 2026 at 04:27:58PM +0800, PS10 PETER HONG =E6=B4=AA=E7=B9=
=BC=E6=BE=A4 wrote:
>> The struct f81604_int_data defines 9 bytes of interrupt data:
>> - Byte 0: Status register (sr)
>> - Byte 1: Interrupt register (isrc)
>> - Byte 2: Interrupt enable register (ier)
>> - Byte 3: Arbitration lost capture (alc)
>> - Byte 4: Error code capture (ecc)
>> - Byte 5: Error warning limit register (ewlr)
>> - Byte 6: RX error counter (rxerr)
>> - Byte 7: TX error counter (txerr)
>> - Byte 8: Reserved (val)
>>=20
>> The hardware sends exactly 9 bytes for the interrupt endpoint.
>> However, the struct was defined with __aligned(4) attribute which
>> caused the compiler to pad the struct to 12 bytes.
>>=20
>> This causes a problem in f81604_read_int_callback() where the short
>> URB check compares urb->actual_length against sizeof(*data). When
>> sizeof(struct f81604_int_data) is 12 but the hardware only sends 9
>> bytes, the check fails and valid interrupt messages are discarded.
>>=20
>> This results in the driver only being able to transmit once because
>> the TX complete interrupt is never processed.
>>=20
>> Fix this by removing the __aligned(4) attribute so the struct size
>> matches the actual hardware data size of 9 bytes.
>>=20
>> Fixes: 88da17436973 ("can: usb: f81604: add Fintek F81604 support")
>> Fixes: 7299b1b39a25 ("can: usb: f81604: handle short interrupt urb =
messages properly")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Ji-Ze Hong (Peter Hong) <peter_hong@fintek.com.tw>
>=20
> Nit, doesn't match the From: line :(
>=20
> Also, the first Fixes: tag isn't correct, it's the second one that
> matters.
>=20
> And wasn't this reported by someone already:
> 	=
https://lore.kernel.org/r/A3834A07-5639-4779-844F-C5843DFC3928@dynetrex.co=
m
> ?
>=20
> And yes, this patch does look correct.
>=20
> thanks,
>=20
> greg k-h

