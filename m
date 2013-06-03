From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: Several sockets on one interface in Python
Date: Mon, 3 Jun 2013 09:20:30 +0200
Message-ID: <CAGm1_ktPetePWzz1Lv8mwg3+HVatTbhyZ_aiHRQ5Z3OtcZwzFQ@mail.gmail.com>
References: <51A87391.6010308@black-photon.de> <51A8D222.8000206@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bk0-f54.google.com ([209.85.214.54]:57434 "EHLO
	mail-bk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750999Ab3FCHUv (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 3 Jun 2013 03:20:51 -0400
Received: by mail-bk0-f54.google.com with SMTP id it19so177609bkc.27
        for <linux-can@vger.kernel.org>; Mon, 03 Jun 2013 00:20:50 -0700 (PDT)
In-Reply-To: <51A8D222.8000206@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Joachim Jaus <jaus@black-photon.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On Fri, May 31, 2013 at 6:38 PM, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> Hi Joachim,
>
> On 31.05.2013 11:55, Joachim Jaus wrote:
>> Hi all,
>> this is my first email to this list, therefore I want start with a big "thank
>> you" to all the people involved in the Linux CAN socket development, which has
>> opened up a lot of interesting possibilities for sensor and machine control
>> for me and my colleagues.
>
> Great! Mind-expansion without drugs but only through SocketCAN :-)
>
>>
>> We would like to bind several sockets with different filter settings to one
>> single CAN interface within the same application. Is that generally a safe
>> thing to do (both in C and in Python)?
>
> Yes, it's a safe thing to do.
>
> E.g. the candump programm does it in this way.
>
> You may create multiple sockets having each multiple filters.
>
> The only potential drawback that you need to put a select() statement around
> it, to manage to read from all created sockets/filedescriptors.
>
>> Is there a way to set filters on a CAN socket in Python similar to the
>> implementation in C?
>
> I don't know exactly.
> But "CAN_RAW_FILTER" is defined in the Python patch:
>
> http://bugs.python.org/file23234/socketcan_v5.patch
>
> http://libbits.wordpress.com/2012/05/22/socketcan-support-in-python/
>
> so you can hope that the filters are configurable in some way.
>
> Perhaps Yegor knows more about this.

No. Never tried filtering. Was just curious, how Python support feels
like, tried the example and wrote the blog entry. Joachim, please try
and share your experience. I'll then include this into our wiki:
http://elinux.org/Python_Can

You can also try to ask devs involved in this patch
creation/reviewing: http://bugs.python.org/issue10141

Yegor
