From: Lehel Benedek <benedek.lehel@gmail.com>
Subject: Re: bind() Host is down listening on j1939 interfaces
Date: Wed, 16 Aug 2017 22:18:32 +0800
Message-ID: <CAJn4=pWXcvaXbZNxTmGj=8KV3RAWAwR7Hce7pb5jw7F=SGnrSQ@mail.gmail.com>
References: <CAJn4=pX9FczzJSFfQPQ3ghSv+T6Lj1SirSmVH1f8mrOXRux-dQ@mail.gmail.com>
 <20170816094029.GD32670@airbook.vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ua0-f173.google.com ([209.85.217.173]:35335 "EHLO
        mail-ua0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751466AbdHPOSd (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 16 Aug 2017 10:18:33 -0400
Received: by mail-ua0-f173.google.com with SMTP id d29so14345987uai.2
        for <linux-can@vger.kernel.org>; Wed, 16 Aug 2017 07:18:33 -0700 (PDT)
In-Reply-To: <20170816094029.GD32670@airbook.vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Lehel Benedek <benedek.lehel@gmail.com>, linux-can@vger.kernel.org, cosmo@iocurrents.com

Hi Kurt,

I've been using the j1939-v2.6.35 branch from git, and doesn't seem to
need enabling of the can-j1939 explicitly, and "ip link set can0 type
j1939" doesn't work, but "modprobe can-j1939" does work!

When running the TestJ1939 the protocol seems to activate
automatically (without needing to call modprobe):
[   66.741478] can: controller area network core (rev 20090105 abi 8)
[   66.754959] NET: Registered protocol family 29
[   66.787201] can: SAE J1939

however gets stuck on the bind call with EHOSTDOWN.

On Wed, Aug 16, 2017 at 5:40 PM, Kurt Van Dijck
<dev.kurt@vandijck-laurijssen.be> wrote:
> Hello,
>
>>
>> Hi all,
>>
>> I've found this message in the archives, and bringing this up because
>> I'm having this exact same issue as described below on a 2.6.35 kernel
>> on an imx53 board.
>> Have tried vcan or flexcan modules, both throwing the same EHOSTDOWN
>> error on binding.
>> However binding to a CAN_RAW socket is working as expected, no problems there.
>>
>> Haven't seen any replies to this issue, Cosmo have you managed to get around it?
>>
>> Any advice on how to troubleshoot this problem would be greatly appreciated.
>
> I assume that the code was still the old-style can-j1939 support, where
> you had to enable the can-j1939 per interface explicitely.
> I'll take a look this evening where the legacy documentation is exactly.
>
> Kurt
>
>>
>> Best regards,
>> Lehel
>>
>>
>> > > Hello,
>> > >
>> > > I'm having a bit of trouble getting the j1939 CAN support working on a Freescale \
>> > > i.MX6 UL.
>> > >
>> > > We are running Debian 3.14.52 kernel on armv7l patched with j1939 support as per \
>> > > http://elinux.org/J1939 and also compiled the latest can-utils from \
>> > > git://github.com/kurt-vd/can-utils and test-can-j1939.
>> > >
>> > > We have a real working can interface on can0 that we start like this:
>> > > root@dart3:~# ip link set can0 up type can bitrate 250000
>> > >
>> > > And also added a vcan interface for testing just in case:
>> > > root@dart3:~# ip link add can2 type vcan
>> > > root@dart3:~# ip link set can2 up
>> > >
>> > > root@dart3:~# ifconfig
>> > > can0      Link encap:UNSPEC  HWaddr 00-00-00-00-00-00-00-00-00-00-00-00-> > 00-00-00-00
>> > >          UP RUNNING NOARP  MTU:16  Metric:1
>> > >          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>> > >          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
>> > >          collisions:0 txqueuelen:10
>> > >          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
>> > >          Interrupt:142
>> > >
>> > > can2      Link encap:UNSPEC  HWaddr 00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00
>> > >          UP RUNNING NOARP  MTU:16  Metric:1
>> > >          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>> > >         TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
>> > >          collisions:0 txqueuelen:0
>> > >          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
>> > >
>> > > testj1939 cannot listen on either can0 or can2.  The error is: testj1939: bind(): \
>> > > Host is down
>> > >
>> > > root@dart3:~# testj1939 -r can0:
>> > > - socket(PF_CAN, SOCK_DGRAM, CAN_J1939);
>> > > - bind(, can0:,,, 24);
>> > > testj1939: bind(): Host is down
>> > >
>> > > root@dart3:~# testj1939 -r can2:
>> > > - socket(PF_CAN, SOCK_DGRAM, CAN_J1939);
>> > > - bind(, can2:,,, 24);
>> > > testj1939: bind(): Host is down
>> > >
>> > > I tested this same scenario on a Debian VM with 3.18 kernel and vcan and it worked \
>> > > fine.  Any suggestions?
