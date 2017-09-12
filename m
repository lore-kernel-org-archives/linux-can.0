From: "ZHU Yi (ST-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>
Subject: RE: [PATCH 3/4] can: flexcan: implement error passive state quirk
Date: Tue, 12 Sep 2017 01:59:15 +0000
Message-ID: <e878b7f3840c4a60940828a3e77d4ee7@SGPMBX1017.APAC.bosch.com>
References: <87faf67d90a246938e0b51d2ddbc8b82@SGPMBX1017.APAC.bosch.com>
 <cc678b44-0aa8-ac91-567e-8b9c234ed024@grandegger.com>
 <ad3cf1da-ca4b-6149-876a-0c983f9d48c8@grandegger.com>
 <dfb4fd69b6d0463ca565245f4c072b90@SGPMBX1017.APAC.bosch.com>
 <1685670a-c87d-2204-7e46-c36ebb8b072f@grandegger.com>
 <bf6cad90aa9d4e8da439a5ac2e21eafd@SGPMBX1017.APAC.bosch.com>
 <20820cdf-afff-9d04-3c9c-511e45bd0853@grandegger.com>
 <1ccdad7593e34103bd4d96f5b1e64ea7@SGPMBX1017.APAC.bosch.com>
 <92d997b5-957e-7e0b-70aa-bff16e289e81@grandegger.com>
 <6903931307914574bcc729ece55c0b0d@SGPMBX1017.APAC.bosch.com>
 <ea3a890e-450e-3c8b-a337-4f81bbb9c0a4@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:57355 "EHLO
        smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751045AbdILB7U (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 11 Sep 2017 21:59:20 -0400
In-Reply-To: <ea3a890e-450e-3c8b-a337-4f81bbb9c0a4@grandegger.com>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Andri Yngvason <andri.yngvason@marel.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "hs@denx.de" <hs@denx.de>, "RUAN Tingquan (ST-FIR/ENG1-Zhu)" <Tingquan.Ruan@cn.bosch.com>, "Jonas Mark (ST-FIR/ENG1)" <Mark.Jonas@de.bosch.com>

SGVsbG8gV29sZmdhbmcsDQoNCj5Gcm9tOiBXb2xmZ2FuZyBHcmFuZGVnZ2VyIFttYWlsdG86d2dA
Z3JhbmRlZ2dlci5jb21dDQo+U2VudDogTW9uZGF5LCBTZXB0ZW1iZXIgMTEsIDIwMTcgMzowNiBQ
TQ0KPg0KPkhlbGxvIFpIVSBZaSwNCj4NCj5BbSAxMS4wOS4yMDE3IHVtIDA0OjI5IHNjaHJpZWIg
WkhVIFlpIChTVC1GSVIvRU5HMS1aaHUpOg0KPj4gWy4uLl0NCj4NCj5UaGUgcGF0Y2hlcyBhcmUg
ZmluZS4gWW91IGNhbiBhZGQgbXk6DQo+DQo+IkFja2VkLWJ5OiBXb2xmZ2FuZyBHcmFuZGVnZ2Vy
IDx3Z0BncmFuZGVnZ2VyLmNvbT4NClRoYW5rcyEgOikNCg0KPg0KPj4gWy4uLl0NCj4NCj5Db3Vs
ZCB5b3UgcGxlYXNlIGFkZCB0aGUgcGF0Y2ggYmVsb3cgZm9yIHRoZSBpLk1YMjg6DQo+DQo+RnJv
bSBjOGM2MWZkMDJlMDE2ZmY4OTBhOWEwZjY3MmNjNjM3OTBiYzhhNDA4IE1vbiBTZXAgMTcgMDA6
MDA6MDAgMjAwMQ0KPkZyb206IFdvbGZnYW5nIEdyYW5kZWdnZXIgPHdnQGdyYW5kZWdnZXIuY29t
Pg0KPkRhdGU6IE1vbiwgMTEgU2VwIDIwMTcgMDg6NTk6NTMgKzAyMDANCj5TdWJqZWN0OiBbUEFU
Q0hdIGNhbjogZmxleGNhbjogZml4IGkuTVgyOCBzdGF0ZSB0cmFuc2l0aW9uIGlzc3VlDQo+DQo+
RW5hYmxlIEZMRVhDQU5fUVVJUktfQlJPS0VOX1BFUlJfU1RBVEUgZm9yIGkuTVgyOCB0byByZXBv
cnQgY29ycmVjdA0KPnN0YXRlIHRyYW5zaXRpb25zLCBlc3BlY2lhbGx5IHRvIGVycm9yIHBhc3Np
dmUuDQo+DQo+U2lnbmVkLW9mZi1ieTogV29sZmdhbmcgR3JhbmRlZ2dlciA8d2dAZ3JhbmRlZ2dl
ci5jb20+DQo+LS0tDQo+IGRyaXZlcnMvbmV0L2Nhbi9mbGV4Y2FuLmMgfCA0ICsrKy0NCj4gMSBm
aWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPg0KPmRpZmYgLS1n
aXQgYS9kcml2ZXJzL25ldC9jYW4vZmxleGNhbi5jIGIvZHJpdmVycy9uZXQvY2FuL2ZsZXhjYW4u
Yw0KPmluZGV4IDU3YjM3NDQ2Li5jOWIzYTFhIDEwMDY0NA0KPi0tLSBhL2RyaXZlcnMvbmV0L2Nh
bi9mbGV4Y2FuLmMNCj4rKysgYi9kcml2ZXJzL25ldC9jYW4vZmxleGNhbi5jDQo+QEAgLTI4NSw3
ICsyODUsOSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGZsZXhjYW5fZGV2dHlwZV9kYXRhIGZzbF9w
MTAxMF9kZXZ0eXBlX2RhdGEgPSB7DQo+IAkucXVpcmtzID0gRkxFWENBTl9RVUlSS19CUk9LRU5f
V0VSUl9TVEFURSwNCj4gfTsNCj4NCj4tc3RhdGljIGNvbnN0IHN0cnVjdCBmbGV4Y2FuX2RldnR5
cGVfZGF0YSBmc2xfaW14MjhfZGV2dHlwZV9kYXRhOw0KPitzdGF0aWMgY29uc3Qgc3RydWN0IGZs
ZXhjYW5fZGV2dHlwZV9kYXRhIGZzbF9pbXgyOF9kZXZ0eXBlX2RhdGEgPSB7DQo+KwkucXVpcmtz
ID0gRkxFWENBTl9RVUlSS19CUk9LRU5fUEVSUl9TVEFURSwNCj4rfTsNCj4NCj4gc3RhdGljIGNv
bnN0IHN0cnVjdCBmbGV4Y2FuX2RldnR5cGVfZGF0YSBmc2xfaW14NnFfZGV2dHlwZV9kYXRhID0g
ew0KPiAJLnF1aXJrcyA9IEZMRVhDQU5fUVVJUktfRElTQUJMRV9SWEZHIHwgRkxFWENBTl9RVUlS
S19FTkFCTEVfRUFDRU5fUlJTIHwNCj4tLQ0KPjIuNy40DQpTdXJlLCBpdCdzIGRvbmUhIDopDQoN
Cj4NCj5JIHRoaW5rIHdlIHNob3VsZCBhZGQgdGhlIGZsYWcgYWxzbyBmb3IgdGhlICJwMTAxMCIs
IGV2ZW4gaWYgSSBoYXZlDQo+b25seSB0ZXN0ZWQgaXQgb24gdGhlIGkuTVg1MzoNCj4NCj5zdGF0
aWMgY29uc3Qgc3RydWN0IGZsZXhjYW5fZGV2dHlwZV9kYXRhIGZzbF9wMTAxMF9kZXZ0eXBlX2Rh
dGEgPSB7DQo+CS5xdWlya3MgPSBGTEVYQ0FOX1FVSVJLX0JST0tFTl9XRVJSX1NUQVRFLA0KPn07
DQpUaGUgV0VSUl9TVEFURSBpcyBhbHJlYWR5IGFkZGVkIGZvciBwMTAxMCwgZG8geW91IG1lYW4g
d2Ugc2hvdWxkIGFkZA0KdGhlIFBFUlJfU1RBVEUgdG8gcDEwMTAgYXMgd2VsbD8NCg0KQmVzdCBy
ZWdhcmRzDQpZaQ0K
