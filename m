From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: SocketCAN: Matlab support
Date: Mon, 19 May 2014 16:17:50 +0200
Message-ID: <CAGm1_ks89UjyXrXsO4MewvafDZuag1DwBrHspv+SENgvEoQe3g@mail.gmail.com>
References: <CAGm1_ktOSQwWgmoZFuBtn0+hJ4zWiEs7iukzEZoQJWNu+zeDHA@mail.gmail.com>
 <201405191606.15857.pisa@cmp.felk.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:55573 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751630AbaESOSM (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 19 May 2014 10:18:12 -0400
Received: by mail-lb0-f172.google.com with SMTP id l4so4115177lbv.17
        for <linux-can@vger.kernel.org>; Mon, 19 May 2014 07:18:10 -0700 (PDT)
In-Reply-To: <201405191606.15857.pisa@cmp.felk.cvut.cz>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Michal Sojka <sojkam1@fel.cvut.cz>

Hi Pavel,

thanks for the info. Will look into it.

Best regards,
Yegor

On Mon, May 19, 2014 at 4:06 PM, Pavel Pisa <pisa@cmp.felk.cvut.cz> wrote:
> Hello Yegor,
>
> we have some experience there with Simulink on Linux
> with fully preemptive-kernel there at CTU.
>
> Mainly my colleague, Michal Sojka, and his students work
> on Simulink embedded coded support. CAN blockset
> for embedded Cortex-R4 system is expected to be finished
> in next two or three months. This work is part
> of our TMS570LS3137 Simulink support.
>
>  http://rtime.felk.cvut.cz/rpp-tms570/
>
> When we have CAN support compliant to the common
> Simulink CAN blocks rules implemented for this target
> we expect to port that implementation to SocketCAN
> and integrate it with our Linux Target for Simulink
> Embedded Coder project
>
>   http://lintarget.sourceforge.net/
>
> So that is our actual state of progress in this
> area. We would be happy to find others with
> interrest in similar projects.
>
> Best wishes,
>
>              Pavel Pisa
>
> On Friday 16 of May 2014 12:14:45 Yegor Yefremov wrote:
>> Has anyone experience with Matlab and SocketCAN? So far I couldn't
>> find anything usable via Google.
>>
>> Regards,
>> Yegor
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-can" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
