From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: rx-fifo: add implmentation and switch flexcan driver to use it
Date: Wed, 11 May 2016 11:12:14 +0200
Message-ID: <5732F76E.6080804@hartkopp.net>
References: <1462791154-13375-1-git-send-email-mkl@pengutronix.de>
 <CAJ=nTsvE1ZMNC9zmagM=CA+7oE5FWCszeJFsXEO5rc7g=X_B-g@mail.gmail.com>
 <CAJ=nTsuQgeLpjA6RrL-CKAx+2P9HQhXsad1Y-zk0Cm4b9FNA1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163]:36269 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751917AbcEKJM2 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 11 May 2016 05:12:28 -0400
In-Reply-To: <CAJ=nTsuQgeLpjA6RrL-CKAx+2P9HQhXsad1Y-zk0Cm4b9FNA1g@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Mirza Krak <mirza.krak@hostmobility.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>



On 05/10/2016 02:55 PM, Mirza Krak wrote:
> 2016-05-10 10:27 GMT+02:00 Mirza Krak <mirza.krak@hostmobility.com>:
>> 2016-05-09 12:52 GMT+02:00 Marc Kleine-Budde <mkl@pengutronix.de>:
>>> Hello,
>>>
>>> this patch add support for a software bases rx-fifo implementation (patches
>>> 1+2). The remaining patches modify the flexcan driver to make use of it. imx6
>>> and vf610 SoCs can make use of the 64 mailbox software FIFO, while older SoCs
>>> still use flexcan's 6 mailbox deep hardware FIFO.
>>>
>>> Testing on any flexcan core is highly appreciated.
>>
>> Hi Marc.
>>
>> Tested your patch series on a vf610 SOC. I ran 2 x CAN @ 1Mbit, 80-90 % busload.
>>
>> I do no longer get any "overrun" errors, which I got without your
>> patch series. And it seems to be stable, unlike previous patch series.
>> Improvement!
>>
>> However I ran a simple sequence test and there seems to be some
>> ordering issues. I have some memory of that similar issues have been
>> discussed earlier on the mailing list and I am not quite sure if this
>> is related to your patch series but I get following:
>>
>> root@mx4-v61-1000000:~/test/can_test# uname -a
>> Linux mx4-v61-1000000 4.1.15-00056-ge0b8ccc-dirty #12 Mon May 9
>> 15:59:54 CEST 2016 armv7l GNU/Linux
>> root@mx4-v61-1000000:~/test/can_test# ./cansequence -r can1
>> interface = can1, family = 29, type = 3, proto = 1
>> received wrong sequence count. expected: 60, got: 61
>> received wrong sequence count. expected: 62, got: 60
>> received wrong sequence count. expected: 61, got: 62
>> received wrong sequence count. expected: 118, got: 119
>> received wrong sequence count. expected: 120, got: 118
>> received wrong sequence count. expected: 119, got: 120
>> received wrong sequence count. expected: 76, got: 77
>> received wrong sequence count. expected: 78, got: 76
>> received wrong sequence count. expected: 77, got: 78
>>
>> One strange thing is that the sequence errors only occur on can1, can0
>> does not show any errors.

Hello Marc,

is it possible that the indirection irq -> rx-fifo -> napi can shuffle 
the CAN frames when the can1 irq is served by different CPUs?

We can probably set the processing CPU number into can_frame.__res0 for 
a test and print it in cansequence then.

Regards,
Oliver

ps. @Mirza: Thanks for testing!

>
> Some follow-up information.
>
> Sequence errors occurs only if I run at 500 kbit/s or faster, which
> suggests that higher CPU load triggers it.
>
> I also ran same tests without your patch series and do not get any
> sequence errors.
>
