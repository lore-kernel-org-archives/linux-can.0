From: "ZHU Yi (ST-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>
Subject: RE: [PATCH 3/4] can: flexcan: implement error passive state quirk
Date: Tue, 12 Sep 2017 08:59:20 +0000
Message-ID: <7bf3b18e225841b5a47430348c3c8489@SGPMBX1017.APAC.bosch.com>
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
 <e878b7f3840c4a60940828a3e77d4ee7@SGPMBX1017.APAC.bosch.com>
 <e1a698c3-58f6-9165-ff8a-595dbee3f70c@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:50555 "EHLO
        smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751214AbdILI7j (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 12 Sep 2017 04:59:39 -0400
In-Reply-To: <e1a698c3-58f6-9165-ff8a-595dbee3f70c@grandegger.com>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Andri Yngvason <andri.yngvason@marel.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "hs@denx.de" <hs@denx.de>, "RUAN Tingquan (ST-FIR/ENG1-Zhu)" <Tingquan.Ruan@cn.bosch.com>, "Jonas Mark (ST-FIR/ENG1)" <Mark.Jonas@de.bosch.com>

SGVsbG8gV29sZmdhbmcsDQoNCj5Gcm9tOiBXb2xmZ2FuZyBHcmFuZGVnZ2VyIFttYWlsdG86d2dA
Z3JhbmRlZ2dlci5jb21dDQo+U2VudDogVHVlc2RheSwgU2VwdGVtYmVyIDEyLCAyMDE3IDI6NTQg
UE0NCj4+PiBbLi4uXQ0KPj4+IEkgdGhpbmsgd2Ugc2hvdWxkIGFkZCB0aGUgZmxhZyBhbHNvIGZv
ciB0aGUgInAxMDEwIiwgZXZlbiBpZiBJIGhhdmUNCj4+PiBvbmx5IHRlc3RlZCBpdCBvbiB0aGUg
aS5NWDUzOg0KPj4+DQo+Pj4gc3RhdGljIGNvbnN0IHN0cnVjdCBmbGV4Y2FuX2RldnR5cGVfZGF0
YSBmc2xfcDEwMTBfZGV2dHlwZV9kYXRhID0gew0KPj4+IAkucXVpcmtzID0gRkxFWENBTl9RVUlS
S19CUk9LRU5fV0VSUl9TVEFURSwNCj4+PiB9Ow0KPj4gVGhlIFdFUlJfU1RBVEUgaXMgYWxyZWFk
eSBhZGRlZCBmb3IgcDEwMTAsIGRvIHlvdSBtZWFuIHdlIHNob3VsZCBhZGQNCj4+IHRoZSBQRVJS
X1NUQVRFIHRvIHAxMDEwIGFzIHdlbGw/DQo+DQo+WWVzLCBiZWNhdXNlIGJ1cyBlcnJvciBpbnRl
cnJ1cHQgZmxvb2RpbmcgbWF5IGJlIGEgcHJvYmxlbSBvbiB0aGVzZQ0KPnN5c3RlbXMsIGVzcGVj
aWFsbHkgbG93LWVuZCBzeXN0ZW0uIEFuZCBXRVJSX1NUQVRFIGVuYWJsZXMgdGhlIGJ1cyBlcnJv
cg0KPmludGVycnVwdCBmcm9tIHRoZSBiZWdpbm5pbmcuDQpPSywgSSdsbCBzZW5kIHRoZSB1cGRh
dGVkIHBhdGNoIHNlcmllcyBsYXRlci4gOikNCg0KVGhhbmtzDQpZaQ0K
