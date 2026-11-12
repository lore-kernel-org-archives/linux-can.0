Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.87
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794475082;
	b=Zoh9LdGmhuqaQLaPmJ1rT/Hvks0NdvASajbgLT34bTOZ+MlWZmBuIYkh/seOXRdi6P09
	 xH8fbDu7NruoHGkzFnFHlHR0GmZqSK98WdF78hVvxI67Xo6o8iFb3LQrHW6KMBGn6XbXL
	 miAm1KxP6l1GQxhbsgN6i9VMUn7TuhDshNyNGya3A2DXCVqoC14jAg4eEdCJ46edcfpXE
	 ROxHvRlxAIyWbwfIXIB492E0x2otI5/9fZmJZ1cUfrtWK4bgGVC4EBHaMV+Bn9pbiAipo
	 EFDJgErscrCiPb6LUfiGaAY7fvfISLdULB+RzotbdCsiDCXAqXf7LgpTIdLnJT2fKQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794475082;
	h=DMARC-Filter:DKIM-Signature:X-QQ-XMRINFO:X-QQ-XMAILINFO:From:To:Cc:
	 Subject:Mime-Version:Content-Type:Content-Transfer-Encoding:Date:
	 X-Priority:Message-ID:X-QQ-MIME:X-Mailer:X-QQ-Mailer:References:
	 In-Reply-To:X-QQ-mid;
	bh=FxECJ+at7tUmdA4jpirQioDBaofqfSHvgn+uUGiUknw=;
	b=a/alDLprmPEqJR2GCPeD4CxnS/zR+A5X4lKCiYxN0nmHWURX4rz4TudkeTJ19jVScQt3
	 daPc3mE2OkUBwGOStQhhu0+nrXOPWM+bAZ+gz/SEpEYxpPzuOPDQdt55+NVpqKoxjupDx
	 E7mtXRZWFVamUInIpsIKm7QHde5eAohPj0r9uZt2LqWOjZi3uRA/M4k/WM2ZGPbnjI1Cc
	 molQ2/iKbyyrMy8fMJ6yl1vkFgdim60d4lflBhWOE4MHlRgPfjw0LIc+5O0sTLtuu9CB1
	 XNWz3YO+HIkSpOX/U/jdeW79zb+4vGJZy77oTNRhNXrhBQEzEbaZeoLp9YZkws7Y7Tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=qLeW0Xau;
	arc=none smtp.remote-ip=162.62.57.87
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AF4606A321;
	Thu, 12 Nov 2026 09:18:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2AF4606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=qLeW0Xau
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794475071; bh=FxECJ+at7tUmdA4jpirQioDBaofqfSHvgn+uUGiUknw=;
	h=From:To:Cc:Subject:Date:References:In-Reply-To;
	b=qLeW0XauRtiEoT2dbWAjBO2gfFyDL+LHJV7vq0XUbVPRvPsVXOaBtCZzssuNRrLHr
	 JnJ3QNxc0yLlR51F+YICuoRLe07rF0Fh2ysJmaFLfqusLGXoPDITzmhDAdkLQ0PwF0
	 fmTRDxIfTmoMXoXuzT64gTu2HG9v4h7ZlwsdJSwc=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-XMAILINFO: N2nZekq4carkcWSgLcJAY8XpK+xVtIIJ0Wzo/gyWOBR9I2B/I5Eu15r0GdMhWU
	 /0KGhzB4wIVlpqNusptcHGTNasQzVmH4xSUQzb+69ogv+JRxpFqmCnzfCKJO+w7B94VvjmcyhuG9a
	 MK80C+/qCZFMWIMIg+g2Haqm8FlLgJ4EUTXPAeP8vS6A4MKD36mFUEsVvt8JfLwwn9gxWGLuDlW4a
	 28KcfPDhxHRsZOr6x9SYV1qVxe2puaPVgNUM6+/MDudauksb05OP7no9K0svZmn+vS4Ut8PY7mT0H
	 w+7dWHZZzHTh9mXKLtfgVlefWqnA/wigeSYPb6S09fD9yCUVSuCHpahAdViqVxjia8b3EwFCXTNou
	 jmeyUz5oWZpk1bEhiPrcTBan6wUtNIJFVNnrU8BnOR8OdnAvJ7VGiNcyZtcYR3uemNDMefz5HPFqA
	 r3nmmZ1quH6EFqAZgVkZNs3rPDX0G6iekzNNBmfxY92ejI6C/adNs13b6zIdg0kmdGFvvE02fijuy
	 WBxpIISuk9dFSL6alMizHmZ+OnOMRJMs/7SvviNfkv8lPzQT6y9dA9AlcTK7nYNl5kI/LwZa0kvh7
	 ZEGj+qhzC2Gm6KkJP5JyQ9aO7lc0WAZH3IEzX11V/TbK+KLrWWVRpweM0IqqW5e+9u7Yn1ng+17eZ
	 YLan45g7yyWRkw4jLdxbDQy8vZ5cUiH0jpeD0tPf4YCrFvjnz/T8Ac73SKdE6+g1uwX4BNsarFrUI
	 +7UKfHBXcB+BJYCFM4S/ic9Iy13FwtqLonCqG+4F0685JAr8fYRh1GoYRRKmb2bQS91LbJMjvETqX
	 oeDeZa7ggPFqBdffEKHGh9Vw3yNH13GQ1BgzeqXlINK8v4HV+IYSWDbQEPIQWVHzgDy+GWDUVOPfg
	 R+7C4t7jMrhkflBt5rGaHTSeVG1JZpGfgHVje3ucqPXMHRepw7aH6AbEki0rxW6Rx0YuZ/dw/Pm6A
	 hPofonKmUVHor6ZyA6Rkjg3scLiQ3U5XVlKSU/27pAAQd1DT2EpbDj74XcSZ0jJcHCkwa891Z0DwS
	 KiBYhDnwC1AJ26xL25zu6LONplvnMM3Zhxd7l5CDUdScWmf4IVHSXuhAHTQ==
