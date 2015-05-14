From: Sharma Bhupesh <bhupesh.sharma@freescale.com>
Subject: RE: [PATCH v2 5/5] can: flexcan: Add support for non RX-FIFO mode
Date: Thu, 14 May 2015 15:44:19 +0000
Message-ID: <BY1PR0301MB130358076C3A5969406DE69182D80@BY1PR0301MB1303.namprd03.prod.outlook.com>
References: <1431603215-25546-1-git-send-email-bhupesh.sharma@freescale.com>
 <1431603215-25546-6-git-send-email-bhupesh.sharma@freescale.com>
 <5554C244.80809@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bl2on0135.outbound.protection.outlook.com ([65.55.169.135]:59760
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S934261AbbENPoW (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 14 May 2015 11:44:22 -0400
In-Reply-To: <5554C244.80809@pengutronix.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, "arnd@arndb.de" <arnd@arndb.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "bhupesh.linux@gmail.com" <bhupesh.linux@gmail.com>, Arora Sakar <Sakar.Arora@freescale.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXJjIEtsZWluZS1CdWRkZSBb
bWFpbHRvOm1rbEBwZW5ndXRyb25peC5kZV0NCj4gU2VudDogVGh1cnNkYXksIE1heSAxNCwgMjAx
NSA5OjEyIFBNDQo+IFRvOiBTaGFybWEgQmh1cGVzaC1CNDUzNzA7IGFybmRAYXJuZGIuZGU7IGxp
bnV4LWNhbkB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IGJodXBlc2gubGludXhAZ21haWwuY29tOyBB
cm9yYSBTYWthci1CNDUyMDU7IGxpbnV4LWFybS0NCj4ga2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiA1LzVdIGNhbjogZmxleGNhbjogQWRkIHN1cHBv
cnQgZm9yIG5vbiBSWC1GSUZPDQo+IG1vZGUNCj4gDQo+IE9uIDA1LzE0LzIwMTUgMDE6MzMgUE0s
IEJodXBlc2ggU2hhcm1hIHdyb3RlOg0KPiA+IFRoaXMgcGF0Y2ggYWRkcyBzdXBwb3J0IGZvciBu
b24gUlgtRklGTyAobGVnYWN5KSBtb2RlIGluIHRoZSBmbGV4Y2FuDQo+ID4gZHJpdmVyLg0KPiA+
DQo+ID4gT24gY2VydGFpbiBTb0NzLCB0aGUgUlgtRklGTyBzdXBwb3J0IG1pZ2h0IGJlIGJyb2tl
biwgYXMgYSByZXN1bHQgd2UNCj4gPiBuZWVkIHRvIGZhbGwtYmFjayBvbiB0aGUgbGVnYWN5IChu
b24gUlgtRklGTykgbW9kZSB0byByZWNlaXZlIENBTg0KPiA+IGZyYW1lcy4NCj4gPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IEJodXBlc2ggU2hhcm1hIDxiaHVwZXNoLnNoYXJtYUBmcmVlc2NhbGUuY29t
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNha2FyIEFyb3JhIDxTYWthci5Bcm9yYUBmcmVlc2NhbGUu
Y29tPg0KPiANCj4gVGhlIG5vbiBGSUZPIG1vZGUgZG9lc24ndCBndWFyYW50ZWUgdGhlIG9yZGVy
IG9mIHRoZSBpbmNvbWluZyBmcmFtZXMsIG5vdA0KPiBkb2VzIG5vdCBldmVuIHRyeSB0by4uLnRo
aXMgaXMgbm90IGFjY2VwdGFibGUuIEknbSBjdXJyZW50bHkgd29ya2luZyBvbiBhDQo+IHBhdGNo
IGJ5IERhdmlkIEphbmRlciB0aGF0IGJyaW5ncyBpbiBub24gRklGTyBtb2RlLCBidXQgdHJpZXMg
dG8ga2VlcCB0aGUNCj4gb3JkZXIgb2YgdGhlIGZyYW1lcy4NCg0KVGhhdCBpcyBhbHJlYWR5IFdJ
UCBhdCBvdXIgZW5kLiBWMyB3aWxsIGNvbnRhaW4gdGhlIHNhbWUgY2hhbmdlLg0KSWYgeW91IGFy
ZSBhbHJlYWR5IHdvcmtpbmcgb24gaXQsIEkgZG9uJ3Qga25vdyBob3cgdG8gcHJvY2VlZCBmdXJ0
aGVyDQphcyB3ZSBoYWQgYWxyZWFkeSB2MSBvZiB0aGlzIHBhdGNoc2V0IHdpdGggdGhlIG5vbiBG
SUZPIG1vZGUgb3V0DQpzaW5jZSBhIG1vbnRoIG9yIHNvLg0KDQpSZWdhcmRzLA0KQmh1cGVzaA0K
