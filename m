From: Jeroen Hofstee <jhofstee@victronenergy.com>
Subject: Re: [PATCH] can: m_can: fix boolreturn.cocci warnings
Date: Tue, 15 Oct 2019 08:32:12 +0000
Message-ID: <1921cfe4-0ee0-e2a5-6696-df5f612c6c56@victronenergy.com>
References: <1571052844-22633-1-git-send-email-pankj.sharma@samsung.com>
 <20191014150428.xhhc43ovkxm6oxf2@332d0cec05f4>
 <20191015055718.mypn63s2ovgwipk3@netronome.com>
 <9ad7810b-2205-3227-7ef9-0272f3714839@victronenergy.com>
 <20191015071311.yssgqhoax46lfa7l@netronome.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191015071311.yssgqhoax46lfa7l@netronome.com>
Content-Language: en-US
Content-ID: <36FD5BB1CE056448B363901C9E4F9225@eurprd07.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Simon Horman <simon.horman@netronome.com>
Cc: kbuild test robot <lkp@intel.com>, Pankaj Sharma <pankj.sharma@samsung.com>, "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "wg@grandegger.com" <wg@grandegger.com>, "mkl@pengutronix.de" <mkl@pengutronix.de>, "davem@davemloft.net" <davem@davemloft.net>, "eugen.hristev@microchip.com" <eugen.hristev@microchip.com>, "ludovic.desroches@microchip.com" <ludovic.desroches@microchip.com>, "pankaj.dubey@samsung.com" <pankaj.dubey@samsung.com>, "rcsekar@samsung.com" <rcsekar@samsung.com>, Sriram Dash <sriram.dash@samsung.com>
List-Id: linux-can.vger.kernel.org

