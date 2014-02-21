From: Lucas Zampar Bernardi <lucas.zampar@gmail.com>
Subject: MCP2515 DTS support
Date: Fri, 21 Feb 2014 13:26:58 -0300
Message-ID: <144554558e0.2748.cbaa067694a7e68fb76a213b35423fb5@gmail.com>
References: <1445543c688.2748.cbaa067694a7e68fb76a213b35423fb5@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-yh0-f44.google.com ([209.85.213.44]:43855 "EHLO
	mail-yh0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932218AbaBUQ1D (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 21 Feb 2014 11:27:03 -0500
Received: by mail-yh0-f44.google.com with SMTP id f73so2543800yha.3
        for <linux-can@vger.kernel.org>; Fri, 21 Feb 2014 08:27:02 -0800 (PST)
Received: from [177.76.89.76] ([177.76.89.76])
        by mx.google.com with ESMTPSA id q9sm19945841yhk.16.2014.02.21.08.26.59
        for <linux-can@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 21 Feb 2014 08:27:01 -0800 (PST)
In-Reply-To: <1445543c688.2748.cbaa067694a7e68fb76a213b35423fb5@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hello all,



I have tried to communicate MCP2515 with new kernel 3.14-rc2 using DTS.=
 At=20
this version, the driver has been modified to support DTS structures.

The hardware its ok, because it has worked witk linux 2.6.39.

The SPI controller also it's ok, because I have an AT45DB321 connected =
and=20
its detected.

Could somebody give some tips?




My DTS SPI node:


			spi0: spi@f0000000 {

				status =3D "okay";

				interrupts =3D <13 4 5>;

				cs-gpios =3D <&pioA 14 0>, <&pioA 7 0>, <&pioA 1 0>, <0>; /* CHIP S=
ELECT */

=A0 =A0 =A0 =A0		=09

=A0 =A0 =A0 =A0=A0		=09

				mtd_dataflash@0 {

					compatible =3D "atmel,at45", "atmel,dataflash";

					spi-max-frequency =3D <1000000>;

					reg =3D <0>;

				};

			=09

				can0: can@1 {

					compatible =3D "microchip,mcp2515";

					reg =3D <2>;

					spi-max-frequency =3D <5000000>;

					clocks =3D <&mcp251x_clock>;

					interrupt-parent =3D <&pioC>; /* MCP GPO Interrupt */

					interrupts =3D <12 0x2>;

				};

		};



I have seen that the mcp2515 interrupt was not created.


# cat /proc/interrupts=A0

=A0 =A0 =A0 =A0 =A0 =A0CPU0 =A0 =A0 =A0=A0

16: 4817 AIC 1 at91_tick, at91_rtc, ttyS0

17:=A081687=A0AIC 17 tc_clkevt

=A018: =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 AIC =A020 =A0at_hdmac

=A019: =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 AIC =A021 =A0at_hdmac

22:=A021294=A0AIC 12 f0008000.mmc

23: 0 AIC 9 f8010000.i2c

24: 0 AIC 10 f8014000.i2c

26: 6 AIC 13 f0000000.spi

=A027: =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 AIC =A024 =A0eth0

=A028: =A0 =A0 =A0 =A0 =A01 =A0 =A0 =A0 AIC =A022 =A0ehci_hcd:usb1, ohc=
i_hcd:usb2

=A030: =A0 =A0 =A0 =A0 =A01 =A0 =A0 =A0GPIO =A026 =A0transfer_button

=A031: =A0 =A0 =A0 =A0 =A00 =A0 =A0 =A0GPIO =A025 =A0custom_button

Err: =A0 =A0 =A0 =A0 =A00




# dmesg | grep spi

[ 0.085937] bus: 'spi': registered

[ 0.085937] device class 'spi_master': registering

[ 0.101562] device: 'f0000000.spi': device_add

[ 0.101562] bus: 'platform': add device f0000000.spi

[ 0.101562] PM: Adding info for platform:f0000000.spi

[ 0.703125] bus: 'spi': add driver mtd_dataflash

[ 0.890625] bus: 'platform': add driver atmel_spi

[ 0.890625] bus: 'platform': driver_probe_device: matched device=20
f0000000.spi with driver atmel_spi

[ 0.890625] bus: 'platform': really_probe: probing driver atmel_spi wit=
h=20
device f0000000.spi

[ 0.890625] atmel_spi f0000000.spi: no sleep pinctrl state

[ 0.890625] atmel_spi f0000000.spi: no idle pinctrl state

[ 0.890625] atmel_spi f0000000.spi: version: 0x212

[ 0.898437] atmel_spi f0000000.spi: Using dma0chan2 (tx) and dma0chan3 =
(rx)=20
for DMA transfers

[ 0.906250] atmel_spi f0000000.spi: Atmel SPI Controller at 0xf0000000 =
(irq 26)

[ 0.914062] device: 'spi32766': device_add

[ 0.914062] PM: Adding info for No Bus:spi32766

[ 0.914062] atmel_spi f0000000.spi: registered master spi32766 (dynamic=
)

[ 0.914062] spi spi32766.0: setup: bpw 8 mode 0x0 -> csr0 00000002

[ 0.914062] spi spi32766.0: setup mode 0, 8 bits/w,=A01000000=A0Hz max =
--> 0

[ 0.914062] device: 'spi32766.0': device_add

[ 0.914062] bus: 'spi': add device spi32766.0

[ 0.914062] PM: Adding info for spi:spi32766.0

[ 0.914062] bus: 'spi': driver_probe_device: matched device spi32766.0 =
with=20
driver mtd_dataflash

[ 0.914062] bus: 'spi': really_probe: probing driver mtd_dataflash with=
=20
device spi32766.0

[ 0.914062] mtd_dataflash spi32766.0: no default pinctrl state

[ 0.914062] mtd_dataflash spi32766.0: new message c783fcb0 submitted fo=
r=20
spi32766.0

[ 0.914062] mtd_dataflash spi32766.0: activate 14, mr 000e0031

[ 0.914062] atmel_spi f0000000.spi: start pio xfer c783fc68: len 1 tx=20
c7869760 rx (null) bitpw 8

[ 0.914062] atmel_spi f0000000.spi: start pio xfer c783fc8c: len 3 tx=20
(null) rx c7869761 bitpw 8

[ 0.914062] atmel_spi f0000000.spi: start pio xfer c783fc8c: len 3 tx=20
(null) rx c7869761 bitpw 8

[ 0.914062] atmel_spi f0000000.spi: start pio xfer c783fc8c: len 3 tx=20
(null) rx c7869761 bitpw 8

[ 0.914062] mtd_dataflash spi32766.0: xfer c783fc68: len 1 tx=20
c7869760/00000000 rx (null)/00000000

[ 0.914062] mtd_dataflash spi32766.0: xfer c783fc8c: len 3 tx=20
(null)/00000000 rx c7869761/00000000

[ 0.914062] mtd_dataflash spi32766.0: DEactivate 14, mr 000f0031

[ 0.914062] mtd_dataflash spi32766.0: new message c783fcb0 submitted fo=
r=20
spi32766.0

[ 0.914062] mtd_dataflash spi32766.0: activate 14, mr 000e0031

[ 0.914062] atmel_spi f0000000.spi: start pio xfer c783fc68: len 1 tx=20
c7869760 rx (null) bitpw 8

[ 0.914062] atmel_spi f0000000.spi: start pio xfer c783fc8c: len 1 tx=20
(null) rx c7869761 bitpw 8

[ 0.914062] mtd_dataflash spi32766.0: xfer c783fc68: len 1 tx=20
c7869760/00000000 rx (null)/00000000

[ 0.914062] mtd_dataflash spi32766.0: xfer c783fc8c: len 1 tx=20
(null)/00000000 rx c7869761/00000000

[ 0.914062] mtd_dataflash spi32766.0: DEactivate 14, mr 000f0031

[ 0.914062] mtd_dataflash spi32766.0: AT45DB321x (4224 KBytes) pagesize=
 528=20
bytes, OTP

[ 0.929687] driver: 'spi32766.0': driver_bound: bound to device 'mtd_da=
taflash'

[ 0.929687] bus: 'spi': really_probe: bound device spi32766.0 to driver=
=20
mtd_dataflash

[ 0.929687] atmel_spi f0000000.spi: registered child spi32766.0

[ 0.929687] spi spi32766.2: setup: bpw 8 mode 0x0 -> csr2 00000002

[ 0.929687] spi spi32766.2: setup mode 0, 8 bits/w,=A05000000=A0Hz max =
--> 0

[ 0.929687] device: 'spi32766.2': device_add

[ 0.929687] bus: 'spi': add device spi32766.2

[ 0.929687] PM: Adding info for spi:spi32766.2

[ 0.929687] atmel_spi f0000000.spi: registered child spi32766.2

[ 0.929687] driver: 'f0000000.spi': driver_bound: bound to device 'atme=
l_spi'

[ 0.929687] bus: 'platform': really_probe: bound device f0000000.spi to=
=20
driver atmel_spi

[ 0.953125] bus: 'spi': add driver mcp251x

[ 0.953125] bus: 'spi': driver_probe_device: matched device spi32766.2 =
with=20
driver mcp251x

[ 0.953125] bus: 'spi': really_probe: probing driver mcp251x with devic=
e=20
spi32766.2

[ 0.953125] mcp251x spi32766.2: no default pinctrl state

[ 0.953125] mcp251x: probe of spi32766.2 failed with error -2

[ 1.328125] bus: 'spi': add driver mmc_spi





Regards,



Lucas Zampar


