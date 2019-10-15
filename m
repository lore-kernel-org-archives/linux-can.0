From: Jeroen Hofstee <jhofstee@victronenergy.com>
Subject: Re: [PATCH] can: m_can: fix boolreturn.cocci warnings
Date: Tue, 15 Oct 2019 06:37:54 +0000
Message-ID: <9ad7810b-2205-3227-7ef9-0272f3714839@victronenergy.com>
References: <1571052844-22633-1-git-send-email-pankj.sharma@samsung.com>
 <20191014150428.xhhc43ovkxm6oxf2@332d0cec05f4>
 <20191015055718.mypn63s2ovgwipk3@netronome.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191015055718.mypn63s2ovgwipk3@netronome.com>
Content-Language: en-US
Content-ID: <DD62C6ECD996A94FA3C4F36AE0F4CF58@eurprd07.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Simon Horman <simon.horman@netronome.com>, kbuild test robot <lkp@intel.com>
Cc: Pankaj Sharma <pankj.sharma@samsung.com>, "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "wg@grandegger.com" <wg@grandegger.com>, "mkl@pengutronix.de" <mkl@pengutronix.de>, "davem@davemloft.net" <davem@davemloft.net>, "eugen.hristev@microchip.com" <eugen.hristev@microchip.com>, "ludovic.desroches@microchip.com" <ludovic.desroches@microchip.com>, "pankaj.dubey@samsung.com" <pankaj.dubey@samsung.com>, "rcsekar@samsung.com" <rcsekar@samsung.com>, Sriram Dash <sriram.dash@samsung.com>
List-Id: linux-can.vger.kernel.org

SGksDQoNCk9uIDEwLzE1LzE5IDc6NTcgQU0sIFNpbW9uIEhvcm1hbiB3cm90ZToNCj4gT24gTW9u
LCBPY3QgMTQsIDIwMTkgYXQgMTE6MDQ6MjhQTSArMDgwMCwga2J1aWxkIHRlc3Qgcm9ib3Qgd3Jv
dGU6DQo+PiBGcm9tOiBrYnVpbGQgdGVzdCByb2JvdCA8bGtwQGludGVsLmNvbT4NCj4+DQo+PiBk
cml2ZXJzL25ldC9jYW4vbV9jYW4vbV9jYW4uYzo3ODM6OS0xMDogV0FSTklORzogcmV0dXJuIG9m
IDAvMSBpbiBmdW5jdGlvbiAnaXNfcHJvdG9jb2xfZXJyJyB3aXRoIHJldHVybiB0eXBlIGJvb2wN
Cj4+DQo+PiAgIFJldHVybiBzdGF0ZW1lbnRzIGluIGZ1bmN0aW9ucyByZXR1cm5pbmcgYm9vbCBz
aG91bGQgdXNlDQo+PiAgIHRydWUvZmFsc2UgaW5zdGVhZCBvZiAxLzAuDQo+PiBHZW5lcmF0ZWQg
Ynk6IHNjcmlwdHMvY29jY2luZWxsZS9taXNjL2Jvb2xyZXR1cm4uY29jY2kNCj4+DQo+PiBGaXhl
czogNDY5NDYxNjNhYzYxICgiY2FuOiBtX2NhbjogYWRkIHN1cHBvcnQgZm9yIGhhbmRsaW5nIGFy
Yml0cmF0aW9uIGVycm9yIikNCj4+IENDOiBQYW5rYWogU2hhcm1hIDxwYW5rai5zaGFybWFAc2Ft
c3VuZy5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBrYnVpbGQgdGVzdCByb2JvdCA8bGtwQGludGVs
LmNvbT4NCj4+IC0tLQ0KPj4NCj4+IHVybDogICAgaHR0cHM6Ly9naXRodWIuY29tLzBkYXktY2kv
bGludXgvY29tbWl0cy9QYW5rYWotU2hhcm1hL2Nhbi1tX2Nhbi1hZGQtc3VwcG9ydC1mb3ItaGFu
ZGxpbmctYXJiaXRyYXRpb24tZXJyb3IvMjAxOTEwMTQtMTkzNTMyDQo+Pg0KPj4gICBtX2Nhbi5j
IHwgICAgNCArKy0tDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVs
ZXRpb25zKC0pDQo+Pg0KPj4gLS0tIGEvZHJpdmVycy9uZXQvY2FuL21fY2FuL21fY2FuLmMNCj4+
ICsrKyBiL2RyaXZlcnMvbmV0L2Nhbi9tX2Nhbi9tX2Nhbi5jDQo+PiBAQCAtNzgwLDkgKzc4MCw5
IEBAIHN0YXRpYyBpbmxpbmUgYm9vbCBpc19sZWNfZXJyKHUzMiBwc3IpDQo+PiAgIHN0YXRpYyBp
bmxpbmUgYm9vbCBpc19wcm90b2NvbF9lcnIodTMyIGlycXN0YXR1cykNCj4+ICAgew0KPj4gICAJ
aWYgKGlycXN0YXR1cyAmIElSX0VSUl9MRUNfMzFYKQ0KPj4gLQkJcmV0dXJuIDE7DQo+PiArCQly
ZXR1cm4gdHJ1ZTsNCj4+ICAgCWVsc2UNCj4+IC0JCXJldHVybiAwOw0KPj4gKwkJcmV0dXJuIGZh
bHNlOw0KPj4gICB9DQo+PiAgIA0KPj4gICBzdGF0aWMgaW50IG1fY2FuX2hhbmRsZV9wcm90b2Nv
bF9lcnJvcihzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LCB1MzIgaXJxc3RhdHVzKQ0KPj4NCj4gPDJj
Pg0KPiBQZXJoYXBzIHRoZSBmb2xsb3dpbmcgaXMgYSBuaWNlciB3YXkgdG8gZXhwcmVzcyB0aGlz
IChjb21wbGV0ZWx5IHVudGVzdGVkKToNCj4NCj4gCXJldHVybiAhIShpcnFzdGF0dXMgJiBJUl9F
UlJfTEVDXzMxWCk7DQo+IDwvMmM+DQoNCg0KUmVhbGx5Li4uLiwgISEgZm9yIGJvb2wgLyBfQm9v
bCB0eXBlcz8gd2h5IG5vdCBzaW1wbHk6DQoNCnN0YXRpYyBpbmxpbmUgYm9vbCBpc19wcm90b2Nv
bF9lcnIodTMyIGlycXN0YXR1cykNCglyZXR1cm4gaXJxc3RhdHVzICYgSVJfRVJSX0xFQ18zMVg7
DQp9DQoNClJlZ2FyZHMsDQpKZXJvZW4NCg0K
