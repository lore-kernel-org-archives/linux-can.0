From: Peter Crosthwaite <peter.crosthwaite@xilinx.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] CAN bus simple SJA1000 PCI card
 emulation for QEMU
Date: Mon, 12 May 2014 19:01:52 +1000
Message-ID: <CAEgOgz7sCAWuyVFOR94omp=2DEpisio+nUQDWBCzq3e-Y_WCVw@mail.gmail.com>
References: <201405092010.19482.pisa@cmp.felk.cvut.cz>
	<201405092014.32116.pisa@cmp.felk.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ve0-f171.google.com ([209.85.128.171]:47590 "EHLO
	mail-ve0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750778AbaELJBx (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 12 May 2014 05:01:53 -0400
Received: by mail-ve0-f171.google.com with SMTP id oz11so8495156veb.30
        for <linux-can@vger.kernel.org>; Mon, 12 May 2014 02:01:53 -0700 (PDT)
In-Reply-To: <201405092014.32116.pisa@cmp.felk.cvut.cz>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Oliver Hartkopp A <socketcan@hartkopp.net>, jinyang.sia@gmail.com, Stefan Weil <sw@weilnetz.de>, rtems-devel@rtems.org, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, linux-can@vger.kernel.org

Hi Pavel,

On Sat, May 10, 2014 at 4:14 AM, Pavel Pisa <pisa@cmp.felk.cvut.cz> wrote:
> The work is based on Jin Yang GSoC 2013 work funded
> by Google and mentored in frame of RTEMS project GSoC
> slot donated to QEMU.
>
> Update from QEMU-1.4 version and architecture cleanup
> by Pavel Pisa (Czech Technical University in Prague).
>
> The core SJA1000 support is independent of provided
> PCI board. The simple core CAN bus infrastructure
> is independent as well.
>
> Connection to the real host CAN bus network through
> SocketCAN network interface is available for Linux
> host system as well.
>
> Signed-off-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
> ---
>  default-configs/pci.mak |   2 +
>  hw/net/Makefile.objs    |   4 +
>  hw/net/can_core.c       | 350 +++++++++++++++++++
>  hw/net/can_pci.c        | 238 +++++++++++++
>  hw/net/can_sja1000.c    | 878 ++++++++++++++++++++++++++++++++++++++++++++++++
>  hw/net/can_sja1000.h    | 163 +++++++++
>  include/net/can_emu.h   | 123 +++++++
>  7 files changed, 1758 insertions(+)

That's a big patch. And it seems to add a new API/framework, then new
users of that API. Can you add your core as a single patch, then
incrementally bring your devices stuff as subsequent patches? My guess
is this should be about 3 patches - are there any circular deps,
requiring you to bring your three c files all at once or is there a
logical order you can add them for ease of review?

Regards,
Peter
