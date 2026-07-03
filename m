Received: from out203-205-221-191.mail.qq.com (out203-205-221-191.mail.qq.com [203.205.221.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838CC2749DF;
	Fri,  3 Jul 2026 14:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783090425; cv=none; b=dThQD53PJZwq3IlQFLzaOcjkEuUpe2oaV5g3UfEIiXwva0dCInUe1NTl2zJTN0PeVbdio2qaiTWW02ZBaBj2A/sdZefDnU9/tKvYxvxiqXEeUETes+DK/LSRfG9Lu9Ipj+he+J0xTfxCwGy/wEVTKMkAc+d94uz9kRF3cl/d7aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783090425; c=relaxed/simple;
	bh=CS+Gi0WzooNXpSduprgHt/xrr1DtrJS76eULUS0BXDQ=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=jPPxQkpT3LpzsioEPN2iTcPOLVJHvQUhxxl7v4QZiauddAsChZh52v/mFafwFt5bEBCsP8ucmlKhVEtr46F6s+T9th0+MqKoF76XAIw8FunK16O3gNauxoUfVeDZRioWMKyAy8DzdJpTsvElN5IGGWCWO3pXOfjPYMFUwUL2KbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=RFUvHBE4; arc=none smtp.client-ip=203.205.221.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="RFUvHBE4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1783090414; bh=CS+Gi0WzooNXpSduprgHt/xrr1DtrJS76eULUS0BXDQ=;
	h=From:To:Cc:Subject:Date:References:In-Reply-To;
	b=RFUvHBE4N9iYueVnB+VpEFRtFe/ziWz9QNBZKs9PSqkdgFeWYniZfXlLnBcmr46Db
	 NJofz0P4wpKmvBTQvKJhqfF8UWLI0wSZXLCEL1FxsfNDivvEZ3AxzDuqokiP1TwDCB
	 Op5nGHm7nRJHg7D98g5E2g1lo235DRO3f0XaG7Ng=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-XMAILINFO: OImhmUSEbAWcT2IHWW/hjuPTBpK4RrQqRf2cBNo/s1dnpGT3F5w5IHksEzAmKP
	 6ZFzYKPMq4B8CxWmN6Uj23da3mQ7AFQqyLRF7jWMIM0F6SEmWPhxipgperIpZlGtuWCHd7xIBiwPp
	 JM8wwprDpf2Re5QKhuDnd/ay+Au+T4tKL+NcvuZrhSWXWbkqVKhff1X2Ts/LRF3T0SA3GE7juYFxS
	 9ZSHzuOLgTv5YloTkoeNB0LFvDWEUz4D1POnNUfPEjmHKKRUViR/TkpzYTgvexR3Fp8bJN9SCchf5
	 U60no2JyJCtDSW366HdHi+JwAA/1Bn4DGhixWVijxhZAcdcgZe98o+59fP0wxP765ME/xy7VkSza6
	 Xu7MXSFfxqP4JoMGkXYoVcC42Cn53vYWfojqS9cp7je2dnXwLtlMuREsPpn3eeyRBnsESGgsswhos
	 q1uAHYwqTpVjXHfFZ2YYXCnGweh5eIbwzmbg8HvW2oCsNwPuubRWrIaHerftu45klQVJ+nWpduhUF
	 /KS34Tep6B10qqgjECkPp6zWiLR1JmHYQP0cRF36Sovdzvgqfc0ChNnCb5inE9Z7s2ZtIyBfXCIzR
	 B0/Jqp/p0+cGkJpOwxb9N46KcD+1pEmCVBbe1luZJb0yVZSbg9QyIn6IkQOWyTWrDvRRXjSvETk9x
	 DM+drrBchaPXqFik96c/Eqc7erMELDBHwApMdW/Zl1Y6YSGRJdXp0bldK2HUF2boaM6TaeIVy5r9t
	 d/MrRoOIZ/XrzTGhSxcva5pihBOjHoHX0VU0F6Z22ZxvViFsPiszZXCoDGZ/QrMyKKJmb20Y72SDI
	 yyFh1c9NN41u1yMZzyq3JwvX74FGHJL3xQxRRG+4jKPlPVmWqcNNeG6vy36OPtKkDtTivJ4jXx+YB
	 hrpoBXWB1kdUZJKNLUetSs6xz7evYwIvWkhgoCEX1gyJ2iHLVqOJegRRGV3LrntBGtcoav8QOFWvh
	 dK4FNW5WGkKrSpr83gkyegxLQglNfToc4ij2eke8fC93fBsOzCHxiZodRjwfNbXdBmYcORAS/ZauM
	 bfRAR3Y3JO+2vQp0RYg1Zpz+Tcj5YHezR6TCb/jItwJgGGSk=
From: "=?utf-8?B?Q3VuaGFvIEx1?=" <1579567540@qq.com>
To: "=?utf-8?B?UXVlbnRpbiBTY2h1bHo=?=" <quentin.schulz@cherry.de>, "=?utf-8?B?TWFyYyBLbGVpbmUtQnVkZGU=?=" <mkl@pengutronix.de>, "=?utf-8?B?a2VybmVs?=" <kernel@pengutronix.de>, "=?utf-8?B?VmluY2VudCBNYWlsaG9s?=" <mailhol@kernel.org>, "=?utf-8?B?Um9iIEhlcnJpbmc=?=" <robh@kernel.org>, "=?utf-8?B?S3J6eXN6dG9mIEtvemxvd3NraQ==?=" <krzk+dt@kernel.org>, "=?utf-8?B?Q29ub3IgRG9vbGV5?=" <conor+dt@kernel.org>, "=?utf-8?B?SGVpa28gU3R1ZWJuZXI=?=" <heiko@sntech.de>
Cc: "=?utf-8?B?bGludXgtY2Fu?=" <linux-can@vger.kernel.org>, "=?utf-8?B?ZGV2aWNldHJlZQ==?=" <devicetree@vger.kernel.org>, "=?utf-8?B?bGludXgtYXJtLWtlcm5lbA==?=" <linux-arm-kernel@lists.infradead.org>, "=?utf-8?B?bGludXgtcm9ja2NoaXA=?=" <linux-rockchip@lists.infradead.org>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>, "=?utf-8?B?SGVpa28gU3R1ZWJuZXI=?=" <heiko.stuebner@cherry.de>
Subject: Re: [PATCH v4 3/4] arm64: dts: rockchip: add CAN-FD nodes for RK3588
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Fri, 3 Jul 2026 22:53:32 +0800
X-Priority: 3
Message-ID: <tencent_6D8030C4363FF6A6191A0C19F384BE91BE07@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20260703-master-v4-0-47d40bbf5fda@qq.com>
 <tencent_48121342466E02301067FDB89BEA68886509@qq.com>
	<8c5be502-c520-42f5-9f2b-c49c04e99f6a@cherry.de>
In-Reply-To: <8c5be502-c520-42f5-9f2b-c49c04e99f6a@cherry.de>
X-QQ-mid: xmsezb41-0t1783090412tldcxqjes

SGkgUXVlbnRpbiwKCgo+wqA+wqBEZXNjcmliZcKgdGhlwqB0aHJlZcKgQ0FOLUZEwqBjb250
cm9sbGVyc8KgaW50ZWdyYXRlZMKgaW7CoFJLMzU4OMKgaW7CoHRoZcKgYmFzZQo+wqA+wqBT
b0PCoC5kdHNpLgo+wqA+Cj7CoD7CoEFkZMKgQ0FOMCzCoENBTjHCoGFuZMKgQ0FOMsKgbm9k
ZXPCoHdpdGjCoHRoZWlywqByZWdpc3RlcsKgcmFuZ2VzLMKgaW50ZXJydXB0cywKPsKgPsKg
Y2xvY2tzwqBhbmTCoHJlc2V0cyzCoGFuZMKga2VlcMKgdGhlbcKgZGlzYWJsZWTCoGJ5wqBk
ZWZhdWx0wqBzb8KgYm9hcmTCoERUU8KgZmlsZXMKPsKgPsKgY2FuwqBlbmFibGXCoHRoZW3C
oGFzwqBuZWVkZWQuCj4KPsKgUmV2aWV3ZWQtYnk6wqBRdWVudGluwqBTY2h1bHrCoDxxdWVu
dGluLnNjaHVsekBjaGVycnkuZGU+CgpUaGFua3MgZm9yIHRoZSByZXZpZXcgYW5kIGZvciB0
aGUgUmV2aWV3ZWQtYnkgdGFnLgoKQmVzdCByZWdhcmRzLApDdW5oYW8=

