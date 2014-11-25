From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v3 0/4] Consolidate and unify state change handling
Date: Tue, 25 Nov 2014 22:07:11 +0100
Message-ID: <5474EF7F.6060008@grandegger.com>
References: <212bdd30-5398-4189-b928-5b9e674ebaa8@GRBSR0089.marel.net> <54723716.5000509@grandegger.com> <20141125155145.30778.82976@shannon>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:37606 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750869AbaKYVHO (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 25 Nov 2014 16:07:14 -0500
In-Reply-To: <20141125155145.30778.82976@shannon>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andri Yngvason <andri.yngvason@marel.com>, linux-can@vger.kernel.org
Cc: mkl@pengutronix.de

On 11/25/2014 04:51 PM, Andri Yngvason wrote:
> Quoting Wolfgang Grandegger (2014-11-23 19:35:50)
>> On 11/22/2014 06:41 PM, Andri Yngvason wrote:
>>> Tested on sja1000 using:
>>>  cangen -g 100 can0
>>> and
>>>  candump -ta -e can0,0:0,#FFFFFFFF
>>>
> ...
>>>  (1416683061.571115)  can0  643   [8]  D9 BB 20 19 28 A0 56 77
>>>  (1416683061.671163)  can0  736   [7]  62 00 39 0E 13 F4 7E
>>>  (1416683061.770988)  can0  2E4   [3]  D2 3F C0
>>
>> This looks now good for the SJA1000 ...
>>
>>> Tested on mscan using:
>>>  cangen -g 100 can0
>>> and
>>>  candump -ta -e can0,0:0,#FFFFFFFF
>>>
> ...
>>>  (0000088454.071587)  can0  07F   [7]  4A 5B 1E B3 5F 63 1E
>>>  (0000088454.171299)  can0  092   [1]  5A
>>>  (0000088454.271898)  can0  492   [8]  41 1C 23 91 77 76 27 D7
>>
>> and MSCAN.
>>
>>> Tested on flexcan using:
>>>  cangen -g 1000 can0
>>>  cangen -g 1000 can1
>>> and
>>>  candump -ta -e can0,0:0,#FFFFFFFF
>>> and
>>>  berr-reporting on
>>
>> I think you need this because your Flexcan platform data are wrong as
>> mentioned earlier.
>>
> I need this because of missing interrupts from the controller and failure to
> address this in the driver. This could be fixed by always leaving the bus error
> interrupts on and polling the state on tx. I'm not sure if either of those are a
> good idea.

You should fix your Flexcan platform binding.

>>> Disconnected bus:
>>>  (000.190615)  can0  2AA   [3]  2F 73 B5
>>>  (000.809397)  can0  3B5   [7]  1F C1 79 77 5D 56 3E
>>>  (000.190926)  can0  4AA   [6]  8A 01 7F 1B 43 CA
>>>  (001.007441)  can0  200000A8   [8]  00 00 00 19 00 00 00 00   ERRORFRAME
> ...
>>>       restarted-after-bus-off
>>>  (000.750963)  can0  6BF   [8]  5A 26 E0 13 B3 FA DE 0E
>>>  (000.190390)  can0  6CD   [4]  09 97 46 75
>>>  (000.809340)  can0  5EC   [2]  9A 2B
>>
>> Looks good as well. Would be nice if you use cangen with a message count
>> in the data.
> I'll keep that in mind next time.
>>
>>> Note: I made the following changes to can-utils:
>>> diff --git a/lib.c b/lib.c
>>> index 2c8df32..973be52 100644
>>> --- a/lib.c
>>> +++ b/lib.c
>>> @@ -446,6 +446,7 @@ static const char *controller_problems[] = {
>>>       "tx-error-warning",
>>>       "rx-error-passive",
>>>       "tx-error-passive",
>>> +     "back-to-error-active",
>>>  };
>>>  
>>>  static const char *protocol_violation_types[] = {
>>> @@ -455,7 +456,7 @@ static const char *protocol_violation_types[] = {
>>>       "tx-dominant-bit-error",
>>>       "tx-recessive-bit-error",
>>>       "bus-overload",
>>> -     "back-to-error-active",
>>> +     "active-error",
>>>       "error-on-tx",
>>>  };

Please post a separate patch for the can-utils.

>>> Andri Yngvason (4):
>>>   can: dev: Consolidate and unify state change handling.
>>>   can: sja1000: Consolidate and unify state change handling.
>>>   can: mscan: Consolidate and unify state change handling.
>>>   can: flexcan: Consolidate and unify state change handling.
>>>
>>>  drivers/net/can/dev.c             |  94 +++++++++++++++++++++++++++++++++++
>>>  drivers/net/can/flexcan.c         | 101 +++++++-------------------------------
>>>  drivers/net/can/mscan/mscan.c     |  48 ++++++------------
>>>  drivers/net/can/sja1000/sja1000.c |  49 +++++++++---------
>>>  include/linux/can/dev.h           |   4 ++
>>>  include/uapi/linux/can/error.h    |   1 +
>>>  6 files changed, 153 insertions(+), 144 deletions(-)
>>
>> I will have a closer look to the patches tomorrow.
>>
> You must be travelling at a relativistic speed. ;)

As fast as I can (in my free time) ;)

Apart from my comments the patchset looks good now... also saving a lot
of lines.

Thanks for your patience.

Wolfgang.
