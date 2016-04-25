From: laurent vaudoit <laurent.vaudoit@gmail.com>
Subject: Re: Raw can socket close and disabling filters
Date: Mon, 25 Apr 2016 09:57:48 +0200
Message-ID: <CAA7hF3zUvYuPj5By5pFcKZGE2wPx7RBSRqC_NrV9gdoSCsgZzw@mail.gmail.com>
References: <loom.20160422T133332-34@post.gmane.org>
	<571B79AC.8000800@hartkopp.net>
	<CAA7hF3wiPi7ybKnpCcFGkQfED-gsZcn_Wahz2u+8Q01Z8-DN8Q@mail.gmail.com>
	<571DCD4C.50601@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-lb0-f196.google.com ([209.85.217.196]:33897 "EHLO
	mail-lb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752231AbcDYH5u convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 25 Apr 2016 03:57:50 -0400
Received: by mail-lb0-f196.google.com with SMTP id w1so8987110lbl.1
        for <linux-can@vger.kernel.org>; Mon, 25 Apr 2016 00:57:49 -0700 (PDT)
In-Reply-To: <571DCD4C.50601@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org

On Mon, Apr 25, 2016 at 9:54 AM, Oliver Hartkopp <socketcan@hartkopp.ne=
t> wrote:
> On 04/25/2016 09:19 AM, laurent vaudoit wrote:
>
>>> So when the notifier runs with NETDEV_UNREGISTER it will remove the
>>> filters
>>> & bind status.
>>>
>>> In this case the block in raw_release() won't have anything to do t=
o
>>> release
>>> the filters and the bind state, right?
>>
>>
>> i agree with this. The fact is that on my setup i need to send an
>> information to another =C2=B5c when releasing a socket on a device, =
and so
>> my specific code was done in the release function, after the
>> unregister.
>
>
> I think using raw_release() as trigger is always a good choice.
>
>> This is how i've seen this behaviour.
>
>
> Interesting information. I didn't know about the notifier running at
> unregister_netdevice_notifier() time.
>
>>> Looks double work - but I wonder why we can rely on a notifier call=
 when
>>> we
>>> call unregister_netdevice_notifier() ??
>>
>>
>> For me, the disable_all_filter part of code in release can not be
>> called, as the ro->bound will allways be 0.
>
>
> The question remains whether we can really rely on the notifier call =
which
> is obviously invoked by unregister_netdevice_notifier() ...
> I'll have to dig if this behaviour is intentional and documented.
> Until then I feel better to leave it as-is.
>

Ok, i will adapt my specific code, as i know this is not a weird
behaviour due to rtpatch or to my specificity.
Thanks
> Regards,
> Oliver

Regards
Laurent
