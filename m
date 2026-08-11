Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA46E38F251;
	Tue, 11 Aug 2026 15:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786460744; cv=none; b=n6HS1w7OhdFHYuIIBX69GJUj5unC2yy2LjP4A8ZPupMIcV6PNAOXxo3ke3g+1JSATwDk2pfXmU/bCHIMtUmyIgz35k3PtqUt7M2j3EsFaRgrV+/ghf4GdWLX1gvjKILqgoykR6d3hbQuBWeGXd254lrR3CKMOoE63QljqmKf/Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786460744; c=relaxed/simple;
	bh=JnXJjcPnN7WCQDI9YmmqPPD8PQN0x2U1x3SkWwURy6w=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=BWVZ44EmxAcEkYzEaY5fFNDTPpRcGvLTz10XiGS+9ioxS8yTcno1k2vsjYTdSWUvXfM2XsTkrAOfyTqQQNeaVNR2VJ4V6TTGO1I6uz3rGHqQCuhgWY7DBzv1Br8AtWgQ9/8jzqg13XTONcX8hJdAH/kGhQ4+fpJnVbRp3h++Fe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=kOKHV3L2; arc=none smtp.client-ip=203.205.221.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="kOKHV3L2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1786460731; bh=JnXJjcPnN7WCQDI9YmmqPPD8PQN0x2U1x3SkWwURy6w=;
	h=From:To:Cc:Subject:Date:References:In-Reply-To;
	b=kOKHV3L2nT02opBVtJMbqbszMD1Ra+I7yNf+gz8CY4Wy2ze3rGwUt9rpBqatx3RpD
	 nOP4Y89WeeNelxz+pzaMCwY38VlpZpqvYdtZTrKZYkdlPwuDvAXALx1gQmX3QEwmvA
	 oDGMTqbvuBK/t2LHll251qLJJn+GUfC7twmtFxbQ=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-XMAILINFO: MOlL/R5ZerVSTpvvGqkZbdOTeCpU10goPmlwQ8WrheTmd2Bi7a0SNk5tSm3w6n
	 f6Qwza09dYj3Pu0YapByYukr4xSKG7HGP2ZwS6jUoLKRgvCPrKOwO50vc6Itf/4Q/w73nZ8EdIFIb
	 uTaD8OTkvRmEvZ4erOQCShlm+Ss7xWRREfmITJxjBZhA/OzPTXfGZN5Gy5+cJf+9iTvdqxg9n2sln
	 qoFsCpELA6C16+32t77/ME+HYWOMD3VSb0SorVpd81xDC1kKbs/BYMkoSZc8Mezza+2nJhzBsNynT
	 4wMJ8pl8fQtj3K2Ys6IlyZvd0JqmkMMVcF6TEZc+UmLN6xwyW2lfWr7irjbqr77ikR9Xhv543wKAT
	 7KhWuJednlSHmZlxVzfXJTwX+omrHB1s7ayXZf6lzOIEOOSXNfZTh634j+BAUmujisMn6CRdIzI5T
	 5L2+SneBu4f01lknp0GGbkIe8ptwWTYuSuQ/Qj+QjAyL1hno+qRi7DxHrHxwtaZ+CPJCXf4gd7pJO
	 Vz961rvCsFjXSPRxq6Wq/RjFLS+o04p2/V0Itb91RdptGNWBE4I9wzMGwM0iHgLRku5EaBPwOG2Jt
	 yxXmSgCYjcKSSmkZfVHmEl+uaxMlIQD8Kln3jKPbPWAYYDdL3RaWBAvZ+va/4LuN+Prr8QQu/OLCK
	 hIiSKYi3Huk6N4NygGCsSt4VX9gnMA+4sozcq/2EMYTStIMJGpyDCJ6H7dbRhOSowS4h5V1CJdN7Q
	 AhgRQmPd4hnTf6aJJt83rZ6q6fvWTcXyl/IoKr45Yc6Vm2hadM52hONFUqkUs4n2MmqkOEkfroJMY
	 eodLhnwMG9tdcENP4sLJlifDN/NIGus8cVxLXs9JXxXZySWV1Oi1xfwZiJkSX+yo8efKpi6oOf8hQ
	 SkC3U8ILMFun0Jpl2ilDgcbIxLbI1UCkcSwFem9uEC4NaKK5eIjnaWSX00xVnGiETbMAcuO1UDP6U
	 IiKZK2+IuPcr9m9w4Mj64Yk/hrW7GlzBF4BZR/aHC1KuAWgkfbtYlm+bFG+n3CnLzPrIDjKMZinD+
	 sAMN0phodaf6KMZYW9E+UFjs2j6rg7U69QDE22VTgnokVKIvUAQ0UdqhdeYP7XvVKTJJ3
