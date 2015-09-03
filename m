From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: [PATCH] autotools: fix syntax error
Date: Thu, 3 Sep 2015 14:56:39 +0200
Message-ID: <CAGm1_kvqD7JzyRqaZO7t+b9Ld_2nLb2MwvR7_6hw=0wGdK5n_g@mail.gmail.com>
References: <1438963526-31603-1-git-send-email-yegorslists@googlemail.com>
 <CAGm1_kvHUgo3gs9vHkp8SqwwM2Z1Yc=CPF8tLWxMgLk0iViD7w@mail.gmail.com> <55E83AA4.7010101@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-vk0-f44.google.com ([209.85.213.44]:35128 "EHLO
	mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751225AbbICM47 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 3 Sep 2015 08:56:59 -0400
Received: by vkaw128 with SMTP id w128so23583213vka.2
        for <linux-can@vger.kernel.org>; Thu, 03 Sep 2015 05:56:59 -0700 (PDT)
In-Reply-To: <55E83AA4.7010101@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Oliver Hartkopp <socketcan@hartkopp.net>

On Thu, Sep 3, 2015 at 2:18 PM, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 09/03/2015 01:53 PM, Yegor Yefremov wrote:
>> On Fri, Aug 7, 2015 at 6:05 PM,  <yegorslists@googlemail.com> wrote:
>>> From: Yegor Yefremov <yegorslists@googlemail.com>
>>>
>>> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
>>> ---
>>>  configure.ac | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/configure.ac b/configure.ac
>>> index 633ba81..8b50fb7 100644
>>> --- a/configure.ac
>>> +++ b/configure.ac
>>> @@ -20,7 +20,7 @@ AC_PROG_CC
>>>  LT_INIT(win32-dll)
>>>
>>>  AM_INIT_AUTOMAKE([foreign no-exeext dist-bzip2])
>>> -m4_ifdef([AM_SILENT_RULES], [AM_SILENT_RULES([yes]]))
>>> +m4_ifdef([AM_SILENT_RULES], [AM_SILENT_RULES([yes])])
>>>
>>>  #
>>>  # Checks for header files.
>>> --
>>> 2.1.4
>>>
>>
>> Ping?
>
> Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
>
> You have write access to the repo, don't you? :)

I do, but having  Acked-by is always good.

Yegor
