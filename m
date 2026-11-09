Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.164
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794202482;
	b=yUW36+Voq9ym4/+VFFk1x/5RjAXfXH1pbG2ADAtuMLaqmvW9t8iE8GltmC1Ygukfpf7K
	 jri9pyHEE7NKWa+GQLJpT0tDIgcBwD92gq3UdiC7Srns0FwdE1JewAK7SGh4O5GThVaso
	 DPXIlKIN+8FVRXbkr87K1F9XJ4Zhp2rUK+14aXrBVV40AWMPl1n/JuXrJe1DsEL58JQH7
	 wyTrWXNh6TtR4qOZVa/WtXzqrIWs4GeMNbS8yVSNKNa4JoCk0EFiDqnJXdsG1Tn3q2WbA
	 b5IqivSjFzAJSCVU5BBhOJaBeX9p/1pmcsGdHAqP6U/flxyGc43UrDs6oBETs+++FTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794202482;
	h=DMARC-Filter:DKIM-Signature:X-QQ-XMRINFO:X-QQ-XMAILINFO:From:To:Cc:
	 Subject:Mime-Version:Content-Type:Content-Transfer-Encoding:Date:
	 X-Priority:Message-ID:X-QQ-MIME:X-Mailer:X-QQ-Mailer:References:
	 In-Reply-To:X-QQ-mid;
	bh=kQpuAErIv+UqR3sTl8YKiWpOrBLtMt4g0lcfxcV1WyY=;
	b=ARB7tAQp1UJdTNVdAJHpMTNqs7Yo8mNzdRwcsib24nXXqfDD0i4+diobsDIy1KFRdOcf
	 j6VKyHx5Uq5JIRRKzVJtzj3aEzo7w0IDUjnRaW9Vmij4IWmOO6/iGDfv2ENhJ5RcVfYbZ
	 5JVI5tuuAto7D6xgBXWi8WcnMNOMGZWWsmoDA9qw+LrneXJNC8VxliER4cXfMiZhOho5w
	 /zH+zHM+aOvbPpMUsnnsAu1SYmO246pnGY41szREnnKDcVKxw8jmBIYyH7A7P7fKDO2AH
	 piUVHeE7svSO0igHzoNOTXuZKvb6KSCX9lY6Cab9rQHnRRo4NMVIgwR9MvcAXyFq8Ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=peZlKzYT;
	arc=none smtp.remote-ip=203.205.221.164
Received: from out203-205-221-164.mail.qq.com (out203-205-221-164.mail.qq.com [203.205.221.164])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D97B606A321
	for <linux-can@vger.kernel.org>; Mon,  9 Nov 2026 05:34:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D97B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=peZlKzYT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794202477; bh=kQpuAErIv+UqR3sTl8YKiWpOrBLtMt4g0lcfxcV1WyY=;
	h=From:To:Cc:Subject:Date:References:In-Reply-To;
	b=peZlKzYTjYDwJvSNZ3VmOZAIF6Sx3xf3vObWCwj1lQvnPJFpf2lbJ8eE3XJRVfNV7
	 oyXOa1QB8UHCZYk1goySu+lmlKEh74X9653Ph1blVJ81AB4j8HjjG+rD5SCv/3I7f8
	 k9sj2kmiMgd3LgeHWQ/yHId318mhVx3XJLX5MngU=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-XMAILINFO: M/58+Pp9IcPFDTqfHqH2QdduhlD7tMwRrTvEjLql0ggrD6oabYgAOVsZ+qIzgD
	 pqzxmkWklRPiY/898n91lXVe0cVfNOqZmGVlRIQrh7t/TGGq7rL7GYjMms+xnspJMF9AkwKTQIv+Y
	 5JX32Kp4e95zagNv2xcoU8sisyJmqb4pwDVSH5Au8EdTvIqbHCVURFAYSFPeO5HFBXq/WUw8UoNwm
	 jrr/ZMhvTe8QVX0Bu9GoopTOntPrSLPhM6Pb2cYqFWSCQ8dhv1rRou2cES/r7U15X8OOF6a7xR596
	 yw4aEdfLo5Cc/V/NceqmYbh/cDqh3erxwcNi50CdEI2YeUG/I4KdEZ4s7aa8IR6n+3jgAaZhceUcv
	 sHaRx/TKjiwZeTOPL/dZlE6DylSrpxJfTb6o5noOqYOryAWnW5ulxUfZnXEfC4hZS7PJINJGnr5Lm
	 LCtzMn4Y3y63vntaAPUbfCdb2WSe8jtCzp4IEN5tWegt9xeFnC3Ibyh9uQGzWE11L/GZfHv7dzqCL
	 uo+xTexOHfMtQRVgUXH+Hj7UKC+cwPWZWULkS91e9VW5QkMXTA+yXfPphGB7n/2PevZTiSzUozPOA
	 Us1YQZySK/kzR/p1y/+otsg/gTnZ8GcAhlu8cW9HGBWMCjw95ao5LnC7zFvMrtUTxbnIhyumevk2S
	 cw5wr/MWaE6s6xdca25KletEO8oYQbj//DzT8ch/6WI14881tX5bk4S+py/Qxch/RvcZO+X3vvlxr
	 Gyr6B8sDZY9Igrwqdjt+w82y89oR+x/0gISR+Ob0+eFgA2WZKjB3O2UrHFa2yezLmlHt1remkCAFO
	 66EWL4LjvaCOeBtcjTGT3w1P77oclo8l1a/YifbIQnZCvb8vvw3aY28WgO6lCa6ukD8jiUxBCSBd1
	 f0jM1xA5fJQ0SPkMsOR2i1/mQlaYelBgtI+mB7m2xu1ZC+6qLidm91vtvNLrqLEd7r2KGE/B5ffqu
	 4jjzfEA2u2mJKJChvJnO5DCDgmMgyrXQWBLtHV48oT3JIraIfmlNMXdBx25eUA5iO1P5x6o9taibr
	 YYhdUKmWPABIXl1H+uUSM3H76vRK+1fFD91Oia8ZhjPK/+kPorx0oZQpZYIqbmT1al0rlzh3uQAul
	 wHZTRjMm1wL5LA==
