From: "Yang, Wenyou" <Wenyou.Yang@Microchip.com>
Subject: Re: AW: [PATCH v4 7/7] can: m_can: Enable TX FIFO Handling for M_CAN
 IP version >= v3.1.x
Date: Tue, 18 Apr 2017 14:17:42 +0800
Message-ID: <ade4d7b4-a440-98ce-3c66-684136cffde7@Microchip.com>
References: <20170408121015.11428-1-mario.huettel@gmx.net>
 <20170408121015.11428-7-mario.huettel@gmx.net>
 <1f88411b-aa58-4e17-02cb-43fc0ffb953c@Microchip.com>
 <a3e6f8f0-8356-4e34-d26c-1cf243caffa0@hartkopp.net>
 <dce17476-21cb-2be8-202f-2662c75d1f3b@free-electrons.com>
 <c04fdd22a8364cc5a6d22f0b957d0fa8@SI-MBX1034.de.bosch.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
        boundary="------------3716B36BD1187A4523B3CDE2"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:49132 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752480AbdDRGRs (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 18 Apr 2017 02:17:48 -0400
In-Reply-To: <c04fdd22a8364cc5a6d22f0b957d0fa8@SI-MBX1034.de.bosch.com>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Huettel Mario (AE/PJ-SCI1)" <Mario.Huettel@de.bosch.com>, Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

--------------3716B36BD1187A4523B3CDE2
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit

Hi Mario,

The device tree patch is attached.

Here is the configure and log.

---8<----

# ip link set can0 type can bitrate 125000 dbitrate 4000000 fd on 
fd-non-iso on
# ip link set can1 type can bitrate 125000 dbitrate 4000000 fd on 
fd-non-iso on
# ip link set can0 up
# ip link set can1 up
# ip -details link show can0
2: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 72 qdisc pfifo_fast state UNKNOWN 
mode DEFAULT group default qlen 10
     link/can  promiscuity 0
     can <FD,FD-NON-ISO> state ERROR-ACTIVE (berr-counter tx 0 rx 0) 
restart-ms 0
           bitrate 125000 sample-point 0.875
           tq 50 prop-seg 69 phase-seg1 70 phase-seg2 20 sjw 1
           m_can: tseg1 2..256 tseg2 1..128 sjw 1..128 brp 1..512 brp-inc 1
           dbitrate 4000000 dsample-point 0.700
           dtq 25 dprop-seg 3 dphase-seg1 3 dphase-seg2 3 dsjw 1
           m_can: dtseg1 1..32 dtseg2 1..16 dsjw 1..16 dbrp 1..32 dbrp-inc 1
           clock 40000000
# ip -details link show can1
3: can1: <NOARP,UP,LOWER_UP,ECHO> mtu 72 qdisc pfifo_fast state UNKNOWN 
mode DEFAULT group default qlen 10
     link/can  promiscuity 0
     can <FD,FD-NON-ISO> state ERROR-ACTIVE (berr-counter tx 0 rx 0) 
restart-ms 0
           bitrate 125000 sample-point 0.875
           tq 50 prop-seg 69 phase-seg1 70 phase-seg2 20 sjw 1
           m_can: tseg1 2..256 tseg2 1..128 sjw 1..128 brp 1..512 brp-inc 1
           dbitrate 4000000 dsample-point 0.700
           dtq 25 dprop-seg 3 dphase-seg1 3 dphase-seg2 3 dsjw 1
           m_can: dtseg1 1..32 dtseg2 1..16 dsjw 1..16 dbrp 1..32 dbrp-inc 1
           clock 40000000
# candump can1 &
#  cansend can0 5A1##111.22.33.44.55.66.77.88.99.aa.bb.cc
   can1  5A1  [12]  11 22 33 44 55 66 77 88 99 AA BB CC
#  cansend can0 5A1##111.22.33.44.55.66.77.88.99.aa.bb.cc
#

--->8----

Hope it is helpful for you.

Any question, please don't hesitate to come back.


Best Regards,

Wenyou Yang


On 2017/4/18 14:04, Huettel Mario (AE/PJ-SCI1) wrote:
> Hi Quentin, hi Wenyou,
>
> Today I've received another email that the driver is not working with the
> M_CAN in Atmel's SAMA5D2.
>
> Can you send me the device tree you're using and post the dmesg output
> of the m_can driver?
>
> There might be a clue why it isn't working.
> The fact that it is working one time and then stops working looks like some problem
> In the TX FIFO to me. Can you please check with some third device/oscilloscope,
> if the controller is sending data. I want to know ehre the problem lies. If it's in the TX or
> RX path.
>
> As for now I can only throw some ideas into the round:
> * What are the PCLK and CCLK values? CCLK >= PCLK?
> * TX FIFO configured to one element and something happens in that case.
> * No TX Event FIFO element configured. The driver also doesn't work in this case.
>
>
> Quentin wrote:
>> Hi Oliver,
>>
>> On 13/04/2017 08:30, Oliver Hartkopp wrote:
>>> Hi Wenyou,
>>>
>>> as Quentin had no problems in his setup:
>>>
>> Actually just retested by doing the same as Wenyou on my SAMA5D2
>> Xplained and I can attest I'm having the same behavior as Wenyou.
>>
>> Best regards,
>> Quentin
>
> ��칻�&�~�&���+-��ݶ��w��˛���m�b��\jx����ܨ}���Ơz�&j:+v�������zZ+��+zf���h���~����i���z��w���?����&�)ߢf


