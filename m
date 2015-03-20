From: "Ahmed S. Darwish" <darwish.07@gmail.com>
Subject: Re: Kvaser leaf light
Date: Fri, 20 Mar 2015 09:52:38 +0200
Message-ID: <20150320075238.GA2387@Darwish.PC>
References: <20150319153152.GA2121@linux>
 <5474697.32.1426825696753.JavaMail.RPO@dhcp32-209.ch.epc>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:33588 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750801AbbCTHwn (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 20 Mar 2015 03:52:43 -0400
Received: by wgbcc7 with SMTP id cc7so82304465wgb.0
        for <linux-can@vger.kernel.org>; Fri, 20 Mar 2015 00:52:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5474697.32.1426825696753.JavaMail.RPO@dhcp32-209.ch.epc>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ralph Potztal <ralph.potztal@espros.com>
Cc: linux-can@vger.kernel.org

Hi Ralph,

[ Please do not top-post; it heavily breaks our ability to follow
  the logical sequence of a discussion thread. More details here:
  http://catb.org/jargon/html/T/top-post.html
  https://lkml.org/lkml/2005/1/11/111 ]

On Fri, Mar 20, 2015 at 05:28:21AM +0100, Ralph Potztal wrote:
>=20
> Hi Ahmed,=20
>=20
> thanks for this. I think that could be the problem, because:
>=20
> # uname -a
> Linux cli-48 3.13.0-46-generic #79-Ubuntu SMP Tue Mar 10 20:06:50 UTC=
 2015 x86_64 x86_64 x86_64 GNU/Linux
>=20

Great we've found the culprit. Now you have multiple possible
solutions:

1) Latest Ubuntu 14.04 LTS seems to offer a 3.16 kernel in a nicely
   packaged "sudo apt-get install" format:
   http://askubuntu.com/questions/506956/how-can-i-install-3-16-kernel-=
on-ubuntu-14-04

2) Manually install the latest 3.19.2 stable kernel, which includes
   support for your Kvaser model.

Keep in mind though that the kvaser_usb module has recently received
a large amount of fixes that's not yet included in the latest stable
kernels. So if you will use the device for continuous hours or plan
to have a heavy tx/rx traffic, you will definitely have to do one of
the following instead:

1) Temporarily use the 3.19.2 kernel, and quickly switch to v4.0
   once it is released. Better yet, directly use kernel v4.0-rc4
   where most of the necessary fixes are included:

   https://lkml.org/lkml/2015/3/15/180

2) I have a version of the driver at work, __with all the fixes__,
   ported for old Ubuntu and CentOS kernels.=20

   I can upload this version on a public website and send you the
   link on Sunday. But kindly note that this will be providied "AS IS",
   without any kind of support (you can *not* bother this mailing list
   about it), or any warranty of merchantability, implied or express.

3) At least port this single patche to your 3.19.2 kernel:

   [a] can: kvaser_usb: Read all messages in a bulk-in URB buffer
   http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commi=
t/?id=3D2fec5104f9c

Regards,
Darwish

>=20
> ----- Urspr=FCngliche Mail -----
> Von: "Ahmed S. Darwish" <darwish.07@gmail.com>
> An: "Ralph Potztal" <ralph.potztal@espros.com>
>=20
> Hi Ralph,
>=20
> On Thu, Mar 19, 2015 at 03:32:48PM +0100, Ralph Potztal wrote:
> >=20
> > Hi there,=20
> >=20
> > I'm trying hard to setup the Kvaser Leaf Light HS v2 with SocketCan=
 on a Ubuntu 14.04.2 workstation. Unfortunately I failed so far and the=
refor wanted to ask you, if you can give me some help.
> >=20
> > My goal is to use the leaf together with wireshark to spy a can bus=
 in one of our automated test systems.
> >=20
> > How I'm trying to set it up:
> > - loading kernel modules:
> > # modprobe can
> > # modprobe can_raw
> > # modprobe can_bcm
> > # modprobe kvaser_usb
> > # modprobe vcan
> >=20
> > - plug the leaf
> >=20
> > - check if the leaf is there:
> > # lsusb
> > Bus 001 Device 002: ID 0bfd:0120 Kvaser AB
> >=20
>=20
> Great, this USB device ID (288/0x120) is indeed supported by the
> kvaser_usb module. It was added only in linux-3.16 though:
>=20
>     https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/c=
ommit/?id=3Db4f20130a
>=20
> So, what is version of your kernel? A `uname -a' would be
> quite helpful.
>=20
> Thanks,
> Darwish
>=20
