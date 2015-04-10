From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: [PATCH] canplayer: convert skipgap to unsigned long
Date: Fri, 10 Apr 2015 11:37:47 +0200
Message-ID: <CAGm1_kty8BGdwr1SkG6f65V788m6nLHZvsnZ+pbZpXRwgRm+1A@mail.gmail.com>
References: <1428613281-21827-1-git-send-email-yegorslists@googlemail.com>
 <552797E7.9000304@hartkopp.net> <CAGm1_kvDgV5Dr4u=kxEQNntf6tBPUh4+ZEv5kw5ebnAnv4m5jQ@mail.gmail.com>
 <552799C5.9040209@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33964 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754161AbbDJJiI (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 10 Apr 2015 05:38:08 -0400
Received: by pacyx8 with SMTP id yx8so16649807pac.1
        for <linux-can@vger.kernel.org>; Fri, 10 Apr 2015 02:38:07 -0700 (PDT)
In-Reply-To: <552799C5.9040209@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On Fri, Apr 10, 2015 at 11:37 AM, Oliver Hartkopp
<socketcan@hartkopp.net> wrote:
> On 10.04.2015 11:33, Yegor Yefremov wrote:
>>
>> On Fri, Apr 10, 2015 at 11:29 AM, Oliver Hartkopp
>
>
>
>>> Yes. And additionally
>>>
>>>          skipgap = strtoul(optarg, NULL, 10);
>>>
>>> should have pointed me to use unsigned long m)
>>
>>
>> Btw. should we initialize skipgap with 0?
>>
>
> static unsigned long skipgap;
> ^^^^^^
>
> Does it for you :-)

You live, you learn :-)
