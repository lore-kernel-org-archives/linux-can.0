From: Stanislau Arkhipenka <dise.logo@mail.ru>
Subject: Connecting mcp2515 to Linux
Date: Fri, 18 Dec 2015 17:23:23 +0300
Message-ID: <1450448603.2873.20.camel@mail.ru>
Reply-To: dise.logo@mail.ru
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-vvhXDafjrjjenvG/nVp2"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from fallback7.mail.ru ([94.100.181.128]:47378 "EHLO
	fallback7.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932640AbbLROnm (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 18 Dec 2015 09:43:42 -0500
Received: from smtp53.i.mail.ru (smtp53.i.mail.ru [94.100.177.113])
	by fallback7.mail.ru (mPOP.Fallback_MX) with ESMTP id 8EBE314ED2376
	for <linux-can@vger.kernel.org>; Fri, 18 Dec 2015 17:23:24 +0300 (MSK)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org


--=-vvhXDafjrjjenvG/nVp2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Dear Colleagues, Hello.
Currently I'm working on building fully functional real size humanoid
robot.
One of major points of my work is connecting peripheral devices through
CAN bus to Cubieboard.
During this activities i have read tonnes of manuals, related to Device
Tree Source, but still have a lot of problems with connecting mcp2515 to
Cubieboard (v1).
Would You be so kind to help my in this field? I'm trying to configure
it more that month and have no success. I don't know where else i can
ask for help, so could You, please, spend 5 minutes to assist me?

My changes in DTS file sun4i-a10-cubieboard.dts represented in following
diff:

54a55,59
>       can0_oscillator =   <&can0_osc>,"oscillator-frequency";
>       can0_speed =      <&can0>,"spi-max-frequency:0";
>       can0_interrupt =
<&can0_pins>,"allwinner,pins:PB11",<&can0>,"interrupts:0";
> 
> 
77a83,90
> 
> /* ************************************************** */
>       clocks {
>               can0_osc: can0_osc {
>                       compatible = "fixed-clock";
>                       #clock-cells = <0>;
>                       clock-frequency  = <16000000>;
>                       };
78a92
> /* ************************************************* */
179a194,199
> /* ****************************************************** */ 
>       can0_pins: can0_pins {
>               allwinner,pins = "PI10", "PI11", "PI12", "PI13"; /* SPI0
*/
>               allwinner,function = "spi0"; /* input */
>       };
> /* ****************************************************** */
220a241
> /* ***************************************** */
226c247,258
< };
---
>       can0: mcp2515@0 {
>               reg= <0>;
>               compatible = "microchip,mcp2515";
>               pinctrl-names = "default";
>               pinctrl-0 = <&can0_pins>;
>               spi-max-frequency = <10000000>;
>               interrupt-parent = <&pio>;
>               interrupts = <25 0x2>;
>               clocks = <&can0_osc>;
>               };
>       };
> /* **************************************** */

Original file can be found here
https://github.com/torvalds/linux/blob/master/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
(also original and modified files are attached to this email)


my CAN controller
http://www.amazon.com/gp/product/B0152VCIA6?psc=1&redirect=true&ref_=ox_sc_act_title_1&smid=A1792RTTLO6S27


During compile i've used following settings:
Linux Kernel Configuration
      Device Drivers
         SPI support
            Utilites for Bitbanging SPI masters
            GPIO-based bitbanging SPI Master
            Allwinner A10
            Allwinner A31
      Networking support
         CAN bus subsystem support
            CAN device drivers
                Virtual Local CAN Interface (vcan)
                Platform CAN drivers with Netlink support
                  CAN bit-timing calculation
                  #?? Enable LED triggers for Netlink based drivers
                  TI High End CAN controller (HECC)
                  Allwinner A10 CAN controller
                  CAN SPI Interface
                     Microchip MCP251x SPI CAN controller


During startup dmesg shows following:

[    5.178360] CAN device driver interface
[    5.201827] pinconfig core: failed to register map default (1): no
configs given
[    5.364882] mcp251x spi32766.0: CANCTRL 0x87
[    5.365508] mcp251x spi32766.0 can0: set_features() failed (-1);
wanted 0x0000000000004008, left 0x0000000000004808
[    7.047499] mcp251x spi32766.0: failed to acquire irq 0

#  ip -s -d link show can0
3: can0: <NOARP,ECHO> mtu 16 qdisc noop state DOWN mode DEFAULT group
default qlen 10
     link/can  promiscuity 0
     can <TRIPLE-SAMPLING> state STOPPED restart-ms 0
       bitrate 125000 sample-point 0.875
       tq 500 prop-seg 6 phase-seg1 7 phase-seg2 2 sjw 1
       mcp251x: tseg1 3..16 tseg2 2..8 sjw 1..4 brp 1..64 brp-inc 1
       clock 8000000
       re-started bus-errors arbit-lost error-warn error-pass bus-off
       0          0          0          0          0          0
     RX: bytes  packets  errors  dropped overrun mcast
     0          0        0       0       0       0
     TX: bytes  packets  errors  dropped carrier collsns
     0          0        0       0       0       0

