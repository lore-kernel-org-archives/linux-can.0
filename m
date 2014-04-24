From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: (Case 14359) Kvaser socketCAN support
Date: Thu, 24 Apr 2014 09:46:21 +0200
Message-ID: <CAGm1_kuo9J1_0nPew_urkF-jh6Y0J0oFaW9QVZe4k4T0KqcVkg@mail.gmail.com>
References: <CAGm1_ks40c8SGE+BuokShMmOXkGk0PO4MF67N+jhYh+DBWnp6w@mail.gmail.com>
 <5357e7f5.c72de00a.4ba2.40ff@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:43729 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751775AbaDXHql (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 24 Apr 2014 03:46:41 -0400
Received: by mail-pd0-f169.google.com with SMTP id y13so734703pdi.28
        for <linux-can@vger.kernel.org>; Thu, 24 Apr 2014 00:46:41 -0700 (PDT)
In-Reply-To: <5357e7f5.c72de00a.4ba2.40ff@mx.google.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Kvaser Support <support@kvaser.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Olivier Sobrie <olivier@sobrie.be>

What about making a table with following columns:

1. driver module name
2. supported devices
3. kernel version, where all these devices are supported

*alternative variant*

1. device name
2. related driver module name
3. kernel version

*another alternative*

the central wiki page shows all modules as a list, each element of the
list opens a new page with following table:

1. device name (perhaps with a product link)
2. kernel version

Marc, Oliver what do you think?

Yegor

On Wed, Apr 23, 2014 at 6:19 PM, Kvaser Support <support@kvaser.com> wrote:
> The provided link covers chips and mentions ESD CAN Cards.  But I do not see any mention of Kvaser in the list.  So, on quick glance I thought it was a list of supported chips.
>
> Most people who purchase will be looking for product level names.  They rarely look in depth at the chip or clock used in the product.  They just want the card to work and are trying to confirm that a particular product works with socketcan.
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
> Date: Wed, 23 Apr 2014 09:48:45 +0200
> To: "Kvaser Support" <support@kvaser.com>
> Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "Olivier Sobrie" <olivier@sobrie.be>
> Subject: Re: (Case 14359) Kvaser socketCAN support
>
>>Hi Troy,
>>
>>What about this link
>>(http://elinux.org/CAN_Bus#SocketCAN_Supported_Controllers)?
>>
>>Linux distribution table i.e. Linux kernel version where not bad. I've
>>also thought about a list of Linux distors, that maintain can-utils,
>>libsocketcan etc.
>>
>>Yegor
>>
>>On Wed, Apr 23, 2014 at 9:38 AM, Kvaser Support <support@kvaser.com> wrote:
>>> Looking at the provided web page and associated links, I do not see:
>>> - a list of vendor supported/tested CAN hardware
>>> - the Linux distribution where this support was included.
>>>
>>> These are two basic questions that we get concerning socketcan.
>>>
>>> Best regards,
>>>
>>> Troy
>>> --
>>> Kvaser Support
>>> support@kvaser.com
>>> ---------------------------------------------------------------------------
>>>
>>>
>>>
>>>
