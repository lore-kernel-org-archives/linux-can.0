From: Mike Purvis <mpurvis@clearpathrobotics.com>
Subject: Re: Standard CAN over IP
Date: Mon, 9 Feb 2015 11:00:46 -0500
Message-ID: <CACsJT9P5w0J7a2htZLqd1EboET3FMYJ=_Hr86TChPBF-Y2rSvQ@mail.gmail.com>
References: <CACsJT9Nxv2Vuq92nnOw4eN6j-RycpqGRErsjp5R_LiMwdS13aQ@mail.gmail.com>
 <54D284B4.5050501@uni-bremen.de> <CACsJT9NuErtQOxTXffx=WYS5j6u8A-mv1XuA6Jxusn+tcDSRrw@mail.gmail.com>
 <54D2BE4E.7090202@optusnet.com.au> <CACsJT9NQGFKMBNjqh+C7pAAt=bcM4U4PL72sQYphAEPyeAxj8g@mail.gmail.com>
 <87a90r782n.fsf@steelpick.2x.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:35882 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933484AbbBIQBH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 9 Feb 2015 11:01:07 -0500
Received: by mail-ig0-f181.google.com with SMTP id hn18so17184076igb.2
        for <linux-can@vger.kernel.org>; Mon, 09 Feb 2015 08:01:07 -0800 (PST)
In-Reply-To: <87a90r782n.fsf@steelpick.2x.cz>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Michal Sojka <sojkam1@fel.cvut.cz>
Cc: tom_usenet@optusnet.com.au, Armin Burchardt <armin@uni-bremen.de>, linux-can@vger.kernel.org, =?UTF-8?B?UGF2ZWwgUMOtxaFh?= <pisa@cmp.felk.cvut.cz>

It's a bummer that N_SLCAN has no checksumming or validation built in
at all. Definitely suggests that SLCAN devices are meant more for
diagnostic/observational use than actual control. (And perhaps another
argument for wrapping the SLCAN tty stream in TCP or UDP).

Michal=E2=80=94 this work looks interesting. However, I'm probably not
interested in taking on an abandonware project. Was this ever
maintained/deployed anywhere, or was it purely an academic exercise?

Mike

On 6 February 2015 at 03:33, Michal Sojka <sojkam1@fel.cvut.cz> wrote:
> Hi Mike,
>
> On Thu, Feb 05 2015, Mike Purvis wrote:
>> Hi Tom,
>>
>> Yes, thanks=E2=80=94 in the short term, I'm going to prototype using=
 an off
>> the shelf USB-based device. In the fullness of time, I'll probably
>> either implement the protocol myself as part of a larger MCU also
>> doing some other stuff, or bring a BSD-licensed implementation of th=
e
>> protocol, if such a thing exists.
>>
>> Looks like you might be able to get CAN over TCP/UDP in two steps, b=
y
>> using socat to link a pty to the network socket, and then running
>> slcand (or the guts of it) against the pty. Does anyone know what th=
e
>> efficiency story is with socat? Does it copy back and forth between
>> between userspace and kernelspace, or is it able to operate fully in
>> kernel-land the way slcand does?
>
> Socat definitely copies everything over the user space.
>
> In the past, we developed a kernel-based CAN-to-Ethernet gateway. See
> http://rtime.felk.cvut.cz/can/can-eth-gw.pdf (the documentation is no=
t
> perfect). The kernel part is at
> https://rtime.felk.cvut.cz/gitweb/can-eth-gw-linux.git/blob/HEAD:/net=
/can/canethgw.c.
> It would probably need minor updates for current kernels. The user sp=
ace
> part, which just configures the kernel to do its job, is at
> https://rtime.felk.cvut.cz/gitweb/can-utils.git/blob/refs/heads/cegw:=
/cegw.c.
>
> The kernel part was measured to be about 10% faster (on x86), but thi=
s
> number depends on the architecture. System calls on modern x86 have l=
ess
> overhead than, for example, on PPC32.
>
> Cheers,
> -Michal