--------------3716B36BD1187A4523B3CDE2
Content-Type: text/plain; charset="UTF-8";
	name="0001-ARM-dts-at91-sama5d2-add-m_can-nodes.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="0001-ARM-dts-at91-sama5d2-add-m_can-nodes.patch"

RnJvbSA5MzBmNTYwYzllNTNkODdjN2M1YTAwNzQ5ODEyMGQxYjFlZmM3ZjBhIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBXZW55b3UgWWFuZyA8d2VueW91LnlhbmdAYXRtZWwu
Y29tPgpEYXRlOiBUdWUsIDEwIE5vdiAyMDE1IDE0OjQ5OjA0ICswODAwClN1YmplY3Q6IFtQ
QVRDSCAxLzJdIEFSTTogZHRzOiBhdDkxOiBzYW1hNWQyOiBhZGQgbV9jYW4gbm9kZXMKCkFk
ZCBub2RlcyB0byBzdXBwb3J0IHRoZSBDb250cm9sbGVyIEFyZWEgTmV0d29yayhNX0NBTikg
b24gU0FNQTVEMi4KCkFzIHNhaWQgaW4gU0FNQTVEMiBkYXRhc2hlZXQsIHRoZSBDQU4gY2xv
Y2sgaXMgcmVjb21tZW5kZWQgdG8gdXNlCmZyZXF1ZW5jaWVzIG9mIDIwLCA0MCBvciA4MCBN
SHouIFRvIGFjaGlldmUgdGhlc2UgZnJlcXVlbmNpZXMsClBNQyBHQ0xLMyBtdXN0IHNlbGVj
dCB0aGUgVVBMTENLKDQ4MCBNSHopIGFzIHNvdXJjZSBjbG9jayBhbmQKZGl2aWRlIGJ5IDI0
LCAxMiwgb3IgNi4gU28sIHRoZSAiYXNzaWduZWQtY2xvY2stcmF0ZXMiIHByb3BlcnR5Cmhh
cyB0aHJlZSBvcHRpb25zOiAyMDAwMDAwMCwgNDAwMDAwMDAsIGFuZCA4MDAwMDAwMC4KVGhl
ICJhc3NpZ25lZC1jbG9jay1wYXJlbnRzIiBwcm9wZXJ0eSBzaG91bGQgYmUgcmVmZXJyZWQg
dG8gdXRtaQpmaXhlZGx5LgoKVGhlIE1TQnMgW2JpdHMgMzE6MTZdIG9mIHRoZSBDQU4gTWVz
c2FnZSBSQU0gZm9yIENBTjAgYW5kIENBTjEgYXJlCmRlZmF1bHQgY29uZmlndXJlZCBpbiAw
eDAwMjAwMDAwLiBUbyBhdm9pZCBjb25mbGljdCB3aXRoIFNSQU0gbWFwCmZvciBwbSwgY2hh
bmdlIHRoZW0gdG8gMHgwMDIxMDAwMCBpbiB0aGUgQVQ5MUJvb3RzdHJhcCB2aWEgc2V0dGlu
Zwp0aGUgQ0FOIE1lbW9yaWVzIEFkZHJlc3MtYmFzZWQgUmVnaXN0ZXIoU0ZSX0NBTikgb2Yg
U0ZSLgoKU2lnbmVkLW9mZi1ieTogV2VueW91IFlhbmcgPHdlbnlvdS55YW5nQGF0bWVsLmNv
bT4KU2VyaWVzLXRvOiBuaWNvbGFzLCBhbGV4LCBkdC1ndXlzLCBraW5nClNlcmllcy1jYzog
ZHQtbGlzdCwgYXJtLWxpc3QsIGxpbnV4LWtlcm5lbCwgd3lhbmcKLS0tCiBhcmNoL2FybS9i
b290L2R0cy9hdDkxLXNhbWE1ZDJfeHBsYWluZWQuZHRzIHwgMjQgKysrKysrKysrKysrKwog
YXJjaC9hcm0vYm9vdC9kdHMvc2FtYTVkMi5kdHNpICAgICAgICAgICAgICB8IDU2ICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrCiAyIGZpbGVzIGNoYW5nZWQsIDgwIGluc2VydGlv
bnMoKykKCmRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9hdDkxLXNhbWE1ZDJfeHBs
YWluZWQuZHRzIGIvYXJjaC9hcm0vYm9vdC9kdHMvYXQ5MS1zYW1hNWQyX3hwbGFpbmVkLmR0
cwppbmRleCA5ZjdmOGE3ZDhmZjkuLjJmMTliMDhkYzIyNiAxMDA2NDQKLS0tIGEvYXJjaC9h
cm0vYm9vdC9kdHMvYXQ5MS1zYW1hNWQyX3hwbGFpbmVkLmR0cworKysgYi9hcmNoL2FybS9i
b290L2R0cy9hdDkxLXNhbWE1ZDJfeHBsYWluZWQuZHRzCkBAIC0yNTcsNiArMjU3LDEyIEBA
CiAJCQkJc3RhdHVzID0gIm9rYXkiOwogCQkJfTsKIAorCQkJY2FuMDogY2FuQGY4MDU0MDAw
IHsKKwkJCQlwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOworCQkJCXBpbmN0cmwtMCA9IDwm
cGluY3RybF9jYW4wX2RlZmF1bHQ+OworCQkJCXN0YXR1cyA9ICJva2F5IjsKKwkJCX07CisK
IAkJCXVhcnQzOiBzZXJpYWxAZmMwMDgwMDAgewogCQkJCWF0bWVsLHVzZS1kbWEtcng7CiAJ
CQkJYXRtZWwsdXNlLWRtYS10eDsKQEAgLTMyMSw2ICszMjcsMTggQEAKIAkJCQkJYmlhcy1k
aXNhYmxlOwogCQkJCX07CiAKKwkJCQlwaW5jdHJsX2NhbjBfZGVmYXVsdDogY2FuMF9kZWZh
dWx0IHsKKwkJCQkJcGlubXV4ID0gPFBJTl9QQzEwX19DQU5UWDA+LAorCQkJCQkJIDxQSU5f
UEMxMV9fQ0FOUlgwPjsKKwkJCQkJYmlhcy1kaXNhYmxlOworCQkJCX07CisKKwkJCQlwaW5j
dHJsX2NhbjFfZGVmYXVsdDogY2FuMV9kZWZhdWx0IHsKKwkJCQkJcGlubXV4ID0gPFBJTl9Q
QzI2X19DQU5UWDE+LAorCQkJCQkJIDxQSU5fUEMyN19fQ0FOUlgxPjsKKwkJCQkJYmlhcy1k
aXNhYmxlOworCQkJCX07CisKIAkJCQlwaW5jdHJsX2NoYXJnZXJfY2hnbGV2OiBjaGFyZ2Vy
X2NoZ2xldiB7CiAJCQkJCXBpbm11eCA9IDxQSU5fUEExMl9fR1BJTz47CiAJCQkJCWJpYXMt
ZGlzYWJsZTsKQEAgLTQ2OCw2ICs0ODYsMTIgQEAKIAkJCQl9OwogCiAJCQl9OworCisJCQlj
YW4xOiBjYW5AZmMwNTAwMDAgeworCQkJCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7CisJ
CQkJcGluY3RybC0wID0gPCZwaW5jdHJsX2NhbjFfZGVmYXVsdD47CisJCQkJc3RhdHVzID0g
Im9rYXkiOworCQkJfTsKIAkJfTsKIAl9OwogCmRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290
L2R0cy9zYW1hNWQyLmR0c2kgYi9hcmNoL2FybS9ib290L2R0cy9zYW1hNWQyLmR0c2kKaW5k
ZXggNTI4YjRlOWM2ZDNkLi4xMjAwZDUyZmYwYTUgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL2Jv
b3QvZHRzL3NhbWE1ZDIuZHRzaQorKysgYi9hcmNoL2FybS9ib290L2R0cy9zYW1hNWQyLmR0
c2kKQEAgLTc2Miw2ICs3NjIsMTggQEAKIAkJCQkJCWF0bWVsLGNsay1vdXRwdXQtcmFuZ2Ug
PSA8MCA4MzAwMDAwMD47CiAJCQkJCX07CiAKKwkJCQkJY2FuMF9jbGs6IGNhbjBfY2xrIHsK
KwkJCQkJCSNjbG9jay1jZWxscyA9IDwwPjsKKwkJCQkJCXJlZyA9IDw1Nj47CisJCQkJCQlh
dG1lbCxjbGstb3V0cHV0LXJhbmdlID0gPDAgODMwMDAwMDA+OworCQkJCQl9OworCisJCQkJ
CWNhbjFfY2xrOiBjYW4xX2NsayB7CisJCQkJCQkjY2xvY2stY2VsbHMgPSA8MD47CisJCQkJ
CQlyZWcgPSA8NTc+OworCQkJCQkJYXRtZWwsY2xrLW91dHB1dC1yYW5nZSA9IDwwIDgzMDAw
MDAwPjsKKwkJCQkJfTsKKwogCQkJCQljbGFzc2RfY2xrOiBjbGFzc2RfY2xrIHsKIAkJCQkJ
CSNjbG9jay1jZWxscyA9IDwwPjsKIAkJCQkJCXJlZyA9IDw1OT47CkBAIC04OTAsNiArOTAy
LDE4IEBACiAJCQkJCQkjY2xvY2stY2VsbHMgPSA8MD47CiAJCQkJCQlyZWcgPSA8NTU+Owog
CQkJCQl9OworCisJCQkJCWNhbjBfZ2NsazogY2FuMF9nY2xrIHsKKwkJCQkJCSNjbG9jay1j
ZWxscyA9IDwwPjsKKwkJCQkJCXJlZyA9IDw1Nj47CisJCQkJCQlhdG1lbCxjbGstb3V0cHV0
LXJhbmdlID0gPDAgODAwMDAwMDA+OworCQkJCQl9OworCisJCQkJCWNhbjFfZ2NsazogY2Fu
MV9nY2xrIHsKKwkJCQkJCSNjbG9jay1jZWxscyA9IDwwPjsKKwkJCQkJCXJlZyA9IDw1Nz47
CisJCQkJCQlhdG1lbCxjbGstb3V0cHV0LXJhbmdlID0gPDAgODAwMDAwMDA+OworCQkJCQl9
OwogCQkJCX07CiAJCQl9OwogCkBAIC0xMTQ0LDYgKzExNjgsMjIgQEAKIAkJCQljbG9ja3Mg
PSA8JmNsazMyaz47CiAJCQl9OwogCisJCQljYW4wOiBjYW5AZjgwNTQwMDAgeworCQkJCWNv
bXBhdGlibGUgPSAiYm9zY2gsbV9jYW4iOworCQkJCXJlZyA9IDwweGY4MDU0MDAwIDB4NDAw
MD4sIDwweDIxMDAwMCAweDQwMDA+OworCQkJCXJlZy1uYW1lcyA9ICJtX2NhbiIsICJtZXNz
YWdlX3JhbSI7CisJCQkJaW50ZXJydXB0cyA9IDw1NiBJUlFfVFlQRV9MRVZFTF9ISUdIIDc+
LAorCQkJCQkgICAgIDw2NCBJUlFfVFlQRV9MRVZFTF9ISUdIIDc+OworCQkJCWludGVycnVw
dC1uYW1lcyA9ICJpbnQwIiwgImludDEiOworCQkJCWNsb2NrcyA9IDwmY2FuMF9jbGs+LCA8
JmNhbjBfZ2Nsaz47CisJCQkJY2xvY2stbmFtZXMgPSAiaGNsayIsICJjY2xrIjsKKwkJCQlh
c3NpZ25lZC1jbG9ja3MgPSA8JmNhbjBfZ2Nsaz47CisJCQkJYXNzaWduZWQtY2xvY2stcGFy
ZW50cyA9IDwmdXRtaT47CisJCQkJYXNzaWduZWQtY2xvY2stcmF0ZXMgPSA8NDAwMDAwMDA+
OworCQkJCWJvc2NoLG1yYW0tY2ZnID0gPDB4MCAwIDAgMzIgMCAwIDAgMT47CisJCQkJc3Rh
dHVzID0gImRpc2FibGVkIjsKKwkJCX07CisKIAkJCXNwaTE6IHNwaUBmYzAwMDAwMCB7CiAJ
CQkJY29tcGF0aWJsZSA9ICJhdG1lbCxhdDkxcm05MjAwLXNwaSI7CiAJCQkJcmVnID0gPDB4
ZmMwMDAwMDAgMHgxMDA+OwpAQCAtMTMwNSw2ICsxMzQ1LDIyIEBACiAJCQkJc3RhdHVzID0g
Im9rYXkiOwogCQkJfTsKIAorCQkJY2FuMTogY2FuQGZjMDUwMDAwIHsKKwkJCQljb21wYXRp
YmxlID0gImJvc2NoLG1fY2FuIjsKKwkJCQlyZWcgPSA8MHhmYzA1MDAwMCAweDQwMDA+LCA8
MHgyMTAwMDAgMHg0MDAwPjsKKwkJCQlyZWctbmFtZXMgPSAibV9jYW4iLCAibWVzc2FnZV9y
YW0iOworCQkJCWludGVycnVwdHMgPSA8NTcgSVJRX1RZUEVfTEVWRUxfSElHSCA3PiwKKwkJ
CQkJICAgICA8NjUgSVJRX1RZUEVfTEVWRUxfSElHSCA3PjsKKwkJCQlpbnRlcnJ1cHQtbmFt
ZXMgPSAiaW50MCIsICJpbnQxIjsKKwkJCQljbG9ja3MgPSA8JmNhbjFfY2xrPiwgPCZjYW4x
X2djbGs+OworCQkJCWNsb2NrLW5hbWVzID0gImhjbGsiLCAiY2NsayI7CisJCQkJYXNzaWdu
ZWQtY2xvY2tzID0gPCZjYW4xX2djbGs+OworCQkJCWFzc2lnbmVkLWNsb2NrLXBhcmVudHMg
PSA8JnV0bWk+OworCQkJCWFzc2lnbmVkLWNsb2NrLXJhdGVzID0gPDQwMDAwMDAwPjsKKwkJ
CQlib3NjaCxtcmFtLWNmZyA9IDwweDAgMCAwIDMyIDAgMCAwIDE+OworCQkJCXN0YXR1cyA9
ICJkaXNhYmxlZCI7CisJCQl9OworCiAJCQljaGlwaWRAZmMwNjkwMDAgewogCQkJCWNvbXBh
dGlibGUgPSAiYXRtZWwsc2FtYTVkMi1jaGlwaWQiOwogCQkJCXJlZyA9IDwweGZjMDY5MDAw
IDB4OD47Ci0tIAoyLjExLjAKCg==
--------------3716B36BD1187A4523B3CDE2
Content-Type: text/plain; charset="UTF-8";
	name="0002-ARM-at91-defconfig-add-MCAN-driver-to-sama5_defconfi.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename*0="0002-ARM-at91-defconfig-add-MCAN-driver-to-sama5_defconfi.pa";
	filename*1="tch"

