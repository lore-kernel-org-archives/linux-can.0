From: Michal Sojka <sojkam1@fel.cvut.cz>
Subject: Re: [PATCH 1/2] canbusload: Add exact CAN frame length calculation (including bitstuffing)
Date: Thu, 30 Jan 2014 14:36:29 +0100
Message-ID: <87fvo5k2w2.fsf@steelpick.2x.cz>
References: <id:87ob2tkcts.fsf@steelpick.2x.cz> <1391076302-12053-1-git-send-email-sojkam1@fel.cvut.cz> <52EA2E66.8020907@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from max.feld.cvut.cz ([147.32.192.36]:41117 "EHLO max.feld.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752169AbaA3Ngf (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 30 Jan 2014 08:36:35 -0500
In-Reply-To: <52EA2E66.8020907@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

On Thu, Jan 30 2014, Marc Kleine-Budde wrote:
> On 01/30/2014 11:05 AM, Michal Sojka wrote:
>> This adds an algorithm for calculating the exact number of bits a CAN
>> frame occupies on the bus and uses this algorithm in canbusload. It
>> also moves the other methods for CAN frame length calculation, already
>> present in canbusload, to the new file.
>> 
>> The added algorithm calculates the exact number of stuffed bit in a
>> CAN frame. Note that in order to calculate that correctly, we must
>> also know the frame's CRC. Hence, the algorithm also includes CRC
>> calculation routine.
>> 
>> The correctness of the algorithm was verified on an oscilloscope for
>> several different SFF and EFF frames.
>> 
>> Currently only CAN frames are supported. For CANFD frames, a different
>> algorithm is needed. CANFD uses different CRC polynomials and
>> calculates the CRC from the staffed bit-stream (CAN calculates CRC
>> from de-stuffed bit-stream).
>> 
>> Signed-off-by: Michal Sojka <sojkam1@fel.cvut.cz>
>> ---
>>  Makefile      |   2 +
>
> Can you update GNUmakefile.am, too

Done.

>>  canbusload.c  |  41 +++-------
>>  canframelen.c | 245 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  canframelen.h |  35 +++++++++
>>  4 files changed, 293 insertions(+), 30 deletions(-)
>>  create mode 100644 canframelen.c
>>  create mode 100644 canframelen.h
>> 
>> diff --git a/Makefile b/Makefile
>> index 2f79ee7..ab99746 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -81,6 +81,7 @@ canbusload.o:	lib.h
>>  log2long.o:	lib.h
>>  log2asc.o:	lib.h
>>  asc2log.o:	lib.h
>> +canframelen.o:  canframelen.h
>>  
>>  cansend:	cansend.o	lib.o
>>  cangen:		cangen.o	lib.o
>> @@ -90,3 +91,4 @@ canlogserver:	canlogserver.o	lib.o
>>  log2long:	log2long.o	lib.o
>>  log2asc:	log2asc.o	lib.o
>>  asc2log:	asc2log.o	lib.o
>> +canbusload:	canbusload.o	canframelen.o
>
> What about adding canframelen.o to the library instead of linking it to
> canbusload?

I added canframelen to the library in GNUmakefile.am. In Makefile, no
library is generated so I left it this way.

I also implemented your other requests. Updated patch will follow.

Thanks,
-Michal
