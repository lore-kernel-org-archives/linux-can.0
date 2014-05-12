From: =?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>
Subject: Re: [Qemu-devel] [PATCH 1/2] CAN bus simple SJA1000 PCI card emulation
 for QEMU
Date: Mon, 12 May 2014 11:18:09 +0200
Message-ID: <537091D1.4080004@suse.de>
References: <201405092010.19482.pisa@cmp.felk.cvut.cz>	<201405092014.32116.pisa@cmp.felk.cvut.cz> <CAEgOgz7sCAWuyVFOR94omp=2DEpisio+nUQDWBCzq3e-Y_WCVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:52579 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755482AbaELJSN (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 12 May 2014 05:18:13 -0400
In-Reply-To: <CAEgOgz7sCAWuyVFOR94omp=2DEpisio+nUQDWBCzq3e-Y_WCVw@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Peter Crosthwaite <peter.crosthwaite@xilinx.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Oliver Hartkopp A <socketcan@hartkopp.net>, jinyang.sia@gmail.com, Stefan Weil <sw@weilnetz.de>, rtems-devel@rtems.org, linux-can@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Am 12.05.2014 11:01, schrieb Peter Crosthwaite:
> On Sat, May 10, 2014 at 4:14 AM, Pavel Pisa <pisa@cmp.felk.cvut.cz> w=
rote:
>> The work is based on Jin Yang GSoC 2013 work funded
>> by Google and mentored in frame of RTEMS project GSoC
>> slot donated to QEMU.

Should/can that be recorded in form of his Signed-off-by before yours?

>> Update from QEMU-1.4 version and architecture cleanup
>> by Pavel Pisa (Czech Technical University in Prague).
>>
>> The core SJA1000 support is independent of provided
>> PCI board. The simple core CAN bus infrastructure
>> is independent as well.
>>
>> Connection to the real host CAN bus network through
>> SocketCAN network interface is available for Linux
>> host system as well.
>>
>> Signed-off-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
>> ---
>>  default-configs/pci.mak |   2 +
>>  hw/net/Makefile.objs    |   4 +
>>  hw/net/can_core.c       | 350 +++++++++++++++++++
>>  hw/net/can_pci.c        | 238 +++++++++++++
>>  hw/net/can_sja1000.c    | 878 +++++++++++++++++++++++++++++++++++++=
+++++++++++
>>  hw/net/can_sja1000.h    | 163 +++++++++
>>  include/net/can_emu.h   | 123 +++++++
>>  7 files changed, 1758 insertions(+)
>=20
> That's a big patch. And it seems to add a new API/framework, then new
> users of that API. Can you add your core as a single patch, then
> incrementally bring your devices stuff as subsequent patches? My gues=
s
> is this should be about 3 patches - are there any circular deps,
> requiring you to bring your three c files all at once or is there a
> logical order you can add them for ease of review?

True. But before you resend, I'd like to hear Stefan H.'s view of
whether CAN should go into hw/net/ at all or into, e.g., hw/can/.

Independently of the placement, it's always an interesting question of
who will maintain this new infrastructure - I don't see any new
MAINTAINERS entries getting added in either patch (NB: a diffstat in 0/=
2
would've been nice) for patch review.

Regards,
Andreas

--=20
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend=C3=B6rffer; HRB 16746 AG N=C3=
=BCrnberg
