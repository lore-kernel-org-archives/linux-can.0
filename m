From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: [PATCH] slcan2d: add new slcan daemon
Date: Thu, 22 Aug 2013 09:12:01 +0200
Message-ID: <CAGm1_ktWEMsxt0VZb06Hhu_8y_vcMbQ5SsRahibZ2dg1v6J6Aw@mail.gmail.com>
References: <1373536496-17141-1-git-send-email-yegorslists@googlemail.com>
 <CAGm1_ktaO0C7sJVFJnCs0OOgfVSkJrk1f04ez5tE=H-Db6P-bA@mail.gmail.com>
 <CAGm1_ksLBm-uS9SiOx+cPHim0CLM6Zg65t4am-=kL_7qgH5-6Q@mail.gmail.com> <5214FCFC.3070404@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bk0-f50.google.com ([209.85.214.50]:58280 "EHLO
	mail-bk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753402Ab3HVHMW (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 22 Aug 2013 03:12:22 -0400
Received: by mail-bk0-f50.google.com with SMTP id mz11so521653bkb.23
        for <linux-can@vger.kernel.org>; Thu, 22 Aug 2013 00:12:21 -0700 (PDT)
In-Reply-To: <5214FCFC.3070404@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>

On Wed, Aug 21, 2013 at 7:46 PM, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> On 17.08.2013 21:01, Yegor Yefremov wrote:
>> On Wed, Jul 24, 2013 at 2:01 PM, Yegor Yefremov
>> <yegorslists@googlemail.com> wrote:
>>> Hi Marc, Oliver,
>>>
>>> On Thu, Jul 11, 2013 at 11:54 AM,  <yegorslists@googlemail.com> wrote:
>>>> From: Yegor Yefremov <yegorslists@googlemail.com>
>>>>
>>>> Cleaned up version of Oliver Hartkopp's effort with addition of
>>>> UART speed configuration.
>>>>
>>>> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
>>>
>>> any comments/suggestions?
>>
>> ping
>>
>
> Hi Yegor,
>
> sorry for my delayed response.
>
> I just got through your slcan2d by diffing it with the existing slcand.
>
> It's a cool cleanup and it adds all relevant command line options we know from
> slcan_attach.c & UART settings - i think that was the idea, right?

Yes. slcan_attach.c is almost obsolete now.

> As i can see there's no change of the functionality when the 'optional
> options' are not given on the command line.
>
> So why don't you just post a patch which makes the slcand your 'slcan2d' code?

You're right. I've reposted the patch as slcand with detailed
description, of what has really changed.

> IMHO having both the slcand and the slcan2d in the same repository does not
> make sense if they behave identical when having the same (empty) options.
>
> Or did I miss anything that slcand <tty> behaves different to slcan2d <tty> ??

ACK.

Yegor
