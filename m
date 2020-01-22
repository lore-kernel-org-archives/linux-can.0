From: Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH 1/3] dt-bindings: net: can: m_can: Add Documentation for
 stb-gpios
Date: Wed, 22 Jan 2020 08:34:20 -0600
Message-ID: <f834087b-da1c-88a0-93fe-bc72c8ac71ff@ti.com>
References: <20200122080310.24653-1-faiz_abbas@ti.com>
 <20200122080310.24653-2-faiz_abbas@ti.com>
 <c3b0eeb8-bd78-aa96-4783-62dc93f03bfe@ti.com>
 <8fc7c343-267d-c91c-0381-60990cfc35e8@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <8fc7c343-267d-c91c-0381-60990cfc35e8@ti.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: Sekhar Nori <nsekhar@ti.com>, Faiz Abbas <faiz_abbas@ti.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, netdev@vger.kernel.org, linux-can@vger.kernel.org
Cc: mark.rutland@arm.com, nm@ti.com, catalin.marinas@arm.com, sriram.dash@samsung.com, t-kristo@ti.com, robh+dt@kernel.org, mkl@pengutronix.de, davem@davemloft.net, wg@grandegger.com
List-Id: linux-can.vger.kernel.org

U2VraGFyCgpPbiAxLzIyLzIwIDg6MjQgQU0sIFNla2hhciBOb3JpIHdyb3RlOgo+IE9uIDIyLzAx
LzIwIDc6MDUgUE0sIERhbiBNdXJwaHkgd3JvdGU6Cj4+IEZhaXoKPj4KPj4gT24gMS8yMi8yMCAy
OjAzIEFNLCBGYWl6IEFiYmFzIHdyb3RlOgo+Pj4gVGhlIENBTiB0cmFuc2NlaXZlciBvbiBzb21l
IGJvYXJkcyBoYXMgYW4gU1RCIHBpbiB3aGljaCBpcwo+Pj4gdXNlZCB0byBjb250cm9sIGl0cyBz
dGFuZGJ5IG1vZGUuIEFkZCBhbiBvcHRpb25hbCBwcm9wZXJ0eQo+Pj4gc3RiLWdwaW9zIHRvIHRv
Z2dsZSB0aGUgc2FtZS4KPj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBGYWl6IEFiYmFzIDxmYWl6X2Fi
YmFzQHRpLmNvbT4KPj4+IFNpZ25lZC1vZmYtYnk6IFNla2hhciBOb3JpIDxuc2VraGFyQHRpLmNv
bT4KPj4+IC0tLQo+Pj4gIMKgIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQv
Y2FuL21fY2FuLnR4dCB8IDIgKysKPj4+ICDCoCAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25z
KCspCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9uZXQvY2FuL21fY2FuLnR4dAo+Pj4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvbmV0L2Nhbi9tX2Nhbi50eHQKPj4+IGluZGV4IGVkNjE0MzgzYWY5Yy4uY2M4YmEzZjdhMmFh
IDEwMDY0NAo+Pj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9j
YW4vbV9jYW4udHh0Cj4+PiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
bmV0L2Nhbi9tX2Nhbi50eHQKPj4+IEBAIC00OCw2ICs0OCw4IEBAIE9wdGlvbmFsIFN1Ym5vZGU6
Cj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRoYXQgY2FuIGJlIHVzZWQgZm9y
IENBTi9DQU4tRkQgbW9kZXMuIFNlZQo+Pj4gICAgICAgICAgICAgICAgIAo+Pj4gRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9jYW4vY2FuLXRyYW5zY2VpdmVyLnR4dAo+Pj4g
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmb3IgZGV0YWlscy4KPj4+ICtzdGItZ3Bp
b3PCoMKgwqDCoMKgwqDCoCA6IGdwaW8gbm9kZSB0byB0b2dnbGUgdGhlIFNUQiAoc3RhbmRieSkg
c2lnbmFsIG9uCj4+PiB0aGUgdHJhbnNjZWl2ZXIKPj4+ICsKPj4gVGhlIG1fY2FuLnR4dCBpcyBm
b3IgdGhlIG1fY2FuIGZyYW1ld29yay7CoCBJZiB0aGlzIGlzIHNwZWNpZmljIHRvIHRoZQo+PiBw
bGF0Zm9ybSB0aGVuIGl0IHJlYWxseSBkb2VzIG5vdCBiZWxvbmcgaGVyZS4KPj4KPj4gSWYgdGhl
IHBsYXRmb3JtIGhhcyBzcGVjaWZpYyBub2RlcyB0aGVuIG1heWJlIHdlIG5lZWQgYQo+PiBtX2Nh
bl9wbGF0Zm9ybS50eHQgYmluZGluZyBmb3Igc3BlY2lmaWMgcGxhdGZvcm0gbm9kZXMuwqAgQnV0
IEkgbGVhdmUKPj4gdGhhdCBkZWNpc2lvbiB0byBSb2IuCj4gU2luY2UgdGhpcyBpcyB0cmFuc2Nl
aXZlciBlbmFibGUsIHNob3VsZCB0aGlzIG5vdCBiZSBpbgo+IERvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9uZXQvY2FuL2Nhbi10cmFuc2NlaXZlci50eHQ/CgorMQoKRGFuCgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtl
cm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5l
bAo=