From: "=?utf-8?B?Q3VuaGFvIEx1?=" <1579567540@qq.com>
To: "=?utf-8?B?TWFyYyBLbGVpbmUtQnVkZGU=?=" <mkl@pengutronix.de>
Cc: "=?utf-8?B?a2VybmVs?=" <kernel@pengutronix.de>, "=?utf-8?B?VmluY2VudCBNYWlsaG9s?=" <mailhol@kernel.org>, "=?utf-8?B?Um9iIEhlcnJpbmc=?=" <robh@kernel.org>, "=?utf-8?B?S3J6eXN6dG9mIEtvemxvd3NraQ==?=" <krzk+dt@kernel.org>, "=?utf-8?B?Q29ub3IgRG9vbGV5?=" <conor+dt@kernel.org>, "=?utf-8?B?SGVpa28gU3R1ZWJuZXI=?=" <heiko@sntech.de>, "=?utf-8?B?bGludXgtY2Fu?=" <linux-can@vger.kernel.org>, "=?utf-8?B?ZGV2aWNldHJlZQ==?=" <devicetree@vger.kernel.org>, "=?utf-8?B?bGludXgtYXJtLWtlcm5lbA==?=" <linux-arm-kernel@lists.infradead.org>, "=?utf-8?B?bGludXgtcm9ja2NoaXA=?=" <linux-rockchip@lists.infradead.org>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>, "=?utf-8?B?SGVpa28gU3R1ZWJuZXI=?=" <heiko.stuebner@cherry.de>
Subject: Re: [PATCH v6 2/4] can: rockchip: add RK3588 CAN support
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Tue, 11 Aug 2026 23:05:29 +0800
X-Priority: 3
Message-ID: <tencent_3D3F22AD1F6C1308CD800C4AC2DAC8414006@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <tencent_7BAA0052C402BFFD26291A64198084E39107@qq.com>
 <tencent_207E464D12344B3228096E23A001D6882508@qq.com>
 <20260731-tall-camouflaged-earthworm-e1a7d0-mkl@pengutronix.de>
 <tencent_A3698A465C4621E164443B0005D1CC6FAE05@qq.com>
	<20260731-precise-functional-lobster-cd779f-mkl@pengutronix.de>
In-Reply-To: <20260731-precise-functional-lobster-cd779f-mkl@pengutronix.de>
X-QQ-mid: xmsezb41-0t1786460729t0u1mf5e1

