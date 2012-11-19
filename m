From: =?iso-8859-1?Q?=22Bernd_Krumb=F6ck=22?= <krumboeck@universalnet.at>
Subject: Re: SocketCAN driver for USB2CAN converter (8 devices)
Date: Mon, 19 Nov 2012 08:38:14 +0100
Message-ID: <8debd5be2ec931afe49301e4893c1de0.squirrel@webmail.universalnet.at>
References: <afad22f184c5b1bc8e833f5dc02d3b84.squirrel@webmail.universalnet.at>
    <50A75AC5.4000503@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp.xy24.at ([85.126.109.136]:35478 "EHLO renate.xy24.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752819Ab2KSHiV (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 19 Nov 2012 02:38:21 -0500
In-Reply-To: <50A75AC5.4000503@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org

Hi Wolfgang!

Many thanks for the information. I will send a patch in about 2 months.

regards,
Bernd

> Hi Bernd,
>
> On 11/17/2012 08:33 AM, "Bernd Krumb=F6ck" wrote:
>> Hi!
>>
>> I'm developing a driver for the USB2CAN converter from "8 devices"
>> (http://www.8devices.com/product/2/usb2can).
>>
>> At the moment the community seems to be very small, so I'm the only
>> tester
>> and I have only this USB2CAN converter. Hope this situation will cha=
nge
>> in
>> future.
>
> I think you need to communicate with another node on the CAN bus to
> fully validate the functionality of the driver, especially to test
> error state and bus-off handling.
>
>> What must be done that this driver will become part of the kernel?
>
> This is a good occasion to update our old "README.submitting-patches"=
,
> which I have attached below:
>
> *********************************************************************
> How to get your Linux-CAN changes into the mainline Linux kernel
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> If you have developed a Linux-CAN (aka Socket-CAN) driver patch which
> is already mature in terms of functionality and code quality, you may
> want to get it into the mainline kernel sooner than later.
>
> Note that the GIT home of the Linux-CAN project is at gitorious.org [=
1].
> There you find the official the "can-utils" and also the "can-modules=
"
> repository allowing to build *out-of-tree* Linux-CAN kernel modules
> mainly useful for old kernel versions. Unfortunately, it is not well
> maintained and pushing your changes mainline is clearly preferred.
>
> Patches for kernel inclusion:
> ----------------------------
>
> For kernel inclusion you should prepare patches against David Millers
> "net-next-2.6" GIT tree, which you can get as shown below:
>
>   $ git clone \
>     git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next-2.6.=
git
>
> In case you have a bug fix patch for a "-rcX" kernel release, you sho=
uld
> use the GIT tree "net-2.6" instead.
>
> Before publishing you should check the following items:
>
> - Please ensure that the patches comply to the Linux coding style rul=
es
>   by reading the kernel's "Documentation/CodingStyle" and running the
>   script "scripts/checkpatch.pl".
>
> - The patch should contain a proper description and your "signed-off-=
by"
>   line.
>
> - Please use a prefix for the subject similar to the following:
>
>   "[PATCH] flexcan: ..."
>
> - Please add a version string to the subject for revised patches, e.g=
=2E:
>
>   "[PATCH v2] flexcan: ..."
>
>   It's also common practice to briefly describe the changes.
>
> - Please send the patches *inline* and take care that your mail clien=
t
>   does *not* white-space mangle the patch. "git-send-email" does a ve=
ry
>   good job, especially for a series of patches.
>
> - "Documentation/SubmittingPatches" of the kernel tree contains furth=
er
>   useful information.
>
> The patch should finally be sent to "linux-can@vger.kernel.org" [4] a=
nd
> maybe other related mailing lists, e.g. the Linux-USB mailing lists f=
or
> CAN USB drivers.
>
> References:
> ----------
>
> [1] http://gitorious.org/linux-can
> [2] http://gitorious.org/linux-can/can-utils
> [3] http://gitorious.org/linux-can/can-modules
> [4] http://vger.kernel.org/majordomo-info.html
> *********************************************************************
>
> Comments on this HOWTO are welcome.
>
> Wolfgang.
>

