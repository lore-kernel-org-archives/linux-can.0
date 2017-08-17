From: Lehel Benedek <benedek.lehel@gmail.com>
Subject: Re: bind() Host is down listening on j1939 interfaces
Date: Thu, 17 Aug 2017 23:26:18 +0800
Message-ID: <CAJn4=pVtnj6LBvLnAjabuv3Fm2G9d5NUoQ3wHRCDAzB90o4Zmg@mail.gmail.com>
References: <CAJn4=pX9FczzJSFfQPQ3ghSv+T6Lj1SirSmVH1f8mrOXRux-dQ@mail.gmail.com>
 <20170816094029.GD32670@airbook.vandijck-laurijssen.be> <CAJn4=pWXcvaXbZNxTmGj=8KV3RAWAwR7Hce7pb5jw7F=SGnrSQ@mail.gmail.com>
 <20170816212827.GG32670@airbook.vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ua0-f179.google.com ([209.85.217.179]:34088 "EHLO
        mail-ua0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752176AbdHQP0T (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 17 Aug 2017 11:26:19 -0400
Received: by mail-ua0-f179.google.com with SMTP id q25so26025063uah.1
        for <linux-can@vger.kernel.org>; Thu, 17 Aug 2017 08:26:19 -0700 (PDT)
In-Reply-To: <20170816212827.GG32670@airbook.vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Lehel Benedek <benedek.lehel@gmail.com>, linux-can@vger.kernel.org, cosmo@iocurrents.com

Hi Kurt,

Thank you for the information, and for all your work on the J1939
implementation in the kernel.

I've followed your advice and recompiled the kernel with the
j1939-iproute2 and that did the trick, TestJ1939 is working now.

Initially I thought that the message: "can: SAE J1939" was indicating
that the interface has activated, but not really.
The "ip link set can0 type j1939" (mentioned on the TestJ1939 git) was
not working because of the missing j1939-iproute2, same goes for the
bind error.

Thanks again!

Best regards,
Lehel

On Thu, Aug 17, 2017 at 5:28 AM, Kurt Van Dijck
<dev.kurt@vandijck-laurijssen.be> wrote:
> Hey,
>
>> Hi Kurt,
>>
>> I've been using the j1939-v2.6.35 branch from git,
> That's old, but was supported.
>
>> and doesn't seem to
>> need enabling of the can-j1939 explicitly,
> How did you conclude that?
>
>> and "ip link set can0 type j1939" doesn't work,
> Where did you find this command?
>
>> but "modprobe can-j1939" does work!
>>
>> When running the TestJ1939 the protocol seems to activate
>> automatically (without needing to call modprobe):
>> [   66.741478] can: controller area network core (rev 20090105 abi 8)
>> [   66.754959] NET: Registered protocol family 29
>> [   66.787201] can: SAE J1939
>>
>> however gets stuck on the bind call with EHOSTDOWN.
>
> [...]
>
>> > I'll take a look this evening where the legacy documentation is exactly.
>
> Please find relevant documentation for your version of can-j1939 support
> at http://elinux.org/index.php?title=J1939&oldid=378716
> I realize there is no real way you could have determined this yourself :-)
> Anyway, if you follow this guid, it should bring you way further.
>
> Kind regards,
> Kurt
>
