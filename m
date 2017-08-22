From: "Jonas Mark (ST-FIR/ENG1)" <Mark.Jonas@de.bosch.com>
Subject: AW: AW: AW: flexcan missing error state transitions
Date: Tue, 22 Aug 2017 19:03:48 +0000
Message-ID: <6a410757a698403c91dcf254a1be3cd9@SI-MBX1030.de.bosch.com>
References: <5213bc7ebd454acea568aba682d696ca@SGPMBX1017.APAC.bosch.com>
 <150333230375.13890.2773067532209799515@maxwell>
 <8e8b90f72f374fb1ab82bc29b8cfc108@SI-MBX1030.de.bosch.com>
 <150333966184.28484.15326759292718336833@maxwell>
 <e54b0db7ec524bcca65e1975aaf13b2b@SI-MBX1030.de.bosch.com>
 <71679863-5b47-faf2-ca44-27eb1abf16c6@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:54099 "EHLO
        smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752031AbdHVTDu (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 22 Aug 2017 15:03:50 -0400
In-Reply-To: <71679863-5b47-faf2-ca44-27eb1abf16c6@pengutronix.de>
Content-Language: de-DE
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Andri Yngvason <andri.yngvason@marel.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "wg@grandegger.com" <wg@grandegger.com>
Cc: "hs@denx.de" <hs@denx.de>, "RUAN Tingquan (ST-FIR/ENG1-Zhu)" <Tingquan.Ruan@cn.bosch.com>, "ZHU Yi (ST-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>, "Jonas Mark (ST-FIR/ENG1)" <Mark.Jonas@de.bosch.com>

SGVsbG8gTWFyYywNCg0KPiA+IFdlIGFyZSBjdXJyZW50bHkgdGhpbmtpbmcgYWJvdXQgd2hldGhl
ciBpdCB3b3VsZCBiZSBwb3NzaWJsZSB0byBkbyB0aGUNCj4gPiBwb2xsaW5nIG9ubHkgaW4gY2Fz
ZSB0aGUgY29udHJvbGxlciBpcyBhY3R1YWxseSBleHBlcmllbmNpbmcgdHJvdWJsZS4NCj4gDQo+
IFdoeSBub3QgZW5hYmxlIGJ1cyBlcnJvcnMgb24gYnJva2VuIGNvbnRyb2xsZXJzLiBEaXNhYmxl
IG9uY2UgYSBidXMgZXJyb3IgaGl0cw0KPiBhbmQgcmUtZW5hYmxlIHRoZW0gYWZ0ZXIgYSBjb25m
aWd1cmFibGUgdGltZW91dCB3aXRoIGEgcHJvcGVyIGRlZmF1bHQuIEkgaGF2ZSBhDQo+IHBhdGNo
IHNvbWV3aGVyZSwgYWx0aG91Z2ggaXQgYXBwbGllcyBvbmx5IGFnYWluc3QgdGhlIHByZSByeC1v
ZmZsb2FkIHZlcnNpb24gb2YgdGhlDQo+IGRyaXZlci4NCg0KSSBhbSBub3Qgc3VyZSB3aGV0aGVy
IEkgdW5kZXJzdGFuZCB5b3VyIHByb3Bvc2FsLiBEbyB5b3UgcHJvcG9zZSB0byBwb2xsIGFsbCB0
aGUNCnRpbWUgYnV0IG9ubHkgc3RvcCB0aGUgcG9sbGluZyB3aGVuIHRoZSBjb250cm9sbGVyIGVu
dGVycyBCdXMtT2ZmPw0KDQpPciBkbyB5b3UgbWVhbiB0byBlbmFibGUgYXV0b21hdGljIHJlc3Rh
cnQgb2YgdGhlIENBTiBjb250cm9sbGVyIGFmdGVyIGEgQnVzLU9mZj8NCldlIGNvdWxkIG5vdCBk
byB0aGlzLiBPdXIgYXBwbGljYXRpb24gbmVlZHMgdG8gaGFuZGxlIEJ1cy1PZmYgYnkgaXRzIG93
bi4gQW5kDQp0aGVyZSB3aWxsIGJlIHN0aWxsIHNpdHVhdGlvbnMgd2hlcmUgRmxleENBTiB3aWxs
IGJlIHNpbGVudGx5IHN0dWNrIGluIEVycm9yIFBhc3NpdmUuDQoNCkNvdWxkIHlvdSBleHBsYWlu
IHlvdXIgaWRlYSBhIGxpdHRsZSBtb3JlPyANCg0KSW4gY2FzZSB5b3UgZmluZCB0aGUgcGF0Y2gg
eW91IG1lbnRpb25lZCwgd2Ugd291bGQgYWxzbyBsaWtlIGxvb2sgYXQgaXQgdG8gc2VlIGlmIHdl
DQpjYW4gZ2V0IGFuIGlkZWEgZnJvbSBpdC4NCg0KV2UgYXJlIGEgbGl0dGxlIGJpdCB0cmFwcGVk
OiBPbiB0aGUgb25lIGhhbmQgd2UgcmVhbGx5IGxpa2UgdGhlIHJlY2VudCBwYXRjaGVzDQpiZWNh
dXNlIGl0IHNvbHZlcyB0aGUgUnggb3ZlcmZsb3cgcHJvYmxlbSB3ZSBhbHNvIGV4cGVyaWVuY2Vk
LiBPbiB0aGUgb3RoZXIgaGFuZA0KdGhlIGVycm9yIHN0YXRlIGhhbmRsaW5nIGlzIG5vdCBhcyBn
b29kIGFueSBtb3JlIGFzIGl0IHdhcy4gU28gd2UgaGlnaGx5IHZhbHVlIHlvdXINCnN1cHBvcnQg
aW4gZmluZGluZyBhIG1haW5saW5lLXJlYWR5IHNvbHV0aW9uLg0KDQpSZWdhcmRzLA0KTWFyaw0K
