From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: SocketCAN driver for USB2CAN converter (8 devices)
Date: Sat, 17 Nov 2012 10:37:09 +0100
Message-ID: <50A75AC5.4000503@grandegger.com>
References: <afad22f184c5b1bc8e833f5dc02d3b84.squirrel@webmail.universalnet.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:35816 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753110Ab2KQJha (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 17 Nov 2012 04:37:30 -0500
In-Reply-To: <afad22f184c5b1bc8e833f5dc02d3b84.squirrel@webmail.universalnet.at>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?ISO-8859-1?Q?Bernd_Krumb=F6ck?= <krumboeck@universalnet.at>
Cc: linux-can@vger.kernel.org

Hi Bernd,

On 11/17/2012 08:33 AM, "Bernd Krumb=F6ck" wrote:
> Hi!
>=20
> I'm developing a driver for the USB2CAN converter from "8 devices"
> (http://www.8devices.com/product/2/usb2can).
>=20
> At the moment the community seems to be very small, so I'm the only t=
ester
> and I have only this USB2CAN converter. Hope this situation will chan=
ge in
> future.

I think you need to communicate with another node on the CAN bus to
fully validate the functionality of the driver, especially to test
error state and bus-off handling.

> What must be done that this driver will become part of the kernel?

This is a good occasion to update our old "README.submitting-patches",
which I have attached below:

*********************************************************************
How to get your Linux-CAN changes into the mainline Linux kernel
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

If you have developed a Linux-CAN (aka Socket-CAN) driver patch which
is already mature in terms of functionality and code quality, you may
want to get it into the mainline kernel sooner than later.

Note that the GIT home of the Linux-CAN project is at gitorious.org [1]=
=2E
There you find the official the "can-utils" and also the "can-modules"
repository allowing to build *out-of-tree* Linux-CAN kernel modules
mainly useful for old kernel versions. Unfortunately, it is not well
maintained and pushing your changes mainline is clearly preferred.

Patches for kernel inclusion:
----------------------------

=46or kernel inclusion you should prepare patches against David Millers
"net-next-2.6" GIT tree, which you can get as shown below:

  $ git clone \
    git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next-2.6.gi=
t

In case you have a bug fix patch for a "-rcX" kernel release, you shoul=
d
use the GIT tree "net-2.6" instead.

Before publishing you should check the following items:

- Please ensure that the patches comply to the Linux coding style rules
  by reading the kernel's "Documentation/CodingStyle" and running the
  script "scripts/checkpatch.pl".

- The patch should contain a proper description and your "signed-off-by=
"
  line.

- Please use a prefix for the subject similar to the following:

  "[PATCH] flexcan: ..."

- Please add a version string to the subject for revised patches, e.g.:

  "[PATCH v2] flexcan: ..."

  It's also common practice to briefly describe the changes.

- Please send the patches *inline* and take care that your mail client
  does *not* white-space mangle the patch. "git-send-email" does a very
  good job, especially for a series of patches.

- "Documentation/SubmittingPatches" of the kernel tree contains further
  useful information.

The patch should finally be sent to "linux-can@vger.kernel.org" [4] and
maybe other related mailing lists, e.g. the Linux-USB mailing lists for
CAN USB drivers.

References:
----------

[1] http://gitorious.org/linux-can
[2] http://gitorious.org/linux-can/can-utils
[3] http://gitorious.org/linux-can/can-modules
[4] http://vger.kernel.org/majordomo-info.html
*********************************************************************

Comments on this HOWTO are welcome.

Wolfgang.
