Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com [203.205.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E061F938
	for <linux-can@vger.kernel.org>; Thu, 15 Oct 2026 07:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792049652; cv=none; b=V+eyArwnjONbxryLMdARVjlHDHo6r1RpOWhuW/S/6C6s65x9yMn3zLnTR7IIp/I/1jGMvk3VmA4vIJIK1x91cBmu0yspZWJLKI395WTQDn+lwA9jqybodBb6taJhghq02xwqU1Oc/wuvVyX4IZgAldILXw+9pfjlWOXczkxmOrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792049652; c=relaxed/simple;
	bh=4CKK7lAR49O9SI1kJP4IT8U/pMoZQR2byuCm1R2pMnU=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=EQ0IobkoFHgvrc0wvCbSjCJIkQSvNqrv5631AlafzU2otnV74eSmU7iwRIHPXWIdfvtgNCRdK4qAy0/5306v3XvlK9Yl/DqPHcsUq0t5oDorX0p6ND1DtKpuKHPdxHwJmZ+n0cHJNsuEpsmSWEPM5FUcPXOrGQ8vN+j+rFQPwMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=q/KQYozg; arc=none smtp.client-ip=203.205.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="q/KQYozg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1792049640; bh=4CKK7lAR49O9SI1kJP4IT8U/pMoZQR2byuCm1R2pMnU=;
	h=From:To:Cc:Subject:Date:References:In-Reply-To;
	b=q/KQYozgK/N0D9Vq3SpfiEx9S2o8mZND17p7qWWt7jIuYph5KMkMOfkMoibK2M7cN
	 HmmuhLD5B1kg7RJiEbqGmsen96ZzmWh2kUOU4UQix+e1+ZmI0Z3kfPJa/v7hgDl3bx
	 V3LDfJFlcxQJugb+vJ1eSqKVKazLSIY5skSmcsKg=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-XMAILINFO: M3Z880YfHp5ouZC8Q6hdtDabPM5zOpEXmAFdt/lAOopz69ksKEpVkV9eq9xoz2
	 BCetcnyU5Yym8A6e/SuzjUjvtWzXzCL85PAnysSiEBAEq7zQlWnTCmBUbhXs4I3mwAXAy97qgygfL
	 O0fbPBGDxCGwPeyTIkQqeXE5XqRL/jQXduh38mzL9DX+6stlTdbM4nwGs6u86RPCRhxfEo0F4c4i+
	 egLl4FRjl7hLJEA7yR/Uqs1+C8gyN2wcZPKWtkFa1vvF1dh//nISG6nG7K1KQiaSnEyCCtalt9Cpe
	 zXlbwWjj6+ahTpbeZkbjNVyrowzm2pHyMM8bp8PaxkPS+LtfnulagXjIbniOpA/LYIqe57ocHd3Ki
	 IF/f9H7dfWqT9IcI8rzUth163WGs8r61i9NqUOaWU9kanUtQFW2lSRok4hAH9f8P6Gp+LA7GC7IFV
	 BwgAOAZv7P6zmpQBLHIHmcEfpLh7VBnVtSjQx6/dMR8imfx+/T68V80K0Q5R1O5/YZ166skJscZkc
	 ktEALx3Ig9/qG4uLXHJRS2mufhePxeImSl3IamPjNCx1fSWrfr58zypvvCJnh/EdBb1cxlod/03jL
	 7dIwIb4Zm78Oh5u7+JzvHvZ7avUFr4aWAr06A0r3JHeT/1z9BoTFAIc67xvXeSpzSzoz1iFDKdyCG
	 zz1cjgS47cxGBg52VIpAgJ14tO4xENQXUo2giCi1h6BGi9wMLQ9NCsAeZww0cLsc0lsQp7OuqSL7Q
	 5XVgkz8Y51Pftl55aLEaoE7CG1Zt18jdgZs7wn5TLpnh4pLpd3MCAAyeipYwJF2Ff/Vo2fY/oEeGI
	 3DDhUeqlYiUSsbD9fsKe/OFK1HTLKZ8Y6IwMwdv1gBZ7CsFXeaF8lquKeT6Il58FNQya6/iefZ0Ps
	 UCvpjMzdpkIl35PdQmMdDbFigWbRhhTHg08WWXmsY2D9Nz+Uf6gooPRX+xxGcKbPlMRBsP2rpGvYF
	 GR4OWWcmurNMO3/DlgoJmxuupy23f79axPhwLTRqYHZSRZ+P6Y53hInq+y9EGp1DfTmElz4qODAY9
	 +spkTo3Mp0mRWHe9CHPHNHUY3A8+cQqEWeJ/i
From: "=?utf-8?B?Q3VuaGFvIEx1?=" <1579567540@qq.com>
To: "=?utf-8?B?c2FzaGlrby1yZXZpZXdz?=" <sashiko-reviews@lists.linux.dev>
Cc: "=?utf-8?B?bGludXgtY2Fu?=" <linux-can@vger.kernel.org>, "=?utf-8?B?TWFyYyBLbGVpbmUtQnVkZGU=?=" <mkl@pengutronix.de>, "=?utf-8?B?T2xpdmVyIEhhcnRrb3Bw?=" <socketcan@hartkopp.net>, "=?utf-8?B?VmluY2VudCBNYWlsaG9s?=" <mailhol@kernel.org>, "=?utf-8?B?T2xla3NpaiBSZW1wZWw=?=" <o.rempel@pengutronix.de>
Subject: Re: [PATCH net v4 5/6] can: rockchip_canfd: serialize TX with bus-off and restart
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Thu, 15 Oct 2026 15:33:58 +0800
X-Priority: 3
Message-ID: <tencent_5B20023C10F7FC6C9ADE688C648A13004709@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20261015-rockchip-canfd-restart-close-v4-0-ad149ff79450@qq.com>
 <20261015-rockchip-canfd-restart-close-v4-5-ad149ff79450@qq.com>
	<sashiko-outbox-172325@kernel.org>
In-Reply-To: <sashiko-outbox-172325@kernel.org>
X-QQ-mid: xmsezb41-0t1792049638trelfzn48

SGksCgo+IFtTZXZlcml0eTogTWVkaXVtXQo+IENvdWxkIHRoaXMgbGVhayBlY2hvIGZyYW1l
cyBhcyBSWCBmcmFtZXMgb24gYSBidXMtb2ZmIGV2ZW50Pwo+IAo+IFdoZW4gcHJpdi0+dHhf
ZW5hYmxlZCBpcyBmYWxzZSwgdGhlIGNvZGUgc2tpcHMgY2FsbGluZyBya2NhbmZkX3J4c3R4
X2ZpbHRlcigpLAo+IGxlYXZpbmcgdHhfZG9uZSBhcyBmYWxzZS4gVGhpcyBieXBhc3NlcyB0
aGUgZWFybHkgcmV0dXJuIGZvciBlY2hvIGZyYW1lcy4KPiBTaW5jZSB0aGUgaGFyZHdhcmUg
cHVzaGVzIHNlbGYtdHJhbnNtaXR0ZWQgZnJhbWVzIHRvIHRoZSBSWCBGSUZPLCB3b3VsZG4n
dAo+IGFueSBlY2hvIGZyYW1lcyBhbHJlYWR5IHByZXNlbnQgaW4gdGhlIFJYIEZJRk8gdGhl
biBmYWxsIHRocm91Z2ggYW5kIGJlCj4gYWxsb2NhdGVkIGFuZCBxdWV1ZWQgYXMgcmVndWxh
ciBSWCBmcmFtZXM/CgpJIHdpbGwgZml4IHRoaXMgaW4gdjUuCgo+IFtTZXZlcml0eTogTWVk
aXVtXQo+IElzIHRoZXJlIGEgZGF0YSByYWNlIG9uIHRoZSBwcml2LT5iZWMgc3RhdGlzdGlj
cyBoZXJlPwo+IAo+IFRoaXMgcGF0Y2ggaW50cm9kdWNlcyB0eF9sb2NrIGFyb3VuZCBwYXJ0
cyBvZiB0aGUgSVJRIGhhbmRsZXIsIGJ1dCBsZWF2ZXMgdGhlCj4gdXBkYXRlcyB0byBwcml2
LT5iZWMgb3V0c2lkZSB0aGUgbG9jay4gVGhlIG5ldGxpbmsgY29tbWFuZAo+IGNhbl9nZXRf
YmVycl9jb3VudGVyKCkgaW52b2tlcyBya2NhbmZkX2dldF9iZXJyX2NvdW50ZXJfY29ycmVj
dGVkKCksIHdoaWNoCj4gYWNjZXNzZXMgcHJpdi0+YmVjIGZyb20gcHJvY2VzcyBjb250ZXh0
IHdpdGhvdXQgZHJpdmVyLXNwZWNpZmljCj4gc2VyaWFsaXphdGlvbi4gQ29uY3VycmVudGx5
LCBOQVBJIGxvb3AgZXhlY3V0aW9uIGRlY3JlbWVudHMgcHJpdi0+YmVjLnJ4ZXJyCj4gYW5k
IHByaXYtPmJlYy50eGVyciByaWdodCBiZWxvdyB0aGlzIGJsb2NrLgo+IAo+IENvdWxkIHRo
aXMgcmVzdWx0IGluIHRvcm4gcmVhZHMgb3IgbG9zdCB1cGRhdGVzIHRvIHRoZSBlcnJvciBj
b3VudGVycyBiZWluZwo+IHJlcG9ydGVkIHRvIHVzZXJzcGFjZT8KClllcywgdGhpcyBpcyBh
biBleGlzdGluZyBpc3N1ZS4gVGhpcyBwYXRjaCBkb2VzIG5vdCBtYWtlIGl0IHdvcnNlLgpJ
IHdpbGwgbGVhdmUgaXQgb3V0IG9mIHRoaXMgc2VyaWVzIGZvciBub3cuIElmIEkgaGF2ZSB0
aW1lIGxhdGVyLApJIHdpbGwgc2VuZCBhIHNlcGFyYXRlIHBhdGNoIHRvIGZpeCBpdC4KClJl
Z2FyZHMsCkN1bmhhbyBMdQoKcHctYm90OiBjcgo=