From: "=?utf-8?B?Q3VuaGFvIEx1?=" <1579567540@qq.com>
To: "=?utf-8?B?TWFyYyBLbGVpbmUtQnVkZGU=?=" <mkl@pengutronix.de>, "=?utf-8?B?Q3VuaGFvIEx1IHZpYSBCNCBSZWxheQ==?=" <devnull+1579567540.qq.com@kernel.org>
Cc: "=?utf-8?B?a2VybmVs?=" <kernel@pengutronix.de>, "=?utf-8?B?SGVpa28gU3R1ZWJuZXI=?=" <heiko@sntech.de>, "=?utf-8?B?bGludXgtY2Fu?=" <linux-can@vger.kernel.org>, "=?utf-8?B?bGludXgtcm9ja2NoaXA=?=" <linux-rockchip@lists.infradead.org>
Subject: Re: [PATCH net v8 09/10] can: rockchip_canfd: prevent timestamp work from rearming after bus-off
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
Date: Mon, 9 Nov 2026 13:34:36 +0800
X-Priority: 3
Message-ID: <tencent_50BFA65A1A3899AA84AC11AE800E44283F07@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20261108-rockchip-canfd-restart-close-v8-0-3e7a23fd9eae@qq.com>
 <20261108-rockchip-canfd-restart-close-v8-9-3e7a23fd9eae@qq.com>
	<20261108-rebel-cicada-of-modernism-a932b9-mkl@pengutronix.de>
In-Reply-To: <20261108-rebel-cicada-of-modernism-a932b9-mkl@pengutronix.de>
X-QQ-mid: xmsezb41-0t1794202476t5wzpjm50

SGksCgo+ID7CoFRoZcKgYnVzLW9mZsKgSVJRwqBjYW5jZWxzwqB0aW1lc3RhbXDCoHdvcmvC
oGFzeW5jaHJvbm91c2x5LsKgSWbCoHRoZcKgd29ya2VyCj4gPsKgaXPCoGFscmVhZHnCoHJ1
bm5pbmcswqBpdMKgY2FuwqByZXF1ZXVlwqBpdHNlbGbCoGFmdGVywqBjYW5jZWxsYXRpb27C
oGFuZMKga2VlcAo+ID7CoHBvbGxpbmfCoHdoaWxlwqB0aGXCoGNvbnRyb2xsZXLCoHJlbWFp
bnPCoGJ1cy1vZmYuCj4gCj4gV2hhdMKgYWJvdXTCoHVzaW5nwqBkaXNhYmxlX2RlbGF5ZWRf
d29yaygpLMKgd2hpY2jCoGF2b2lkc8KgcmUtc2NoZWR1bGluZy4KPiAKPiBGb3LCoGFuwqBl
eGFtcGxlwqBzZWU6Cj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjYxMTA4LWdz
X3VzYi1maXhlcy12NS02LWQ1MmRkNDk0MGQ0NkBwZW5ndXRyb25peC5kZS8KClRoYW5rcyBm
b3IgdGhlIHN1Z2dlc3Rpb24gYW5kIHRoZSBleGFtcGxlLiBJJ2xsIHN3aXRjaCB0byBkaXNh
YmxlX2RlbGF5ZWRfd29yaygpIGluIHRoZSBuZXh0IHZlcnNpb24uCgpJJ2xsIHJldGFpbiB0
aGUgbG9jayBhbmQgYWN0aXZlIGNoZWNrIGFyb3VuZCBjb3VudGVyIHJlYWRzLCBzaW5jZSB0
aGUgYnVzLW9mZiBwYXRoIHJlc2V0cyB0aGUgY29udHJvbGxlciBpbW1lZGlhdGVseSBhZnRl
ciBzdG9wcGluZyB0aW1lc3RhbXAgd29yay4KCkJlc3QgcmVnYXJkcywKQ3VuaGFvIEx1Cg==

