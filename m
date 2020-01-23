From: Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: [PATCH 1/3] dt-bindings: net: can: m_can: Add Documentation for
 stb-gpios
Date: Thu, 23 Jan 2020 13:09:41 +0530
Message-ID: <57baeedc-9f51-7b92-f190-c0bbd8525a16@ti.com>
References: <20200122080310.24653-1-faiz_abbas@ti.com>
 <20200122080310.24653-2-faiz_abbas@ti.com>
 <c3b0eeb8-bd78-aa96-4783-62dc93f03bfe@ti.com>
 <8fc7c343-267d-c91c-0381-60990cfc35e8@ti.com>
 <f834087b-da1c-88a0-93fe-bc72c8ac71ff@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <f834087b-da1c-88a0-93fe-bc72c8ac71ff@ti.com>
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
To: Dan Murphy <dmurphy@ti.com>, Sekhar Nori <nsekhar@ti.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, netdev@vger.kernel.org, linux-can@vger.kernel.org
Cc: mark.rutland@arm.com, nm@ti.com, catalin.marinas@arm.com, sriram.dash@samsung.com, t-kristo@ti.com, robh+dt@kernel.org, mkl@pengutronix.de, davem@davemloft.net, wg@grandegger.com
List-Id: linux-can.vger.kernel.org

SGksCgpPbiAyMi8wMS8yMCA4OjA0IHBtLCBEYW4gTXVycGh5IHdyb3RlOgo+IFNla2hhcgo+IAo+
IE9uIDEvMjIvMjAgODoyNCBBTSwgU2VraGFyIE5vcmkgd3JvdGU6Cj4+IE9uIDIyLzAxLzIwIDc6
MDUgUE0sIERhbiBNdXJwaHkgd3JvdGU6Cj4+PiBGYWl6Cj4+Pgo+Pj4gT24gMS8yMi8yMCAyOjAz
IEFNLCBGYWl6IEFiYmFzIHdyb3RlOgo+Pj4+IFRoZSBDQU4gdHJhbnNjZWl2ZXIgb24gc29tZSBi
b2FyZHMgaGFzIGFuIFNUQiBwaW4gd2hpY2ggaXMKPj4+PiB1c2VkIHRvIGNvbnRyb2wgaXRzIHN0
YW5kYnkgbW9kZS4gQWRkIGFuIG9wdGlvbmFsIHByb3BlcnR5Cj4+Pj4gc3RiLWdwaW9zIHRvIHRv
Z2dsZSB0aGUgc2FtZS4KPj4+Pgo+Pj4+IFNpZ25lZC1vZmYtYnk6IEZhaXogQWJiYXMgPGZhaXpf
YWJiYXNAdGkuY29tPgo+Pj4+IFNpZ25lZC1vZmYtYnk6IFNla2hhciBOb3JpIDxuc2VraGFyQHRp
LmNvbT4KPj4+PiAtLS0KPj4+PiDCoMKgIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9uZXQvY2FuL21fY2FuLnR4dCB8IDIgKysKPj4+PiDCoMKgIDEgZmlsZSBjaGFuZ2VkLCAyIGlu
c2VydGlvbnMoKykKPj4+Pgo+Pj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvbmV0L2Nhbi9tX2Nhbi50eHQKPj4+PiBiL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9uZXQvY2FuL21fY2FuLnR4dAo+Pj4+IGluZGV4IGVkNjE0MzgzYWY5Yy4u
Y2M4YmEzZjdhMmFhIDEwMDY0NAo+Pj4+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9uZXQvY2FuL21fY2FuLnR4dAo+Pj4+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9uZXQvY2FuL21fY2FuLnR4dAo+Pj4+IEBAIC00OCw2ICs0OCw4IEBAIE9w
dGlvbmFsIFN1Ym5vZGU6Cj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdGhh
dCBjYW4gYmUgdXNlZCBmb3IgQ0FOL0NBTi1GRCBtb2Rlcy4gU2VlCj4+Pj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgCj4+Pj4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L25ldC9jYW4vY2FuLXRyYW5zY2VpdmVyLnR4dAo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGZvciBkZXRhaWxzLgo+Pj4+ICtzdGItZ3Bpb3PCoMKgwqDCoMKgwqDCoCA6IGdw
aW8gbm9kZSB0byB0b2dnbGUgdGhlIFNUQiAoc3RhbmRieSkgc2lnbmFsIG9uCj4+Pj4gdGhlIHRy
YW5zY2VpdmVyCj4+Pj4gKwo+Pj4gVGhlIG1fY2FuLnR4dCBpcyBmb3IgdGhlIG1fY2FuIGZyYW1l
d29yay7CoCBJZiB0aGlzIGlzIHNwZWNpZmljIHRvIHRoZQo+Pj4gcGxhdGZvcm0gdGhlbiBpdCBy
ZWFsbHkgZG9lcyBub3QgYmVsb25nIGhlcmUuCj4+Pgo+Pj4gSWYgdGhlIHBsYXRmb3JtIGhhcyBz
cGVjaWZpYyBub2RlcyB0aGVuIG1heWJlIHdlIG5lZWQgYQo+Pj4gbV9jYW5fcGxhdGZvcm0udHh0
IGJpbmRpbmcgZm9yIHNwZWNpZmljIHBsYXRmb3JtIG5vZGVzLsKgIEJ1dCBJIGxlYXZlCj4+PiB0
aGF0IGRlY2lzaW9uIHRvIFJvYi4KPj4gU2luY2UgdGhpcyBpcyB0cmFuc2NlaXZlciBlbmFibGUs
IHNob3VsZCB0aGlzIG5vdCBiZSBpbgo+PiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvbmV0L2Nhbi9jYW4tdHJhbnNjZWl2ZXIudHh0Pwo+IAoKVGhlIHRyYW5zY2VpdmVyIG5vZGUg
aXMganVzdCBhIG5vZGUgd2l0aG91dCBhbiBhc3NvY2lhdGVkIGRldmljZS4gSSBoYWQKdHJpZWQg
dG8gY29udmVydCBpdCB0byBhIHBoeSBpbXBsZW1lbnRhdGlvbiBidXQgdGhhdCBpZGVhIGdvdCBz
aG90IGRvd24KaGVyZToKCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3BhdGNod29yay9wYXRjaC8x
MDA2MjM4LwoKVGhhbmtzLApGYWl6CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2Vy
bmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1h
bi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
