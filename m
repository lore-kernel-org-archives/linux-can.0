From: "ZHU Yi (ST-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>
Subject: RE: [PATCH v2 2/2] can: flexcan: adding platform specific details for
 LS1021A
Date: Tue, 21 Nov 2017 03:31:01 +0000
Message-ID: <63a0798d1f5b4fa6ada730c6ba03480c@SGPMBX1017.APAC.bosch.com>
References: <1510307990-15418-1-git-send-email-pankaj.bansal@nxp.com>
 <1510660589-16125-1-git-send-email-pankaj.bansal@nxp.com>
 <1510660589-16125-2-git-send-email-pankaj.bansal@nxp.com>
 <828fba89-66dc-a2c5-e095-8554b9dce5d5@pengutronix.de>
 <AM0PR0402MB3940A4B29C67BAD85F461331F12E0@AM0PR0402MB3940.eurprd04.prod.outlook.com>
 <343d8c69-a01a-5ff7-75a2-99523391f97c@grandegger.com>
 <ff7b32a8bc694c92b10967bfd2de24fa@SGPMBX1017.APAC.bosch.com>
 <AM0PR0402MB394058F204ECA509D1ADB6AEF1220@AM0PR0402MB3940.eurprd04.prod.outlook.com>
 <cf35f42c513946918031b4c1cf6d8778@SGPMBX1017.APAC.bosch.com>
 <AM0PR0402MB3940F2C5AEB0734DC8B79608F1230@AM0PR0402MB3940.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:57792 "EHLO
        smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752263AbdKUDbF (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 20 Nov 2017 22:31:05 -0500
In-Reply-To: <AM0PR0402MB3940F2C5AEB0734DC8B79608F1230@AM0PR0402MB3940.eurprd04.prod.outlook.com>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Pankaj Bansal <pankaj.bansal@nxp.com>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Varun Sethi <V.Sethi@nxp.com>, Poonam Aggrwal <poonam.aggrwal@nxp.com>, Bhupesh Sharma <bhupesh.sharma@freescale.com>

SGVsbG8gUGFua2FqLA0KDQo+RnJvbTogUGFua2FqIEJhbnNhbCBbbWFpbHRvOnBhbmthai5iYW5z
YWxAbnhwLmNvbV0NCj5TZW50OiBUdWVzZGF5LCBOb3ZlbWJlciAyMSwgMjAxNyAxMDozOCBBTQ0K
PiBbLi4uXQ0KPg0KPlRoYW5rcyBaaHUgWWkuIEluIHRoYXQgY2FzZSBkbyB3ZSBldmVuIG5lZWQg
dG8gcHV0IHRoZXNlIGNoYW5nZXMgaW4gYSBxdWlyaz8NCj5TaG91bGRuJ3QgdGhpcyBjb2RlIGJl
IGdlbmVyaWMgZmxleGNhbiBjb2RlLCBpcnJlc3BlY3RpdmUgb2YgdGhlIHBsYXRmb3JtPw0KSWYg
aW4gdGhlIGZ1dHVyZSB2ZXJzaW9uIG9mIGZsZXhjYW4gc3VwcG9ydHMgdGhlIGNvbXBsZXRlIHNl
dCBvZg0Kc3RhdGUgaW50ZXJydXB0cywgdGhlbiB0aGUgbmV3IGNvcmUgd2hpY2ggZG9uJ3QgbmVl
ZCB0aGUgd29ya2Fyb3VuZA0KY2FuIHN3aXRjaCBpdCBvZmYgZWFzaWx5IHZpYSBub3Qgc3BlY2lm
eWluZyB0aGVzZSBxdWlya3MuDQoNCk1ha2UgaXQgaXJyZXNwZWN0aXZlIG9mIHRoZSBwbGF0Zm9y
bSB3aWxsIGFkZCB0aGUgdW5uZWNlc3Nhcnkgb3ZlcmhlYWQNCnRvIHRoZSBuZXcgY29yZSAoYWx0
aG91Z2ggdGhlIG92ZXJoZWFkIGlzIGxpdHRsZSkuDQoNCj4NCj4gWy4uLl0NCj4NCj5JIHdpbGwg
dGVzdCB0aGlzIGFmdGVyIFBFUlJfU1RBVEUgcXVpcmsuIEJ1dCBhcyBJIG1lbnRpb25lZCBhYm92
ZSwgaW4gbXkgb3Bpbmlvbg0KPndlIHNob3VsZCByZW1vdmUgRkxFWENBTl9RVUlSS19CUk9LRU5f
UEVSUl9TVEFURSwgYW5kIG1ha2UgdGhlc2UgY2hhbmdlcw0KPmNvbW1vbiBmb3IgYWxsIHBsYXRm
b3Jtcy4NClRoYW5rcywgSSdtIGxvb2tpbmcgZm9yd2FyZCB0byB0aGUgdGVzdCByZXN1bHRzLiBB
cyBleHBsYWluZWQgYWJvdmUsDQp3ZSBhcmUgc3RpbGwgaW4gdGhlIGhvcGUgdGhhdCBGTEVYQ0FO
IG1pZ2h0IGltcHJvdmUgaW4gdGhlIGZ1dHVyZS4gOikNCg0KQmVzdCByZWdhcmRzDQpZaQ0K
