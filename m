From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re:
Date: Wed, 8 May 2013 10:11:06 +0200
Message-ID: <CAGm1_kvQoiFAotYRuA=DGBTuOfLmUbHgn2DZ-6TE+wRBmCqW+A@mail.gmail.com>
References: <CANdmM3MFEe-iXinRohUN9rEF-C2CoEg1va=nE7W-=KThogz7sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bk0-f43.google.com ([209.85.214.43]:46232 "EHLO
	mail-bk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752368Ab3EHIL2 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 8 May 2013 04:11:28 -0400
Received: by mail-bk0-f43.google.com with SMTP id jm19so718401bkc.2
        for <linux-can@vger.kernel.org>; Wed, 08 May 2013 01:11:27 -0700 (PDT)
In-Reply-To: <CANdmM3MFEe-iXinRohUN9rEF-C2CoEg1va=nE7W-=KThogz7sg@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: kedari appana <kedare06@gmail.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>

On Wed, May 8, 2013 at 8:25 AM, kedari appana <kedare06@gmail.com> wrote:
> Hi,
>
>  if i type the below command i am getting the following errors
> # ip link show can0
> 2: can0: <NOARP40000> mtu 16 qdisc noop qlen 10
>     link/[280]
> #cat /proc/interrupts
> in this i am not getting entry for my can interrupt handler
> #./canconfig can0 bitrate 50000 ctrlmode triple-sampling on
> this command was successfull but when i debugging it is showing  can0:
> bit-timing not yet defined
>
> #If i use ifconfig can0 up
> error is can0: bit-timing not yet defined
> ifconfig: SIOCSIFFLAGS: Invalid argument
> Please help me what is the problem.

In this thread there is a presentation slides for iproute2 and
canutils cross-compilation:
http://e2e.ti.com/support/arm/sitara_arm/f/791/p/154560/899055.aspx.
Presentation file is
d_can_on_Beaglebone.pptx.

Or just take http://buildroot.uclibc.org/ and create your rootfs with
it. can-utils and iproute2 (must be explicitly activated to disable
the one from BusyBox, that AFAIK doesn't support CAN routines) are
already there.

Yegor
