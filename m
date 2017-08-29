From: "Zhu Yi" <zhuyi882004@126.com>
Subject: [PATCH 1/2] can: flexcan: mitigate i.MX6 incomplete state irq
Date: Tue, 29 Aug 2017 19:28:05 +0800 (CST)
Message-ID: <6216ffc8.93c5.15e2dbf9b21.Coremail.zhuyi882004@126.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: base64
Return-path: <linux-can-owner@vger.kernel.org>
Received: from m15-45.126.com ([220.181.15.45]:22601 "EHLO m15-45.126.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751332AbdH2L2j (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 29 Aug 2017 07:28:39 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "wg@grandegger.com" <wg@grandegger.com>, "mkl@pengutronix.de" <mkl@pengutronix.de>, "andri.yngvason@marel.com" <andri.yngvason@marel.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "hs@denx.de" <hs@denx.de>, "mark.jonas@de.bosch.com" <mark.jonas@de.bosch.com>, "tingquan.ruan@cn.bosch.com" <tingquan.ruan@cn.bosch.com>, "yi.zhu5@cn.bosch.com" <yi.zhu5@cn.bosch.com>

VGhlIGkuTVg2IGZsZXhjYW4gY29yZSB3aWxsIG5vdCBnZW5lcmF0ZSBzdGF0ZSBpbnRlcnJ1cHQg
Zm9yIHNvbWUgc3RhdGUKdHJhbnNpdGlvbnMuIFRoaXMgcGF0Y2ggZW5hYmxlcyB0aGUgYnVzIGVy
cm9yIGludGVycnVwdCBvbiBpLk1YNiBieQplbmFibGluZyBGTEVYQ0FOX1FVSVJLX0JST0tFTl9F
UlJfU1RBVEUgYW5kIGNoYW5naW5nIHRoZSBjYWxsIG9mCmZsZXhjYW5faXJxX3N0YXRlKCkgdXBv
biBfYW55XyBpbnRlcnJ1cHQgdG8gbWl0aWdhdGUgdGhpcyBpc3N1ZS4KClNpZ25lZC1vZmYtYnk6
IFpodSBZaSA8eWkuemh1NUBjbi5ib3NjaC5jb20+ClNpZ25lZC1vZmYtYnk6IE1hcmsgSm9uYXMg
PG1hcmsuam9uYXNAZGUuYm9zY2guY29tPgotLS0KIGRyaXZlcnMvbmV0L2Nhbi9mbGV4Y2FuLmMg
fCA3ICsrKystLS0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25z
KC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvY2FuL2ZsZXhjYW4uYyBiL2RyaXZlcnMvbmV0
L2Nhbi9mbGV4Y2FuLmMKaW5kZXggMTNmMGYyMS4uNzViYjlmNiAxMDA2NDQKLS0tIGEvZHJpdmVy
cy9uZXQvY2FuL2ZsZXhjYW4uYworKysgYi9kcml2ZXJzL25ldC9jYW4vZmxleGNhbi5jCkBAIC0y
ODgsNyArMjg4LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBmbGV4Y2FuX2RldnR5cGVfZGF0YSBm
c2xfaW14MjhfZGV2dHlwZV9kYXRhOwogCiBzdGF0aWMgY29uc3Qgc3RydWN0IGZsZXhjYW5fZGV2
dHlwZV9kYXRhIGZzbF9pbXg2cV9kZXZ0eXBlX2RhdGEgPSB7CiAJLnF1aXJrcyA9IEZMRVhDQU5f
UVVJUktfRElTQUJMRV9SWEZHIHwgRkxFWENBTl9RVUlSS19FTkFCTEVfRUFDRU5fUlJTIHwKLQkJ
RkxFWENBTl9RVUlSS19VU0VfT0ZGX1RJTUVTVEFNUCwKKwkJRkxFWENBTl9RVUlSS19VU0VfT0ZG
X1RJTUVTVEFNUCB8IEZMRVhDQU5fUVVJUktfQlJPS0VOX0VSUl9TVEFURSwKIH07CiAKIHN0YXRp
YyBjb25zdCBzdHJ1Y3QgZmxleGNhbl9kZXZ0eXBlX2RhdGEgZnNsX3ZmNjEwX2RldnR5cGVfZGF0
YSA9IHsKQEAgLTc2NSw4ICs3NjUsOSBAQCBzdGF0aWMgaXJxcmV0dXJuX3QgZmxleGNhbl9pcnEo
aW50IGlycSwgdm9pZCAqZGV2X2lkKQogCQlmbGV4Y2FuX3dyaXRlKHJlZ19lc3IgJiBGTEVYQ0FO
X0VTUl9BTExfSU5ULCAmcmVncy0+ZXNyKTsKIAl9CiAKLQkvKiBzdGF0ZSBjaGFuZ2UgaW50ZXJy
dXB0ICovCi0JaWYgKHJlZ19lc3IgJiBGTEVYQ0FOX0VTUl9FUlJfU1RBVEUpCisJLyogc3RhdGUg
Y2hhbmdlIGludGVycnVwdCBvciBvbiBicm9rZW4gZXJyb3Igc3RhdGUgY29yZSAqLworCWlmICgo
cmVnX2VzciAmIEZMRVhDQU5fRVNSX0VSUl9TVEFURSkgfHwKKwkgICAgKHByaXYtPmRldnR5cGVf
ZGF0YS0+cXVpcmtzICYgRkxFWENBTl9RVUlSS19CUk9LRU5fRVJSX1NUQVRFKSkKIAkJZmxleGNh
bl9pcnFfc3RhdGUoZGV2LCByZWdfZXNyKTsKIAogCS8qIGJ1cyBlcnJvciBJUlEgLSBoYW5kbGUg
aWYgYnVzIGVycm9yIHJlcG9ydGluZyBpcyBhY3RpdmF0ZWQgKi8KLS0gCjIuNy40Cg==
