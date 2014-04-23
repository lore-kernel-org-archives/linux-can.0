From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: (Case 14359) Kvaser socketCAN support
Date: Wed, 23 Apr 2014 09:48:45 +0200
Message-ID: <CAGm1_ks40c8SGE+BuokShMmOXkGk0PO4MF67N+jhYh+DBWnp6w@mail.gmail.com>
References: <CAGm1_kuvZx7uoGTYbwDkWh1NAHNxUeDpn=2nnojvaOH17eh7pA@mail.gmail.com>
 <53576dee.0770e00a.185d.04ca@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-pb0-f54.google.com ([209.85.160.54]:34024 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753938AbaDWHtG (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 23 Apr 2014 03:49:06 -0400
Received: by mail-pb0-f54.google.com with SMTP id ma3so524745pbc.13
        for <linux-can@vger.kernel.org>; Wed, 23 Apr 2014 00:49:05 -0700 (PDT)
In-Reply-To: <53576dee.0770e00a.185d.04ca@mx.google.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Kvaser Support <support@kvaser.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Olivier Sobrie <olivier@sobrie.be>

Hi Troy,

What about this link
(http://elinux.org/CAN_Bus#SocketCAN_Supported_Controllers)?

Linux distribution table i.e. Linux kernel version where not bad. I've
also thought about a list of Linux distors, that maintain can-utils,
libsocketcan etc.

Yegor

On Wed, Apr 23, 2014 at 9:38 AM, Kvaser Support <support@kvaser.com> wrote:
> Looking at the provided web page and associated links, I do not see:
> - a list of vendor supported/tested CAN hardware
> - the Linux distribution where this support was included.
>
> These are two basic questions that we get concerning socketcan.
>
> Best regards,
>
> Troy
> --
> Kvaser Support
> support@kvaser.com
> ---------------------------------------------------------------------------
>
>
>
> -----Original Message-----
> From: "Yegor Yefremov" <yegorslists@googlemail.com>
> Reply-To: "Yegor Yefremov" <yegorslists@googlemail.com>
> Date: Tue, 22 Apr 2014 07:54:31 +0200
> To: "Kvaser Support" <support@kvaser.com>
> Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "Olivier Sobrie" <olivier@sobrie.be>
> Subject: Re: (Case 14359) Kvaser socketCAN support
>
>>On Tue, Apr 22, 2014 at 2:40 AM, Kvaser Support <support@kvaser.com> wrote:
>>> Thanks for the information Oliver.
>>>
>>> Is there a good location for us to point to that would list the current hardware supported by Socketcan and the version of Linux needed for that support?  A site that is kept up to date?
>>>
>>> I am looking for something that we could put in a FAQ on our website that point people using socketcan in the correct direction.
>>
>>Try http://elinux.org/CAN_Bus
>>
>>The wiki could definitely get more care, but from time to time we update it.
>>
>>Regards,
>>Yegor
>>
>>> ---------------------------------------------------------------------------
>>>
>>>
>>>
>>>
