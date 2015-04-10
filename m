From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: [PATCH] canplayer: convert skipgap to unsigned long
Date: Fri, 10 Apr 2015 11:33:23 +0200
Message-ID: <CAGm1_kvDgV5Dr4u=kxEQNntf6tBPUh4+ZEv5kw5ebnAnv4m5jQ@mail.gmail.com>
References: <1428613281-21827-1-git-send-email-yegorslists@googlemail.com> <552797E7.9000304@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:36374 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754517AbbDJJdp (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 10 Apr 2015 05:33:45 -0400
Received: by pabsx10 with SMTP id sx10so16448031pab.3
        for <linux-can@vger.kernel.org>; Fri, 10 Apr 2015 02:33:44 -0700 (PDT)
In-Reply-To: <552797E7.9000304@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On Fri, Apr 10, 2015 at 11:29 AM, Oliver Hartkopp
<socketcan@hartkopp.net> wrote:
>
>
> On 09.04.2015 23:01, Yegor Yefremov wrote:
>>
>> The result of (last_log_tv.tv_sec - log_tv.tv_sec) is
>> unsigned long, so use labs() in order not to trim the
>> value to int. Make skipgap to unsigned long for the same
>> reason.
>>
>
> Yes. And additionally
>
>         skipgap = strtoul(optarg, NULL, 10);
>
> should have pointed me to use unsigned long m)

Btw. should we initialize skipgap with 0?

>
> Thanks Yegor!
>
> Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
>
> Regards,
> Oliver
>
>
>> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
>> ---
>>   canplayer.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/canplayer.c b/canplayer.c
>> index f74668e..437ed4b 100644
>> --- a/canplayer.c
>> +++ b/canplayer.c
>> @@ -86,7 +86,7 @@ void print_usage(char *prg)
>>                 "send frames immediately)\n");
>>         fprintf(stderr, "                      -g <ms>      (gap in milli
>> "
>>                 "seconds - default: %d ms)\n", DEFAULT_GAP);
>> -       fprintf(stderr, "                      -s <s>      (skip gaps in "
>> +       fprintf(stderr, "                      -s <s>       (skip gaps in
>> "
>>                 "timestamps > 's' seconds)\n");
>>         fprintf(stderr, "                      -x           (disable local
>> "
>>                 "loopback of sent CAN frames)\n");
>> @@ -241,7 +241,8 @@ int main(int argc, char **argv)
>>         FILE *infile = stdin;
>>         unsigned long gap = DEFAULT_GAP;
>>         int use_timestamps = 1;
>> -       static int verbose, opt, delay_loops, skipgap;
>> +       static int verbose, opt, delay_loops;
>> +       static unsigned long skipgap;
>>         static int loopback_disable = 0;
>>         static int infinite_loops = 0;
>>         static int loops = DEFAULT_LOOPS;
>> @@ -482,7 +483,7 @@ int main(int argc, char **argv)
>>                                         /* test for logfile timestamps
>> jumping backwards OR      */
>>                                         /* if the user likes to skip long
>> gaps in the timestamps */
>>                                         if ((last_log_tv.tv_sec >
>> log_tv.tv_sec) ||
>> -                                           (skipgap &&
>> abs(last_log_tv.tv_sec - log_tv.tv_sec) > skipgap))
>> +                                           (skipgap &&
>> labs(last_log_tv.tv_sec - log_tv.tv_sec) > skipgap))
>>                                                 create_diff_tv(&today_tv,
>> &diff_tv, &log_tv);
>>
>>                                         last_log_tv = log_tv;
>>
>
