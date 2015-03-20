From: Ralph Potztal <ralph.potztal@espros.com>
Subject: Re: Kvaser leaf light
Date: Fri, 20 Mar 2015 05:28:21 +0100 (CET)
Message-ID: <5474697.32.1426825696753.JavaMail.RPO@dhcp32-209.ch.epc>
References: <20150319153152.GA2121@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.espros.ch ([82.197.176.76]:46523 "EHLO mail.espros.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750778AbbCTE2Y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 20 Mar 2015 00:28:24 -0400
In-Reply-To: <20150319153152.GA2121@linux>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Ahmed S. Darwish" <darwish.07@gmail.com>
Cc: linux-can@vger.kernel.org


Hi Ahmed,=20

thanks for this. I think that could be the problem, because:

# uname -a
Linux cli-48 3.13.0-46-generic #79-Ubuntu SMP Tue Mar 10 20:06:50 UTC 2=
015 x86_64 x86_64 x86_64 GNU/Linux

Best regards,=20
Ralph

----- Urspr=C3=BCngliche Mail -----
Von: "Ahmed S. Darwish" <darwish.07@gmail.com>
An: "Ralph Potztal" <ralph.potztal@espros.com>
CC: linux-can@vger.kernel.org
Gesendet: Donnerstag, 19. M=C3=A4rz 2015 16:31:52
Betreff: Re: Kvaser leaf light

Hi Ralph,

On Thu, Mar 19, 2015 at 03:32:48PM +0100, Ralph Potztal wrote:
>=20
> Hi there,=20
>=20
> I'm trying hard to setup the Kvaser Leaf Light HS v2 with SocketCan o=
n a Ubuntu 14.04.2 workstation. Unfortunately I failed so far and there=
for wanted to ask you, if you can give me some help.
>=20
> My goal is to use the leaf together with wireshark to spy a can bus i=
n one of our automated test systems.
>=20
> How I'm trying to set it up:
> - loading kernel modules:
> # modprobe can
> # modprobe can_raw
> # modprobe can_bcm
> # modprobe kvaser_usb
> # modprobe vcan
>=20
> - plug the leaf
>=20
> - check if the leaf is there:
> # lsusb
> Bus 001 Device 002: ID 0bfd:0120 Kvaser AB
>=20

Great, this USB device ID (288/0x120) is indeed supported by the
kvaser_usb module. It was added only in linux-3.16 though:

    https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/com=
mit/?id=3Db4f20130a

So, what is version of your kernel? A `uname -a' would be
quite helpful.

Thanks,
Darwish


--- Disclaimer: ---=20
This email and contents is for use only by the intended recipient. If y=
ou are not the individual or entity to whom it is addressed, you are he=
reby formally notified that any use, copying or distribution of this em=
ail and attachments, in whole or in part, is strictly prohibited. If yo=
u have received this email in error, please notify the sender and delet=
e the message and attachment(s) from your system. Any views, opinions o=
r information, expressed or contained in this email, are those of the s=
ender and not necessarily reflect those of ESPROS Photonics AG. To help=
 protect our environment, please avoid printing out this information un=
necessarily.
