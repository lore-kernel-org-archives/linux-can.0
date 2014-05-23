From: "jinyang.sia-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <jinyang.sia-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: CAN SJA100 controller emulation and SocketCAN based host CAN bus
 access
Date: Fri, 23 May 2014 09:52:26 +0800
Message-ID: <201405230952241177037@gmail.com>
References: <201405092010.19482.pisa@cmp.felk.cvut.cz>
 <CAJSP0QXLCZYrvHpPQH6CSTkfL2ezdvZya32kuHfs4FgYvC_Btg@mail.gmail.com>,
 <201405151553.07872.pisa@cmp.felk.cvut.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2954341533641585148=="
Return-path: <rtems-devel-bounces-WKV1R6NGPIzYtjvyW6yDsg@public.gmane.org>
List-Unsubscribe: <http://www.rtems.org/mailman/options/rtems-devel>,
 <mailto:rtems-devel-request-WKV1R6NGPIzYtjvyW6yDsg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://www.rtems.org/pipermail/rtems-devel/>
List-Post: <mailto:rtems-devel-WKV1R6NGPIzYtjvyW6yDsg@public.gmane.org>
List-Help: <mailto:rtems-devel-request-WKV1R6NGPIzYtjvyW6yDsg@public.gmane.org?subject=help>
List-Subscribe: <http://www.rtems.org/mailman/listinfo/rtems-devel>,
 <mailto:rtems-devel-request-WKV1R6NGPIzYtjvyW6yDsg@public.gmane.org?subject=subscribe>
Errors-To: rtems-devel-bounces-WKV1R6NGPIzYtjvyW6yDsg@public.gmane.org
Sender: rtems-devel-bounces-WKV1R6NGPIzYtjvyW6yDsg@public.gmane.org
To: Pavel Pisa <pisa-/N2ztlQkxE7Ub/6JBqosbQ@public.gmane.org>, Stefan Hajnoczi <stefanha-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?B?QW5kcmVhc0bDpHJiZXI=?= <afaerber-l3A5Bk7waGM@public.gmane.org>, Peter Crosthwaite <peter.crosthwaite-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Cc: Oliver Hartkopp A <socketcan-fJ+pQTUTwRTk1uMJSBkQmQ@public.gmane.org>, linux-can <linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, RTEMS Devel <rtems-devel-WKV1R6NGPIzYtjvyW6yDsg@public.gmane.org>, qemu-devel <qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org>, Stefan Weil <sw-QDXxdeohBKYb1SvskN2V4Q@public.gmane.org>
List-Id: linux-can.vger.kernel.org

This is a multi-part message in MIME format.

--===============2954341533641585148==
Content-Type: multipart/alternative;
	boundary="----=_001_NextPart101010047614_=----"

This is a multi-part message in MIME format.

------=_001_NextPart101010047614_=----
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64

