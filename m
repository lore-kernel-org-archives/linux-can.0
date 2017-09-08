From: "ZHU Yi (ST-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>
Subject: RE: [PATCH 3/4] can: flexcan: implement error passive state quirk
Date: Fri, 8 Sep 2017 08:30:43 +0000
Message-ID: <de72370af85b4b3881056029b588069b@SGPMBX1017.APAC.bosch.com>
References: <87faf67d90a246938e0b51d2ddbc8b82@SGPMBX1017.APAC.bosch.com>
 <cc678b44-0aa8-ac91-567e-8b9c234ed024@grandegger.com>
 <ad3cf1da-ca4b-6149-876a-0c983f9d48c8@grandegger.com>
 <dfb4fd69b6d0463ca565245f4c072b90@SGPMBX1017.APAC.bosch.com>
 <1685670a-c87d-2204-7e46-c36ebb8b072f@grandegger.com>
 <bf6cad90aa9d4e8da439a5ac2e21eafd@SGPMBX1017.APAC.bosch.com>
 <20820cdf-afff-9d04-3c9c-511e45bd0853@grandegger.com>
 <1ccdad7593e34103bd4d96f5b1e64ea7@SGPMBX1017.APAC.bosch.com>
 <92d997b5-957e-7e0b-70aa-bff16e289e81@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:48385 "EHLO
        smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754135AbdIHIar (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 8 Sep 2017 04:30:47 -0400
In-Reply-To: <92d997b5-957e-7e0b-70aa-bff16e289e81@grandegger.com>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Andri Yngvason <andri.yngvason@marel.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "hs@denx.de" <hs@denx.de>, "RUAN Tingquan (ST-FIR/ENG1-Zhu)" <Tingquan.Ruan@cn.bosch.com>, "Jonas Mark (ST-FIR/ENG1)" <Mark.Jonas@de.bosch.com>

SGVsbG8gV29sZmdhbmcsDQoNCj5Gcm9tOiBXb2xmZ2FuZyBHcmFuZGVnZ2VyIFttYWlsdG86d2dA
Z3JhbmRlZ2dlci5jb21dDQo+U2VudDogRnJpZGF5LCBTZXB0ZW1iZXIgMDgsIDIwMTcgMzowMiBQ
TQ0KPg0KPj4+IFsuLi5dDQo+Pj4gRXJyb3Igd2FybmluZyBpcyBhbHdheXMgcmVwb3J0ZWQgYW5k
IHdpdGggdGhlIHF1aXJrIGFib3ZlIGFsc28gZXJyb3INCj4+PiBwYXNzaXZlLiBBZnRlciByZWNv
bm5lY3RpbmcgdGhlIGNhYmxlIHRoZSBlcnJvciBjb3VudGVyIGFsc28ganVtcHMgdG8NCj4+PiAx
MzUuIFdpdGggYnVzLW9mZiwgdGhlIGRldmljZSBhbHNvIHJlcG9ydHMgMy0+MCBhZnRlciBidXMg
ZXJyb3INCj4+PiByZWNvdmVyeToNCj4+IFsuLi5dDQo+SSBmb3Jnb3QgdG8gbWVudGlvbiwgSSB1
c2VkICJyZXN0YXJ0LW1zIDEwMCIgZm9yIG15IHRlc3RzIHdpdGggdGhlIGkuTVgyOC4NCkFoLCBv
a2F5LCB0aGF0IGV4cGxhaW5zIGEgbG90LiA6KQ0KDQo+DQo+PiBbLi4uXQ0KPk9uIG1vc3QgY29u
dHJvbGxlcnMgd2UgZG8gbm90IHVzZSB0aGUgaGFyZHdhcmUgcmVjb3ZlcnkgcHJvY2VkdXJlIGJ1
dA0KPmp1c3QgcmVzdGFydCB0aGUgY29udHJvbGxlci4gSW4gdGhlIHBhc3QgSSBhbHJlYWR5IGhh
ZCBwbGFucyB0byBjaGFuZ2UNCj50aGF0Og0KPg0KPmh0dHA6Ly9zb2NrZXQtY2FuLjk5NjI1Ny5u
My5uYWJibGUuY29tL1JGQy1pbXByb3ZlLWFuZC1jb25zb2xpZGF0ZS1zdGF0ZS1jaGFuZ2UtYW5k
LWJ1cy1vZmYtaGFuZGxpbmctdGQyNzU1Lmh0bWwNClRoYXQncyBhIGdvb2QgaWRlYS4gVGhlIGNh
bl9jaGFuZ2Vfc3RhdGUoKSB3YXMgaW1wbGVtZW50ZWQsIGJ1dCB0aGUNCnJlc3Qgc2VlbXMgbmVl
ZCBhIGxvbmcgd2F5IHRvIGdvLg0KDQo+DQo+PiBbLi4uXQ0KPj4+IHJvb3RAbTI4ZXZrOn4jIFsg
IDY3NC45ODU4OTddIGZsZXhjYW4gODAwMzIwMDAuY2FuIGNhbjA6IGN0cmw9MHgxMWFhMDUzIHJl
Z19pZmxhZz0weDAgcmVnX2Vzcj0weDQgZXJyPTAvMA0KPg0KPlRoZSBsb2cgYWJvdmUgaXMgYXBw
cm94LiAxMDBtcyBhZnRlciB0aGUgcHJldmlvdXMgb25lLg0KPg0KPj4gY3RybDogQk9GRl9NU0s9
MWIsIEVSUl9NU0s9MGIsIFtUUl1XUk5fTVNLPTAwYg0KPj4gZXNyOiAgQk9GRl9JTlQ9MWIsIEZM
VF9DT05GPTAwYg0KPj4gc28gdGhlIHN0YXRlIGNoYW5nZSB0byBlcnJvciBhY3RpdmUgdXBvbiBh
ICJidXMgb2ZmIiBpbnRlcnJ1cHQuDQo+DQo+Tm8sIGFmdGVyIHJlc3RhcnQuDQpPSywgYWx0aG91
Z2ggaXQgaXMgc3RpbGwgd2VpcmQgdGhhdCBbVFJdV1JOX01TSyBpcyAwIGFmdGVyIHJlc3RhcnQu
DQoNCj4NCj4+PiBbLi4uXQ0KPkFzIG1lbnRpb25lZCBhYm92ZSwgInJlc3RhcnQgMTAwIiB3YXMg
dXNlZCBmb3IgdGhlIGxpbmsuIFVuZm9ydHVuYXRlbHksDQo+YnVzLW9mZiBoYW5kbGluZyBpcyBu
b3QgY29uc2lzdGVudCBmb3IgYWxsIENBTiBjb250cm9sbGVycywgYXMgbWVudGlvbmVkDQo+aW4g
dGhlIGxpbmsgYWJvdmUuDQpZZXMsIHlvdSdyZSByaWdodC4gUGVyaGFwcyAiYnJ1dGUtZm9yY2Ug
c3RvcCBhbmQgcmVzdGFydCB0aGUgY29udHJvbGxlciINCmlzIHN0aWxsIHRoZSBtb3N0IHNvbGlk
IHdheSB0byBoYW5kbGUgYnVzLW9mZiBhbW9uZyBhbGwgZGlmZmVyZW50IENBTg0KY29udHJvbGxl
cnMuDQoNCk9uIHRoZSBvdGhlciBoYW5kLCB0aGF0IG1lYW5zIHRoZSBwYXRjaCBhbHNvIHdvcmtz
IGZvciBpLk1YMjggaW4gcmVnYXJkcw0Kb2YgdGhyb3R0bGUgaXJxIGZsb29kaW5nIGFmdGVyIGVu
YWJsZWQgdGhlIFBFUlJfU1RBVEUgcXVpcmssIHJpZ2h0Pw0KDQpCZXN0IHJlZ2FyZHMNCllpDQo=
