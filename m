From: "Schenk, Gavin" <G.Schenk@eckelmann.de>
Subject: Re: [PATCH 1/2] can: flexcan: fix endianess detection
Date: Thu, 26 Apr 2018 06:06:01 +0000
Message-ID: <59d27567946e3c11b7cce38dfc773405cb0046d3.camel@eckelmann.de>
References: <20180425145040.22031-1-u.kleine-koenig@pengutronix.de>
 <20180425145040.22031-2-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180425145040.22031-2-u.kleine-koenig@pengutronix.de>
Content-Language: de-DE
Content-ID: <5BA20BAAE4B86142B1E0406EF007BEC2@eckelmann.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>, "wg@grandegger.com" <wg@grandegger.com>, "mkl@pengutronix.de" <mkl@pengutronix.de>
Cc: "kernel@pengutronix.de" <kernel@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

SGksDQoNCj4gSW4gY29tbWl0IDg4NDYyZDJhNzgzMCAoImNhbjogZmxleGNhbjogUmVtb2RlbCBG
bGV4Q0FOIHJlZ2lzdGVyIHIvdyBBUElzDQo+IGZvciBiaWcgZW5kaWFuIEZsZXhDQU4gY29udHJv
bGxlcnMuIikgdGhlIGZvbGxvd2luZyBsb2dpYyB3YXMNCj4gaW1wbGVtZW50ZWQ6DQo+IA0KPiAJ
aWYgdGhlIGR0IHByb3BlcnR5ICJiaWctZW5kaWFuIiBpcyBnaXZlbiBvcg0KPiAJICAgdGhlIGRl
dmljZSBpcyBjb21wYXRpYmxlIHRvICJmc2wscDEwMTAtZmxleGNhbiI6DQo+IAkJdXNlIGJpZy1l
bmRpYW4gbW9kZTsNCj4gCWVsc2UNCj4gCQl1c2UgbGl0dGxlLWVuZGlhbiBtb2RlOw0KPiANCj4g
VGhpcyByZWxpZXMgb24gY29tbWl0IGQ1MGY0NjMwYzJlMSAoImFybTogZHRzOiBSZW1vdmUgcDEw
MTAtZmxleGNhbg0KPiBjb21wYXRpYmxlIGZyb20gaW14IHNlcmllcyBkdHMiKSB3aGljaCB3YXMg
YXBwbGllZCBhIGZldyBjb21taXRzIGxhdGVyLg0KPiBXaXRob3V0IHRoaXMgY29tbWl0IChvciBh
biBvbGQgZGV2aWNlIHRyZWUgdXNlZCBmb3IgYm9vdGluZyBhIG5ldw0KPiBrZXJuZWwpIHRoZSBm
bGV4Y2FuIGRldmljZXMgb24gaS5NWDI1LCBpLk1YMjgsIGkuTVgzNSBhbmQgaS5NWDUzIG1hdGNo
DQo+IHRoZSAndGhlIGRldmljZSBpcyBjb21wYXRpYmxlIHRvICJmc2wscDEwMTAtZmxleGNhbiIn
IHRlc3QgYW5kIHNvIGFyZQ0KPiBzd2l0Y2hlZCBlcnJvbmVvdXNseSB0byBiaWcgZW5kaWFuIG1v
ZGUuDQo+IA0KPiBJbnN0ZWFkIG9mIHRoZSBjaGVjayBhYm92ZSBwdXQgYSBmbGFnIGludG8gZGV2
dHlwZSBkYXRhIGFuZCByZWx5IG9uDQo+IG9mX21hdGNoX2RldmljZSB5aWVsZGluZyB0aGUgbW9z
dCBjb21wYXRpYmxlIG1hdGNoDQo+IA0KPiBGaXhlczogODg0NjJkMmE3ODMwICgiY2FuOiBmbGV4
Y2FuOiBSZW1vZGVsIEZsZXhDQU4gcmVnaXN0ZXIgci93IEFQSXMgZm9yIGJpZw0KPiBlbmRpYW4g
RmxleENBTiBjb250cm9sbGVycy4iKQ0KPiBTaWduZWQtb2ZmLWJ5OiBVd2UgS2xlaW5lLUvDtm5p
ZyA8dS5rbGVpbmUta29lbmlnQHBlbmd1dHJvbml4LmRlPg0KVGVzdGVkLWJ5OiBHYXZpbiBTY2hl
bmsgPGcuc2NoZW5rQGVja2VsbWFubi5kZT4NCg0KUmVnYXJkcw0KR2F2aW4gU2NoZW5rCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJu
ZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
