From: David Rorex <drorex@gmail.com>
Subject: socketcan support for kvaser pciecan 4xhs?
Date: Thu, 23 Feb 2017 17:46:18 -0800
Message-ID: <CACAQXeKHkkx6JD3eEY=bS7g+RXq8xeyNs9RZ8da0OAa4E+O7ew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ua0-f175.google.com ([209.85.217.175]:35030 "EHLO
        mail-ua0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751246AbdBXBqp (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 23 Feb 2017 20:46:45 -0500
Received: by mail-ua0-f175.google.com with SMTP id 40so5433419uau.2
        for <linux-can@vger.kernel.org>; Thu, 23 Feb 2017 17:46:44 -0800 (PST)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hello,

I have one of these cards: https://www.kvaser.com/product/kvaser-pciecan-4x=
hs/
and I am wondering if the kvaser_pci module supports it under linux. I
have had good results using the kvaser_usb module and a Kvaser Leaf
Light HS v2 usb adapter, but with the pcie card after I modprobe
kvaser_pci all I see is this in dmesg:

[100210.826630] CAN device driver interface
[100210.837062] sja1000 CAN netdevice driver

And no can0 etc interfaces get created.

Looking at the spec sheet for the device:
http://canlandbucket.s3-website-eu-west-1.amazonaws.com/productionResources=
Files/94452d98-248a-4618-8f75-04c016cc62d6/KVASER_PCIECAN_4XHS_A4_WEB.pdf
It says "Implements Kvaser=E2=80=99s CAN IP in an FPGA, resulting in high m=
ax
message rate." so I am wondering if perhaps it does not use the same
sja1000 chip as the other pci cards and thus might not be supported by
the driver?

Output of uname -a:

Linux 4.4.0-63-generic #84-Ubuntu SMP Wed Feb 1 17:20:32 UTC 2017
x86_64 x86_64 x86_64 GNU/Linux

Output of lspci -v:

04:00.0 CANBUS: Kvaser AB Device 000d (rev 01)
        Subsystem: Kvaser AB Device 000d
        Flags: bus master, fast devsel, latency 0, IRQ 19
        Memory at f7d00000 (32-bit, non-prefetchable) [size=3D128K]
        Capabilities: [50] MSI: Enable- Count=3D1/1 Maskable- 64bit+
        Capabilities: [78] Power Management version 3
        Capabilities: [80] Express Endpoint, MSI 00
        Capabilities: [100] Virtual Channel

Please let me know if there's any other info from the system that
might be useful and I appreciate any help. Kvaser provides their own
drivers that work but they have their own API and it would be nice to
use the standardized SocketCAN API.

Thanks,
David Rorex
