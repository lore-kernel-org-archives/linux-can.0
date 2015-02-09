From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Standard CAN over IP
Date: Mon, 09 Feb 2015 19:32:02 +0100
Message-ID: <54D8FD22.8030903@hartkopp.net>
References: <CACsJT9Nxv2Vuq92nnOw4eN6j-RycpqGRErsjp5R_LiMwdS13aQ@mail.gmail.com> <54D284B4.5050501@uni-bremen.de> <CACsJT9NuErtQOxTXffx=WYS5j6u8A-mv1XuA6Jxusn+tcDSRrw@mail.gmail.com> <54D2BE4E.7090202@optusnet.com.au> <CACsJT9NQGFKMBNjqh+C7pAAt=bcM4U4PL72sQYphAEPyeAxj8g@mail.gmail.com> <87a90r782n.fsf@steelpick.2x.cz> <CACsJT9P5w0J7a2htZLqd1EboET3FMYJ=_Hr86TChPBF-Y2rSvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:25182 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932330AbbBIScS (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 9 Feb 2015 13:32:18 -0500
In-Reply-To: <CACsJT9P5w0J7a2htZLqd1EboET3FMYJ=_Hr86TChPBF-Y2rSvQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Mike Purvis <mpurvis@clearpathrobotics.com>, Michal Sojka <sojkam1@fel.cvut.cz>
Cc: tom_usenet@optusnet.com.au, Armin Burchardt <armin@uni-bremen.de>, linux-can@vger.kernel.org, =?UTF-8?B?UGF2ZWwgUMOtxaFh?= <pisa@cmp.felk.cvut.cz>

Hi all,

yes it was an academic approach to check how to route CAN frames via UD=
P=20
inside the kernel (and do some performance measurements too).

The main problem was the missing 'standard' configuration possibility o=
f UDP=20
connections to establish the UDP/IP link without an user space applicat=
ion.

So I wonder if it would make sense to add some (small) CAN specific cod=
e to be=20
able to use the new 'Foo over UDP' support which has been added to the =
3.18=20
Kernel recently:

http://lwn.net/Articles/614348/

Tom Herbert created some pretty generic configuration interface to esta=
blish=20
UDP sockets inside the kernel.

Regards,
Oliver

On 09.02.2015 17:00, Mike Purvis wrote:
> It's a bummer that N_SLCAN has no checksumming or validation built in
> at all. Definitely suggests that SLCAN devices are meant more for
> diagnostic/observational use than actual control. (And perhaps anothe=
r
> argument for wrapping the SLCAN tty stream in TCP or UDP).
>
> Michal=E2=80=94 this work looks interesting. However, I'm probably no=
t
> interested in taking on an abandonware project. Was this ever
> maintained/deployed anywhere, or was it purely an academic exercise?
>
> Mike
>
> On 6 February 2015 at 03:33, Michal Sojka <sojkam1@fel.cvut.cz> wrote=
:
>> Hi Mike,
>>
>> On Thu, Feb 05 2015, Mike Purvis wrote:
>>> Hi Tom,
>>>
>>> Yes, thanks=E2=80=94 in the short term, I'm going to prototype usin=
g an off
>>> the shelf USB-based device. In the fullness of time, I'll probably
>>> either implement the protocol myself as part of a larger MCU also
>>> doing some other stuff, or bring a BSD-licensed implementation of t=
he
>>> protocol, if such a thing exists.
>>>
>>> Looks like you might be able to get CAN over TCP/UDP in two steps, =
by
>>> using socat to link a pty to the network socket, and then running
>>> slcand (or the guts of it) against the pty. Does anyone know what t=
he
>>> efficiency story is with socat? Does it copy back and forth between
>>> between userspace and kernelspace, or is it able to operate fully i=
n
>>> kernel-land the way slcand does?
>>
>> Socat definitely copies everything over the user space.
>>
>> In the past, we developed a kernel-based CAN-to-Ethernet gateway. Se=
e
>> http://rtime.felk.cvut.cz/can/can-eth-gw.pdf (the documentation is n=
ot
>> perfect). The kernel part is at
>> https://rtime.felk.cvut.cz/gitweb/can-eth-gw-linux.git/blob/HEAD:/ne=
t/can/canethgw.c.
>> It would probably need minor updates for current kernels. The user s=
pace
>> part, which just configures the kernel to do its job, is at
>> https://rtime.felk.cvut.cz/gitweb/can-utils.git/blob/refs/heads/cegw=
:/cegw.c.
>>
>> The kernel part was measured to be about 10% faster (on x86), but th=
is
>> number depends on the architecture. System calls on modern x86 have =
less
>> overhead than, for example, on PPC32.
>>
>> Cheers,
>> -Michal
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
