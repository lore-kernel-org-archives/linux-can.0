From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Raw can socket close and disabling filters
Date: Mon, 25 Apr 2016 09:54:52 +0200
Message-ID: <571DCD4C.50601@hartkopp.net>
References: <loom.20160422T133332-34@post.gmane.org>
 <571B79AC.8000800@hartkopp.net>
 <CAA7hF3wiPi7ybKnpCcFGkQfED-gsZcn_Wahz2u+8Q01Z8-DN8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.218]:17459 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753805AbcDYHy5 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 25 Apr 2016 03:54:57 -0400
In-Reply-To: <CAA7hF3wiPi7ybKnpCcFGkQfED-gsZcn_Wahz2u+8Q01Z8-DN8Q@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: laurent vaudoit <laurent.vaudoit@gmail.com>
Cc: linux-can@vger.kernel.org

On 04/25/2016 09:19 AM, laurent vaudoit wrote:

>> So when the notifier runs with NETDEV_UNREGISTER it will remove the =
filters
>> & bind status.
>>
>> In this case the block in raw_release() won't have anything to do to=
 release
>> the filters and the bind state, right?
>
> i agree with this. The fact is that on my setup i need to send an
> information to another =C2=B5c when releasing a socket on a device, a=
nd so
> my specific code was done in the release function, after the
> unregister.

I think using raw_release() as trigger is always a good choice.

> This is how i've seen this behaviour.

Interesting information. I didn't know about the notifier running at=20
unregister_netdevice_notifier() time.

>> Looks double work - but I wonder why we can rely on a notifier call =
when we
>> call unregister_netdevice_notifier() ??
>
> For me, the disable_all_filter part of code in release can not be
> called, as the ro->bound will allways be 0.

The question remains whether we can really rely on the notifier call=20
which is obviously invoked by unregister_netdevice_notifier() ...
I'll have to dig if this behaviour is intentional and documented.
Until then I feel better to leave it as-is.

Regards,
Oliver
