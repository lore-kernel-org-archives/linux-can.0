From: Michal Sojka <sojkam1@fel.cvut.cz>
Subject: Re: Standard CAN over IP
Date: Fri, 06 Feb 2015 09:33:36 +0100
Message-ID: <87a90r782n.fsf@steelpick.2x.cz>
References: <CACsJT9Nxv2Vuq92nnOw4eN6j-RycpqGRErsjp5R_LiMwdS13aQ@mail.gmail.com> <54D284B4.5050501@uni-bremen.de> <CACsJT9NuErtQOxTXffx=WYS5j6u8A-mv1XuA6Jxusn+tcDSRrw@mail.gmail.com> <54D2BE4E.7090202@optusnet.com.au> <CACsJT9NQGFKMBNjqh+C7pAAt=bcM4U4PL72sQYphAEPyeAxj8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from max.feld.cvut.cz ([147.32.192.36]:54848 "EHLO max.feld.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751568AbbBFIll convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 6 Feb 2015 03:41:41 -0500
In-Reply-To: <CACsJT9NQGFKMBNjqh+C7pAAt=bcM4U4PL72sQYphAEPyeAxj8g@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Mike Purvis <mpurvis@clearpathrobotics.com>, tom_usenet@optusnet.com.au
Cc: Armin Burchardt <armin@uni-bremen.de>, linux-can@vger.kernel.org, 'Pavel =?utf-8?B?UMOtxaFhJw==?= <pisa@cmp.felk.cvut.cz>

Hi Mike,

On Thu, Feb 05 2015, Mike Purvis wrote:
> Hi Tom,
>
> Yes, thanks=E2=80=94 in the short term, I'm going to prototype using =
an off
> the shelf USB-based device. In the fullness of time, I'll probably
> either implement the protocol myself as part of a larger MCU also
> doing some other stuff, or bring a BSD-licensed implementation of the
> protocol, if such a thing exists.
>
> Looks like you might be able to get CAN over TCP/UDP in two steps, by
> using socat to link a pty to the network socket, and then running
> slcand (or the guts of it) against the pty. Does anyone know what the
> efficiency story is with socat? Does it copy back and forth between
> between userspace and kernelspace, or is it able to operate fully in
> kernel-land the way slcand does?

Socat definitely copies everything over the user space.

In the past, we developed a kernel-based CAN-to-Ethernet gateway. See
http://rtime.felk.cvut.cz/can/can-eth-gw.pdf (the documentation is not
perfect). The kernel part is at
https://rtime.felk.cvut.cz/gitweb/can-eth-gw-linux.git/blob/HEAD:/net/c=
an/canethgw.c.
It would probably need minor updates for current kernels. The user spac=
e
part, which just configures the kernel to do its job, is at
https://rtime.felk.cvut.cz/gitweb/can-utils.git/blob/refs/heads/cegw:/c=
egw.c.

The kernel part was measured to be about 10% faster (on x86), but this
number depends on the architecture. System calls on modern x86 have les=
s
overhead than, for example, on PPC32.

Cheers,
-Michal