SGksIGFsbA0KSSBqdXN0IHJlYWQgdGhpcyBlLW1haWwgdG9kYXkuIGRpZG4ndCBjaGVjayB0aGUg
ZS1tYWlsIGZvciBhIGxvbmcgdGltZSwgYmVjYXVzZSBhIGxpdHRsZSBidXN5IG9uIHRoZSBncmFk
dWF0aW9uIHN0dWZmcy4gSSBzdGlsbCB3YW50IHRvIGRvIHNvbWV0aGluZyBvbiB0aGlzIHByb2pl
Y3QuIFNvLCBpIHdvdWxkIGxpa2UgdG8gd29ya2luZyBvbiBhbnl0aGluZyBpIGNhbiBoZWxwLg0K
DQpUaGFua3MsDQpKaW4gWWFuZw0KDQoNCg0KDQpqaW55YW5nLnNpYUBnbWFpbC5jb20NCg0KRnJv
bTogUGF2ZWwgUGlzYQ0KRGF0ZTogMjAxNC0wNS0xNSAyMTo1Mw0KVG86IFN0ZWZhbiBIYWpub2N6
aTsgQW5kcmVhc0bDpHJiZXI7IFBldGVyIENyb3N0aHdhaXRlDQpDQzogcWVtdS1kZXZlbEBub25n
bnUub3JnOyBPbGl2ZXIgSGFydGtvcHAgQTsgamlueWFuZy5zaWE7IFN0ZWZhbiBXZWlsOyBydGVt
cy1kZXZlbDsgbGludXgtY2FuDQpTdWJqZWN0OiBSZTogW1FlbXUtZGV2ZWxdIFtQQVRDSCAwLzJd
IENBTiBTSkExMDAgY29udHJvbGxlciBlbXVsYXRpb24gYW5kIFNvY2tldENBTiBiYXNlZCBob3N0
IENBTiBidXMgYWNjZXNzDQpIZWxsbyBhbGwsDQoNCnRoZSBmaXJzdCBtdWNoIHRoYW5rcyB0byBT
dGVmYW4sIEFuZHJlYXMgYW5kIFBldGVyDQpmb3IgcmVwbHkuDQoNCk5leHQsIHNob3VsZCBJIGtl
ZXAgbGludXgtY2FuIGluIHRoZSB0YWxrDQooaXQgaXMgYWdhaW5zdCBsaXN0IGNyb3NzLXBvc3Rp
bmcgcnVsZSkgb3IgYWxsDQpwb3RlbnRpYWxseSBpbnRlcnJlc3RlZCBwYXJ0aWNpcGFudHMgYWdy
ZWUgdG8gc3RheS9mb2xsb3cNCnRoaXMgYW5kIGZ1dHVyZSBDQU4rUUVNVSByZWxhdGVkIHRvcGlj
cyBvbiBRRU1VIGxpc3Q/DQoNCkkgd291bGQgcmVtb3ZlIFJURU1TIGluIHRoZSBuZXh0IHBvc3Qu
IEV2ZW4gdGhhdA0KaXQgaXMgb25lIG9mIHBvdGVudGlhbCB1c2Vycywgb3JpZ2luYWwgImludmVz
dG9yIiwNCmludGVybmFscyBvZiB0aGUgZW11bGF0aW9uIGFyZSBvdXQgb2YgdGhpcyBwcm9qZWN0
DQpzY29wZS4NCg0KT24gTW9uZGF5IDEyIG9mIE1heSAyMDE0IDExOjE4OjA5IEFuZHJlYXMgRsOk
cmJlciB3cm90ZToNCj4gQW0gMTIuMDUuMjAxNCAxMTowMSwgc2NocmllYiBQZXRlciBDcm9zdGh3
YWl0ZToNCj4gPiBPbiBTYXQsIE1heSAxMCwgMjAxNCBhdCA0OjE0IEFNLCBQYXZlbCBQaXNhIDxw
aXNhQGNtcC5mZWxrLmN2dXQuY3o+IHdyb3RlOg0KPiA+PiBUaGUgd29yayBpcyBiYXNlZCBvbiBK
aW4gWWFuZyBHU29DIDIwMTMgd29yayBmdW5kZWQNCj4gPj4gYnkgR29vZ2xlIGFuZCBtZW50b3Jl
ZCBpbiBmcmFtZSBvZiBSVEVNUyBwcm9qZWN0IEdTb0MNCj4gPj4gc2xvdCBkb25hdGVkIHRvIFFF
TVUuDQo+DQo+IFNob3VsZC9jYW4gdGhhdCBiZSByZWNvcmRlZCBpbiBmb3JtIG9mIGhpcyBTaWdu
ZWQtb2ZmLWJ5IGJlZm9yZSB5b3Vycz8NCg0KSSB0cnkgdG8gZG8gc29tZXRoaW5nIHdpdGggdGhh
dC4gSSB3b3VsZCBwcmVmZmVyIHRvIGFkZCBoaW0NCmJ1dCBJIHdvdWxkIGxpa2UgdG8gaGF2ZSBo
aXMgY29uZmlybWF0aW9uIGJlZm9yZWhhbmQuDQpUaGUgR1NvQyAyMDEzIHdvcmsgaXMgYXZhaWxh
YmxlIGluIGhpcyBHaXRIdWIgcmVwbyBpbmNsdWRpbmcNCm5lZ290aWF0ZWQgZmluYWwgbGljZW5j
ZSBpbmNsdXNpb24NCg0KaHR0cHM6Ly9naXRodWIuY29tL0ppbi1ZYW5nL1FFTVUtMS40LjINCg0K
SSB3YXMgYWdhaW5zdCB0byBib3RoZXJpbmcgeW91IGJ5IHBhdGNoZXMgZm9yIG9sZCBRRU1VDQp2
ZXJzaW9uIHNvIEkgaGF2ZSBwb3N0cG9uZWQgY29tbXVuaWNhdGlvbiB0aWxsIEkgaGF2ZQ0KdGlt
ZSB0byBicmluZyBpdCB0byB0aGUgbGF0ZXN0IEdJVC4gQnV0IHRoZXJlIGlzIHNpZ25pZmljYW50
DQpyZWRlc2lnbiB3aGljaCB1bnRpZXMgY2hhbmdlcyBmcm9tIGhhcmRjb2RlZCBtb2RpZmljYXRp
b25zDQp0byBRRU1VIGNoYXJhY3RlciBkcml2ZXIgKG9yaWdpbmFsIGFwcHJvYWNoKSBhbmQgY2hh
bmdlcw0Kd2hvbGUgcGF0Y2hlcyBhcmNoaXRlY3R1cmUgc3Vic3RhbnRpYWxseSBpbmNsdWRpbmcN
Cm9taXNzaW9uIG9mIHNvbWUgZnVuY3Rpb25hbGl0eSBmb3IgYmVnaW5uaW5nIGFuZCBwcm9iYWJs
eQ0KaW50cm9kdWN0aW9uIG9mIG5ldyBlcnJvcnMuIFNvIEkgdGhpbmsgdGhhdCBJIGFtIG5vdA0K
YXV0aG9yaXplZCB0byBwcm92aWRlIFNpZ25lZC1vZmYtYnkgSmluIFlhbmcgb24gbXkgb3duLg0K
QnV0IG9yaWdpbmFsIHdvcmsgc3RhdHVzIGFuZCBsaWNlbnNlIGlzIGRlY2xhcmVkIGJ5DQpKaW4g
WWFuZyBhbmQgR1NvQyAyMDEzLg0KDQo+ID4gVGhhdCdzIGEgYmlnIHBhdGNoLiBBbmQgaXQgc2Vl
bXMgdG8gYWRkIGEgbmV3IEFQSS9mcmFtZXdvcmssIHRoZW4gbmV3DQo+ID4gdXNlcnMgb2YgdGhh
dCBBUEkuIENhbiB5b3UgYWRkIHlvdXIgY29yZSBhcyBhIHNpbmdsZSBwYXRjaCwgdGhlbg0KPiA+
IGluY3JlbWVudGFsbHkgYnJpbmcgeW91ciBkZXZpY2VzIHN0dWZmIGFzIHN1YnNlcXVlbnQgcGF0
Y2hlcz8gTXkgZ3Vlc3MNCj4gPiBpcyB0aGlzIHNob3VsZCBiZSBhYm91dCAzIHBhdGNoZXMgLSBh
cmUgdGhlcmUgYW55IGNpcmN1bGFyIGRlcHMsDQo+ID4gcmVxdWlyaW5nIHlvdSB0byBicmluZyB5
b3VyIHRocmVlIGMgZmlsZXMgYWxsIGF0IG9uY2Ugb3IgaXMgdGhlcmUgYQ0KPiA+IGxvZ2ljYWwg
b3JkZXIgeW91IGNhbiBhZGQgdGhlbSBmb3IgZWFzZSBvZiByZXZpZXc/DQo+DQo+IFRydWUuIEJ1
dCBiZWZvcmUgeW91IHJlc2VuZCwgSSdkIGxpa2UgdG8gaGVhciBTdGVmYW4gSC4ncyB2aWV3IG9m
DQo+IHdoZXRoZXIgQ0FOIHNob3VsZCBnbyBpbnRvIGh3L25ldC8gYXQgYWxsIG9yIGludG8sIGUu
Zy4sIGh3L2Nhbi8uDQoNClRoYXQgaXMgc2lnbmlmaWNhbnQgcXVlc3Rpb24gYW5kIG15IHNlbmRp
bmcgb2YgdGhlIHBhdGNoIHNlcmllcyBpcyBtYWlubHkNCmJhc2UgdG8gc3RhcnQgZGlzY3Vzc2lv
biBhYm91dCB0aGlzIGFuZCBzdXBwb3J0IGFyY2hpdGVjdHVyZS4NCkkgbmVlZCB0byBsZWFybiBt
bm9yZSBhYm91dCBRRU1VIGludGVybmFscyBhbmQgcG9zc2libGUgbWVjaGFuaXNtcw0KdG8gdXNl
IGZyb20gUUVNVSBleHBlcnRzIGFzIHdlbGwuDQoNCj4gSW5kZXBlbmRlbnRseSBvZiB0aGUgcGxh
Y2VtZW50LCBpdCdzIGFsd2F5cyBhbiBpbnRlcmVzdGluZyBxdWVzdGlvbiBvZg0KPiB3aG8gd2ls
bCBtYWludGFpbiB0aGlzIG5ldyBpbmZyYXN0cnVjdHVyZSAtIEkgZG9uJ3Qgc2VlIGFueSBuZXcN
Cj4gTUFJTlRBSU5FUlMgZW50cmllcyBnZXR0aW5nIGFkZGVkIGluIGVpdGhlciBwYXRjaCAoTkI6
IGEgZGlmZnN0YXQgaW4gMC8yDQo+IHdvdWxkJ3ZlIGJlZW4gbmljZSkgZm9yIHBhdGNoIHJldmll
dy4NCg0KSSBoYXZlIHBlcnNvbmFsIGludGVycmVzdCBpbiBDQU4gYW5kIGNvbnRyb2wgc3lzdGVt
cyBldGMuIHdoaWNoDQpjYW4gYmUgdHJhY2tlZCBtb3JlIHRoYW4gMTUgeWVhcnMgYmFjay4gQnV0
IEkgaGF2ZSBubyBmdW5kaW5nDQpmb3IgdGhpcy9RRU1VIHdvcmsgYW5kIHNvbWUgb2YgbXkgb3Ro
ZXIgcHJvamVjdHMgYXZhaWxhYmxlLg0KT24gdGhlIG90aGVyIGhhbmQsIG91ciBncm91cCBvbiBE
ZXBhcnRtZW50IG9mIENvbnRyb2wgRW5naW5uZXJpbmcNCm9mIEN6ZWNoIFRlY2huaWNhbCBVbml2
ZXJzaXR5IGhhdmUgcGFydGljaXBhdGVkIGluIG1hbnkgc2VyaW91cw0KcHJvamVjdHMgYW5kIHdl
IGNvbnRyaWJ1dGUgdG8gKGlkZWFsbHkgYWxsIG9wZW4pIENBTiBlY29zeXN0ZW1zLg0KDQpDQU4g
YXQgQ3plY2ggVGVjaG5pY2FsIFVuaXZlcnNpdHkNCg0KICBodHRwczovL3J0aW1lLmZlbGsuY3Z1
dC5jei9jYW4vDQoNCmxpbmtzIG91ciBncm91cCBwcm9qZWN0cyBhbmQgc29tZSBzbWFsbCBwYXJ0
IG9mIG91ciB1bml2ZXJzaXR5DQpvdGhlciBkZXBhcnRtZW50cyBDQU4gcHJvamVjdHMsIHdoaWNo
IHdlIGhhdmUgZ290IHNvbWUgbm90aWNlIGFib3V0Lg0KDQpJIGNhbm5vdCBzcGVhayBmb3Igb3Vy
IGdyb3VwIGhlYWQgaWYgaGUgcHJvdmlkZSBzdXBwb3J0L2FsbG93cw0KdG8gbWFpbnRhaW4gUUVN
VSBDQU4gcHJvamVjdCBieSB1cy4gQnV0IEkgcGVyc29uYWxseSBoYXZlDQppbnRlcnJlc3QgZm9y
IHRoaXMgYW5kIEkgd291bGQgYXBwbHkgZm9yIG1haW50YWluZXJzaGlwLg0KQnV0IEkvcGVyc29u
YWxseSBjYW4gcHJvdmlkZSBvbmx5IG15IHNwYXJlIHRpbWUgdGhvdWdodA0KSSBoYXZlIGEgcHJv
YmxlbXMgd2l0aCBmYXN0IHJlc3BvbnNlcyBhbmQgdGltZSBpbiBnZW5lcmFsLg0KDQpCdXQgSSBh
bSBrZWVwaW5nIG1hbnkgb3BlbiBwcm9qZWN0IGFsaXZlIG9yIGF0IGxlYXN0IGNvbXBpbGFibGUN
CmZvciAxNSB5ZWFycyBhbmQgbW9yZSBhbHJlYWR5Lg0KDQpodHRwczovL3d3dy5vaGxvaC5uZXQv
YWNjb3VudHMvcHBpc2EvcG9zaXRpb25zDQoNCk9uIFR1ZXNkYXkgMTMgb2YgTWF5IDIwMTQgMTQ6
Mjk6MDggU3RlZmFuIEhham5vY3ppIHdyb3RlOg0KPiBPbiBGcmksIE1heSA5LCAyMDE0IGF0IDg6
MTAgUE0sIFBhdmVsIFBpc2EgPHBpc2FAY21wLmZlbGsuY3Z1dC5jej4gd3JvdGU6DQo+DQo+IFBs
ZWFzZSBydW4gdGhlIHBhdGNoZXMgdGhyb3VnaCBzY3JpcHRzL2NoZWNrcGF0Y2gucGwgYW5kIGFk
ZHJlc3MgdGhlDQo+IHdhcm5pbmdzLg0KPg0KPiBUaGlzIHBhdGNoIGRvZXNuJ3QgdXNlIFFFTVUn
cyBuZXR3b3JrIGxheWVyLiAgUGVyaGFwcyBpdCBzaG91bGQgYnV0DQo+IEknbSBub3QgZmFtaWxp
YXIgd2l0aCBDQU4uICBUaGUgUUVNVSBuZXR3b3JrIGxheWVyIGltcGxlbWVudHMgYQ0KPiBwb2lu
dC10by1wb2ludCBtb2RlbCB3aGVyZSBOZXRDbGllbnRTdGF0ZSBpbnN0YW5jZXMgY2FuIHNlbmQv
cmVjZWl2ZQ0KPiBwYWNrZXRzLiAgSXQgc2VlbXMgYSBzdWJzZXQgb2YgdGhpcyB3YXMgcmVpbXBs
ZW1lbnRlZCBmb3IgQ0FOIGJ1dCBJDQo+IGRvbid0IHNlZSBtdWNoIHVuaXF1ZSBiZWhhdmlvciBp
biB0aGUgY29yZSBDQU4gY29kZS4gIFdoeSBkaWRuJ3QgeW91DQo+IHVzZSB0aGUgUUVNVSBuZXR3
b3JrIGxheWVyPw0KDQpZZXMsIHRoYXQgaXMgbWFpbiBxdWVzdGlvbi4gSXQgd291bGQgYmUgZ3Jl
YXQgdG8gdXNlIFFFTVUgaW5mcmFzdHJ1Y3R1cmUNCmZvciBicm9hZGNhc3RpbmcgbWVzc2FnZXMv
ZnJhbWVzLiBJIGFtIG5vdCBlbm91Z2ggZmFtaWxpYXIgd2l0aCBpdA0KYW5kIEkgd291bGQgbmVl
ZCBzb21lIGhlbHAgdG8gZmluZCBob3cgaXQgY291bGQgYmUgdXNlZCBmb3IgQ0FOLg0KDQpCdXQg
b24gdGhlIG90aGVyIGhhbmQsIHRoZXJlIGlzIHF1ZXN0aW9uLCBpZiByZWFsIGJlaGF2aW9yDQph
bmQgbWVzc2FnZXMgb3JkZXJpbmcgc2hvdWxkIGJlIG1vZGVsbGVkIGZvciBDQU4gb3IgaWYNCndl
IGNvbnNpZGVyIG9ubHkgc29tZSArLy0gd29ya2luZyBzb2x1dGlvbi4gSWYgdGhlIGJlaGF2ZQ0K
b2YgcmVhbCBDQU4gbmV0d29yayBpcyByZXF1aXJlZCBsYXRlciwgaXQgY2FuIGJlIHZlcnkgaGFy
ZA0KdG8gbW9kZWwgaXQgYnkgaW5mcmFzdHJ1Y3R1cmUgZGVzaWduZWQgZm9yIG90aGVyIGRhdGEg
Zmxvdy4NCg0KSW4gdGhlIGZ1bGwgbW9kZWwgY2FzZSwgZWFjaCBDYW5CdXNDbGllbnQgc2hvdWxk
IHB1Ymxpc2gNCml0cyBsaXN0IG9mIENBTiBjb21tdW5pY2F0aW9uIG9iamVjdHMgcmVhZHkgZm9y
IFR4IGFuZCBSeC4NCkZvciBUeCB1c3VhbGx5IG9yZGVyZWQgYnkgbWVzc2FnZSBJRHMgKHJlcHJl
c2VudGluZyBwcmlvcml0eQ0KaW4gYXJiaXRyYXRpb24gcHJvY2VzcykuIEdsb2JhbCBjbGllbnRz
IG9yZGVyIGZvciBnaXZlbiBidXMNCnNob3VsZCBiZSByZWNvbXB1dGVkIGZvciBlYWNoIGNoYW5n
ZSBvbiBjbGllbnRzIGxpc3QgYnkNCmNsaWVudCdzIGNoYW5nZSBhY3RpdmF0ZWQgYnVzIGFyYml0
cmF0aW9uIHByb2Nlc3MuDQpUaGF0IHByb2Nlc3Mgc2hvdWxkIHRoZW4gc2VsZWN0IG5leHQgbWVz
c2FnZSBmb3IgdHJhbnNtaXRpb24uDQpUaGVuIGl0IHNob3VsZCBiZSBkZWxpdmVyZWQgdG8gYWxs
IENhbkJ1c0NsaWVuJ3MgUnggY29tbXVuaWNhdGlvbg0Kb2JqZWN0cyB3aGljaCBmaWx0ZXJzIG1h
dGNoIENBTiBtZXNzYWdlIElELg0KDQpUaGUgbWFpbiBwcm9ibGVtICh3aGVuIGNvbXBhcmVkIHRv
IHRoZSByZWFsIGJ1cykgaXMsIHRoYXQgcmVhbA0KYnVzIGRvZXMgdHJhbnNmZXIgcmF0ZSBsaW1p
dGluZyAobWF4IDFNIGJpdC9zIC0gc3R1ZmZpbmcgZXRjLikuDQpCdXQgaW4gUUVNVSBmYXN0ZXIg
bWVzc2FnZXMgZmxvdyBjYW4gb3ZlcmZsb3cgUnggYnVmZmVycw0KaW4gc2l0dWF0aW9ucyB3aGlj
aCBjYW5ub3QgbGVhZCB0byB0aGUgb3ZlcmZsb3cgaW4gcmVhbCBzaXR1YXRpb24uDQpTbyB0aGVy
ZSBzaG91bGQgYmUgc29tZSBtZWNoYW5pc20gdG8gY2hlY2sgUnggb2JqZWN0IGF2YWlsYWJpbGl0
eQ0KaW4gY2xpZW50cy4gVGhhbiB0aGVyZSBzaG91bGQgYmUgbWVjaGFuaXNtIHRvIHBvc3Rwb25l
IGRhdGEgZXhjaGFuZ2UNCmluIHN1Y2ggY2FzZSBmb3IgYXQgbGVhc3QgdGltZSBlcXVpdmFsZW50
IHRvIHJlYWwgbWVzc2FnZSBwcmVzZW5jZQ0Kb24gYSB3aXJlICh3ZSBoYXZlIGltcGxlbWVudGVk
IGNvbXB1dGF0aW9uIGZvciBleGFjdCB0aW1lIHJlcXVpcmVkDQpmb3IgbWVzc2FnZSBmcm9tIGl0
cyBhY3R1YWwgZGF0YSBpbmNsdWRpbmcgc3R1ZmZpbmcgYW5kIENSQyBkb25lDQpmb3Igb3VyIGlu
ZHVzdHJpYWwgcGFydG5lciBpbiBvdGhlciBwcm9qZWN0KS4NCg0KVGhlIG1lc3NhZ2UgVHggYXR0
ZW1wdCBleHBpcmF0aW9uIHNob3VsZCBiZSBwb3N0cG9uZWQgZm9yDQpldmVuIGxvbmdlciB3aGVu
IGl0IGlzIG5vdCBhY2NlcHRlZC9jb25maXJtZWQgYnkgYW55DQp0YXJnZXQgYW5kIGVycm9yIHNo
b3VsZCBiZSByZXBvcnRlZCBiYWNrIHRvIGNvcnJlc3BvbmRpbmcNClR4IG9iamVjdC4NCg0KU29t
ZSBjb250cm9sbGVycyBwcm92aWRlICJvdmVybG9hZCBmcmFtZSIgcmVzcG9uc2Ugd2hpY2gNCnNo
b3VsZC9jb3VsZCBiZSBpbmNsdWRlZC9lbXVsYXRlZCBhcyB3ZWxsLg0KDQpDb250cm9sbGVycyBz
aG91bGQgZXZhbHVhdGUgYW5kIGNvdW50IFR4IGFuZCBSeCBlcnJvcnMgY291bnRzDQphbmQgY2hh
bmdlIHN0YXRlIGFwcHJvcHJpYXRlbHkuDQoNCkkgYW0gbm90IHN1cmUgaWYgYWxsIHRoYXQgY2Fu
IGJlIGVtdWxhdGVkIGJ5IG5ldHdvcmsgUUVNVQ0Kc3Vic3lzdGVtIG9yIGlmIHJlcXVpcmVkIGNo
YW5nZXMgYXJlIGFjY2VwdGFibGUuDQoNCkkgZG8gbm90IGtub3cgaWYgaXQgd29ydGggdG8gY29u
c2lkZXIgYWxsIHRoaXMgYXQgYWxsLg0KDQpNeSBhY3R1YWwgZ29hbCB3YXMgdG8gaGF2ZSBzb21l
dGhpbmcgc2ltcGxlIHdoaWNoIHdvcmtzDQphbmQgY2FuIGJlIHVzZWQgZm9yIGRyaXZlcnMgaW1w
bGVtZW50b3JzIChpLmUuIFJURU1TKQ0KdG8gZ2V0IGludG8gc3RhdGUgd2hlbiBmaXJzdCBtZXNz
YWdlIGlzIHNlbnQgYW5kIHJlY2VpdmVkDQphbmQgdGhlbiBzd2l0Y2ggdG8gcmVhbCBIVy4NCg0K
QW5kIHllcywgaXQgd291bGQgYmUgZ3JlYXQgdG8gaGF2ZSBhbGwgdGhpcyBpbXBsZW1lbnRlZA0K
dG8gY2FuIGRvIGRyaXZlcnMgdGVzdGluZyBhbmQgY29ycmVjdG5lc3MgYXNzZXNzbWVudCBpbiBR
RU1VLg0KDQpJIGFtIGFibGUgdG8gdGhpbmsgYWJvdXQgaW5mcmFzdHJ1Y3R1cmUgd2hpY2ggYWxs
b3dzIHN1Y2gNCmV4dGVuc2lvbnMgaW4gZnV0dXJlLiBCdXQgcmVhbCBpbXBsZW1lbnRhdGlvbiBp
cyBtdXRpLW1hbi15ZWFyDQpwcm9qZWN0IHdoaWNoIG5lZWRzIGNvbnRyaWJ1dGlvbiBmcm9tIG1v
cmUgcGVvcGxlLg0KDQpTbyBhdCB0aGUgZW5kLCBJIGFtIG5vdCBzdXJlIGlmIG5ldCBvciBub3Qt
bmV0LiBJIGV4cGVjdGVkDQpzb21lIG9iamVjdGlvbnMgdG8gYWRkaXRpb24gb2Ygc3Vic3lzdGVt
LiBJZiB5b3UgYWdyZWUNCndpdGggaHcvY2FuIHRoYW4gSSB3b3VsZCBpbmNsaW5lIHRvIHNlcGFy
YXRpb24gb2YgY29kZSB3aGljaA0KbmVlZHMgdG8gZm9sbG93IENBTiBpbmZyYXN0cnVjdHVyZSBk
ZXZlbG9wbWVudCBjYXVzZWQNCmNoYW5nZXMgdG9nZXRoZXIuDQoNCj4gPiAgIC0gQ0FOIGJ1cyBz
aW1wbGUgU0pBMTAwMCBQQ0kgY2FyZCBlbXVsYXRpb24gZm9yIFFFTVUNCj4gPg0KPiA+ICAgICBG
aWxlczoNCj4gPg0KPiA+ICAgICAgIC0gaW5jbHVkZS9uZXQvY2FuX2VtdS5oDQo+ID4gICAgICAg
ICAgIC0gYmFzaWMgQ0FOIGJ1cyByZWxhdGVkIHR5cGVzLiBUaG9zZSB3aGljaCBjb3VsZCBwb3Nz
aWJseSBjbGFzaA0KPiA+ICAgICAgICAgICAgIHdpdGggTGludXgga2VybmVsIHByZXBlbmRlZCBi
eSAicWVtdV8iLg0KPiA+ICAgICAgICAgICAtIHByb3RvdHlwZXMgZm9yIENBTiBidXNlcyBuYW1p
bmcgYW5kIGNsaWVudHMgcmVnaXN0cmF0aW9uDQo+ID4gICAgICAgICAgIC0gb3JpZ2luYWwgSmlu
IFlhbmcgYXBwcm9hY2ggdXNlcyBjaGFyZGV2LCBidXQgdGhhdCBkb2VzIG5vdA0KPiA+ICAgICAg
ICAgICAgIG1hcCB3ZWxsIHRvIGxpdHRsZSBkaWZmZXJlbnQgc2VtYW50aWNzIG9mIENBTiBtZXNz
YWdlcw0KPiA+ICAgICAgICAgICAgIGRpc3RyaWJ1dGlvbi4gSSBoYXZlIGNvbnNpZGVyZWQgY29t
bW9uIHZsYW4gY29kZSBidXQNCj4gPiAgICAgICAgICAgICBJIGhhdmUgbm90IGZvdW5kIGhvdyB0
byB1c2UgaXQgd2l0aCBDQU4gd2VsbCB0b28uDQo+ID4NCj4gPiAgICAgICAtIGh3L25ldC9jYW5f
Y29yZS5jDQo+ID4gICAgICAgICAgIC0gaW1wbGVtZW50YXRpb24gb2YgQ0FOIG1lc3NhZ2VzIGRl
bGl2ZXJ5DQo+ID4gICAgICAgICAgIC0gc3VwcG9ydCB0byBjb25uZWN0IGludG8gcmVhbCBob3N0
IENBTiBidXMgbmV0d29yayBmb3IgY2FzZQ0KPiA+ICAgICAgICAgICAgIG9mIExpbnV4IFNvY2tl
dENBTg0KPg0KPiBUaGUgbmV0d29yayBsYXllciBpbXBsZW1lbnRzIChwb29ybHkpIGEgZmxvdyBj
b250cm9sIG1lY2hhbmlzbSBzbyB0aGF0DQo+IGRldmljZXMgd2l0aCBsaW1pdGVkIGJ1ZmZlcnMs
IGxpa2UgYSBVU0IgbmV0d29yayBjYXJkLCBjYW4gcGF1c2UNCj4gcmVjZWl2ZSB1bnRpbCB0aGUg
Z3Vlc3QgaGFzIGRyYWluZWQgdGhlIHJlY2VpdmUgYnVmZmVyLiAgSSBkb24ndCBzZWUNCj4gdGhh
dCBpbiB0aGUgQ0FOIGNvZGUsIHNvIGlzIGl0IG9rYXkgdG8gZHJvcCBmcmFtZXM/DQoNClRoZXJl
IGlzIG5vIHN1Y2ggbWVjaGFuaXNtIGluIG91ciBpbXBsZW1lbnRhdGlvbiBub3cuDQpCdXQgaXQg
aXMgZGVzaXJhYmxlIGluIGxvbmdlciBydW4gYW4gdGhlcmUgd2FzIHNvbWUgbWluaW1hbA0Kc29s
dXRpb24gaW4gb3JpZ2luYWwgSmluIFlhbmcncyBjaGFyIGRldmljZSBjb2RlLg0KDQo+IEFib3V0
IHRoZSBMaW51eCBzb2NrZXQgZmlsZSBkZXNjcmlwdG9yOg0KPiAxLiBJdCBzaG91bGQgYmUgbm9u
LWJsb2NraW5nIGJlY2F1c2UgUUVNVSBpcyBhbiBldmVudC1kcml2ZW4gcHJvZ3JhbS4NCj4gV2Ug
bXVzdCBuZXZlciBibG9jayB3YWl0aW5nIHRvIHJlYWQvd3JpdGUgZGF0YSBmcm9tL3RvIGEgc29j
a2V0Lg0KPiAyLiBNaXNzaW5nIEVJTlRSIGVycm9yIGhhbmRsaW5nIGluIGNhc2UgYSBzaWduYWwg
aW50ZXJydXB0ZWQgYQ0KPiByZWFkKDIpL3dyaXRlKDIpIHN5c3RlbSBjYWxsLg0KDQpZZXMsIHRo
YXQgYXJlIG5leHQgc3RlcHMgb3Igb3RoZXIgb3B0aW9uIGlzIHRvIHN0YXJ0DQpkZWxpdmVyeSB0
aHJlYWQgZm9yIGVhY2ggQ0FOIGJ1cy4gV2hpY2ggY291bGQgYmUgbmF0dXJhbA0Kc29sdXRpb24g
Zm9yIHJlYWwgYnVzIGJlaGF2aW9yIHNpbXVsYXRpb24uDQpBcmUgdGhlcmUgc29tZSByZWFzb25z
IGFnYWluc3QgdXNlIG9mIHNlcGFyYXRlIHRocmVhZA0KZm9yIHRoaXMgcHVycG9zZT8NCg0KRXZl
biBzdWNoIHRocmVhZCBjb3VsZCBjYWxsIGFjdHVhbCBzeXNjYWxsIG5vbmJsb2NraW4NCnRvIGNh
biB0aW1lb3V0IGFuZCByZXBvcnQgZXJyb3JzLiBCdXQgaXQgY291bGQgYmUgc2ltcGxlcg0KdG8g
cHJvZ3JhbSBhbmQgcGFyYWxsZWxpemUgbWVzYWdlcyBkZWxpdmVyeSB3aXRoIGVtdWxhdGVkIENQ
VSBydW4uDQoNCj4gSW4gdGhlIFFFTVUgbmV0d29yayBsYXllciB0aGUgY2FuX2NvcmUuYyBiZWhh
dmlvciB3b3VsZCBiZSBwcm9kdWNlZA0KPiB1c2luZyBhIGh1YiB3aXRoIGEgdGFwIG9yIHNvY2tl
dCBuZXRkZXYuICBUaGUgYnJvYWRjYXN0IGNvZGUgaW4gdGhlDQo+IGh1YiBuZXRkZXYgaXMgc2Vw
YXJhdGUgZnJvbSB0aGUgTGludXgtc3BlY2lmaWMgdGFwIGNvZGUuICBJIHRoaW5rIHlvdQ0KPiBj
YW4gaW1wbGVtZW50IGEgQ0FOIHNvY2tldCBuZXRkZXYgYW5kIHVzZSB0aGUgaHViIHRvIGJyb2Fk
Y2FzdC4NCg0KSSBuZWVkIHRvIGxlYXJuIG1vcmUgYWJvdXQgUUVNVSBpbnRlcm5hbHMgYW5kIHJl
dXNhYmxlIGZlYXR1cmVzLg0KVGhhbmsgZm9yIHN1Z2dlc3Rpb25zLg0KDQo+ID4gICAgICAgLSBo
dy9uZXQvY2FuX3NqYTEwMDAuaA0KPiA+ICAgICAgICAgICAtIGRlY2xhcmF0aW9ucyBvZiBTSkEx
MDAwIENBTiBjb250cm9sbGVyIHJlZ2lzdGVycw0KPiA+ICAgICAgICAgICAgIGFuZCBjb25uZWN0
aW9uIHR5cGUgaW5kZXBlbmRlbnQgcGFydCBvZiBBUEkNCj4gPg0KPiA+ICAgICAgIC0gaHcvbmV0
L2Nhbl9zamExMDAwLmMNCj4gPiAgICAgICAgICAgLSBTSkExMDAwIENBTiBjb250cm9sbGVyIHJl
Z2lzdGVycyBhbmQgcmVnaXN0ZXJzIG1vZGVsDQo+ID4gICAgICAgICAgICAgaW1wbGVtZW50YXRp
b24gLSBoYXJkIHBhcnQgaW1wbGVtZW50ZWQgYnkgSmluIFlhbmcNCj4gPg0KPiA+ICAgICAgIC0g
aHcvbmV0L2Nhbl9wY2kuYw0KPiA+ICAgICAgICAgICAtIGNvbm5lY3Rpb24gb2YgYWJvdmUgaW5m
cmFzdHJ1Y3R1cmUgdG8gdGhlIG1pbmltYWwgUENJDQo+ID4gICAgICAgICAgICAgY2FyZCB3aXRo
IG9ubHkgb25lIG1taW8gQkFSIGFuZCBubyBicmlkZ2UgaW50ZXJydXB0cyBzZXR1cA0KPiA+ICAg
ICAgICAgICAgIGFuZCBjb250cm9sLiBVbmZvcnR1YW50ZWxseSwgSSBhbSBub3QgYXdhcmUgb2Yg
YW55IHN1Y2gNCj4gPiAgICAgICAgICAgICBzdHJhaWdodGZvcndhcmQgY2FyZCBidXQgaXQgaXMg
Z3JlYXQgZm9yIHRlc3RpbmcgYW5kDQo+ID4gICAgICAgICAgICAgZHJpdmVycyBwb3J0aW5nLiBV
c2VkIHZlbmRvciBhbmQgcHJvZHVjdCBJRCBhcmUgcmFuZG9tIG9uZXMNCj4gPiAgICAgICAgICAg
ICBjaG9zZW4gYnkgSmluIFlhbmcsIGlmIHRoZXJlIGlzIHNvbWUgY29uc2Vuc3VzIHRoYXQgd29y
aw0KPiA+IHdvcnRoIGZvciBpbnRlZ3JhdGlvbiB0aGVuIEkgc3VnZ2VzdCB0byBhc2sgUmVkSGF0
IGZvciB1bmlxdWUgUENJIElEDQo+ID4gZG9uYXRpb24NCj4NCj4gV2hhdCBpcyB0aGUgcmVsYXRp
b25zaGlwIGJldHdlZW4gY2FuX3BjaS5jIGFuZCB0aGUgZW11bGF0ZWQgS3Zhc2VyIGRldmljZT8N
Cj4NCj4gSW1wbGVtZW50aW5nIG9uZSByZWFsIGRldmljZSB3b3VsZCBiZSB2ZXJ5IGltcG9ydGFu
dCB0byBlc3RhYmxpc2ggdGhhdA0KPiB0aGlzIENBTiBpbXBsZW1lbnRhdGlvbiBjYW4gbW9kZWwg
cmVhbCBkZXZpY2VzLg0KDQpUaGVyZSBpcyBicm9hZCByYW5nZSBvZiBDQU4gY29udHJvbGxlcnMs
IHdlIGhhdmUgc2VsZWN0ZWQgb25lIGZhbW91cyBDQU4NCmRpc2NyZXRlIGNvbnRyb2xsZXIgY2hp
cCBTSkExMDAwLiBQcm9ibGVtIGlzLCB0aGF0IGl0IHByZWRhdGVzIFBDSQ0KYW5kIGlzIGludGVu
ZGVkIHRvIGJlIHVzZWQgd2l0aCA4MDUxIGxpa2UgbXVsdGlwbGV4ZWQgYnVzLg0KSXQgaXMgc3Rp
bGwgb25lIG9mIHRoZSBtb3N0IHVzZWQgY2hpcHMgb24gYWRkb25zIGNhcmRzLiBDQU4gaXMgY29t
bW9uDQpvbiBTb0MgYW5kIE1DVXMgYW5kIHRoZXkgdXNlIG1hbnkgZGlmZmVyZW50IGRlcml2YXRp
b25zIG9yIGNvbXBsZXRlbHkNCmRpZmZlcmVudCByZWdpc3RlcnMgbW9kZWxzLiBCdXQgdGhlcmUg
aXMgcmVhbGx5IHZlcnkgbGl0dGxlIG90aGVyDQpDQU4gY29udHJvbGxlciBjaGlwcyBhdmFpbGFi
bGUgZm9yIGFkZG9uIGNhcmRzIChPS0ksIGRpc2NvbnRpbnVlZCBJbnRlbCwgLi4uKS4NClNvIFNK
QTEwMDAgaXMgcmVhc29uYWJsZSBjaG9pY2UgZm9yIG91ciBRRU1VIGVmZm9ydC4gQnV0IGl0IGhh
cyB0byBiZSB1c2VkDQppbiBjb21iaW5hdGlvbiB3aXRoIHNvbWUgUENJLWxvY2FsIGJ1cyBicmlk
Z2UuIEJ1dCB0aGVzZSBicmlkZ2VzDQphcmUgcXVpdGUgc3RyYW5nZSwgc29tZXRpbWVzIHJldXNl
ZCBjaGlwIGZvciBvbGQgSVNETiBzb2x1dGlvbnMgZXRjLg0KU28gdGhleSBuZWVkIHNwZWNpYWwg
Y29uZmlndXJhdGlvbiB0byBhY2Nlc3MgbG9jYWwgYnVzIGNvbm5lY3RlZCBDQU4NCmNvbnRyb2xs
ZXIgYW5kIG1haW5seSB0byBzZXR1cCByb3V0aW5nIG9mIGludGVycnVwdHMuDQoNCkVtdWxhdGlv
biBvZiBQQ0ktbG9jYWwgYnVzIGJyaWRnZSBjb21wbGljYXRlcyBib3RoIHNpZGVzIGluIGFjdGlv
biAtDQpRRU1VIGVtdWxhdGlvbiBzaWRlIGFuZCBkZXZlbG9wZWQgQ0FOIGRyaXZlcnMgc2lkZS4g
VGhhdCBpcyB3aHkNCndlIGhhdmUgImRlc2lnbmVkIiBiYXNpYyBjYXJkIHdpdGggY2xlYW4gaW1w
bGVtZW50YXRpb24gZGlyZWN0bHkNCm1hcHBpbmcgU0pBMTAwMCBjaGlwIGludG8gUENJIG1lbW9y
eSBCQVIgd2l0aCBkaXJlY3QsIGxldmVsIHRyaWdnZXJlZA0Kcm91dGluZyBvZiBpbnRlcnJ1cHQg
dG8gY29ycmVzcG9uZGluZyAiUENJIGJvYXJkIiBBIHBpbi4NCg0KV2hlbiB3ZSBoYXZlIGNvbmZp
cm1lZCB0aGF0IHRoaXMgd29ya3MgdG9nZXRoZXIgd2l0aCBtb2RpZmllZA0KTGluQ0FOIGRyaXZl
ciBJIGhhdmUgc3RhcnRlZCB0byBpbXBsZW1lbnQgbW9kZWwgY29ycmVzcG9uZGluZw0KdG8gcmVh
bCBQQ0kgQ0FOIGNhcmQuIEkgaGF2ZSBzZWxlY3RlZCBLdmFzZXIgY2FyZCBiZWNhdXNlDQp3ZSBw
b3NlIG1vcmUgb2YgdGhlc2UgYXQgdW5pdmVyc2l0eS9zbyBJIGNhbiBjaGVjayByZWFsIGNvbnRl
bnRzDQpvZiBvdGhlciBjb25maWd1cmF0aW9uL3N1cHBvcnQgc3BhY2VzL0JBUnMgb24gcmVhbCBk
ZXZpY2UuDQpUaGUgYWR2YW50YWdlIG9mIHRoYXQgc2VsZWN0aW9uIGlzIHRoYXQgZHJpdmVyIGZv
ciB0aGlzIGNhcmQNCmlzIGluY2x1ZGVkIGluIG1haW5saW5lIExpbnV4IGluIENBTi9Tb2NrZXRD
QU4gc3Vic3lzdGVtLg0KVGhpcyBib2FyZCBjYW4gaGF2ZSB1cCB0byBmb3VyIFNKQTEwMDAgY2hp
cHMgaW4gb25lIG9mIGl0cyBCQVJzLA0KVGhlIGJvYXJkIHJvdXRlcyBpbnRlcnJ1cHRzIHRocm91
Z2ggYnJpZGUgaW50ZXJydXB0IGNvbnRyb2wvbWFza2luZw0KYW5kIGNvbmZpZ3VyYXRpb24sIHdo
aWNoIGhhcyB0byBiZSBlbXVsYXRlZCBhcyB3ZWxsLg0KSXQgZXZlbiBtYXBzIGNoaXBzIGludG8g
SS9PIHNwYWNlIGluc3RlYWQgb2YgTU1JTy4NCg0KSSB0aGluayB0aGF0IGZvciBkcml2ZXJzIHdy
aXRlcnMgb3IgZXZlbiBjYW4gaW5mcmFzdHJ1Y3R1cmUNCmRldmVsb3BlcnMgKHVzZXJzcGFjZSBh
bmQgaGlnaGVyIGxldmVsIHRvb2xzKSBpdCBpcyBhZHZhbnRhZ2UgdG8gaGF2ZQ0Kc2ltcGxlIHNv
bHV0aW9uIHdpdGggY29ycmVzcG9uZGluZyBkcml2ZXIgaW4gYSBndWVzdCBrZXJuZWwgKHNvbWV0
aGluZw0KbGlrZSB2aXJ0aW8pLiBPbiB0aGUgb3RoZXIgaGFuZCwgY29uY3JldGUgcmVhbCBoYXJk
d2FyZSBkcml2ZXINCnRlc3RpbmcgcmVxdWlyZXMgZXhhY3QgaGFyZHdhcmUgY29tcGxleGl0eSBl
bXVsYXRpb24gYW5kIGFsbG93cw0KdG8gdXNlIHVubW9kaWZpZWQgT1MgYW5kIGF2YWlsYWJsZSBk
cml2ZXJzLg0KDQpCdXQgaWYgeW91IHRoaW5rLCB0aGF0IHRoaXMgYXJ0aWZpY2lhbCBzaW1wbGUg
Y2FyZCBkZXNpZ24gaXMgbm90DQpnb29kIGlkZWEgZm9yIFFFTVUsIHRoZW4gaXQgY2FuIGJlIGRp
c2NhcmRlZCBhbmQgb25seSBLdmFzZXINCih3aGVuIGl0IHdvcmtzIG5vdykgaW5jbHVkZWQuDQoN
ClRoZSBkZWNpc2lvbnMgZm9yIGZ1cnRoZXIgZGV2ZWxvcG1lbnQNCg0KU2hvdWxkIGJlIG1pbmlt
YWwgd29ya2luZyBzb2x1dGlvbiBpbmNsdWRlZCBpbiB0aGUgUUVNVQ0KbWFpbmxpbmUgaW4gc2hv
cnQgdGVybT8NCihtb250aHMgLi4gb3IgcmF0aGVyIHdhaXQgZm9yIGFncmVlbWVudCBvbiBmaW5h
bA0KaW5mcmFzdHJ1Y3R1cmUsIG1heSBiZSB5ZWFycyBiZWNhdXNlIG9mIG91ciBvdGhlciBsb2Fk
DQphbmQgY29tcGxleGl0eSBvZiBmdWxsIG1vZGVsIHRhc2spDQoNCklzIHByZWZlcnJlZCBhcHBy
b2FjaCB0byBvcGVuIENBTiBRRU1VIGZvcmsgb24gR2l0SHViPw0KRXRjLi4uDQoNCkkgY29uc2lk
ZXIgYXMgYSBnb29kIHJlc3VsdCwgdGhhdCBteSBhY3R1YWwgYXR0ZW1wdCBhbmQgUUVNVSBvZmZl
cmVkDQppbmZyYXN0cnVjdHVyZSBhbGxvd3MgdG8gdG8gcHJvdmlkZSBtaW5pbWFsIHRlc3RhYmxl
IHNvbHV0aW9uIHdpdGgNCm5vIFFFTVUgbW9kaWZpY2F0aW9ucyAoZXhjZXB0IE1ha2VmaWxlcyku
IFNvIEkgaG9wZSB0aGF0IGlzIGlzDQpyZWFzb25hYmxlIHN0YXJ0IGFuZCBvdXIgZWZmb3J0IHdv
dWxkIGJlIG9mIHNvbWUgdXNlIGZvciBvdGhlcnMuDQoNCkJlc3Qgd2lzaGVzLA0KDQogICAgICAg
ICAgICAgIFBhdmVsDQoNClBTOiBJIGFtIG5vdCBzdXJlIGlmIEkgd2lsbCBiZSBvbmxpbmUgdGls
bCBNb25kYXk=

