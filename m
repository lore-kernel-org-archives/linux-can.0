From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH net-next] can: dev: call netif_carrier_off() in
 register_candev()
Date: Mon, 24 Jun 2019 08:34:13 +0000
Message-ID: <20190624083352.29257-1-rasmus.villemoes@prevas.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller" <davem@davemloft.net>
Cc: Rasmus Villemoes <Rasmus.Villemoes@prevas.se>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

Q09ORklHX0NBTl9MRURTIGlzIGRlcHJlY2F0ZWQuIFdoZW4gdHJ5aW5nIHRvIHVzZSB0aGUgZ2Vu
ZXJpYyBuZXRkZXYNCnRyaWdnZXIgYXMgc3VnZ2VzdGVkLCB0aGVyZSdzIGEgc21hbGwgaW5jb25z
aXN0ZW5jeSB3aXRoIHRoZSBsaW5rDQpwcm9wZXJ0eTogVGhlIExFRCBpcyBvbiBpbml0aWFsbHks
IHN0YXlzIG9uIHdoZW4gdGhlIGRldmljZSBpcyBicm91Z2h0DQp1cCwgYW5kIHRoZW4gdHVybnMg
b2ZmIChhcyBleHBlY3RlZCkgd2hlbiB0aGUgZGV2aWNlIGlzIGJyb3VnaHQgZG93bi4NCg0KTWFr
ZSBzdXJlIHRoZSBMRUQgYWx3YXlzIHJlZmxlY3RzIHRoZSBzdGF0ZSBvZiB0aGUgQ0FOIGRldmlj
ZS4NCg0KU2lnbmVkLW9mZi1ieTogUmFzbXVzIFZpbGxlbW9lcyA8cmFzbXVzLnZpbGxlbW9lc0Bw
cmV2YXMuZGs+DQotLS0NCiBkcml2ZXJzL25ldC9jYW4vZGV2LmMgfCAxICsNCiAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2Nhbi9kZXYu
YyBiL2RyaXZlcnMvbmV0L2Nhbi9kZXYuYw0KaW5kZXggYzA1ZTRkNTBkNDNkLi5mYWQyN2FjZTYy
NDggMTAwNjQ0DQotLS0gYS9kcml2ZXJzL25ldC9jYW4vZGV2LmMNCisrKyBiL2RyaXZlcnMvbmV0
L2Nhbi9kZXYuYw0KQEAgLTEyNjAsNiArMTI2MCw3IEBAIGludCByZWdpc3Rlcl9jYW5kZXYoc3Ry
dWN0IG5ldF9kZXZpY2UgKmRldikNCiAJCXJldHVybiAtRUlOVkFMOw0KIA0KIAlkZXYtPnJ0bmxf
bGlua19vcHMgPSAmY2FuX2xpbmtfb3BzOw0KKwluZXRpZl9jYXJyaWVyX29mZihkZXYpOw0KIAly
ZXR1cm4gcmVnaXN0ZXJfbmV0ZGV2KGRldik7DQogfQ0KIEVYUE9SVF9TWU1CT0xfR1BMKHJlZ2lz
dGVyX2NhbmRldik7DQotLSANCjIuMjAuMQ0KDQo=