Your help is REALLY important for me!
Thank you in advance, SA.

--=-vvhXDafjrjjenvG/nVp2
Content-Type: audio/vnd.dts; name="sun4i-a10-cubieboard.dts"
Content-Disposition: attachment; filename="sun4i-a10-cubieboard.dts"
Content-Transfer-Encoding: base64

LyoKICogQ29weXJpZ2h0IDIwMTIgU3RlZmFuIFJvZXNlCiAqIFN0ZWZhbiBSb2VzZSA8c3JAZGVu
eC5kZT4KICoKICogVGhpcyBmaWxlIGlzIGR1YWwtbGljZW5zZWQ6IHlvdSBjYW4gdXNlIGl0IGVp
dGhlciB1bmRlciB0aGUgdGVybXMKICogb2YgdGhlIEdQTCBvciB0aGUgWDExIGxpY2Vuc2UsIGF0
IHlvdXIgb3B0aW9uLiBOb3RlIHRoYXQgdGhpcyBkdWFsCiAqIGxpY2Vuc2luZyBvbmx5IGFwcGxp
ZXMgdG8gdGhpcyBmaWxlLCBhbmQgbm90IHRoaXMgcHJvamVjdCBhcyBhCiAqIHdob2xlLgogKgog
KiAgYSkgVGhpcyBmaWxlIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0
IGFuZC9vcgogKiAgICAgbW9kaWZ5IGl0IHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVy
YWwgUHVibGljIExpY2Vuc2UgYXMKICogICAgIHB1Ymxpc2hlZCBieSB0aGUgRnJlZSBTb2Z0d2Fy
ZSBGb3VuZGF0aW9uOyBlaXRoZXIgdmVyc2lvbiAyIG9mIHRoZQogKiAgICAgTGljZW5zZSwgb3Ig
KGF0IHlvdXIgb3B0aW9uKSBhbnkgbGF0ZXIgdmVyc2lvbi4KICoKICogICAgIFRoaXMgZmlsZSBp
cyBkaXN0cmlidXRlZCBpbiB0aGUgaG9wZSB0aGF0IGl0IHdpbGwgYmUgdXNlZnVsLAogKiAgICAg
YnV0IFdJVEhPVVQgQU5ZIFdBUlJBTlRZOyB3aXRob3V0IGV2ZW4gdGhlIGltcGxpZWQgd2FycmFu
dHkgb2YKICogICAgIE1FUkNIQU5UQUJJTElUWSBvciBGSVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIg
UFVSUE9TRS4gIFNlZSB0aGUKICogICAgIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGZvciBt
b3JlIGRldGFpbHMuCiAqCiAqIE9yLCBhbHRlcm5hdGl2ZWx5LAogKgogKiAgYikgUGVybWlzc2lv
biBpcyBoZXJlYnkgZ3JhbnRlZCwgZnJlZSBvZiBjaGFyZ2UsIHRvIGFueSBwZXJzb24KICogICAg
IG9idGFpbmluZyBhIGNvcHkgb2YgdGhpcyBzb2Z0d2FyZSBhbmQgYXNzb2NpYXRlZCBkb2N1bWVu
dGF0aW9uCiAqICAgICBmaWxlcyAodGhlICJTb2Z0d2FyZSIpLCB0byBkZWFsIGluIHRoZSBTb2Z0
d2FyZSB3aXRob3V0CiAqICAgICByZXN0cmljdGlvbiwgaW5jbHVkaW5nIHdpdGhvdXQgbGltaXRh
dGlvbiB0aGUgcmlnaHRzIHRvIHVzZSwKICogICAgIGNvcHksIG1vZGlmeSwgbWVyZ2UsIHB1Ymxp
c2gsIGRpc3RyaWJ1dGUsIHN1YmxpY2Vuc2UsIGFuZC9vcgogKiAgICAgc2VsbCBjb3BpZXMgb2Yg
dGhlIFNvZnR3YXJlLCBhbmQgdG8gcGVybWl0IHBlcnNvbnMgdG8gd2hvbSB0aGUKICogICAgIFNv
ZnR3YXJlIGlzIGZ1cm5pc2hlZCB0byBkbyBzbywgc3ViamVjdCB0byB0aGUgZm9sbG93aW5nCiAq
ICAgICBjb25kaXRpb25zOgogKgogKiAgICAgVGhlIGFib3ZlIGNvcHlyaWdodCBub3RpY2UgYW5k
IHRoaXMgcGVybWlzc2lvbiBub3RpY2Ugc2hhbGwgYmUKICogICAgIGluY2x1ZGVkIGluIGFsbCBj
b3BpZXMgb3Igc3Vic3RhbnRpYWwgcG9ydGlvbnMgb2YgdGhlIFNvZnR3YXJlLgogKgogKiAgICAg
VEhFIFNPRlRXQVJFIElTIFBST1ZJREVEICJBUyBJUyIsIFdJVEhPVVQgV0FSUkFOVFkgT0YgQU5Z
IEtJTkQsCiAqICAgICBFWFBSRVNTIE9SIElNUExJRUQsIElOQ0xVRElORyBCVVQgTk9UIExJTUlU
RUQgVE8gVEhFIFdBUlJBTlRJRVMKICogICAgIE9GIE1FUkNIQU5UQUJJTElUWSwgRklUTkVTUyBG
T1IgQSBQQVJUSUNVTEFSIFBVUlBPU0UgQU5ECiAqICAgICBOT05JTkZSSU5HRU1FTlQuIElOIE5P
IEVWRU5UIFNIQUxMIFRIRSBBVVRIT1JTIE9SIENPUFlSSUdIVAogKiAgICAgSE9MREVSUyBCRSBM
SUFCTEUgRk9SIEFOWSBDTEFJTSwgREFNQUdFUyBPUiBPVEhFUiBMSUFCSUxJVFksCiAqICAgICBX
SEVUSEVSIElOIEFOIEFDVElPTiBPRiBDT05UUkFDVCwgVE9SVCBPUiBPVEhFUldJU0UsIEFSSVNJ
TkcKICogICAgIEZST00sIE9VVCBPRiBPUiBJTiBDT05ORUNUSU9OIFdJVEggVEhFIFNPRlRXQVJF
IE9SIFRIRSBVU0UgT1IKICogICAgIE9USEVSIERFQUxJTkdTIElOIFRIRSBTT0ZUV0FSRS4KICov
CgovZHRzLXYxLzsKI2luY2x1ZGUgInN1bjRpLWExMC5kdHNpIgojaW5jbHVkZSAic3VueGktY29t
bW9uLXJlZ3VsYXRvcnMuZHRzaSIKCiNpbmNsdWRlIDxkdC1iaW5kaW5ncy9ncGlvL2dwaW8uaD4K
I2luY2x1ZGUgPGR0LWJpbmRpbmdzL3BpbmN0cmwvc3VuNGktYTEwLmg+CgovIHsKCW1vZGVsID0g
IkN1YmlldGVjaCBDdWJpZWJvYXJkIjsKCWNvbXBhdGlibGUgPSAiY3ViaWV0ZWNoLGExMC1jdWJp
ZWJvYXJkIiwgImFsbHdpbm5lcixzdW40aS1hMTAiOwoKCWFsaWFzZXMgewoJCXNlcmlhbDAgPSAm
dWFydDA7Cgl9OwoKCWNob3NlbiB7CgkJc3Rkb3V0LXBhdGggPSAic2VyaWFsMDoxMTUyMDBuOCI7
Cgl9OwoKCWxlZHMgewoJCWNvbXBhdGlibGUgPSAiZ3Bpby1sZWRzIjsKCQlwaW5jdHJsLW5hbWVz
ID0gImRlZmF1bHQiOwoJCXBpbmN0cmwtMCA9IDwmbGVkX3BpbnNfY3ViaWVib2FyZD47CgoJCWJs
dWUgewoJCQlsYWJlbCA9ICJjdWJpZWJvYXJkOmJsdWU6dXNyIjsKCQkJZ3Bpb3MgPSA8JnBpbyA3
IDIxIEdQSU9fQUNUSVZFX0hJR0g+OyAvKiBMRUQxICovCgkJfTsKCgkJZ3JlZW4gewoJCQlsYWJl
bCA9ICJjdWJpZWJvYXJkOmdyZWVuOnVzciI7CgkJCWdwaW9zID0gPCZwaW8gNyAyMCBHUElPX0FD
VElWRV9ISUdIPjsgLyogTEVEMiAqLwoJCQlsaW51eCxkZWZhdWx0LXRyaWdnZXIgPSAiaGVhcnRi
ZWF0IjsKCQl9OwoJfTsKfTsKCiZhaGNpIHsKCXRhcmdldC1zdXBwbHkgPSA8JnJlZ19haGNpXzV2
PjsKCXN0YXR1cyA9ICJva2F5IjsKfTsKCiZjb2RlYyB7CglzdGF0dXMgPSAib2theSI7Cn07Cgom
Y3B1MCB7CgljcHUtc3VwcGx5ID0gPCZyZWdfZGNkYzI+Owp9OwoKJmVoY2kwIHsKCXN0YXR1cyA9
ICJva2F5IjsKfTsKCiZlaGNpMSB7CglzdGF0dXMgPSAib2theSI7Cn07CgomZW1hYyB7CglwaW5j
dHJsLW5hbWVzID0gImRlZmF1bHQiOwoJcGluY3RybC0wID0gPCZlbWFjX3BpbnNfYT47CglwaHkg
PSA8JnBoeTE+OwoJc3RhdHVzID0gIm9rYXkiOwp9OwoKJmVtYWNfc3JhbSB7CglzdGF0dXMgPSAi
b2theSI7Cn07CgomaTJjMCB7CglwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOwoJcGluY3RybC0w
ID0gPCZpMmMwX3BpbnNfYT47CglzdGF0dXMgPSAib2theSI7CgoJYXhwMjA5OiBwbWljQDM0IHsK
CQlyZWcgPSA8MHgzND47CgkJaW50ZXJydXB0cyA9IDwwPjsKCX07Cn07CgomaTJjMSB7CglwaW5j
dHJsLW5hbWVzID0gImRlZmF1bHQiOwoJcGluY3RybC0wID0gPCZpMmMxX3BpbnNfYT47CglzdGF0
dXMgPSAib2theSI7Cn07CgomaXIwIHsKCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7CglwaW5j
dHJsLTAgPSA8JmlyMF9yeF9waW5zX2E+OwoJc3RhdHVzID0gIm9rYXkiOwp9OwoKJm1kaW8gewoJ
c3RhdHVzID0gIm9rYXkiOwoKCXBoeTE6IGV0aGVybmV0LXBoeUAxIHsKCQlyZWcgPSA8MT47Cgl9
Owp9OwoKJm1tYzAgewoJcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsKCXBpbmN0cmwtMCA9IDwm
bW1jMF9waW5zX2E+LCA8Jm1tYzBfY2RfcGluX3JlZmVyZW5jZV9kZXNpZ24+OwoJdm1tYy1zdXBw
bHkgPSA8JnJlZ192Y2MzdjM+OwoJYnVzLXdpZHRoID0gPDQ+OwoJY2QtZ3Bpb3MgPSA8JnBpbyA3
IDEgR1BJT19BQ1RJVkVfSElHSD47IC8qIFBIMSAqLwoJY2QtaW52ZXJ0ZWQ7CglzdGF0dXMgPSAi
b2theSI7Cn07Cgomb2hjaTAgewoJc3RhdHVzID0gIm9rYXkiOwp9OwoKJm9oY2kxIHsKCXN0YXR1
cyA9ICJva2F5IjsKfTsKCiZvdGdfc3JhbSB7CglzdGF0dXMgPSAib2theSI7Cn07CgomcGlvIHsK
CWxlZF9waW5zX2N1YmllYm9hcmQ6IGxlZF9waW5zQDAgewoJCWFsbHdpbm5lcixwaW5zID0gIlBI
MjAiLCAiUEgyMSI7CgkJYWxsd2lubmVyLGZ1bmN0aW9uID0gImdwaW9fb3V0IjsKCQlhbGx3aW5u
ZXIsZHJpdmUgPSA8U1VONElfUElOQ1RSTF8yMF9NQT47CgkJYWxsd2lubmVyLHB1bGwgPSA8U1VO
NElfUElOQ1RSTF9OT19QVUxMPjsKCX07CgoJdXNiMF9pZF9kZXRlY3RfcGluOiB1c2IwX2lkX2Rl
dGVjdF9waW5AMCB7CgkJYWxsd2lubmVyLHBpbnMgPSAiUEg0IjsKCQlhbGx3aW5uZXIsZnVuY3Rp
b24gPSAiZ3Bpb19pbiI7CgkJYWxsd2lubmVyLGRyaXZlID0gPFNVTjRJX1BJTkNUUkxfMTBfTUE+
OwoJCWFsbHdpbm5lcixwdWxsID0gPFNVTjRJX1BJTkNUUkxfUFVMTF9VUD47Cgl9Owp9OwoKJnJl
Z19haGNpXzV2IHsKCXN0YXR1cyA9ICJva2F5IjsKfTsKCiNpbmNsdWRlICJheHAyMDkuZHRzaSIK
CiZyZWdfZGNkYzIgewoJcmVndWxhdG9yLWFsd2F5cy1vbjsKCXJlZ3VsYXRvci1taW4tbWljcm92
b2x0ID0gPDEwMDAwMDA+OwoJcmVndWxhdG9yLW1heC1taWNyb3ZvbHQgPSA8MTQ1MDAwMD47Cgly
ZWd1bGF0b3ItbmFtZSA9ICJ2ZGQtY3B1IjsKfTsKCiZyZWdfZGNkYzMgewoJcmVndWxhdG9yLWFs
d2F5cy1vbjsKCXJlZ3VsYXRvci1taW4tbWljcm92b2x0ID0gPDEwMDAwMDA+OwoJcmVndWxhdG9y
LW1heC1taWNyb3ZvbHQgPSA8MTQwMDAwMD47CglyZWd1bGF0b3ItbmFtZSA9ICJ2ZGQtaW50LWRs
bCI7Cn07CgomcmVnX2xkbzEgewoJcmVndWxhdG9yLW5hbWUgPSAidmRkLXJ0YyI7Cn07CgomcmVn
X2xkbzIgewoJcmVndWxhdG9yLWFsd2F5cy1vbjsKCXJlZ3VsYXRvci1taW4tbWljcm92b2x0ID0g
PDMwMDAwMDA+OwoJcmVndWxhdG9yLW1heC1taWNyb3ZvbHQgPSA8MzAwMDAwMD47CglyZWd1bGF0
b3ItbmFtZSA9ICJhdmNjIjsKfTsKCiZyZWdfdXNiMV92YnVzIHsKCXN0YXR1cyA9ICJva2F5IjsK
fTsKCiZyZWdfdXNiMl92YnVzIHsKCXN0YXR1cyA9ICJva2F5IjsKfTsKCiZzcGkwIHsKCXBpbmN0
cmwtbmFtZXMgPSAiZGVmYXVsdCI7CglwaW5jdHJsLTAgPSA8JnNwaTBfcGluc19hPiwKCQkgICAg
PCZzcGkwX2NzMF9waW5zX2E+OwoJc3RhdHVzID0gIm9rYXkiOwp9OwoKJnVhcnQwIHsKCXBpbmN0
cmwtbmFtZXMgPSAiZGVmYXVsdCI7CglwaW5jdHJsLTAgPSA8JnVhcnQwX3BpbnNfYT47CglzdGF0
dXMgPSAib2theSI7Cn07CgomdXNiX290ZyB7Cglkcl9tb2RlID0gIm90ZyI7CglzdGF0dXMgPSAi
b2theSI7Cn07CgomdXNicGh5IHsKCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7CglwaW5jdHJs
LTAgPSA8JnVzYjBfaWRfZGV0ZWN0X3Bpbj47Cgl1c2IwX2lkX2RldC1ncGlvID0gPCZwaW8gNyA0
IEdQSU9fQUNUSVZFX0hJR0g+OyAvKiBQSDQgKi8KCXVzYjFfdmJ1cy1zdXBwbHkgPSA8JnJlZ191
c2IxX3ZidXM+OwoJdXNiMl92YnVzLXN1cHBseSA9IDwmcmVnX3VzYjJfdmJ1cz47CglzdGF0dXMg
PSAib2theSI7Cn07Cg==


