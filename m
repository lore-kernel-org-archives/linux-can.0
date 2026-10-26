Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793027053;
	b=np9+fau5Cx6z3mEOHcA9jgzugSIp3ANRVyoVDPhb5tmOLAuve6pqaO7oiZk+zyWBgg66
	 X0Af8kOImUzdTxqeqBIXPmOHmSzNtYBB1+q8UhoSGBdu8Kvdqz1tTKZ6Zo7YoehJtGgVH
	 o5d7tDTrfIOyJf5e55wCUWDTtCBWHlgbHOfhcO8itlZ3LIEwLA1or6RT6PLchX9E1+LU1
	 r7j0/HnPIoL2bZH+gmjeNSrgeGCxW5fDoez0oJ1BZPcZULj1jD0cdFF+xcQsRkAe7LcBC
	 AtQNlE5KFWyU7q1THTBmg3mVud2LK5U5LTlUwAri/3kZehqxrMvph9mrYMSxuTRzbNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793027053;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:From:To:Cc:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=6hz5uza8UCAu1Jf83s707Rg61KRs8PkOBOl6V9Iw00E=;
	b=4qzx6HTlPRFZZ/G6T1ShSR8VX7y6zW+R5l1hQe/0fehX/PgkSuBOuNTF48y85A2PkKkm
	 FlGy7erBEyrRNNEICVc+JHxQp2mpcMH2BcvjxvxnZO3a2xf9rZ28f6XltZ1PqRpusuqZJ
	 J5iKqNlF3Dl5K0n5K8GARhaCfpNIald8d6K6sCm0+KmW9iNI9dnqT9j683wkPomSxo26E
	 gx8I6kzsZKO41MZXfXNdqSGrmaGSlqjdwhrCg8KB7e7fLsC07ZgpT3OUJkclxUuzV6j75
	 GloZLyoTAxIllzz0oJ9hjYefITHMYzFeTWIzAxnIhdWe4FgIWdMk5dVCw3yjlW+/4SA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nabladev.com;
	spf=pass smtp.mailfrom=nabladev.com;
	dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=QAD8j98g;
	arc=none smtp.remote-ip=178.251.229.89
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DCF606A31A;
	Mon, 26 Oct 2026 15:04:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56DCF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=QAD8j98g
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 08B66109697;
	Mon, 26 Oct 2026 16:04:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1793027046;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=6hz5uza8UCAu1Jf83s707Rg61KRs8PkOBOl6V9Iw00E=;
	b=QAD8j98ggHzcW8yd8J1Ifh5uWQm69X822XjTfFT0rPzwR0ZNiYPNci8OXcst+l9ZbNbAqR
	Ywd+teA3k/qiJidFn9pnBtGSWLvBxZl6/OvVlrE0p/t9+FTjQSQ4+YwdHF3s5vKUGjKnqX
	oHP0Lp+fIcAI74SaVEFixa2ywzeuCacVYk8ezV/mzRt3XkNKgKl4z2kVVN7zeMoQkKqPZQ
	9xe9jU3Kgy8c37lQBnUyTyfF2jUvMqrriJvfT7vL2TcP7CQJDA02v2fm0bEYxS/sE+2Rf9
	FZi4imAAafJd6yU6c+LzHzwf0aaESkeXSRv67TUiblMEXtlkBC/jItlbjoGwOA==
Message-ID: <eca44457-d3d3-4732-977d-d30a408b7b66@nabladev.com>
Date: Mon, 26 Oct 2026 16:04:02 +0100
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] arm64: dts: imx95: Add support for Data Modul
 i.MX95 eDM SBC
From: Marek Vasut <marex@nabladev.com>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,
 linux-arm-kernel@lists.infradead.org, Aswath Govindraju
 <a-govindraju@ti.com>, Conor Dooley <conor+dt@kernel.org>,
 Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org, imx@lists.linux.dev, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260928204741.175754-1-marex@nabladev.com>
 <20260928204741.175754-3-marex@nabladev.com> <arvPDq8sjjv7na01@SMW015318>
 <49303872-5622-4e1d-8e1a-01394ec29367@nabladev.com>
 <20260930174413.GA2463938@francesco-nb> <ar1bhpji35CbArtY@SMW015318>
 <17f240e5-9c65-4562-ba51-535b0c69c5fd@nabladev.com>
 <ar19W4wX07p8u3_5@lizhi-Precision-Tower-5810>
 <4efdcea6-a099-46a6-8d07-dd5c583b962a@nabladev.com>
Content-Language: en-US
In-Reply-To: <4efdcea6-a099-46a6-8d07-dd5c583b962a@nabladev.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 9/30/26 11:49 PM, Marek Vasut wrote:

Hello Frank,

>>>> So I suggest remove it now and add it when need.
>>> Can we please go with consistency between these boards from one vendor ?
>>
>> Yes, I am keeping consistency, then ask remove it. I applied alex's v2
>> version. I put v1 link to show krzy's concern.
>>
>> https://lore.kernel.org/imx/20260319125013.2421621-3- 
>> alexander.stein@ew.tq-group.com/
>>
>> Changes in v2:
>> * Changed commit message to imperative form
>> * Remove (currently unused) display and backlight nodes
> I sent you a V6 with those nodes removed.

Have you had a chance to handle the V6 ?

Thank you !
