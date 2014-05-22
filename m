From: Maxime Jayat <maxime@artisandeveloppeur.fr>
Subject: Re: Kernel Oops when setting j1939 device on
Date: Thu, 22 May 2014 11:57:28 +0200
Message-ID: <537DCA08.4040000@artisandeveloppeur.fr>
References: <CAJdBzeATNb2pBOdp5bpx86Bw+K00wYwjgFOuRGbtZSPXvMoBuQ@mail.gmail.com> <20140520201654.GD25701@vandijck-laurijssen.be> <CAJdBzeBEL=pz4imZvywVwZsjj3o7Gh6JshgKrm3aSbYOjMiZ6Q@mail.gmail.com> <20140521191215.GA581@vandijck-laurijssen.be> <CAJdBzeA8=UVGa0yR2AUexEJjhtcd16P=iwdoM8+MqM=UHvfdCw@mail.gmail.com> <20140522092927.GA23173@vandijck-laurijssen.be>
Reply-To: maxime@artisandeveloppeur.fr
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-we0-f170.google.com ([74.125.82.170]:39586 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751993AbaEVJ5c (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 22 May 2014 05:57:32 -0400
Received: by mail-we0-f170.google.com with SMTP id u57so3278110wes.15
        for <linux-can@vger.kernel.org>; Thu, 22 May 2014 02:57:31 -0700 (PDT)
In-Reply-To: <20140522092927.GA23173@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Timothy Vieregge <tvieregge@clearpathrobotics.com>, linux-can@vger.kernel.org, Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>

Le 22/05/2014 11:29, Kurt Van Dijck a =C3=A9crit :
> On Wed, May 21, 2014 at 05:01:44PM -0400, Timothy Vieregge wrote:
>> On Wed, May 21, 2014 at 3:12 PM, Kurt Van Dijck
>> <dev.kurt@vandijck-laurijssen.be> wrote:
>>> Hey Timothy,
>>>
>>> On Tue, May 20, 2014 at 04:46:10PM -0400, Timothy Vieregge wrote:
> [...]
>>>>
>>>> I didn't specifically replace any of the modules, I simply loaded =
the
>>>> ones that were present in the custom kernel (can, vcan and can_raw=
).
>>>
>>> 1. did you "insmod xxx" or "modprobe xxx"
>>> 2. Didn't you load can-j1939?
>>
>> I used modprobe.
>>
>> I did not. Unsurprisingly that fixed my problems.
>> I'll update the elinux wiki slightly once I have access. That should
>> avoid some of
>> the questions like this in the future.
>=20
> That is a fine idea.
> Anyway, 'ip link set vcan0 j1939 on' should return with something
> like 'protocol not supported', as does my system, until you manually
> load can-j1939.
>=20
> loading can-j1939 automatically did not work due to the netlink locks=
=2E
>=20
> Kind regards,
> Kurt

Hi Timothy and Kurt,

I've hit the same problem as Timothy in the past. I've looked into it
and the reason for it is that the code in
https://gitorious.org/linux-can/linux-can-j1939/source/j1939-v3.8:net/c=
an/af_can.c#L1020-1041
is different from the code in
https://gitorious.org/linux-can/can-j1939-modules/source/master:net/can=
/af_can.c#L1169
and the former still has a bug that is fixed in the latter in can_valid=
ate_link_af.

In particular:
		cp =3D can_get_proto(nla_type(prot));
		if (!cp || !cp->rtnl_link_ops)
			ret =3D -EPROTONOSUPPORT;
		else if (!cp->rtnl_link_ops->validate_link_af)
			ret =3D 0;
		else
			ret =3D cp->rtnl_link_ops->validate_link_af(dev, prot);
		can_put_proto(cp);
		if (ret < 0)
			return ret;

doesn't end well for can_put_proto when can_get_proto returns NULL.

I find it not very clear to see what is the most up-to-date repo for J1=
939
and whether all the branches in linux-can-j1939 are supposed to be main=
tained
along with can-j1939-modules.
And the terrible commit history view of gitorious doesn't help.

--=20
Maxime Jayat