--=-vvhXDafjrjjenvG/nVp2
Content-Type: audio/vnd.dts; name="sun4i-a10-cubieboard_can.dts"
Content-Disposition: attachment; filename="sun4i-a10-cubieboard_can.dts"
Content-Transfer-Encoding: base64

LyoKICogQ29weXJpZ2h0IDIwMTIgU3RlZmFuIFJvZXNlCiAqIFN0ZWZhbiBSb2VzZSA8c3JAZGVu
eC5kZT4KICoKICogVGhpcyBmaWxlIGlzIGR1YWwtbGljZW5zZWQ6IHlvdSBjYW4gdXNlIGl0IGVp
dGhlciB1bmRlciB0aGUgdGVybXMKICogb2YgdGhlIEdQTCBvciB0aGUgWDExIGxpY2Vuc2UsIGF0
IHlvdXIgb3B0aW9uLiBOb3RlIHRoYXQgdGhpcyBkdWFsCiAqIGxpY2Vuc2luZyBvbmx5IGFwcGxp
ZXMgdG8gdGhpcyBmaWxlLCBhbmQgbm90IHRoaXMgcHJvamVjdCBhcyBhCiAqIHdob2xlLgogKgog
KiAgYSkgVGhpcyBmaWxlIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0
IGFuZC9vcgogKiAgICAgbW9kaWZ5IGl0IHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVy
YWwgUHVibGljIExpY2Vuc2UgYXMKICogICAgIHB1Ymxpc2hlZCBieSB0aGUgRnJlZSBTb2Z0d2Fy
ZSBGb3VuZGF0aW9uOyBlaXRoZXIgdmVyc2lvbiAyIG9mIHRoZQogKiAgICAgTGljZW5zZSwgb3Ig
KGF0IHlvdXIgb3B0aW9uKSBhbnkgbGF0ZXIgdmVyc2lvbi4KICoKICogICAgIFRoaXMgZmlsZSBp
cyBkaXN0cmlidXRlZCBpbiB0aGUgaG9wZSB0aGF0IGl0IHdpbGwgYmUgdXNlZnVsLAogKiAgICAg
YnV0IFdJVEhPVVQgQU5ZIFdBUlJBTlRZOyB3aXRob3V0IGV2ZW4gdGhlIGltcGxpZWQgd2FycmFu
dHkgb2YKICogICAgIE1FUkNIQU5UQUJJTElUWSBvciBGSVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIg
UFVSUE9TRS4gIFNlZSB0aGUKICogICAgIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGZvciBt
b3JlIGRldGFpbHMuCiAqCiAqIE9yLCBhbHRlcm5hdGl2ZWx5LAogKgogKiAgYikgUGVybWlzc2lv
biBpcyBoZXJlYnkgZ3JhbnRlZCwgZnJlZSBvZiBjaGFyZ2UsIHRvIGFueSBwZXJzb24KICogICAg
IG9idGFpbmluZyBhIGNvcHkgb2YgdGhpcyBzb2Z0d2FyZSBhbmQgYXNzb2NpYXRlZCBkb2N1bWVu
dGF0aW9uCiAqICAgICBmaWxlcyAodGhlICJTb2Z0d2FyZSIpLCB0byBkZWFsIGluIHRoZSBTb2Z0
d2FyZSB3aXRob3V0CiAqICAgICByZXN0cmljdGlvbiwgaW5jbHVkaW5nIHdpdGhvdXQgbGltaXRh
dGlvbiB0aGUgcmlnaHRzIHRvIHVzZSwKICogICAgIGNvcHksIG1vZGlmeSwgbWVyZ2UsIHB1Ymxp
c2gsIGRpc3RyaWJ1dGUsIHN1YmxpY2Vuc2UsIGFuZC9vcgogKiAgICAgc2VsbCBjb3BpZXMgb2Yg
dGhlIFNvZnR3YXJlLCBhbmQgdG8gcGVybWl0IHBlcnNvbnMgdG8gd2hvbSB0aGUKICogICAgIFNv
ZnR3YXJlIGlzIGZ1cm5pc2hlZCB0byBkbyBzbywgc3ViamVjdCB0byB0aGUgZm9sbG93aW5nCiAq
ICAgICBjb25kaXRpb25zOgogKgogKiAgICAgVGhlIGFib3ZlIGNvcHlyaWdodCBub3RpY2UgYW5k
IHRoaXMgcGVybWlzc2lvbiBub3RpY2Ugc2hhbGwgYmUKICogICAgIGluY2x1ZGVkIGluIGFsbCBj
b3BpZXMgb3Igc3Vic3RhbnRpYWwgcG9ydGlvbnMgb2YgdGhlIFNvZnR3YXJlLgogKgogKiAgICAg
VEhFIFNPRlRXQVJFIElTIFBST1ZJREVEICJBUyBJUyIsIFdJVEhPVVQgV0FSUkFOVFkgT0YgQU5Z
IEtJTkQsCiAqICAgICBFWFBSRVNTIE9SIElNUExJRUQsIElOQ0xVRElORyBCVVQgTk9UIExJTUlU
RUQgVE8gVEhFIFdBUlJBTlRJRVMKICogICAgIE9GIE1FUkNIQU5UQUJJTElUWSwgRklUTkVTUyBG
T1IgQSBQQVJUSUNVTEFSIFBVUlBPU0UgQU5ECiAqICAgICBOT05JTkZSSU5HRU1FTlQuIElOIE5P
IEVWRU5UIFNIQUxMIFRIRSBBVVRIT1JTIE9SIENPUFlSSUdIVAogKiAgICAgSE9MREVSUyBCRSBM
SUFCTEUgRk9SIEFOWSBDTEFJTSwgREFNQUdFUyBPUiBPVEhFUiBMSUFCSUxJVFksCiAqICAgICBX
SEVUSEVSIElOIEFOIEFDVElPTiBPRiBDT05UUkFDVCwgVE9SVCBPUiBPVEhFUldJU0UsIEFSSVNJ
TkcKICogICAgIEZST00sIE9VVCBPRiBPUiBJTiBDT05ORUNUSU9OIFdJVEggVEhFIFNPRlRXQVJF
IE9SIFRIRSBVU0UgT1IKICogICAgIE9USEVSIERFQUxJTkdTIElOIFRIRSBTT0ZUV0FSRS4KICov
CgovZHRzLXYxLzsKI2luY2x1ZGUgInN1bjRpLWExMC5kdHNpIgojaW5jbHVkZSAic3VueGktY29t
bW9uLXJlZ3VsYXRvcnMuZHRzaSIKCiNpbmNsdWRlIDxkdC1iaW5kaW5ncy9ncGlvL2dwaW8uaD4K
I2luY2x1ZGUgPGR0LWJpbmRpbmdzL3BpbmN0cmwvc3VuNGktYTEwLmg+CgovIHsKCW1vZGVsID0g
IkN1YmlldGVjaCBDdWJpZWJvYXJkIjsKCWNvbXBhdGlibGUgPSAiY3ViaWV0ZWNoLGExMC1jdWJp
ZWJvYXJkIiwgImFsbHdpbm5lcixzdW40aS1hMTAiOwoKCWNhbjBfb3NjaWxsYXRvciA9ICAgPCZj
YW4wX29zYz4sIm9zY2lsbGF0b3ItZnJlcXVlbmN5IjsKCWNhbjBfc3BlZWQgPSAgICAgIDwmY2Fu
MD4sInNwaS1tYXgtZnJlcXVlbmN5OjAiOwoJY2FuMF9pbnRlcnJ1cHQgPSAgIDwmY2FuMF9waW5z
PiwiYWxsd2lubmVyLHBpbnM6UEIxMSIsPCZjYW4wPiwiaW50ZXJydXB0czowIjsKCgoJYWxpYXNl
cyB7CgkJc2VyaWFsMCA9ICZ1YXJ0MDsKCX07CgoJY2hvc2VuIHsKCQlzdGRvdXQtcGF0aCA9ICJz
ZXJpYWwwOjExNTIwMG44IjsKCX07CgoJbGVkcyB7CgkJY29tcGF0aWJsZSA9ICJncGlvLWxlZHMi
OwoJCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7CgkJcGluY3RybC0wID0gPCZsZWRfcGluc19j
dWJpZWJvYXJkPjsKCgkJYmx1ZSB7CgkJCWxhYmVsID0gImN1YmllYm9hcmQ6Ymx1ZTp1c3IiOwoJ
CQlncGlvcyA9IDwmcGlvIDcgMjEgR1BJT19BQ1RJVkVfSElHSD47IC8qIExFRDEgKi8KCQl9OwoK
CQlncmVlbiB7CgkJCWxhYmVsID0gImN1YmllYm9hcmQ6Z3JlZW46dXNyIjsKCQkJZ3Bpb3MgPSA8
JnBpbyA3IDIwIEdQSU9fQUNUSVZFX0hJR0g+OyAvKiBMRUQyICovCgkJCWxpbnV4LGRlZmF1bHQt
dHJpZ2dlciA9ICJoZWFydGJlYXQiOwoJCX07CgovKiAqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKiAqLwoJY2xvY2tzIHsKCQljYW4wX29zYzogY2FuMF9v
c2MgewoJCQljb21wYXRpYmxlID0gImZpeGVkLWNsb2NrIjsKCQkJI2Nsb2NrLWNlbGxzID0gPDA+
OwoJCQljbG9jay1mcmVxdWVuY3kgID0gPDE2MDAwMDAwPjsKCQkJfTsKCX07Ci8qICoqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKiogKi8KfTsKCiZhaGNpIHsK
CXRhcmdldC1zdXBwbHkgPSA8JnJlZ19haGNpXzV2PjsKCXN0YXR1cyA9ICJva2F5IjsKfTsKCiZj
b2RlYyB7CglzdGF0dXMgPSAib2theSI7Cn07CgomY3B1MCB7CgljcHUtc3VwcGx5ID0gPCZyZWdf
ZGNkYzI+Owp9OwoKJmVoY2kwIHsKCXN0YXR1cyA9ICJva2F5IjsKfTsKCiZlaGNpMSB7CglzdGF0
dXMgPSAib2theSI7Cn07CgomZW1hYyB7CglwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOwoJcGlu
Y3RybC0wID0gPCZlbWFjX3BpbnNfYT47CglwaHkgPSA8JnBoeTE+OwoJc3RhdHVzID0gIm9rYXki
Owp9OwoKJmVtYWNfc3JhbSB7CglzdGF0dXMgPSAib2theSI7Cn07CgomaTJjMCB7CglwaW5jdHJs
LW5hbWVzID0gImRlZmF1bHQiOwoJcGluY3RybC0wID0gPCZpMmMwX3BpbnNfYT47CglzdGF0dXMg
PSAib2theSI7CgoJYXhwMjA5OiBwbWljQDM0IHsKCQlyZWcgPSA8MHgzND47CgkJaW50ZXJydXB0
cyA9IDwwPjsKCX07Cn07CgomaTJjMSB7CglwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOwoJcGlu
Y3RybC0wID0gPCZpMmMxX3BpbnNfYT47CglzdGF0dXMgPSAib2theSI7Cn07CgomaXIwIHsKCXBp
bmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7CglwaW5jdHJsLTAgPSA8JmlyMF9yeF9waW5zX2E+OwoJ
c3RhdHVzID0gIm9rYXkiOwp9OwoKJm1kaW8gewoJc3RhdHVzID0gIm9rYXkiOwoKCXBoeTE6IGV0
aGVybmV0LXBoeUAxIHsKCQlyZWcgPSA8MT47Cgl9Owp9OwoKJm1tYzAgewoJcGluY3RybC1uYW1l
cyA9ICJkZWZhdWx0IjsKCXBpbmN0cmwtMCA9IDwmbW1jMF9waW5zX2E+LCA8Jm1tYzBfY2RfcGlu
X3JlZmVyZW5jZV9kZXNpZ24+OwoJdm1tYy1zdXBwbHkgPSA8JnJlZ192Y2MzdjM+OwoJYnVzLXdp
ZHRoID0gPDQ+OwoJY2QtZ3Bpb3MgPSA8JnBpbyA3IDEgR1BJT19BQ1RJVkVfSElHSD47IC8qIFBI
MSAqLwoJY2QtaW52ZXJ0ZWQ7CglzdGF0dXMgPSAib2theSI7Cn07Cgomb2hjaTAgewoJc3RhdHVz
ID0gIm9rYXkiOwp9OwoKJm9oY2kxIHsKCXN0YXR1cyA9ICJva2F5IjsKfTsKCiZvdGdfc3JhbSB7
CglzdGF0dXMgPSAib2theSI7Cn07CgomcGlvIHsKCWxlZF9waW5zX2N1YmllYm9hcmQ6IGxlZF9w
aW5zQDAgewoJCWFsbHdpbm5lcixwaW5zID0gIlBIMjAiLCAiUEgyMSI7CgkJYWxsd2lubmVyLGZ1
bmN0aW9uID0gImdwaW9fb3V0IjsKCQlhbGx3aW5uZXIsZHJpdmUgPSA8U1VONElfUElOQ1RSTF8y
MF9NQT47CgkJYWxsd2lubmVyLHB1bGwgPSA8U1VONElfUElOQ1RSTF9OT19QVUxMPjsKCX07CgoJ
dXNiMF9pZF9kZXRlY3RfcGluOiB1c2IwX2lkX2RldGVjdF9waW5AMCB7CgkJYWxsd2lubmVyLHBp
bnMgPSAiUEg0IjsKCQlhbGx3aW5uZXIsZnVuY3Rpb24gPSAiZ3Bpb19pbiI7CgkJYWxsd2lubmVy
LGRyaXZlID0gPFNVTjRJX1BJTkNUUkxfMTBfTUE+OwoJCWFsbHdpbm5lcixwdWxsID0gPFNVTjRJ
X1BJTkNUUkxfUFVMTF9VUD47Cgl9OwovKiAqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKiogKi8gCgljYW4wX3BpbnM6IGNhbjBfcGlucyB7CgkJYWxs
d2lubmVyLHBpbnMgPSAiUEkxMCIsICJQSTExIiwgIlBJMTIiLCAiUEkxMyI7IC8qIFNQSTAgKi8K
CQlhbGx3aW5uZXIsZnVuY3Rpb24gPSAic3BpMCI7IC8qIGlucHV0ICovCgl9OwovKiAqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKiogKi8KfTsKCiZy
ZWdfYWhjaV81diB7CglzdGF0dXMgPSAib2theSI7Cn07CgojaW5jbHVkZSAiYXhwMjA5LmR0c2ki
CgomcmVnX2RjZGMyIHsKCXJlZ3VsYXRvci1hbHdheXMtb247CglyZWd1bGF0b3ItbWluLW1pY3Jv
dm9sdCA9IDwxMDAwMDAwPjsKCXJlZ3VsYXRvci1tYXgtbWljcm92b2x0ID0gPDE0NTAwMDA+OwoJ
cmVndWxhdG9yLW5hbWUgPSAidmRkLWNwdSI7Cn07CgomcmVnX2RjZGMzIHsKCXJlZ3VsYXRvci1h
bHdheXMtb247CglyZWd1bGF0b3ItbWluLW1pY3Jvdm9sdCA9IDwxMDAwMDAwPjsKCXJlZ3VsYXRv
ci1tYXgtbWljcm92b2x0ID0gPDE0MDAwMDA+OwoJcmVndWxhdG9yLW5hbWUgPSAidmRkLWludC1k
bGwiOwp9OwoKJnJlZ19sZG8xIHsKCXJlZ3VsYXRvci1uYW1lID0gInZkZC1ydGMiOwp9OwoKJnJl
Z19sZG8yIHsKCXJlZ3VsYXRvci1hbHdheXMtb247CglyZWd1bGF0b3ItbWluLW1pY3Jvdm9sdCA9
IDwzMDAwMDAwPjsKCXJlZ3VsYXRvci1tYXgtbWljcm92b2x0ID0gPDMwMDAwMDA+OwoJcmVndWxh
dG9yLW5hbWUgPSAiYXZjYyI7Cn07CgomcmVnX3VzYjFfdmJ1cyB7CglzdGF0dXMgPSAib2theSI7
Cn07CgomcmVnX3VzYjJfdmJ1cyB7CglzdGF0dXMgPSAib2theSI7Cn07CgovKiAqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKiAqLwomc3BpMCB7CglwaW5jdHJsLW5hbWVz
ID0gImRlZmF1bHQiOwoJcGluY3RybC0wID0gPCZzcGkwX3BpbnNfYT4sCgkJICAgIDwmc3BpMF9j
czBfcGluc19hPjsKCXN0YXR1cyA9ICJva2F5IjsKCWNhbjA6IG1jcDI1MTVAMCB7CgkJcmVnPSA8
MD47CgkJY29tcGF0aWJsZSA9ICJtaWNyb2NoaXAsbWNwMjUxNSI7CgkJcGluY3RybC1uYW1lcyA9
ICJkZWZhdWx0IjsKCQlwaW5jdHJsLTAgPSA8JmNhbjBfcGlucz47CgkJc3BpLW1heC1mcmVxdWVu
Y3kgPSA8MTAwMDAwMDA+OwoJCWludGVycnVwdC1wYXJlbnQgPSA8JnBpbz47CgkJaW50ZXJydXB0
cyA9IDwyNSAweDI+OwoJCWNsb2NrcyA9IDwmY2FuMF9vc2M+OwoJCX07Cgl9OwovKiAqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqICovCgomdWFydDAgewoJcGluY3RybC1u
YW1lcyA9ICJkZWZhdWx0IjsKCXBpbmN0cmwtMCA9IDwmdWFydDBfcGluc19hPjsKCXN0YXR1cyA9
ICJva2F5IjsKfTsKCiZ1c2Jfb3RnIHsKCWRyX21vZGUgPSAib3RnIjsKCXN0YXR1cyA9ICJva2F5
IjsKfTsKCiZ1c2JwaHkgewoJcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsKCXBpbmN0cmwtMCA9
IDwmdXNiMF9pZF9kZXRlY3RfcGluPjsKCXVzYjBfaWRfZGV0LWdwaW8gPSA8JnBpbyA3IDQgR1BJ
T19BQ1RJVkVfSElHSD47IC8qIFBINCAqLwoJdXNiMV92YnVzLXN1cHBseSA9IDwmcmVnX3VzYjFf
dmJ1cz47Cgl1c2IyX3ZidXMtc3VwcGx5ID0gPCZyZWdfdXNiMl92YnVzPjsKCXN0YXR1cyA9ICJv
a2F5IjsKfTsK


--=-vvhXDafjrjjenvG/nVp2--

