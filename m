Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8652857F0
	for <linux-can@vger.kernel.org>; Thu, 15 Oct 2026 10:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792059221; cv=none; b=u6Xe+NwY1yw7OpEVBkmtHmm6y5HnuJoRMUG/5VwlW8VEA8aBZwobG2Jm0zOyZ3WQsWAO7bVvxKEj9qtJVjPlZCjHWNa9LYSuP0/rLlkD9NZRwLpoRkGgx+jrm+eUozSjmOgU6AXUE7nElTOzgFfA6eZuLUrbTtyRyZgMoIOk9GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792059221; c=relaxed/simple;
	bh=MMlRXSAS2923dKkz9CNJnOAq1/1JxcvHXhLKFq46OcM=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=foC0CEpayJOQrs7It7fi7KY9joQzk8VXdMJ1YoGbO4gGOElGi6G9/vY7QwSiU0gggghIUKAeT4q9Qz+nSS67UwAD9Y1gbY5DBUQXTNCK2LMRPd9xCj/hB7MckfeIpynedosBOJL+0/v+lhWZEp/2IjiEL4TylfIIRWk8uUWHlpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=IVgv/a7y; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="IVgv/a7y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1792059213; bh=MMlRXSAS2923dKkz9CNJnOAq1/1JxcvHXhLKFq46OcM=;
	h=From:To:Cc:Subject:Date:References:In-Reply-To;
	b=IVgv/a7y/he0GTNv5G7BZFIJcyfjoenClG2fYeqLV3feIG19WE2ASpWiSLPBVOJTl
	 CDJzdtiX9S/PsmOFOy0NztmOmOI7sTENmGxo6JuZ8h8QjpgVRokZafTuGut322JaXP
	 6dwUuxkPdu39eFi2FmufTHbrLt4ZqJQ7PDLTgftQ=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-XMAILINFO: MyUpnyPwWZhGr2AovVLd2l3avmgw3ofQgmI7yHqE1KR6nEdW1DMKGzdjdBHaNX
	 Io9JAV2hfW7EbNWVuaBZ2Qrpa5Kk1sRhRVwxeEYf/rUgtxWV1ayjwpsYyi7bStPoN78EN3/ldA1Fv
	 BT+8X/NMWj2S/NwKqFkNLFs1VlawMLciHQY3ZJq4+sUvBDJ3afYcyNov0z4130ku4ueerzCR0dFx/
	 ZeVtGgIENdAfH6Xs2W8cs7r2HcD4JPwX9agf4YL8RKJ2wWY9DilBcHybt0/KaJBm5oD/3irf6CtP3
	 z2j6Y2bH5SkuAO6ggVEPCgFTMW59vqNcL6gq1E4Y+725sMCjt1s1VQ/+VV5pZ1LSHpy6kUrWEjHsa
	 kENewPqSsTm9x2UUAbqHADg5O6wLXOlizwmlGoPltBh2mIB/+LO/VCD7bAOa9sCcPrf3Q9m5ap+Ib
	 S+bILUBEgpP+WQ9+/V3X30DKwFkgbcVA9MkPk1mH1bZgd8PJ+bFnBiI15WAmyOkg+HOS2Rjjme5pU
	 kIkPtXNT25RpZZwDMQ6A6EiTtME1cTgNhMHMv333jXha7wbMx/axjsH4YmpVaB/799srVdmJvNKCB
	 2T3khwcPa8A+eDhoHFuc2Z6DiHcHCSEUtfR2rhW2lEyJkdG8W7LkCWVwo9+CDq6S1QgL716zLegQu
	 L440vUj361Vgo9t+kQhjuqeUY0CQMl5sGU+Zt2RSKG0v+XM0yVyEQQ7bqXFQVCLIy+3esUxFyM80d
	 4wftLMrzogu6/mZY1+cjUIXykEBcsK3fajIckMOn8xmnkuvR1XaQs409tNXQbyYC+ZLDOzpEwiGA5
	 m0IJmAfXFOR1bLF61FzP9bJSupG40Uy8XX4VtfZYicgMFJYx/5ANwJCAStwjsXf1/66aiqK7LlYdO
	 YH0oSvVazZA62feYmJOMNzoP84uLO39ScLmr1s/C9kclp7VFRjRVNJMcPGH0ex16VgAkMlFwGb719
	 Fx/WHwl7RdVl4sFUlkfrMzBPFAHFeytSTnCB4J2So0VZqiYQyfsNESUJ+H7EKQtvDKKuFocZqmBOK
	 YQcw33+efjABMIHKABCiqFA055t5TO3tIBzkJ