RnJvbSBlNmIxODllNjE4ZmM5MGEyM2U3ZjEzYjJkYWYzOTNjYTk3YWM3ODY1IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBXZW55b3UgWWFuZyA8d2VueW91LnlhbmdAYXRtZWwu
Y29tPgpEYXRlOiBGcmksIDE3IEZlYiAyMDE3IDE2OjM2OjU3ICswODAwClN1YmplY3Q6IFtQ
QVRDSCAyLzJdIEFSTTogYXQ5MS9kZWZjb25maWc6IGFkZCBNQ0FOIGRyaXZlciB0byBzYW1h
NV9kZWZjb25maWcKCkFkZCB0aGUgQ29udHJvbGxlciBBcmVhIE5ldHdvcmsgKE1DQU4pIGRy
aXZlciBjb21waWxhdGlvbgpmb3Igc2FtYTUgZGVmYXVsdCBjb25maWd1cmF0aW9uLiBJcyB1
c2VkIGJ5IHNhbWE1ZDIgU29DIGZvciBpbnN0YW5jZS4KClNpZ25lZC1vZmYtYnk6IFdlbnlv
dSBZYW5nIDx3ZW55b3UueWFuZ0BhdG1lbC5jb20+ClNlcmllcy10bzogYWxleCwgbmljb2xh
cywga2luZywgbWFyZWsKU2VyaWVzLWNjOiBhcm0tbGlzdCwgbGludXgta2VybmVsCi0tLQog
YXJjaC9hcm0vY29uZmlncy9zYW1hNV9kZWZjb25maWcgfCAxICsKIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2NvbmZpZ3Mvc2FtYTVf
ZGVmY29uZmlnIGIvYXJjaC9hcm0vY29uZmlncy9zYW1hNV9kZWZjb25maWcKaW5kZXggNzc3
YzllOTg2NDI1Li4wMWY3ZGVkZDU3MGQgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL2NvbmZpZ3Mv
c2FtYTVfZGVmY29uZmlnCisrKyBiL2FyY2gvYXJtL2NvbmZpZ3Mvc2FtYTVfZGVmY29uZmln
CkBAIC01Miw2ICs1Miw3IEBAIENPTkZJR19JUF9QTlBfUkFSUD15CiBDT05GSUdfSVBWNl9T
SVRfNlJEPXkKIENPTkZJR19DQU49eQogQ09ORklHX0NBTl9BVDkxPXkKK0NPTkZJR19DQU5f
TV9DQU49eQogQ09ORklHX0NGRzgwMjExPXkKIENPTkZJR19NQUM4MDIxMT15CiBDT05GSUdf
TUFDODAyMTFfTEVEUz15Ci0tIAoyLjExLjAKCg==
--------------3716B36BD1187A4523B3CDE2--
