From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: Problem with Eurotech COM1273 Dual Channel CAN PC104 Module.
Date: Tue, 15 Apr 2014 09:55:51 +0000
Message-ID: <164afc991761b9eeb0eec6902814d00e@grandegger.com>
References: <CA+s8ZrqFBun4bo2rJJFHb0FrV7m7PLybUVM+jjahKsdW8bdnaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from pluto.manitu.net ([217.11.48.9]:51754 "EHLO pluto.manitu.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751352AbaDOJzx (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 15 Apr 2014 05:55:53 -0400
In-Reply-To: <CA+s8ZrqFBun4bo2rJJFHb0FrV7m7PLybUVM+jjahKsdW8bdnaQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: khurram gulzar <khurramgulzar@gmail.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, socketcan-users@lists.berlios.de, linux-can@vger.kernel.org

Hi Khurram,

we have switched to a new mailing list some time ago, which I have
therefore added to the CC.

On Tue, 15 Apr 2014 11:07:15 +0300, khurram gulzar
<khurramgulzar@gmail.com> wrote:
> Hi Oliver and Wolfgang,=C2=A0
> Thanks for your support in advance=C2=A0
> I have recently updated the system from Kernel 2.6 to use the new ker=
nel
> 3.2 for linux.=C2=A0I have noticed that the socket-can is integrated =
in the
> kernel.=C2=A0 I enabled the driver in the kernel from the kernel conf=
ig.=C2=A0
> The drivers are loaded successfully and both the CAN are transmitting
the
> packets.=C2=A0However its unable to receive any packets on any of the=
 CAN.=C2=A0
> The system configurations are still the same=C2=A0loaded drivers=C2=A0
> -> can.ko-> can-raw.ko-> sja1000-iomux

There is now module named "sja1000-iomux" in the mainline kernel.
Where did you get it from?

> The address of can is configured to base=3D0x200,0x204 and irq=3D10,1=
1 with
> speed=3D1000,1000 i.e. 1Mbits/sec=C2=A0=20
> I have checked the irq in /proc/interrupts. IRQ 10 and 11 =C2=A0are s=
howing
> connected to CAN0 and CAN1.

Do the IRQ counts increase when you send messages?

> Can you please tell me what seems to be wrong-=C2=A0 Waiting for your
> reply=C2=A0

Could you switch to a recent mainline kernel version?

Wolfgang.