------=_001_NextPart101010047614_=----
Content-Type: text/html;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=EF=BB=BF<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META content=3D"text/html; charset=3Dutf-8" http-equiv=3DContent-Type>
<STYLE>
BLOCKQUOTE {
	MARGIN-TOP: 0px; MARGIN-BOTTOM: 0px; MARGIN-LEFT: 2em
}
OL {
	MARGIN-TOP: 0px; MARGIN-BOTTOM: 0px
}
UL {
	MARGIN-TOP: 0px; MARGIN-BOTTOM: 0px
}
P {
	MARGIN-TOP: 0px; MARGIN-BOTTOM: 0px
}
BODY {
	LINE-HEIGHT: 1.5; FONT-FAMILY: =E5=BE=AE=E8=BD=AF=E9=9B=85=E9=BB=91; COLO=
R: #000000; FONT-SIZE: 10.5pt
}
</STYLE>

<META name=3DGENERATOR content=3D"MSHTML 8.00.7600.17267"></HEAD>
<BODY style=3D"MARGIN: 10px">
<DIV>Hi, all</DIV>
<DIV>I just read this e-mail today. didn't check the e-mail for a long tim=
e,=20
because a&nbsp;little busy on the graduation stuffs. I still want to do=20
something on this project. So, i would like to working on anything i can=20
help.</DIV>
<DIV>&nbsp;</DIV>
<DIV>Thanks,</DIV>
<DIV>Jin Yang</DIV>
<DIV>&nbsp;</DIV>
<HR style=3D"WIDTH: 210px; HEIGHT: 1px" align=3Dleft color=3D#b5c4df SIZE=
=3D1>

