From: Mirza Krak <mirza.krak@hostmobility.com>
Subject: Re: socketcan support for kvaser pciecan 4xhs?
Date: Fri, 24 Feb 2017 15:19:59 +0100
Message-ID: <CAJ=nTsuLqmp36BLMVECnn531WbYoLEqETdF4zn5togK49EED2Q@mail.gmail.com>
References: <CACAQXeKHkkx6JD3eEY=bS7g+RXq8xeyNs9RZ8da0OAa4E+O7ew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-lf0-f54.google.com ([209.85.215.54]:35968 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751115AbdBXOUB (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 24 Feb 2017 09:20:01 -0500
Received: by mail-lf0-f54.google.com with SMTP id b80so9359015lfe.3
        for <linux-can@vger.kernel.org>; Fri, 24 Feb 2017 06:20:00 -0800 (PST)
In-Reply-To: <CACAQXeKHkkx6JD3eEY=bS7g+RXq8xeyNs9RZ8da0OAa4E+O7ew@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: David Rorex <drorex@gmail.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

2017-02-24 2:46 GMT+01:00 David Rorex <drorex@gmail.com>:
> Hello,
>
> I have one of these cards: https://www.kvaser.com/product/kvaser-pciecan-=
4xhs/
> and I am wondering if the kvaser_pci module supports it under linux. I
> have had good results using the kvaser_usb module and a Kvaser Leaf
> Light HS v2 usb adapter, but with the pcie card after I modprobe
> kvaser_pci all I see is this in dmesg:
>
> [100210.826630] CAN device driver interface
> [100210.837062] sja1000 CAN netdevice driver
>
> And no can0 etc interfaces get created.
>
> Looking at the spec sheet for the device:
> http://canlandbucket.s3-website-eu-west-1.amazonaws.com/productionResourc=
esFiles/94452d98-248a-4618-8f75-04c016cc62d6/KVASER_PCIECAN_4XHS_A4_WEB.pdf
> It says "Implements Kvaser=E2=80=99s CAN IP in an FPGA, resulting in high=
 max
> message rate." so I am wondering if perhaps it does not use the same
> sja1000 chip as the other pci cards and thus might not be supported by
> the driver?

The product sheet states that PCIECAN 4XHS supports CAN FD so it is
safe to assume that it does not use a SJA1000 chip, or something that
is compatible.


> 04:00.0 CANBUS: Kvaser AB Device 000d (rev 01)
>         Subsystem: Kvaser AB Device 000d
>         Flags: bus master, fast devsel, latency 0, IRQ 19
>         Memory at f7d00000 (32-bit, non-prefetchable) [size=3D128K]
>         Capabilities: [50] MSI: Enable- Count=3D1/1 Maskable- 64bit+
>         Capabilities: [78] Power Management version 3
>         Capabilities: [80] Express Endpoint, MSI 00
>         Capabilities: [100] Virtual Channel

Looking in kvaser_pci.c, above device ID is not represented in the
"supported" list. It only has two devices in the list:

#define KVASER_PCI_VENDOR_ID1     0x10e8    /* the PCI device and vendor ID=
s */
#define KVASER_PCI_DEVICE_ID1     0x8406

#define KVASER_PCI_VENDOR_ID2     0x1a07    /* the PCI device and vendor ID=
s */
#define KVASER_PCI_DEVICE_ID2     0x0008

--=20
Med V=C3=A4nliga H=C3=A4lsningar / Best Regards

*******************************************************************
Mirza Krak
Host Mobility AB
mirza.krak@hostmobility.com
Anders Personsgatan 12, 416 64 G=C3=B6teborg
Sweden
http://www.hostmobility.com
Direct: +46 31 31 32 704
Phone: +46 31 31 32 700
Fax: +46 31 80 67 51
Mobile: +46 730 28 06 22
*******************************************************************