SGVsbG8gU2ltb24sDQoNCk9uIDEwLzE1LzE5IDk6MTMgQU0sIFNpbW9uIEhvcm1hbiB3cm90ZToN
Cj4gT24gVHVlLCBPY3QgMTUsIDIwMTkgYXQgMDY6Mzc6NTRBTSArMDAwMCwgSmVyb2VuIEhvZnN0
ZWUgd3JvdGU6DQo+PiBIaSwNCj4+DQo+PiBPbiAxMC8xNS8xOSA3OjU3IEFNLCBTaW1vbiBIb3Jt
YW4gd3JvdGU6DQo+Pj4gT24gTW9uLCBPY3QgMTQsIDIwMTkgYXQgMTE6MDQ6MjhQTSArMDgwMCwg
a2J1aWxkIHRlc3Qgcm9ib3Qgd3JvdGU6DQo+Pj4+IEZyb206IGtidWlsZCB0ZXN0IHJvYm90IDxs
a3BAaW50ZWwuY29tPg0KPj4+Pg0KPj4+PiBkcml2ZXJzL25ldC9jYW4vbV9jYW4vbV9jYW4uYzo3
ODM6OS0xMDogV0FSTklORzogcmV0dXJuIG9mIDAvMSBpbiBmdW5jdGlvbiAnaXNfcHJvdG9jb2xf
ZXJyJyB3aXRoIHJldHVybiB0eXBlIGJvb2wNCj4+Pj4NCj4+Pj4gICAgUmV0dXJuIHN0YXRlbWVu
dHMgaW4gZnVuY3Rpb25zIHJldHVybmluZyBib29sIHNob3VsZCB1c2UNCj4+Pj4gICAgdHJ1ZS9m
YWxzZSBpbnN0ZWFkIG9mIDEvMC4NCj4+Pj4gR2VuZXJhdGVkIGJ5OiBzY3JpcHRzL2NvY2NpbmVs
bGUvbWlzYy9ib29scmV0dXJuLmNvY2NpDQo+Pj4+DQo+Pj4+IEZpeGVzOiA0Njk0NjE2M2FjNjEg
KCJjYW46IG1fY2FuOiBhZGQgc3VwcG9ydCBmb3IgaGFuZGxpbmcgYXJiaXRyYXRpb24gZXJyb3Ii
KQ0KPj4+PiBDQzogUGFua2FqIFNoYXJtYSA8cGFua2ouc2hhcm1hQHNhbXN1bmcuY29tPg0KPj4+
PiBTaWduZWQtb2ZmLWJ5OiBrYnVpbGQgdGVzdCByb2JvdCA8bGtwQGludGVsLmNvbT4NCj4+Pj4g
LS0tDQo+Pj4+DQo+Pj4+IHVybDogICAgaHR0cHM6Ly9naXRodWIuY29tLzBkYXktY2kvbGludXgv
Y29tbWl0cy9QYW5rYWotU2hhcm1hL2Nhbi1tX2Nhbi1hZGQtc3VwcG9ydC1mb3ItaGFuZGxpbmct
YXJiaXRyYXRpb24tZXJyb3IvMjAxOTEwMTQtMTkzNTMyDQo+Pj4+DQo+Pj4+ICAgIG1fY2FuLmMg
fCAgICA0ICsrLS0NCj4+Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBk
ZWxldGlvbnMoLSkNCj4+Pj4NCj4+Pj4gLS0tIGEvZHJpdmVycy9uZXQvY2FuL21fY2FuL21fY2Fu
LmMNCj4+Pj4gKysrIGIvZHJpdmVycy9uZXQvY2FuL21fY2FuL21fY2FuLmMNCj4+Pj4gQEAgLTc4
MCw5ICs3ODAsOSBAQCBzdGF0aWMgaW5saW5lIGJvb2wgaXNfbGVjX2Vycih1MzIgcHNyKQ0KPj4+
PiAgICBzdGF0aWMgaW5saW5lIGJvb2wgaXNfcHJvdG9jb2xfZXJyKHUzMiBpcnFzdGF0dXMpDQo+
Pj4+ICAgIHsNCj4+Pj4gICAgCWlmIChpcnFzdGF0dXMgJiBJUl9FUlJfTEVDXzMxWCkNCj4+Pj4g
LQkJcmV0dXJuIDE7DQo+Pj4+ICsJCXJldHVybiB0cnVlOw0KPj4+PiAgICAJZWxzZQ0KPj4+PiAt
CQlyZXR1cm4gMDsNCj4+Pj4gKwkJcmV0dXJuIGZhbHNlOw0KPj4+PiAgICB9DQo+Pj4+ICAgIA0K
Pj4+PiAgICBzdGF0aWMgaW50IG1fY2FuX2hhbmRsZV9wcm90b2NvbF9lcnJvcihzdHJ1Y3QgbmV0
X2RldmljZSAqZGV2LCB1MzIgaXJxc3RhdHVzKQ0KPj4+Pg0KPj4+IDwyYz4NCj4+PiBQZXJoYXBz
IHRoZSBmb2xsb3dpbmcgaXMgYSBuaWNlciB3YXkgdG8gZXhwcmVzcyB0aGlzIChjb21wbGV0ZWx5
IHVudGVzdGVkKToNCj4+Pg0KPj4+IAlyZXR1cm4gISEoaXJxc3RhdHVzICYgSVJfRVJSX0xFQ18z
MVgpOw0KPj4+IDwvMmM+DQo+Pg0KPj4gUmVhbGx5Li4uLiwgISEgZm9yIGJvb2wgLyBfQm9vbCB0
eXBlcz8gd2h5IG5vdCBzaW1wbHk6DQo+Pg0KPj4gc3RhdGljIGlubGluZSBib29sIGlzX3Byb3Rv
Y29sX2Vycih1MzIgaXJxc3RhdHVzKQ0KPj4gCXJldHVybiBpcnFzdGF0dXMgJiBJUl9FUlJfTEVD
XzMxWDsNCj4+IH0NCj4gR29vZCBwb2ludCwgc2lsbHkgbWUuDQoNCg0KRm9yIGNsYXJpdHksIEkg
YW0gY29tbWVudGluZyBvbiB0aGUgc3VnZ2VzdGlvbiBtYWRlIGJ5DQp0aGUgdG9vbCwgbm90IHRo
ZSBwYXRjaCBpdHNlbGYuLg0KDQpSZWdhcmRzLA0KDQpKZXJvZW4NCg0K