<DIV><SPAN>
<DIV style=3D"FONT-FAMILY: verdana; FONT-SIZE: 10pt">
<DIV>jinyang.sia-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</DIV></DIV></SPAN></DIV>
<DIV>&nbsp;</DIV>
<DIV=20
style=3D"BORDER-BOTTOM: medium none; BORDER-LEFT: medium none; PADDING-BOT=
TOM: 0cm; PADDING-LEFT: 0cm; PADDING-RIGHT: 0cm; BORDER-TOP: #b5c4df 1pt s=
olid; BORDER-RIGHT: medium none; PADDING-TOP: 3pt">
<DIV=20
style=3D"PADDING-BOTTOM: 8px; PADDING-LEFT: 8px; PADDING-RIGHT: 8px; FONT-=
FAMILY: tahoma; BACKGROUND: #efefef; COLOR: #000000; FONT-SIZE: 12px; PADD=
ING-TOP: 8px">
<DIV><B>From:</B>&nbsp;<A href=3D"mailto:pisa-/N2ztlQkxE7Ub/6JBqosbQ@public.gmane.org">Pavel=20
Pisa</A></DIV>
<DIV><B>Date:</B>&nbsp;2014-05-15&nbsp;21:53</DIV>
<DIV><B>To:</B>&nbsp;<A href=3D"mailto:stefanha-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">Stefan Hajnoczi=
</A>; <A=20
href=3D"mailto:afaerber-l3A5Bk7waGM@public.gmane.org">AndreasF=C3=A4rber</A>; <A=20
href=3D"mailto:peter.crosthwaite-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org">Peter Crosthwaite</A></DIV>
<DIV><B>CC:</B>&nbsp;<A=20
href=3D"mailto:qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org">qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org</A>; <A=20
href=3D"mailto:socketcan-fJ+pQTUTwRTk1uMJSBkQmQ@public.gmane.org">Oliver Hartkopp A</A>; <A=20
href=3D"mailto:jinyang.sia-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">jinyang.sia</A>; <A=20
href=3D"mailto:sw-QDXxdeohBKYb1SvskN2V4Q@public.gmane.org">Stefan Weil</A>; <A=20
href=3D"mailto:rtems-devel-WKV1R6NGPIzYtjvyW6yDsg@public.gmane.org">rtems-devel</A>; <A=20
href=3D"mailto:linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">linux-can</A></DIV>
<DIV><B>Subject:</B>&nbsp;Re: [Qemu-devel] [PATCH 0/2] CAN SJA100 controll=
er=20
emulation and SocketCAN based host CAN bus access</DIV></DIV></DIV>
<DIV>
<DIV>Hello all,</DIV>
<DIV>&nbsp;</DIV>
<DIV>the first much thanks to Stefan, Andreas and Peter</DIV>
<DIV>for reply.</DIV>
<DIV>&nbsp;</DIV>
<DIV>Next, should I keep linux-can in the talk</DIV>
<DIV>(it is against list cross-posting rule) or all</DIV>
<DIV>potentially interrested participants agree to stay/follow</DIV>
<DIV>this and future CAN+QEMU related topics on QEMU list?</DIV>
<DIV>&nbsp;</DIV>
<DIV>I would remove RTEMS in the next post. Even that</DIV>
<DIV>it is one of potential users, original "investor",</DIV>
<DIV>internals of the emulation are out of this project</DIV>
<DIV>scope.</DIV>
<DIV>&nbsp;</DIV>
<DIV>On Monday 12 of May 2014 11:18:09 Andreas F=C3=A4rber wrote:</DIV>
<DIV>&gt; Am 12.05.2014 11:01, schrieb Peter Crosthwaite:</DIV>
<DIV>&gt; &gt; On Sat, May 10, 2014 at 4:14 AM, Pavel Pisa=20
&lt;pisa-/N2ztlQkxE7Ub/6JBqosbQ@public.gmane.org&gt; wrote:</DIV>
<DIV>&gt; &gt;&gt; The work is based on Jin Yang GSoC 2013 work funded</DI=
V>
<DIV>&gt; &gt;&gt; by Google and mentored in frame of RTEMS project GSoC</=
DIV>
<DIV>&gt; &gt;&gt; slot donated to QEMU.</DIV>
<DIV>&gt;</DIV>
<DIV>&gt; Should/can that be recorded in form of his Signed-off-by before=20
yours?</DIV>
<DIV>&nbsp;</DIV>
<DIV>I try to do something with that. I would preffer to add him</DIV>
<DIV>but I would like to have his confirmation beforehand.</DIV>
<DIV>The GSoC 2013 work is available in his GitHub repo including</DIV>
<DIV>negotiated final licence inclusion</DIV>
<DIV>&nbsp;</DIV>
<DIV>https://github.com/Jin-Yang/QEMU-1.4.2</DIV>
<DIV>&nbsp;</DIV>
<DIV>I was against to bothering you by patches for old QEMU</DIV>
<DIV>version so I have postponed communication till I have</DIV>
<DIV>time to bring it to the latest GIT. But there is significant</DIV>
<DIV>redesign which unties changes from hardcoded modifications</DIV>
<DIV>to QEMU character driver (original approach) and changes</DIV>
<DIV>whole patches architecture substantially including</DIV>
<DIV>omission of some functionality for beginning and probably</DIV>
<DIV>introduction of new errors. So I think that I am not</DIV>
<DIV>authorized to provide Signed-off-by Jin Yang on my own.</DIV>
<DIV>But original work status and license is declared by</DIV>
<DIV>Jin Yang and GSoC 2013.</DIV>
<DIV>&nbsp;</DIV>
<DIV>&gt; &gt; That's a big patch. And it seems to add a new API/framework=
, then=20
new</DIV>
<DIV>&gt; &gt; users of that API. Can you add your core as a single patch,=
=20
then</DIV>
<DIV>&gt; &gt; incrementally bring your devices stuff as subsequent patche=
s? My=20
guess</DIV>
<DIV>&gt; &gt; is this should be about 3 patches - are there any circular=20
deps,</DIV>
<DIV>&gt; &gt; requiring you to bring your three c files all at once or is=
 there=20
