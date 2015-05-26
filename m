From: Jesse James <jjames@dukemfg.com>
Subject: RE: PROBLEM: Attempt to Enable CAN Network with MCP251x SPI
 Interface Results in Kernel Panics at Boot
Date: Tue, 26 May 2015 17:41:45 +0000
Message-ID: <388824CB4174CA41B696BDD3405FBE6459CFEEBE@stlex-1.stl.dukemfg.local>
References: <388824CB4174CA41B696BDD3405FBE6459CFEE9C@stlex-1.stl.dukemfg.local>
 <20150526172534.GS26599@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.dukemfg.com ([216.43.59.182]:50236 "EHLO mail.dukemfg.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750845AbbEZRlr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 26 May 2015 13:41:47 -0400
In-Reply-To: <20150526172534.GS26599@saruman.tx.rr.com>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "balbi@ti.com" <balbi@ti.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>

Thank you for the quick response.  I was able to switch to the head of =
the master branch and duplicate the issue as well, see below.  The reas=
on I added the USB group was due to the lines from the boot log:

[    0.195398] [usb_manager]: CONFIG_USB_SW_SUNXI_USB0_OTG
[    0.202738] WRN:L268(drivers/usb/sunxi_usb/manager/usb_manager.c):ER=
R: usbc0 port_type(-16777249) is unkown
[    0.211219] WRN:L426(drivers/usb/sunxi_usb/manager/usb_manager.c):ER=
R: check_usb_board_info failed
[    0.218891] WRN:L480(drivers/usb/sunxi_usb/manager/usb_manager.c):ER=
R: get_usb_cfg

This seems to be where things go wrong.  This error does not happen whe=
n the kernel is not configured with CAN.  I assume you are correct that=
 the USB code section is not causing this, and that the CAN module is c=
orrupting the usb config before it loaded.

///////////////////////////////////////////////////////////////////////=
///////////////////////
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
<1>Unable to handle kernel paging request at virtual address f19f06dc
[    1.284082] Unable to handle kernel paging request at virtual addres=
s f19f06dc
<1>pgd =3D c0004000
[    1.292950] pgd =3D c0004000
<1>[f19f06dc] *pgd=3D00000000[    1.298001] [f19f06dc] *pgd=3D00000000

<0>Internal error: Oops: 5 [#1] PREEMPT ARM
[    1.305676] Internal error: Oops: 5 [#1] PREEMPT ARM
<d>Modules linked in:[    1.312462] Modules linked in:

CPU: 0    Not tainted  (3.4.103+ #1)
[    1.319010] CPU: 0    Not tainted  (3.4.103+ #1)
PC is at sunxi_gpio_request_array.part.4+0xdc/0x4c4
[    1.328234] PC is at sunxi_gpio_request_array.part.4+0xdc/0x4c4
LR is at sunxi_gpio_request_array.part.4+0x4c0/0x4c4
[    1.338836] LR is at sunxi_gpio_request_array.part.4+0x4c0/0x4c4
pc : [<c0029cac>]    lr : [<c002a090>]    psr: 20000013
sp : df827ef0  ip : b1b08738  fp : b1b08740
[    1.353684] pc : [<c0029cac>]    lr : [<c002a090>]    psr: 20000013
[    1.353689] sp : df827ef0  ip : b1b08738  fp : b1b08740
r10: 71c20780  r9 : c07f0838  r8 : c0605fe0
[    1.369066] r10: 71c20780  r9 : c07f0838  r8 : c0605fe0
r7 : c092900c  r6 : 00000001  r5 : 00000058  r4 : c0879a08
[    1.379493] r7 : c092900c  r6 : 00000001  r5 : 00000058  r4 : c0879a=
08
r3 : 71c20794  r2 : b1b08748  r1 : 00000000  r0 : f19f0700
[    1.391220] r3 : 71c20794  r2 : b1b08748  r1 : 00000000  r0 : f19f07=
00
=46lags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
[    1.403729] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Seg=
ment kernel
Control: 10c5387d  Table: 40004019  DAC: 00000015
[    1.415458] Control: 10c5387d  Table: 40004019  DAC: 00000015
///////////////////////////////////////////////////////////////////////=
///////////////////////

Thanks,
Jesse

-----Original Message-----
=46rom: Felipe Balbi [mailto:balbi@ti.com]=20
Sent: Tuesday, May 26, 2015 12:26 PM
To: Jesse James
Cc: linux-can@vger.kernel.org; linux-usb@vger.kernel.org
Subject: Re: PROBLEM: Attempt to Enable CAN Network with MCP251x SPI In=
terface Results in Kernel Panics at Boot

On Tue, May 26, 2015 at 05:21:23PM +0000, Jesse James wrote:
> Hello,
>=20
> I recently purchased a A10-OLinuXino-LIME from=20
> https://www.olimex.com/.=A0 This board uses the Allwinner A10 Cortex-=
8=20
> chipset.=A0 Using the kernel from https://github.com/linux-sunxi and=20
> commit e37d760b363888f3a65cd6455c99a75cac70a7b8, I was able to

this commit is not upstream, you need to ask for support from whoever m=
aintains linux-sunxi

> successfully build and run kernel 3.4.90+ on the above mentioned

yeah, this kernel is pretty old, you really need to contact linux-sunxi=
 maintainers.

> board.
>=20
> I attempted to enable the CAN Network with the MCP251x SPI interface=20
> enabled, config file is attached, and now the kernel "panics" at boot=
=2E=A0=20
> The short hand looks like the following: (Full boot log is
> attached)
>=20
> /////////////////////////////////////////////////////////////////////=
/
> /////////////////////////
> <6>ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver [=A0=A0=A0=20
> 1.272001] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver=20
> <1>Unable to handle kernel paging request at virtual address 71c007b4=
=20
> [=A0=A0=A0 1.284403] Unable to handle kernel paging request at virtua=
l=20
> address 71c007b4 <1>pgd =3D c0004000 [=A0=A0=A0 1.293294] pgd =3D c00=
04000=20
> <1>[71c007b4] *pgd=3D00000000[=A0=A0=A0 1.298345] [71c007b4] *pgd=3D0=
0000000
>=20
> <0>Internal error: Oops: 5 [#1] PREEMPT ARM [=A0=A0=A0 1.306038] Inte=
rnal=20
> error: Oops: 5 [#1] PREEMPT ARM <d>Modules linked in:[=A0=A0=A0 1.312=
825]=20
> Modules linked in:
>=20
> CPU: 0=A0=A0=A0 Not tainted=A0 (3.4.90+ #8)
> [=A0=A0=A0 1.319284] CPU: 0=A0=A0=A0 Not tainted=A0 (3.4.90+ #8) PC i=
s at=20
> sunxi_gpio_request_array.part.4+0xdc/0x4c4

this isn't even a USB bug. Unless you can reproduce this problem with
v4.0 or v4.1-rc5, then there's nothing this forum can do to help you ou=
t, sorry.

--
balbi