From: "=?utf-8?B?Q3VuaGFvIEx1?=" <1579567540@qq.com>
To: "=?utf-8?B?c2FzaGlrby1yZXZpZXdz?=" <sashiko-reviews@lists.linux.dev>
Cc: "=?utf-8?B?bGludXgtY2Fu?=" <linux-can@vger.kernel.org>, "=?utf-8?B?TWFyYyBLbGVpbmUtQnVkZGU=?=" <mkl@pengutronix.de>, "=?utf-8?B?T2xpdmVyIEhhcnRrb3Bw?=" <socketcan@hartkopp.net>, "=?utf-8?B?VmluY2VudCBNYWlsaG9s?=" <mailhol@kernel.org>, "=?utf-8?B?T2xla3NpaiBSZW1wZWw=?=" <o.rempel@pengutronix.de>
Subject: Re: [PATCH net v5 3/6] can: rockchip_canfd: cancel bus-off restart before closing the device
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Thu, 15 Oct 2026 18:13:31 +0800
X-Priority: 3
Message-ID: <tencent_8C34600511CC8FB1699A864BE621016BC405@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20261015-rockchip-canfd-restart-close-v5-0-ae77327037c9@qq.com>
 <20261015-rockchip-canfd-restart-close-v5-3-ae77327037c9@qq.com>
	<sashiko-outbox-172613@kernel.org>
In-Reply-To: <sashiko-outbox-172613@kernel.org>
X-QQ-mid: xmsezb41-0t1792059211tklax5wa2

SGksCgo+IFtTZXZlcml0eTogSGlnaF0KPiBEb2VzIHJrY2FuZmRfc3RvcCgpIGFsc28gbmVl
ZCBhIHJlYWRiYWNrIGZsdXNoIGFmdGVyIGRpc2FibGluZyBoYXJkd2FyZQo+IGludGVycnVw
dHMsIHNpbWlsYXIgdG8gdGhlIG9uZSBhZGRlZCBhYm92ZSBpbiBya2NhbmZkX3NldF9tb2Rl
KCk/Cj4KPiBXaXRob3V0IGEgcmVhZGJhY2sgZmx1c2ggYmVmb3JlIHRoZSBzdWJzZXF1ZW50
IGZyZWVfaXJxKCkgY2FsbCwgaWYgdGhlCj4gc2hhcmVkIElSUSBsaW5lIHJlY2VpdmVzIGFu
IGludGVycnVwdCBiZWZvcmUgdGhlIHBvc3RlZCB3cml0ZSByZWFjaGVzCj4gdGhlIGJ1cywg
dGhlIENQVSBjb3VsZCByZWNlaXZlIHRoZSBpbnRlcnJ1cHQgYWZ0ZXIgdGhlIGhhbmRsZXIg
aGFzIGJlZW4KPiBkZXJlZ2lzdGVyZWQuIENvdWxkIHRoaXMgY2F1c2UgYW4gdW5oYW5kbGVk
IGludGVycnVwdCBzdG9ybSB0aGF0IGRpc2FibGVzCj4gdGhlIHNoYXJlZCBJUlEgbGluZSBl
bnRpcmVseT8KClRoZSBtaXNzaW5nIHJlYWRiYWNrIGluIHJrY2FuZmRfc3RvcCgpIGlzIGEg
cHJlLWV4aXN0aW5nIGlzc3VlLAppbmRlcGVuZGVudCBvZiB0aGUgcmVzdGFydC9jbG9zZSBy
YWNlIGFkZHJlc3NlZCBieSB0aGlzIHBhdGNoLiBUaGUKaW50ZXJydXB0LW1hc2sgd3JpdGUg
Zm9sbG93ZWQgYnkgZnJlZV9pcnEoKSwgd2l0aG91dCBhIHJlYWRiYWNrLCBoYXMKYmVlbiBw
cmVzZW50IHNpbmNlIGZmNjBiZmJhZjY3ZiAoImNhbjogcm9ja2NoaXBfY2FuZmQ6IGFkZCBk
cml2ZXIgZm9yClJvY2tjaGlwIENBTi1GRCBjb250cm9sbGVyIikuIFRoaXMgcGF0Y2ggZG9l
cyBub3QgY2hhbmdlIHRoYXQgc2VxdWVuY2UuCgpJIHdpbGwgbGVhdmUgdGhpcyBpc3N1ZSBv
dXQgb2YgdGhlIGN1cnJlbnQgc2VyaWVzLiBXaGVuIEkgaGF2ZSB0aW1lLApJIHdpbGwgZm9s
bG93IHVwIHdpdGggYSBzZXBhcmF0ZSBwYXRjaCB0byBmaXggaXQuCgpSZWdhcmRzLApDdW5o
YW8gTHUK