a</DIV>
<DIV>&gt; &gt; logical order you can add them for ease of review?</DIV>
<DIV>&gt;</DIV>
<DIV>&gt; True. But before you resend, I'd like to hear Stefan H.'s view=20
of</DIV>
<DIV>&gt; whether CAN should go into hw/net/ at all or into, e.g.,=20
hw/can/.</DIV>
<DIV>&nbsp;</DIV>
<DIV>That is significant question and my sending of the patch series is=20
mainly</DIV>
<DIV>base to start discussion about this and support architecture.</DIV>
<DIV>I need to learn mnore about QEMU internals and possible mechanisms</D=
IV>
<DIV>to use from QEMU experts as well.</DIV>
<DIV>&nbsp;</DIV>
<DIV>&gt; Independently of the placement, it's always an interesting quest=
ion=20
of</DIV>
<DIV>&gt; who will maintain this new infrastructure - I don't see any new<=
/DIV>
<DIV>&gt; MAINTAINERS entries getting added in either patch (NB: a diffsta=
t in=20
0/2</DIV>
<DIV>&gt; would've been nice) for patch review.</DIV>
<DIV>&nbsp;</DIV>
<DIV>I have personal interrest in CAN and control systems etc. which</DIV>
<DIV>can be tracked more than 15 years back. But I have no funding</DIV>
<DIV>for this/QEMU work and some of my other projects available.</DIV>
<DIV>On the other hand, our group on Department of Control Enginnering</DI=
V>
<DIV>of Czech Technical University have participated in many serious</DIV>
<DIV>projects and we contribute to (ideally all open) CAN ecosystems.</DIV=
>
<DIV>&nbsp;</DIV>
<DIV>CAN at Czech Technical University</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp; https://rtime.felk.cvut.cz/can/</DIV>
<DIV>&nbsp;</DIV>
<DIV>links our group projects and some small part of our university</DIV>
<DIV>other departments CAN projects, which we have got some notice about.<=
/DIV>
<DIV>&nbsp;</DIV>
<DIV>I cannot speak for our group head if he provide support/allows</DIV>
<DIV>to maintain QEMU CAN project by us. But I personally have</DIV>
<DIV>interrest for this and I would apply for maintainership.</DIV>
<DIV>But I/personally can provide only my spare time thought</DIV>
<DIV>I have a problems with fast responses and time in general.</DIV>
<DIV>&nbsp;</DIV>
<DIV>But I am keeping many open project alive or at least compilable</DIV>
<DIV>for 15 years and more already.</DIV>
<DIV>&nbsp;</DIV>
<DIV>https://www.ohloh.net/accounts/ppisa/positions</DIV>
<DIV>&nbsp;</DIV>
<DIV>On Tuesday 13 of May 2014 14:29:08 Stefan Hajnoczi wrote:</DIV>
<DIV>&gt; On Fri, May 9, 2014 at 8:10 PM, Pavel Pisa=20
&lt;pisa-/N2ztlQkxE7Ub/6JBqosbQ@public.gmane.org&gt; wrote:</DIV>
<DIV>&gt;</DIV>
<DIV>&gt; Please run the patches through scripts/checkpatch.pl and address=
=20
the</DIV>
<DIV>&gt; warnings.</DIV>
<DIV>&gt;</DIV>
<DIV>&gt; This patch doesn't use QEMU's network layer.&nbsp; Perhaps it sh=
ould=20
but</DIV>
<DIV>&gt; I'm not familiar with CAN.&nbsp; The QEMU network layer implemen=
ts=20
a</DIV>
<DIV>&gt; point-to-point model where NetClientState instances can=20
send/receive</DIV>
<DIV>&gt; packets.&nbsp; It seems a subset of this was reimplemented for C=
AN but=20
I</DIV>
<DIV>&gt; don't see much unique behavior in the core CAN code.&nbsp; Why d=
idn't=20
you</DIV>
<DIV>&gt; use the QEMU network layer?</DIV>
<DIV>&nbsp;</DIV>
<DIV>Yes, that is main question. It would be great to use QEMU=20
infrastructure</DIV>
<DIV>for broadcasting messages/frames. I am not enough familiar with it</D=
IV>
<DIV>and I would need some help to find how it could be used for CAN.</DIV=
>
<DIV>&nbsp;</DIV>
<DIV>But on the other hand, there is question, if real behavior</DIV>
<DIV>and messages ordering should be modelled for CAN or if</DIV>
<DIV>we consider only some +/- working solution. If the behave</DIV>
<DIV>of real CAN network is required later, it can be very hard</DIV>
<DIV>to model it by infrastructure designed for other data flow.</DIV>
<DIV>&nbsp;</DIV>
<DIV>In the full model case, each CanBusClient should publish</DIV>
<DIV>its list of CAN communication objects ready for Tx and Rx.</DIV>
<DIV>For Tx usually ordered by message IDs (representing priority</DIV>
<DIV>in arbitration process). Global clients order for given bus</DIV>
<DIV>should be recomputed for each change on clients list by</DIV>
<DIV>client's change activated bus arbitration process.</DIV>
<DIV>That process should then select next message for transmition.</DIV>
<DIV>Then it should be delivered to all CanBusClien's Rx communication</DI=
V>
<DIV>objects which filters match CAN message ID.</DIV>
<DIV>&nbsp;</DIV>
<DIV>The main problem (when compared to the real bus) is, that real</DIV>
<DIV>bus does transfer rate limiting (max 1M bit/s - stuffing etc.).</DIV>
<DIV>But in QEMU faster messages flow can overflow Rx buffers</DIV>
<DIV>in situations which cannot lead to the overflow in real situation.</D=
IV>
<DIV>So there should be some mechanism to check Rx object availability</DI=
V>
<DIV>in clients. Than there should be mechanism to postpone data exchange<=
/DIV>
<DIV>in such case for at least time equivalent to real message presence</D=
IV>
<DIV>on a wire (we have implemented computation for exact time required</D=
IV>
<DIV>for message from its actual data including stuffing and CRC done</DIV=
>
<DIV>for our industrial partner in other project).</DIV>
<DIV>&nbsp;</DIV>
<DIV>The message Tx attempt expiration should be postponed for</DIV>
<DIV>even longer when it is not accepted/confirmed by any</DIV>
<DIV>target and error should be reported back to corresponding</DIV>
<DIV>Tx object.</DIV>
<DIV>&nbsp;</DIV>
<DIV>Some controllers provide "overload frame" response which</DIV>
<DIV>should/could be included/emulated as well.</DIV>
<DIV>&nbsp;</DIV>
<DIV>Controllers should evaluate and count Tx and Rx errors counts</DIV>
<DIV>and change state appropriately.</DIV>
<DIV>&nbsp;</DIV>
<DIV>I am not sure if all that can be emulated by network QEMU</DIV>
<DIV>subsystem or if required changes are acceptable.</DIV>
<DIV>&nbsp;</DIV>
<DIV>I do not know if it worth to consider all this at all.</DIV>
<DIV>&nbsp;</DIV>
<DIV>My actual goal was to have something simple which works</DIV>
<DIV>and can be used for drivers implementors (i.e. RTEMS)</DIV>
<DIV>to get into state when first message is sent and received</DIV>
<DIV>and then switch to real HW.</DIV>
<DIV>&nbsp;</DIV>
<DIV>And yes, it would be great to have all this implemented</DIV>
<DIV>to can do drivers testing and correctness assessment in QEMU.</DIV>
<DIV>&nbsp;</DIV>
<DIV>I am able to think about infrastructure which allows such</DIV>
<DIV>extensions in future. But real implementation is muti-man-year</DIV>
<DIV>project which needs contribution from more people.</DIV>
<DIV>&nbsp;</DIV>
<DIV>So at the end, I am not sure if net or not-net. I expected</DIV>
<DIV>some objections to addition of subsystem. If you agree</DIV>
<DIV>with hw/can than I would incline to separation of code which</DIV>
<DIV>needs to follow CAN infrastructure development caused</DIV>
<DIV>changes together.</DIV>
<DIV>&nbsp;</DIV>
<DIV>&gt; &gt;&nbsp;&nbsp; - CAN bus simple SJA1000 PCI card emulation for=
=20
QEMU</DIV>
<DIV>&gt; &gt;</DIV>
<DIV>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; Files:</DIV>
<DIV>&gt; &gt;</DIV>
<DIV>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - include/net/can_emu.h=
</DIV>
<DIV>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 -=20
basic CAN bus related types. Those which could possibly clash</DIV>
<DIV>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;=20
with Linux kernel prepended by "qemu_".</DIV>
<DIV>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 -=20
prototypes for CAN buses naming and clients registration</DIV>
<DIV>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 -=20
original Jin Yang approach uses chardev, but that does not</DIV>
<DIV>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; map=20
well to little different semantics of CAN messages</DIV>
<DIV>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;=20
distribution. I have considered common vlan code but</DIV>
<DIV>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; I=20
have not found how to use it with CAN well too.</DIV>
<DIV>&gt; &gt;</DIV>
<DIV>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - hw/net/can_core.c</DI=
V>
<DIV>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 -=20
implementation of CAN messages delivery</DIV>
<DIV>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 -=20
support to connect into real host CAN bus network for case</DIV>
<DIV>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; of=20
Linux SocketCAN</DIV>
<DIV>&gt;</DIV>
<DIV>&gt; The network layer implements (poorly) a flow control mechanism s=
o=20
that</DIV>
<DIV>&gt; devices with limited buffers, like a USB network card, can pause=
</DIV>
<DIV>&gt; receive until the guest has drained the receive buffer.&nbsp; I =
don't=20
see</DIV>
<DIV>&gt; that in the CAN code, so is it okay to drop frames?</DIV>
<DIV>&nbsp;</DIV>
<DIV>There is no such mechanism in our implementation now.</DIV>
<DIV>But it is desirable in longer run an there was some minimal</DIV>
<DIV>solution in original Jin Yang's char device code.</DIV>
<DIV>&nbsp;</DIV>
<DIV>&gt; About the Linux socket file descriptor:</DIV>
<DIV>&gt; 1. It should be non-blocking because QEMU is an event-driven=20
program.</DIV>
<DIV>&gt; We must never block waiting to read/write data from/to a socket.=
</DIV>
<DIV>&gt; 2. Missing EINTR error handling in case a signal interrupted a</=
DIV>
<DIV>&gt; read(2)/write(2) system call.</DIV>
<DIV>&nbsp;</DIV>
<DIV>Yes, that are next steps or other option is to start</DIV>
<DIV>delivery thread for each CAN bus. Which could be natural</DIV>
<DIV>solution for real bus behavior simulation.</DIV>
<DIV>Are there some reasons against use of separate thread</DIV>
<DIV>for this purpose?</DIV>
<DIV>&nbsp;</DIV>
<DIV>Even such thread could call actual syscall nonblockin</DIV>
<DIV>to can timeout and report errors. But it could be simpler</DIV>
<DIV>to program and parallelize mesages delivery with emulated CPU run.</D=
IV>
<DIV>&nbsp;</DIV>
<DIV>&gt; In the QEMU network layer the can_core.c behavior would be=20
produced</DIV>
<DIV>&gt; using a hub with a tap or socket netdev.&nbsp; The broadcast cod=
e in=20
the</DIV>
<DIV>&gt; hub netdev is separate from the Linux-specific tap code.&nbsp; I=
 think=20
you</DIV>
<DIV>&gt; can implement a CAN socket netdev and use the hub to broadcast.<=
/DIV>
<DIV>&nbsp;</DIV>
<DIV>I need to learn more about QEMU internals and reusable features.</DIV=
>
<DIV>Thank for suggestions.</DIV>
<DIV>&nbsp;</DIV>
<DIV>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - hw/net/can_sja1000.h<=
/DIV>
<DIV>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 -=20
declarations of SJA1000 CAN controller registers</DIV>
<DIV>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; and=20
connection type independent part of API</DIV>
<DIV>&gt; &gt;</DIV>
<DIV>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - hw/net/can_sja1000.c<=
/DIV>
<DIV>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 -=20
SJA1000 CAN controller registers and registers model</DIV>
<DIV>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;=20
implementation - hard part implemented by Jin Yang</DIV>
<DIV>&gt; &gt;</DIV>
<DIV>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - hw/net/can_pci.c</DIV=
>
<DIV>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 -=20
connection of above infrastructure to the minimal PCI</DIV>
<DIV>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;=20
card with only one mmio BAR and no bridge interrupts setup</DIV>
<DIV>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; and=20
control. Unfortuantelly, I am not aware of any such</DIV>
<DIV>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;=20
straightforward card but it is great for testing and</DIV>
<DIV>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;=20
drivers porting. Used vendor and product ID are random ones</DIV>
<DIV>&gt;=20
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;=20
chosen by Jin Yang, if there is some consensus that work</DIV>
<DIV>&gt; &gt; worth for integration then I suggest to ask RedHat for uniq=
ue PCI=20
ID</DIV>
<DIV>&gt; &gt; donation</DIV>
<DIV>&gt;</DIV>
<DIV>&gt; What is the relationship between can_pci.c and the emulated Kvas=
er=20
device?</DIV>
<DIV>&gt;</DIV>
<DIV>&gt; Implementing one real device would be very important to establis=
h=20
that</DIV>
<DIV>&gt; this CAN implementation can model real devices.</DIV>
<DIV>&nbsp;</DIV>
<DIV>There is broad range of CAN controllers, we have selected one famous=20
CAN</DIV>
<DIV>discrete controller chip SJA1000. Problem is, that it predates PCI</D=
IV>
<DIV>and is intended to be used with 8051 like multiplexed bus.</DIV>
<DIV>It is still one of the most used chips on addons cards. CAN is common=
</DIV>
<DIV>on SoC and MCUs and they use many different derivations or completely=
</DIV>
<DIV>different registers models. But there is really very little other</DI=
V>
<DIV>CAN controller chips available for addon cards (OKI, discontinued Int=
el,=20
...).</DIV>
<DIV>So SJA1000 is reasonable choice for our QEMU effort. But it has to be=
=20
used</DIV>
<DIV>in combination with some PCI-local bus bridge. But these bridges</DIV=
>
<DIV>are quite strange, sometimes reused chip for old ISDN solutions etc.<=
/DIV>
<DIV>So they need special configuration to access local bus connected CAN<=
/DIV>
<DIV>controller and mainly to setup routing of interrupts.</DIV>
<DIV>&nbsp;</DIV>
<DIV>Emulation of PCI-local bus bridge complicates both sides in action -<=
/DIV>
<DIV>QEMU emulation side and developed CAN drivers side. That is why</DIV>
<DIV>we have "designed" basic card with clean implementation directly</DIV=
>
<DIV>mapping SJA1000 chip into PCI memory BAR with direct, level triggered=
</DIV>
<DIV>routing of interrupt to corresponding "PCI board" A pin.</DIV>
<DIV>&nbsp;</DIV>
<DIV>When we have confirmed that this works together with modified</DIV>
<DIV>LinCAN driver I have started to implement model corresponding</DIV>
<DIV>to real PCI CAN card. I have selected Kvaser card because</DIV>
<DIV>we pose more of these at university/so I can check real contents</DIV=
>
<DIV>of other configuration/support spaces/BARs on real device.</DIV>
<DIV>The advantage of that selection is that driver for this card</DIV>
<DIV>is included in mainline Linux in CAN/SocketCAN subsystem.</DIV>
<DIV>This board can have up to four SJA1000 chips in one of its BARs,</DIV=
>
<DIV>The board routes interrupts through bride interrupt control/masking</=
DIV>
<DIV>and configuration, which has to be emulated as well.</DIV>
<DIV>It even maps chips into I/O space instead of MMIO.</DIV>
<DIV>&nbsp;</DIV>
<DIV>I think that for drivers writers or even can infrastructure</DIV>
<DIV>developers (userspace and higher level tools) it is advantage to have=
</DIV>
<DIV>simple solution with corresponding driver in a guest kernel=20
(something</DIV>
<DIV>like virtio). On the other hand, concrete real hardware driver</DIV>
<DIV>testing requires exact hardware complexity emulation and allows</DIV>
<DIV>to use unmodified OS and available drivers.</DIV>
<DIV>&nbsp;</DIV>
<DIV>But if you think, that this artificial simple card design is not</DIV=
>
<DIV>good idea for QEMU, then it can be discarded and only Kvaser</DIV>
<DIV>(when it works now) included.</DIV>
<DIV>&nbsp;</DIV>
<DIV>The decisions for further development</DIV>
<DIV>&nbsp;</DIV>
<DIV>Should be minimal working solution included in the QEMU</DIV>
<DIV>mainline in short term?</DIV>
<DIV>(months .. or rather wait for agreement on final</DIV>
<DIV>infrastructure, may be years because of our other load</DIV>
<DIV>and complexity of full model task)</DIV>
<DIV>&nbsp;</DIV>
<DIV>Is preferred approach to open CAN QEMU fork on GitHub?</DIV>
<DIV>Etc...</DIV>
<DIV>&nbsp;</DIV>
<DIV>I consider as a good result, that my actual attempt and QEMU offered<=
/DIV>
<DIV>infrastructure allows to to provide minimal testable solution with</D=
IV>
<DIV>no QEMU modifications (except Makefiles). So I hope that is is</DIV>
<DIV>reasonable start and our effort would be of some use for others.</DIV=
>
<DIV>&nbsp;</DIV>
<DIV>Best wishes,</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;=20
Pavel</DIV>
<DIV>&nbsp;</DIV>
<DIV>PS: I am not sure if I will be online till Monday</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;</DIV></DIV></BODY></HTML>

------=_001_NextPart101010047614_=------


--===============2954341533641585148==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
rtems-devel mailing list
rtems-devel-WKV1R6NGPIzYtjvyW6yDsg@public.gmane.org
http://www.rtems.org/mailman/listinfo/rtems-devel

--===============2954341533641585148==--
