From: "ZHU Yi (ST-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>
Subject: RE: [PATCH 3/4] can: flexcan: implement error passive state quirk
Date: Thu, 7 Sep 2017 08:11:39 +0000
Message-ID: <bf6cad90aa9d4e8da439a5ac2e21eafd@SGPMBX1017.APAC.bosch.com>
References: <87faf67d90a246938e0b51d2ddbc8b82@SGPMBX1017.APAC.bosch.com>
 <cc678b44-0aa8-ac91-567e-8b9c234ed024@grandegger.com>
 <ad3cf1da-ca4b-6149-876a-0c983f9d48c8@grandegger.com>
 <dfb4fd69b6d0463ca565245f4c072b90@SGPMBX1017.APAC.bosch.com>
 <1685670a-c87d-2204-7e46-c36ebb8b072f@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:50372 "EHLO
        smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752778AbdIGILm (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 7 Sep 2017 04:11:42 -0400
In-Reply-To: <1685670a-c87d-2204-7e46-c36ebb8b072f@grandegger.com>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Andri Yngvason <andri.yngvason@marel.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "hs@denx.de" <hs@denx.de>, "RUAN Tingquan (ST-FIR/ENG1-Zhu)" <Tingquan.Ruan@cn.bosch.com>, "Jonas Mark (ST-FIR/ENG1)" <Mark.Jonas@de.bosch.com>

SGVsbG8gV29sZmdhbmcsDQoNCj5Gcm9tOiBXb2xmZ2FuZyBHcmFuZGVnZ2VyIFttYWlsdG86d2dA
Z3JhbmRlZ2dlci5jb21dDQo+U2VudDogVGh1cnNkYXksIFNlcHRlbWJlciAwNywgMjAxNyAzOjI3
IFBNDQo+DQo+W3NuaXBdDQo+Pj4gSSBuZWVkIGhlcmU6DQo+Pj4NCj4+PiAJICAgIChwcml2LT5k
ZXZ0eXBlX2RhdGEtPnF1aXJrcyAmIChGTEVYQ0FOX1FVSVJLX0JST0tFTl9QRVJSX1NUQVRFIHwN
Cj4+PiAJCQkJCSAgIEZMRVhDQU5fUVVJUktfQlJPS0VOX1dFUlJfU1RBVEUpKSAmJg0KPj4+DQo+
Pj4gT3IgbWF5YmUgYmV0dGVyLCBhZGQgRkxFWENBTl9RVUlSS19CUk9LRU5fUEVSUl9TVEFURSB0
byB0aGUgbGVnYWN5IGNvcmVzDQo+Pj4gYXMgd2VsbC4NCj5bc25pcF0NCj4+IElmIHdlIGFkZCB0
aGUgV0VSUl9TVEFURSBoZXJlLCB0aGUgcHJvcyBpcyB0aGUgb2xkIGNvcmUgd2lsbCBhdXRvbWF0
aWMNCj4+IHRha2UgYWR2YW50YWdlIG9mIHRoaXMgY2hhbmdlLCB0aGUgY29ucyBpcyB0aGUgcXVp
cmtzIGRvIG5vdCBuZWVkIHRvDQo+PiBtYXRjaCB0aGUgZXhhY3QgaGFyZHdhcmUgZmVhdHVyZSwg
d2hpY2ggbWF5IGxlYWQgdG8gYSBiaXQgY2hhb3MgSU1ITy4NCj4NCj5XZWxsLCBpdCdzIG5vdCBh
bHdheXMgcG9zc2libGUgdG8gbWFrZSBpdCByaWdodCBmb3IgYWxsIGhhcmR3YXJlDQo+dmFyaWFu
dHMuIFBlb3BsZSB3aWxsIHNwZWFrIHVwIGluIGNhc2Ugb2YgcHJvYmxlbXMuDQpBZ3JlZS4NCg0K
Pg0KPj4gV2hhdCBkbyB5b3UgdGhpbms/DQo+DQo+SSB3b3VsZCBzZXQgRkxFWENBTl9RVUlSS19C
Uk9LRU5fUEVSUl9TVEFURSBmb3IgdGhlIGxlZ2FjeSBjb3JlcyBhcw0KPndlbGwuIEkgaGF2ZSBh
biBpLk1YMjggYm9hcmQgaGVyZSBhcyB3ZWxsLiBJdCBzaG91bGQgbm90IG5lZWQgdGhlDQo+cXVp
cmtzLiBXaWxsIHRlc3QgaXQgbGF0ZXIgdGhpcyB3ZWVrLg0KR3JlYXQhIEFjY29yZGluZyB0byBp
Lk1YMjgncyBkYXRhc2hlZXQsIHRoZSBndWVzcyBpcyBpdCBzaG91bGQgbmVlZA0KdGhlIEZMRVhD
QU5fUVVJUktfQlJPS0VOX1BFUlJfU1RBVEUgZW5hYmxlZCBhcyB3ZWxsIGFzIGkuTVg2Lg0KSSdt
IGxvb2tpbmcgZm9yd2FyZCB0byB0aGUgcmVzdWx0cyBhbmQgaG9wZSBpdCB3b3JrcyEgOikNCg0K
Pg0KPltzbmlwXQ0KPj4+IEV2ZW4gaWYgdGhlIHN0YXRlIHJlcG9ydGluZyBpcyBraW5kIG9mIHdl
aXJkIHdpdGggdGhhdCBjb3JlLCBpbnRlcnJ1cHQgZmxvb2RpbmcNCj4+PiBkb2VzIG5vdCBoYXBw
ZW4uDQo+PiBHcmVhdCEgVGhlIHBhdGNoIHNlZW1zIHdvcmsgb24gdGhpcyBjb3JlIHRvby4gOikN
Cj4NCj5ZZXMsIGl0IHdvcmtzIGZvciB0aGUgaS5NWDUzLCBhdCBsZWFzdC4NCj4NCj4+IEJUVywg
ZG8geW91IGFwcGx5IHRoZSBwYXRjaCBmcm9tIHRoZSBpbmxpbmUgdGV4dCBvZiB0aGUgZS1tYWls
PyBXZSBhcmUNCj4+IGN1cmlvdXMgb2Ygd2hldGhlciBvdXRsb29rIDIwMTMgaXMgYWJsZSB0byBz
ZW5kIGlubGluZSBwYXRjaCBvciBub3QuDQo+DQo+Tm8gcHJvYmxlbSwgImdpdCBhbSIgd29ya2Vk
IGxpa2UgYSBjaGFybS4NClRoYXQgd291bGQgYmUgYSBiaWcgcmVsaWVmIGZvciB1cy4gV2Ugd2Vy
ZSB3b3JyaWVkIGFib3V0IHRoYXQgd2UgY2FuJ3QNCnNlbmQgdmFsaWQgaW5saW5lIHBhdGNoIHZp
YSBvdXRsb29rLCBhbmQgbmVlZHMgdG8gZGVhbCB3aXRoIGF0dGFjaG1lbnQNCmluIHRoZSBlbmQu
DQoNClRoYW5rcyBmb3IgdGhlIGluZm8hIDopDQoNCkJlc3QgcmVnYXJkcw0KWWkNCg==