From: "=?utf-8?B?Q3VuaGFvIEx1?=" <1579567540@qq.com>
To: "=?utf-8?B?TWFyYyBLbGVpbmUtQnVkZGU=?=" <mkl@pengutronix.de>
Cc: "=?utf-8?B?SmFrdWIgS2ljaW5za2k=?=" <kuba@kernel.org>, "=?utf-8?B?bmV0ZGV2?=" <netdev@vger.kernel.org>, "=?utf-8?B?ZGF2ZW0=?=" <davem@davemloft.net>, "=?utf-8?B?ZWR1bWF6ZXQ=?=" <edumazet@kernel.org>, "=?utf-8?B?cGFiZW5p?=" <pabeni@redhat.com>, "=?utf-8?B?aG9ybXM=?=" <horms@kernel.org>, "=?utf-8?B?bWFpbGhvbA==?=" <mailhol@kernel.org>, "=?utf-8?B?c29ja2V0Y2Fu?=" <socketcan@hartkopp.net>, "=?utf-8?B?cm9iaW4=?=" <robin@protonic.nl>, "=?utf-8?B?by5yZW1wZWw=?=" <o.rempel@pengutronix.de>, "=?utf-8?B?a2VybmVs?=" <kernel@pengutronix.de>, "=?utf-8?B?bWF4?=" <max@enpas.org>, "=?utf-8?B?bGludXgtY2Fu?=" <linux-can@vger.kernel.org>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] MAINTAINERS: exclude CAN documentation from general networking
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Thu, 12 Nov 2026 17:17:49 +0800
X-Priority: 3
Message-ID: <tencent_FD28A290DF67931DCD970C5042E788514006@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20261112-exclude-can-docs-from-netdev-v1-1-b5eb3ba4ae86@qq.com>
	<20261112-polite-nano-peccary-fdf491-mkl@pengutronix.de>
In-Reply-To: <20261112-polite-nano-peccary-fdf491-mkl@pengutronix.de>
X-QQ-mid: xmsezb41-0t1794475069t1av64kev

SGkgTWFyYywKCj4gPsKgZGlmZsKgLS1naXTCoGEvTUFJTlRBSU5FUlPCoGIvTUFJTlRBSU5F
UlMKPiA+wqBpbmRleMKgMjIyYjdmYzJjM2FhLi5jYjFmZWM4ZWM1ZjXCoDEwMDY0NAo+ID7C
oC0tLcKgYS9NQUlOVEFJTkVSUwo+ID7CoCsrK8KgYi9NQUlOVEFJTkVSUwo+ID7CoEBAwqAt
MTk2MDAsNsKgKzE5NjAwLDEwwqBAQMKgRjogc2FtcGxlcy9wa3RnZW4vCj4gPsKgwqBGOiB0
b29scy9uZXQvCj4gPsKgwqBGOiB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9uZXQvCj4gPsKg
wqBYOiBEb2N1bWVudGF0aW9uL25ldHdvcmtpbmcvYmF0bWFuLWFkdi5yc3QKPiA+wqArWDog
RG9jdW1lbnRhdGlvbi9uZXR3b3JraW5nL2Nhbi5yc3QKPiA+wqArWDogRG9jdW1lbnRhdGlv
bi9uZXR3b3JraW5nL2RldmljZV9kcml2ZXJzL2Nhbi9jYW4zMjcucnN0Cj4KPiBXaHnCoG5v
dMKgZXhjbHVkZcKgdGhlwqB3aGlsZcKgImNhbiLCoHN1YmRpcj8KClN1cmUsIEknbGwgZXhj
bHVkZSB0aGUgd2hvbGUgRG9jdW1lbnRhdGlvbi9uZXR3b3JraW5nL2RldmljZV9kcml2ZXJz
L2Nhbi8KZGlyZWN0b3J5IGluIHYyLgoKSSB3YXNuJ3Qgc3VyZSBhdCBmaXJzdCB3aGV0aGVy
IHRoZSB3aG9sZSBkaXJlY3Rvcnkgc2hvdWxkIGJlIGV4Y2x1ZGVkLApzbyBJIHRvb2sgYSBj
b25zZXJ2YXRpdmUgYXBwcm9hY2ggYW5kIG9ubHkgY2hhbmdlZCB0aGUgZW50cmllcyB3aGVy
ZQpJIGhhZCBjb25maXJtZWQgdGhlIGlzc3VlLgoKQmVzdCByZWdhcmRzLApDdW5oYW8gTHUK
Cg==

