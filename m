From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] autotools: fix syntax error
Date: Thu, 03 Sep 2015 16:14:19 +0200
Message-ID: <55E855BB.7050104@hartkopp.net>
References: <1438963526-31603-1-git-send-email-yegorslists@googlemail.com> <CAGm1_kvHUgo3gs9vHkp8SqwwM2Z1Yc=CPF8tLWxMgLk0iViD7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:63649 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756596AbbICOOY (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 3 Sep 2015 10:14:24 -0400
In-Reply-To: <CAGm1_kvHUgo3gs9vHkp8SqwwM2Z1Yc=CPF8tLWxMgLk0iViD7w@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Yegor Yefremov <yegorslists@googlemail.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>

do it so do it so :-)

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

Tnx!

Oliver

On 09/03/2015 01:53 PM, Yegor Yefremov wrote:
> On Fri, Aug 7, 2015 at 6:05 PM,  <yegorslists@googlemail.com> wrote:
>> From: Yegor Yefremov <yegorslists@googlemail.com>
>>
>> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
>> ---
>>  configure.ac | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/configure.ac b/configure.ac
>> index 633ba81..8b50fb7 100644
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -20,7 +20,7 @@ AC_PROG_CC
>>  LT_INIT(win32-dll)
>>
>>  AM_INIT_AUTOMAKE([foreign no-exeext dist-bzip2])
>> -m4_ifdef([AM_SILENT_RULES], [AM_SILENT_RULES([yes]]))
>> +m4_ifdef([AM_SILENT_RULES], [AM_SILENT_RULES([yes])])
>>
>>  #
>>  # Checks for header files.
>> --
>> 2.1.4
>>
> 
> Ping?
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
