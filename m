From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: RE: [PATCH 1/8] dt-bindings: can: rcar_can: document r8a774[35] can
 support
Date: Thu, 25 Jan 2018 10:55:26 +0000
Message-ID: <TY1PR06MB0895FFD9D73D3784AD9CFD3DC0E10@TY1PR06MB0895.apcprd06.prod.outlook.com>
References: <1510067449-17017-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1510067449-17017-2-git-send-email-fabrizio.castro@bp.renesas.com>
 <SG2PR06MB0886FFF48DD9DBE7693EEDBDC0E20@SG2PR06MB0886.apcprd06.prod.outlook.com>
 <da4afc82-aeb6-05d9-4a41-b2627f736064@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relmlor4.renesas.com ([210.160.252.174]:35716 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751154AbeAYKzd (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 25 Jan 2018 05:55:33 -0500
In-Reply-To: <da4afc82-aeb6-05d9-4a41-b2627f736064@pengutronix.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert+renesas@glider.be>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, Wolfgang Grandegger <wg@grandegger.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>

VGhhbmsgeW91IE1hcmMuDQoNCkNoZWVycywNCkZhYnJpemlvDQoNCj4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyYyBLbGVpbmUtQnVkZGUgW21haWx0bzpta2xAcGVuZ3V0
cm9uaXguZGVdDQo+IFNlbnQ6IDI1IEphbnVhcnkgMjAxOCAwODo1Mw0KPiBUbzogRmFicml6aW8g
Q2FzdHJvIDxmYWJyaXppby5jYXN0cm9AYnAucmVuZXNhcy5jb20+DQo+IENjOiBTaW1vbiBIb3Jt
YW4gPGhvcm1zQHZlcmdlLm5ldC5hdT47IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnQrcmVuZXNh
c0BnbGlkZXIuYmU+OyBsaW51eC1jYW5Admdlci5rZXJuZWwub3JnOw0KPiBuZXRkZXZAdmdlci5r
ZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgtcmVuZXNhcy1zb2NA
dmdlci5rZXJuZWwub3JnOyBDaHJpcyBQYXRlcnNvbg0KPiA8Q2hyaXMuUGF0ZXJzb24yQHJlbmVz
YXMuY29tPjsgQmlqdSBEYXMgPGJpanUuZGFzQGJwLnJlbmVzYXMuY29tPjsgV29sZmdhbmcgR3Jh
bmRlZ2dlciA8d2dAZ3JhbmRlZ2dlci5jb20+OyBSb2IgSGVycmluZw0KPiA8cm9iaCtkdEBrZXJu
ZWwub3JnPjsgTWFyayBSdXRsYW5kIDxtYXJrLnJ1dGxhbmRAYXJtLmNvbT4NCj4gU3ViamVjdDog
UmU6IFtQQVRDSCAxLzhdIGR0LWJpbmRpbmdzOiBjYW46IHJjYXJfY2FuOiBkb2N1bWVudCByOGE3
NzRbMzVdIGNhbiBzdXBwb3J0DQo+DQo+IE9uIDAxLzI0LzIwMTggMDY6MjIgUE0sIEZhYnJpemlv
IENhc3RybyB3cm90ZToNCj4gPiB0aGFuayB5b3UgZm9yIEFja2luZyB0aGUgcGF0Y2gsIGp1c3Qg
d29uZGVyaW5nIGlmIHRoaXMgcGF0Y2ggaGFzIGFueQ0KPiA+IGNoYW5jZSB0byBlbmQgdXAgaW4g
djQuMTY/DQo+DQo+IEkgY2FuIHRha2UgdGhpcyB2aWEgdGhlIGxpbnV4LWNhbiB0cmVlLCBpZiBu
byBvbmUgZWxzZSB0YWtlcyBpdC4NCj4NCj4gTWFyYw0KPg0KPiAtLQ0KPiBQZW5ndXRyb25peCBl
LksuICAgICAgICAgICAgICAgICAgfCBNYXJjIEtsZWluZS1CdWRkZSAgICAgICAgICAgfA0KPiBJ
bmR1c3RyaWFsIExpbnV4IFNvbHV0aW9ucyAgICAgICAgfCBQaG9uZTogKzQ5LTIzMS0yODI2LTky
NCAgICAgfA0KPiBWZXJ0cmV0dW5nIFdlc3QvRG9ydG11bmQgICAgICAgICAgfCBGYXg6ICAgKzQ5
LTUxMjEtMjA2OTE3LTU1NTUgfA0KPiBBbXRzZ2VyaWNodCBIaWxkZXNoZWltLCBIUkEgMjY4NiAg
fCBodHRwOi8vd3d3LnBlbmd1dHJvbml4LmRlICAgfA0KDQoNCg0KDQpSZW5lc2FzIEVsZWN0cm9u
aWNzIEV1cm9wZSBMdGQsIER1a2VzIE1lYWRvdywgTWlsbGJvYXJkIFJvYWQsIEJvdXJuZSBFbmQs
IEJ1Y2tpbmdoYW1zaGlyZSwgU0w4IDVGSCwgVUsuIFJlZ2lzdGVyZWQgaW4gRW5nbGFuZCAmIFdh
bGVzIHVuZGVyIFJlZ2lzdGVyZWQgTm8uIDA0NTg2NzA5Lg0K
