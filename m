From: laurent vaudoit <laurent.vaudoit@gmail.com>
Subject: Re: Raw can socket close and disabling filters
Date: Mon, 25 Apr 2016 09:19:25 +0200
Message-ID: <CAA7hF3wiPi7ybKnpCcFGkQfED-gsZcn_Wahz2u+8Q01Z8-DN8Q@mail.gmail.com>
References: <loom.20160422T133332-34@post.gmane.org>
	<571B79AC.8000800@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-lb0-f193.google.com ([209.85.217.193]:35048 "EHLO
	mail-lb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751771AbcDYHT1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 25 Apr 2016 03:19:27 -0400
Received: by mail-lb0-f193.google.com with SMTP id mx9so8875620lbb.2
        for <linux-can@vger.kernel.org>; Mon, 25 Apr 2016 00:19:26 -0700 (PDT)
In-Reply-To: <571B79AC.8000800@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org

Hi Oliver,

On Sat, Apr 23, 2016 at 3:33 PM, Oliver Hartkopp <socketcan@hartkopp.ne=
t> wrote:
> Hi Laurent,
>
> On 04/22/2016 01:39 PM, laurent vaudoit wrote:
>
>> i'm using a 3.10 kernel with rtpatch applied, with raw can features.
>> Running some debug in the release function, i've seen something weir=
d (for
>> me).
>>
>> In the function, we get the socket informations
>> and then we unregister the notifier.
>>
>> After this, we test if the socket is bound and which is the ifindex.
>>
>> But when the unregister function is called, there is a call to the
>> notifier
>> with the event NETDEV_UNREGISTER, who leads to clear the socket
>> inforamtions
>> like bound and ifindex.
>>
>> So in the release function we can never enter in the code specific t=
o a
>> device.
>
>
> The relevant removal is protected by lock_sock().
>
> So when the notifier runs with NETDEV_UNREGISTER it will remove the f=
ilters
> & bind status.
>
> In this case the block in raw_release() won't have anything to do to =
release
> the filters and the bind state, right?

i agree with this. The fact is that on my setup i need to send an
information to another =C2=B5c when releasing a socket on a device, and=
 so
my specific code was done in the release function, after the
unregister.
This is how i've seen this behaviour.
>
> Looks double work - but I wonder why we can rely on a notifier call w=
hen we
> call unregister_netdevice_notifier() ??

=46or me, the disable_all_filter part of code in release can not be
called, as the ro->bound will allways be 0.
>
> Regards,
> Oliver
>

Regards
Laurent