SGkgTWFyYywKCkkgd291bGQgbGlrZSB0byBmb2xsb3cgdXAgb24gbXkgcHJldmlvdXMgZW1h
aWwgcmVnYXJkaW5nIFJLMzU4OCBDQU4tRkQKYW5kIFREQy4KCkFzIHJlcG9ydGVkIHByZXZp
b3VzbHk6Cgo+IEVuYWJsaW5nIFREQyBtYWtlcyB0aGUgdHJhbnNtaXR0ZXIgZW50ZXIgYnVz
LW9mZiBmb3IgZXZlcnkgVERDTyB2YWx1ZQo+IHRlc3RlZC4gVGhpcyBpbmNsdWRlcyB0aGUg
ZnJhbWV3b3JrIHZhbHVlIChURENPPTQ4KSwgVERDTz0wLCBhbmQgdGhlCj4gbm9uLXplcm8g
dmFsdWVzIDEsIDgsIDE2LCAyNCwgMzIsIDQwLCA0OCBhbmQgNTYuIFdpdGggVERDTz02Mywg
b25seSBvbmUKPiBmcmFtZSB3YXMgcmVjZWl2ZWQgZHVyaW5nIGEgMTAgc2Vjb25kIHRlc3Qs
IHNvIHRoYXQgc2V0dGluZyBpcyBub3QgdXNhYmxlLgoKSSBoYXZlIG5vdyBhbHNvIGNvbXBs
ZXRlZCBhIDIwLWhvdXIgQ0FOLUZEIHRlc3Qgd2l0aCBUREMgZGlzYWJsZWQsIHVzaW5nCnRo
ZSBzYW1lIHNldHVwIGFzIGRlc2NyaWJlZCBpbiBteSBwcmV2aW91cyBlbWFpbDoKCiAgQm9h
cmQ6ICAgICAgICAgICAgIGVtYmVkZmlyZSxyazM1ODgtbHViYW5jYXQtNWlvCiAgQ0FOIGNs
b2NrOiAgICAgICAgIDMwMCBNSHoKICBOb21pbmFsIGJpdHJhdGU6ICAgNTAwIGtiaXQvcwog
IERhdGEgYml0cmF0ZTogICAgICA1IE1iaXQvcwogIFNhbXBsZSBwb2ludHM6ICAgICA4MCUg
bm9taW5hbCwgODAlIGRhdGEKICBCdXM6ICAgICAgICAgICAgICAgY2FuMCBhbmQgY2FuMSBk
aXJlY3RseSBjb25uZWN0ZWQsIDYwIE9obSB0ZXJtaW5hdGlvbgoKVGhlIDUgTWJpdC9zIGRh
dGEgYml0cmF0ZSBpcyB0aGUgbWF4aW11bSBzdXBwb3J0ZWQgYnkgdGhlIENBTgp0cmFuc2Nl
aXZlcnMgb24gdGhpcyBib2FyZC4KCk5vIGZyYW1lcyB3ZXJlIGxvc3QgZHVyaW5nIHRoZSAy
MC1ob3VyIHRlc3QsIGFuZCBubyBDQU4gZXJyb3JzIHdlcmUKcmVwb3J0ZWQgaW4gdGhlIGtl
cm5lbCBsb2cuIFRoZSBmaW5hbCBpZmNvbmZpZyBzdGF0aXN0aWNzIHdlcmU6CgogIGNhbjAg
Ulg6IDYwNzkzOTkyMiBwYWNrZXRzLCA5NjEzMDQ5OTg3IGJ5dGVzICg5LjYgR0IpCiAgY2Fu
MCBUWDogNjA3OTM5OTIyIHBhY2tldHMsIDk2MTMwNDk5ODcgYnl0ZXMgKDkuNiBHQikKICBj
YW4xIFJYOiA2MDc5Mzk5MjIgcGFja2V0cywgOTYxMzA0OTk4NyBieXRlcyAoOS42IEdCKQoK
VGhlIGVycm9yLCBkcm9wcGVkLCBhbmQgb3ZlcnJ1biBjb3VudGVycyB3ZXJlIGFsbCB6ZXJv
LiBUaGUga2VybmVsIGxvZwpjb250YWluZWQgZmV3ZXIgdGhhbiB0ZW4gVFhFX0ZJRk9fRlVM
TF9JTlQgaW5mb3JtYXRpb25hbCBtZXNzYWdlcyBkdXJpbmcKdGhlIGVudGlyZSB0ZXN0LCB3
aXRoIG5vIGNvcnJlc3BvbmRpbmcgZnJhbWUgbG9zcywgYnVzIGVycm9yLCBvciBidXMtb2Zm
CmV2ZW50LgoKVGhlc2UgcmVzdWx0cyBzaG93IHRoYXQsIG9uIHRoaXMgaGFyZHdhcmUgc2V0
dXAsIFJLMzU4OCBDQU4tRkQgb3BlcmF0ZXMKcmVsaWFibHkgYXQgNSBNYml0L3Mgd2hlbiBU
REMgaXMgZGlzYWJsZWQsIHdoaWxlIGVuYWJsaW5nIFREQyBwcmV2ZW50cwpub3JtYWwgQ0FO
IGNvbW11bmljYXRpb24uCgpXb3VsZCBpdCB0aGVyZWZvcmUgYmUgYWNjZXB0YWJsZSB0byBk
cm9wIFJLQ0FORkRfUVVJUktfQ0FORkRfQlJPS0VOIGZvcgpSSzM1ODggYW5kIGVuYWJsZSBD
QU4tRkQgc3VwcG9ydCB3aGlsZSBleHBsaWNpdGx5IGtlZXBpbmcgVERDIGRpc2FibGVkPwoK
QWx0ZXJuYXRpdmVseSwgc2hvdWxkIEkgZm9sbG93IHlvdXIgZWFybGllciBzdWdnZXN0aW9u
IGFuZCBhZGQKUktDQU5GRF9RVUlSS19DQU5GRF9CUk9LRU4gYmFjayBmb3IgUkszNTg4IGlu
IHRoaXMgc2VyaWVzPwoKQmVzdCByZWdhcmRzLApDdW5oYW8=

