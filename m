From: "bhupesh.sharma@freescale.com" <bhupesh.sharma@freescale.com>
Subject: RE: [PATCH 2/2] arm/dts: Add nodes for flexcan devices present on
 LS1021A SoC
Date: Thu, 9 Apr 2015 15:31:39 +0000
Message-ID: <BY1PR0301MB130321631BC01630EA87441282FB0__40241.3596901626$1428593853$gmane$org@BY1PR0301MB1303.namprd03.prod.outlook.com>
References: <1428591087-12831-1-git-send-email-bhupesh.sharma@freescale.com>
 <1428591087-12831-2-git-send-email-bhupesh.sharma@freescale.com>
 <55269444.7050707@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:60125 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755688AbbDIPhR (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 9 Apr 2015 11:37:17 -0400
Received: from gallifrey.ext.pengutronix.de ([2001:6f8:1178:4:5054:ff:fe8d:eefb] helo=bjornoya.do.blackshift.org)
	by metis.ext.pengutronix.de with esmtp (Exim 4.72)
	(envelope-from <mkl@pengutronix.de>)
	id 1YgEW3-0001HX-QY
	for linux-can@vger.kernel.org; Thu, 09 Apr 2015 17:37:15 +0200
Received: from [172.17.34.170] (unknown [172.17.34.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	(Authenticated sender: frogger)
	by bjornoya.do.blackshift.org (Postfix) with ESMTPSA id 7F012E61D
	for <linux-can@vger.kernel.org>; Thu,  9 Apr 2015 15:37:15 +0000 (UTC)
In-Reply-To: <55269444.7050707@pengutronix.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, "arnd@arndb.de" <arnd@arndb.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: "bhupesh.linux@gmail.com" <bhupesh.linux@gmail.com>, "olof@lixom.net" <olof@lixom.net>, "Sakar.Arora@freescale.com" <Sakar.Arora@freescale.com>

SGkgTWFyYywNCg0KPiBGcm9tOiBNYXJjIEtsZWluZS1CdWRkZSBbbWFpbHRvOm1rbEBwZW5ndXRy
b25peC5kZV0NCj4gDQo+IE9uIDA0LzA5LzIwMTUgMDQ6NTEgUE0sIEJodXBlc2ggU2hhcm1hIHdy
b3RlOg0KPiA+IEZyb206IFNha2FyIEFyb3JhIDxTYWthci5Bcm9yYUBmcmVlc2NhbGUuY29tPg0K
PiA+DQo+ID4gVGhpcyBwYXRjaCBhZGRzIHRoZSBkZXZpY2Ugbm9kZXMgZm9yIGZsZXhjYW4gY29u
dHJvbGxlcihzKSBwcmVzZW50IG9uDQo+ID4gTFMxMDIxQSBTb0MuDQo+ID4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBCaHVwZXNoIFNoYXJtYSA8Ymh1cGVzaC5zaGFybWFAZnJlZXNjYWxlLmNvbT4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBTYWthciBBcm9yYSA8U2FrYXIuQXJvcmFAZnJlZXNjYWxlLmNvbT4N
Cj4gPiAtLS0NCj4gPiAgYXJjaC9hcm0vYm9vdC9kdHMvbHMxMDIxYS1xZHMuZHRzIHwgICAgOCAr
KysrKysrKw0KPiA+ICBhcmNoL2FybS9ib290L2R0cy9sczEwMjFhLmR0c2kgICAgfCAgIDIwICsr
KysrKysrKysrKysrKysrKysrDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMjggaW5zZXJ0aW9ucygr
KQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2xzMTAyMWEtcWRzLmR0
cw0KPiA+IGIvYXJjaC9hcm0vYm9vdC9kdHMvbHMxMDIxYS1xZHMuZHRzDQo+ID4gaW5kZXggOWM1
ZTE2Yi4uMTY0MWEwNCAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9sczEwMjFh
LXFkcy5kdHMNCj4gPiArKysgYi9hcmNoL2FybS9ib290L2R0cy9sczEwMjFhLXFkcy5kdHMNCj4g
PiBAQCAtMjM4LDMgKzIzOCwxMSBAQA0KPiA+ICAmdWFydDEgew0KPiA+ICAJc3RhdHVzID0gIm9r
YXkiOw0KPiA+ICB9Ow0KPiA+ICsNCj4gPiArJmNhbjAgew0KPiA+ICsJc3RhdHVzID0gIm9rYXki
Ow0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArJmNhbjEgew0KPiA+ICsJc3RhdHVzID0gIm9rYXkiOw0K
PiA+ICt9Ow0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9sczEwMjFhLmR0c2kN
Cj4gPiBiL2FyY2gvYXJtL2Jvb3QvZHRzL2xzMTAyMWEuZHRzaSBpbmRleCBjNzBiYjI3Li5jNDQ2
NjFiIDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2xzMTAyMWEuZHRzaQ0KPiA+
ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2xzMTAyMWEuZHRzaQ0KPiA+IEBAIC0zMzIsNiArMzMy
LDI2IEBADQo+ID4gIAkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+ID4gIAkJfTsNCj4gPg0KPiA+
ICsJCWNhbjA6IGNhbkAyYTcwMDAwIHsNCj4gPiArCQkJY29tcGF0aWJsZSA9ICJmc2wsbHMxMDIx
YS1mbGV4Y2FuIjsNCj4gPiArCQkJcmVnID0gPDB4MCAweDJhNzAwMDAgMHgwIDB4MTAwMD47DQo+
ID4gKwkJCWludGVycnVwdHMgPSA8R0lDX1NQSSAxMjYgSVJRX1RZUEVfTEVWRUxfSElHSD47DQo+
ID4gKwkJCWNsb2NrcyA9IDwmcGxhdGZvcm1fY2xrIDE+Ow0KPiA+ICsJCQljbG9jay1mcmVxdWVu
Y3kgPSA8MTUwMDAwMDAwPjsNCj4gDQo+IFBsZWFzZSBkb24ndCB1c2UgY2xvY2stZnJlcXVlbmN5
LCBpdCdzIG9ubHkgbmVlZGVkIGZvciBwb3dlcnBjcyB3aXRob3V0DQo+IHByb3BlciBjbG9jayBz
dXBwb3J0Lg0KDQpPay4gV2lsbCBmaXggaW4gdjIuDQoNCj4gDQo+ID4gKwkJCWNsb2NrLW5hbWVz
ID0gInBlciI7DQo+IA0KPiBQbGVhc2UgcHJvdmlkZSBhIHBlciBhbmQgaXBnIGNsb2NrLCBvdGhl
cndpc2UgdGhlIGRyaXZlciB3aWxsIG5vdCB3b3JrDQo+IHByb3Blcmx5Lg0KDQpPay4gV2lsbCBm
aXggaW4gdjIuDQoNCj4gPiArCQkJbGl0dGxlLWVuZGlhbjsNCj4gPiArCQl9Ow0KPiANCg0KUmVn
YXJkcywNCkJodXBlc2gNCg==

