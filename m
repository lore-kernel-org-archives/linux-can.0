From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] canplayer: convert skipgap to unsigned long
Date: Fri, 10 Apr 2015 11:37:09 +0200
Message-ID: <552799C5.9040209@hartkopp.net>
References: <1428613281-21827-1-git-send-email-yegorslists@googlemail.com> <552797E7.9000304@hartkopp.net> <CAGm1_kvDgV5Dr4u=kxEQNntf6tBPUh4+ZEv5kw5ebnAnv4m5jQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.160]:41258 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932082AbbDJJhM (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 10 Apr 2015 05:37:12 -0400
In-Reply-To: <CAGm1_kvDgV5Dr4u=kxEQNntf6tBPUh4+ZEv5kw5ebnAnv4m5jQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Yegor Yefremov <yegorslists@googlemail.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 10.04.2015 11:33, Yegor Yefremov wrote:
> On Fri, Apr 10, 2015 at 11:29 AM, Oliver Hartkopp


>> Yes. And additionally
>>
>>          skipgap = strtoul(optarg, NULL, 10);
>>
>> should have pointed me to use unsigned long m)
>
> Btw. should we initialize skipgap with 0?
>

static unsigned long skipgap;
^^^^^^

Does it for you :-)


