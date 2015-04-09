From: "bhupesh.sharma@freescale.com" <bhupesh.sharma@freescale.com>
Subject: RE: [PATCH 3/3] can: flexcan: Add support for non RX-FIFO mode and
 ERRATA ERR005829
Date: Thu, 9 Apr 2015 15:45:37 +0000
Message-ID: <BY1PR0301MB1303A2C667A89188E2E9383B82FB0@BY1PR0301MB1303.namprd03.prod.outlook.com>
References: <1428593056-13701-1-git-send-email-bhupesh.sharma@freescale.com>
 <1428593056-13701-3-git-send-email-bhupesh.sharma@freescale.com>
 <55269D84.1070606@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bn1on0137.outbound.protection.outlook.com ([157.56.110.137]:22416
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755477AbbDIPpl (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 9 Apr 2015 11:45:41 -0400
In-Reply-To: <55269D84.1070606@pengutronix.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "arnd@arndb.de" <arnd@arndb.de>, "bhupesh.linux@gmail.com" <bhupesh.linux@gmail.com>, "Sakar.Arora@freescale.com" <Sakar.Arora@freescale.com>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXJjIEtsZWluZS1CdWRkZSBb
bWFpbHRvOm1rbEBwZW5ndXRyb25peC5kZV0NCj4gT24gMDQvMDkvMjAxNSAwNToyNCBQTSwgQmh1
cGVzaCBTaGFybWEgd3JvdGU6DQo+ID4gVGhpcyBwYXRjaCBhZGRzIHN1cHBvcnQgZm9yIG5vbiBS
WC1GSUZPIChsZWdhY3kpIG1vZGUgYW5kIEVSUkFUQQ0KPiA+IEVSUjAwNTgyOSBoYW5kbGluZyBp
biBmbGV4Y2FuIGRyaXZlci4NCj4gDQo+IFdoYXQgYWJvdXQNCj4gMjVlOTI0NDUwZmNiIGNhbjog
ZmxleGNhbjogaW1wbGVtZW50IHdvcmthcm91bmQgZm9yIGVycmF0YSBFUlIwMDU4MjkgPw0KDQpP
b3BzLCBsb29rcyBsaWtlIGEgdHlwby4gV2lsbCBmaXggaW4gVjIuDQoNCj4gPiBCb3RoIHRoZXNl
IGZlYXR1cmVzIGFyZSBub3cgc2VsZWN0YWJsZSB2aWEgS2NvbmZpZyBlbnRyaWVzIGFuZCBoZW5j
ZQ0KPiA+IGNhbiBiZSB0dXJuZWQtb24vb2ZmIGFzIHBlciBhIFNvQyBmZWF0dXJlIHNldCBhdmFp
bGFiaWxpdHkuDQo+IA0KPiBTb3JyeSBLY29uZmlnIGlzIG5vdCBhbiBvcHRpb24gaGVyZS4NCg0K
SSBtZWFudCB0aGUgZGVmY29uZmlnIGhlcmUuIEJ5IGRlZmF1bHQgdGhlIGVycmF0YSBoYW5kbGlu
ZyB3b3VsZCBiZSB0dXJuZWQtb2ZmDQppbiB0aGUgS2NvbmZpZy4NCg0KQW55IG90aGVyIGlkZWFz
Pw0KDQoNClJlZ2FyZHMsDQpCaHVwZXNoDQo=
