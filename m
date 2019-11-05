From: Jose Abreu <Jose.Abreu@synopsys.com>
Subject: RE: KASAN: use-after-free Read in j1939_session_get_by_addr
Date: Tue, 5 Nov 2019 08:21:16 +0000
Message-ID: <BN8PR12MB3266A0CC1496ED5D532EA6D5D37E0@BN8PR12MB3266.namprd12.prod.outlook.com>
References: <0000000000009393ba059691c6a3@google.com>
 <0000000000009427b5059694e33c@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0000000000009427b5059694e33c@google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: syzbot <syzbot+d9536adc269404a984f8@syzkaller.appspotmail.com>, "Jose.Abreu@synopsys.com" <Jose.Abreu@synopsys.com>, "arvid.brodin@alten.se" <arvid.brodin@alten.se>, "davem@davemloft.net" <davem@davemloft.net>, "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>"jose.abreu@synopsys.com" <Jose.Abreu@synopsys.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux@rempel-privat.de" <linux@rempel-privat.de>, "mkl@pengutronix.de" <mkl@pengutronix.de>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "robin@protonic.nl" <robin@protonic.nl>, "socketcan@hartkopp.net" <socketcan@hartkopp.net>, "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@goo>
List-Id: linux-can.vger.kernel.org

RnJvbTogc3l6Ym90IDxzeXpib3QrZDk1MzZhZGMyNjk0MDRhOTg0ZjhAc3l6a2FsbGVyLmFwcHNw
b3RtYWlsLmNvbT4NCkRhdGU6IE5vdi8wNS8yMDE5LCAwODowNTowMSAoVVRDKzAwOjAwKQ0KDQo+
IHN5emJvdCBoYXMgYmlzZWN0ZWQgdGhpcyBidWcgdG86DQo+IA0KPiBjb21taXQgMmFmNjEwNmFl
OTQ5NjUxZDUyOWM4YzNmMDczNGMzYTdiYWJkMGQ0Yg0KPiBBdXRob3I6IEpvc2UgQWJyZXUgPEpv
c2UuQWJyZXVAc3lub3BzeXMuY29tPg0KPiBEYXRlOiAgIFR1ZSBKdWwgOSAwODowMzowMCAyMDE5
ICswMDAwDQo+IA0KPiAgICAgIG5ldDogc3RtbWFjOiBJbnRyb2R1Y2luZyBzdXBwb3J0IGZvciBQ
YWdlIFBvb2wNCg0KRnJvbSB0aGUgY29uZmlnIHByb3ZpZGVkLCBzdG1tYWMgZHJpdmVyIGlzIG5v
dCBldmVuIGVuYWJsZWQuIENhbiB5b3UgDQpwbGVhc2UgY29uZmlybSB0aGUgYmlzZWN0aW9uIHBy
b2Nlc3MgPw0KDQotLS0NClRoYW5rcywNCkpvc2UgTWlndWVsIEFicmV1DQo=
