Received: from out203-205-221-164.mail.qq.com (out203-205-221-164.mail.qq.com [203.205.221.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DA343A80C;
	Thu, 30 Jul 2026 14:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785420296; cv=none; b=o74luMppjgnqRaELRbrmnCQiXOQNC0JnZBGeWzByTlmzaE6Aw9Bp0A/Htu5NQoSVZMJZYSakCLcCYUlMJ+sN+p/qOjMlP0KVzFu3Kzby2Fr1GPOcHThtHc07qZ47I8f1HjplwVT5JaQ1K6v6w4mKOIkolhaO0hYi4saA88+wBx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785420296; c=relaxed/simple;
	bh=tGTkNpzchZNpj9HV/ywwb5I5HWM8o4egLfUtXR/eyws=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=qu1ZXMVaEHKurulk11uLvSnBiqxRM+fgH7sVfDXMNOHjFlzra7t0JZ7oFhcWGSTO8E0SHTOnFvHgOTeC/F9WC/1WZh6GRBw91Q+lyhd557GjqwRX0+7lVwx3rzie1+FNsZvFfTXs0w/mSh/km/41aodAtGEeFRHo3xopaydeZjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=k4Rkd8v5; arc=none smtp.client-ip=203.205.221.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="k4Rkd8v5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1785420285; bh=tGTkNpzchZNpj9HV/ywwb5I5HWM8o4egLfUtXR/eyws=;
	h=From:To:Cc:Subject:Date:References:In-Reply-To;
	b=k4Rkd8v5CBpNWsHys2gIx7tEERm/Gg2BZm6q6Q9XXLbVLW/O08S9tD+I2YavdOcUD
	 LYNHIAU6PG0tGn9BBCyr166QNRNvZvqHMeEYxl8gV3FOIsjMQOdH/4ncpbuT/t8/S3
	 Dp1wPH1cGn2x42uHEHHHA3efA0eQoj0jwtE+11aw=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-XMAILINFO: OSDxAxedUaWCj2nTIt4SlIaffdcH5TQCRrGH0D8KpcaLyWVb1AwgKVCVXs2DWK
	 LNtUkzL9ckzg8n/vwGTDh37CuOMJ/jk8m5P2ov6ji0h8i0yEPAD6g8f13u6Wzvf8NQWblMCL6tdi8
	 n84Y8Gd93c6wwHxiY2CzcTWxSFpNxquPtjltH5Gohg78FP8n2Rgses0ZLPqL+q1jBmr4BUGRRWLoJ
	 mzgRxKscnUWbxpcbn90kGBkb8Zk4nJEs9avZKYXhgZ40ZW3D6TNOdTT0iHsTcVifVYbgKcEkwwxsi
	 XVASX+rDPXebyz8IBUKXCDZrgCTDTXsx/RsXySzy16SymfY2jx/UuPWOhpcFLmkjk5rHciEsLMV32
	 GlsyqsInI/qWW+vp5H3gPDkqmQcMOpqwSCY0tO5mpzeDFr74EmfKcCjnBQG8PDP5pwpTdwxRm1gQn
	 IFxpqjvHYIOiImt4hWSx3Cicy4n7csvilLZDluDJIozh1MPeazckTOZvaTWi+1ApHoWAeXUTX1yGy
	 mXtwgxV5S52elwF8LB5VUw9AjdSlcvI7bcDD6QURAcB87LS4+vaoa+eT557/Ytw+7yf5i5m2aGKXd
	 OJcssUEls/O2bkeVxtHV0SIqwQ0KCDKzj1Bxhmz+WbArbmARae7VtMQtTyrkeTZuNNHqng7pioyRY
	 Q26hUwSyXzU6RQyZnYoWfS/Xgu0G5AjrAiBno6ow+d1FRZnmI05yA9uj/yX04MS3HCso5Hr480RX3
	 iFx6FDfaGiUZJ4bCZRgw4wJMK7iYXxOo6LAsYriEOg0nVcdNmqfqMgnDg0FzvXLxb7sOYcuHPTYt+
	 1jz/U2htRblg2PcEVv54uyluXpuCBQfzZp2IRSWKaG6miMeP2sAtZYSu5V/34MSg9AbfxxqGvCBT6
	 V7aoav8ab4frjDX4Zg8Zjs42YbdzPme6ruHELpPa9dlB2XegZjQ9DxJCoKA57zh2gwGn1tHa/8OSv
	 mUcin/yiwLi889aRRZonur5oBq8pv8DnHV8CC8LQUTA7Hb1X2GPnsBQGD1VrIKZzbVIXcDBSQseUc
	 7Tn2yI4ueKfxmtSocjSKhS0ut9haSKXoBYqzznJ/1nIhbHa8z51U+xFdNBfQr6fNBT2q1XzWMHrrl
	 TcdV4PWUzIr3nQ==
From: "=?utf-8?B?Q3VuaGFvIEx1?=" <1579567540@qq.com>
To: "=?utf-8?B?UXVlbnRpbiBTY2h1bHo=?=" <quentin.schulz@cherry.de>, "=?utf-8?B?TWFyYyBLbGVpbmUtQnVkZGU=?=" <mkl@pengutronix.de>, "=?utf-8?B?a2VybmVs?=" <kernel@pengutronix.de>, "=?utf-8?B?VmluY2VudCBNYWlsaG9s?=" <mailhol@kernel.org>, "=?utf-8?B?Um9iIEhlcnJpbmc=?=" <robh@kernel.org>, "=?utf-8?B?S3J6eXN6dG9mIEtvemxvd3NraQ==?=" <krzk+dt@kernel.org>, "=?utf-8?B?Q29ub3IgRG9vbGV5?=" <conor+dt@kernel.org>, "=?utf-8?B?SGVpa28gU3R1ZWJuZXI=?=" <heiko@sntech.de>
Cc: "=?utf-8?B?bGludXgtY2Fu?=" <linux-can@vger.kernel.org>, "=?utf-8?B?ZGV2aWNldHJlZQ==?=" <devicetree@vger.kernel.org>, "=?utf-8?B?bGludXgtYXJtLWtlcm5lbA==?=" <linux-arm-kernel@lists.infradead.org>, "=?utf-8?B?bGludXgtcm9ja2NoaXA=?=" <linux-rockchip@lists.infradead.org>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>, "=?utf-8?B?SGVpa28gU3R1ZWJuZXI=?=" <heiko.stuebner@cherry.de>
Subject: Re: [PATCH v5 4/4] arm64: dts: rockchip: Enable CAN controller on RK3588-Tiger-Haikou
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Thu, 30 Jul 2026 22:04:43 +0800
X-Priority: 3
Message-ID: <tencent_34D00CC80826788DD404902246F9ED36E10A@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20260725-master-v5-0-75da459d2b93@qq.com>
 <tencent_8E35228F9F4F133FCDBCCC4902F6887D0006@qq.com>
	<7628bc49-b4e7-4716-9579-022c20bbf134@cherry.de>
In-Reply-To: <7628bc49-b4e7-4716-9579-022c20bbf134@cherry.de>
X-QQ-mid: xmsezb41-0t1785420283tmh58ymmo

SGkgUXVlbnRpbiwKCj4gQ2FuIHlvdSBwbGVhc2UgbW92ZSB0aGUgYXNzaWduZWQtY2xvY2tz
KiBwcm9wZXJ0aWVzIHRvIHJrMzU4OC10aWdlci5kdHNpCj4gaW5zdGVhZD8gUkszNTg4IFRp
Z2VyIGlzIGEgU09NIGFuZCBIYWlrb3UgaXMgYSBjYXJyaWVyYm9hcmQuIFRoZQo+IGNhcnJp
ZXJib2FyZCB0YWtlcyB0aGUgc2lnbmFsIGRpcmVjdGx5IGZyb20gdGhlIFNvQyBhbmQgcm91
dGUgdGhvc2UgdG8gYQo+IHRyYW5zY2VpdmVyLiBJJ20gYXNzdW1pbmcgYWxsIGNhcnJpZXJi
b2FyZHMgZm9yIFRpZ2VyIHdpbGwgbmVlZCB0aG9zZQo+IHR3byBwcm9wZXJ0aWVzLCBzbyBi
ZXR0ZXIgaGF2ZSB0aGVtIGluIHRoZSBTb00gRFRTSS4KPgo+IG9uIHRvcCBvZiB0aGlzIHBh
dGNoIGFuZCBzcXVhc2ggYW5kIHdlJ2xsIGhhdmUgd2hhdCBJIHdvdWxkIGxpa2UgdG8gaGF2
ZS4KPgo+IElmIHRoZXJlJ3Mgbm8gbmVlZCBmb3IgYSB2NiwgSSdtIGFzc3VtaW5nIEhlaWtv
IGNhbiBzaW1wbHkgZml4IHRoYXQgd2hlbgo+IGFwcGx5aW5nIGFuZCB0aHVzIHRoZXJlIG1h
eSBiZSBubyBuZWVkIHRvIHNlbmQgYSB2NiBqdXN0IGZvciB0aGF0IChidXQKPiBpZiB5b3Ug
bmVlZCB0byBzZW5kIGEgdjYsIHBsZWFzZSBjb25zaWRlciBkb2luZyB0aGUgc3VnZ2VzdGVk
IGNoYW5nZXMKPiBhYm92ZSkuCgpJIHdpbGwgbW92ZSB0aGUgYXNzaWduZWQtY2xvY2tzIGFu
ZCBhc3NpZ25lZC1jbG9jay1yYXRlcyBwcm9wZXJ0aWVzIHRvCnJrMzU4OC10aWdlci5kdHNp
LiBJIGFtIHByZXBhcmluZyB2NiBub3cgYW5kIHdpbGwgcG9zdCBpdApzaG9ydGx5IHdpdGgg
dGhlc2UgY2hhbmdlcy4KClRoYW5rcywKQ3VuaGFv

