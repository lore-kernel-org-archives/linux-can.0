From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v3] slcand: add slcan_attach and UART settings
Date: Sun, 15 Sep 2013 22:11:41 +0200
Message-ID: <5236147D.8020200@hartkopp.net>
References: <1379067102-27741-1-git-send-email-yegorslists@googlemail.com> <5232F733.2040707@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:43831 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752442Ab3IOULq (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 15 Sep 2013 16:11:46 -0400
In-Reply-To: <5232F733.2040707@i2se.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stefan Wahren <stefan.wahren@i2se.com>, yegorslists@googlemail.com
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de

On 13.09.2013 13:29, Stefan Wahren wrote:
> Hello Yegor,
> 
> Am 13.09.2013 12:11, schrieb yegorslists@googlemail.com:
>> From: Yegor Yefremov <yegorslists@googlemail.com>
>>
>> slcand takes settings known from slcan_attach to configure CAN
>> interface, like open/close channel, set bitrate etc (Oliver Hartkopp).
>>
>> In addition -S option sets UART's baudrate (Yegor Yefremov).
>>
>> This way slcand combines three autilities in one: old slcand,
>> slcan_attach and stty.
>>
>> Example: slcand -o -s8 -S 3000000 ttyUSB0
>>
>> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
>> CC: stefan.wahren@i2se.com
>> CC: socketcan@hartkopp.net
>> CC: mkl@pengutronix.de
>> ---
>> Changes since v2:
>>    More style fixes as suggested by Stefan Wahren
>> Changes since v1:
>>    Implement suggestions from Stefan Wahren
>>    - fix style issues
>>    - changed look_up_uart_speed parameter from int to long int
>>    - look_up_uart_speed return value will be checked for unsupported baudrates
>>   slcand.c |  297
>> +++++++++++++++++++++++++++++++++++++++++++++++++++++---------
>>   1 files changed, 255 insertions(+), 42 deletions(-)
>>


> okay, looks good to me.
> 
> Best regards
> 
> Stefan
> 

Hi all,

i applied the v3 patch to the can-utils git repo.

Thanks!

I tried linux/scripts/checkpatch.pl which provided tons of issues :-(

Therefore i fixed up the entire coding style and removed an empty statement
in the 'if (speed)' condition to make sure, that the write() statement is not
unintentionally optimized away by the compiler %-)

See changes here:

https://gitorious.org/linux-can/can-utils/commit/35d2bc1381f04e0fcc5baadf9d1ddad8db0187d3 

There's still one warning left:

slcand.c: In function 'daemonize':
slcand.c:180:8: warning: variable 'dummyFile' set but not used [-Wunused-but-set-variable]
  FILE *dummyFile;
        ^

Any suggestion?

Best regards,
Oliver

