From: Sebastian Haas <dev@sebastianhaas.info>
Subject: Re: RFC SFF bitfield filter - was Re: RFC: (optional) software filtering
 in candump
Date: Sun, 02 Jun 2013 14:23:19 +0200
Message-ID: <51AB3937.1080209@sebastianhaas.info>
References: <51A70F0E.1010902@sebastianhaas.info> <51A71298.1070202@volkswagen.de> <51A71696.8030609@sebastianhaas.info> <20130530101719.GB427@vandijck-laurijssen.be> <51A740E7.3020400@volkswagen.de> <20130530123526.GC427@vandijck-laurijssen.be> <51A77250.8070907@sebastianhaas.info> <51AA01F0.8020308@hartkopp.net> <51AA3ED6.9010806@sebastianhaas.info> <51AB1772.2000608@hartkopp.net> <20130602111705.GA630@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtprelay05.ispgateway.de ([80.67.31.94]:57992 "EHLO
	smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751863Ab3FBMXX (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 2 Jun 2013 08:23:23 -0400
In-Reply-To: <20130602111705.GA630@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Sandro Anders | CarMediaLab <sandro.anders@carmedialab.de>, linux-can Mailing List <linux-can@vger.kernel.org>

Am 02.06.2013 13:17, schrieb Kurt Van Dijck:
> On Sun, Jun 02, 2013 at 11:59:14AM +0200, Oliver Hartkopp wrote:
>>
>>> Am 01.06.2013 16:15, schrieb Oliver Hartkopp:
>>
>>>> The idea is to introduce a new socket option CAN_RAW_FILTER_UNIQUE for the
>>>> RAW socket, that catches and omits duplicate frames when it's enabled.
>>>> This is a per-socket option and is active for all configured filters applied
>>>> to this socket.
>>>>
>>>> It's a relatively small and clear change and it fixes your "bug".
>>>>
>>>> Here's the output of candump with and without the 'unique' option when
>>>> invoking "cansend vcan0 1FF#" in another terminal:
>>>>
>>>> $ ./candump vcan0,100~7FF,101~7FF
>>>>     vcan0  1FF   [0]
>>>>     vcan0  1FF   [0]
>>>>
>>>> $ ./candump vcan0,100~7FF,101~7FF,U
>>>>     vcan0  1FF   [0]
>>>>
>>>> I hope this fit your needs ?! :-)
>>> Yes it does. It may not be a "clean" solution, but it fixes the issue.
>>>
>>
>> Yes. It is a bit of a fix that handles overlapping filters but is does not
>> provide a logical AND operation on a bigger number of inverted filters.
>>
>> E.g. i wanted to remove some single SFF CAN IDs in the 3xx and 5xx range,
>> which lead to something like this:
>>
>> candump vcan0,100~C0000100,500:C0000500,333:C00007FF, ...
>>
>> 100~C0000100 -> NOT 1XX 3XX 5XX 7XX SFF frames
>> 500:C0000500 -> add 5XX 7XX again
>> 333:C00007FF, ... -> add single IDs in the 1XX 3XX range
>>
>> It was a mess. The current filters are not optimized for complex requirements.
>>
>> Even if it only would be usable for the SFF CAN IDs 0 .. 2048, i wonder if it
>> would help to configure a 2048 bit bitfield for a 'really individual' filter.
>>
>> The CAN_RAW socket would get a new sockopt which sets a 128 byte array
>> (2048/8) to specify for each single CAN ID if it can pass the filter:
>>
>> u8 bfield[128] /* 2048 bit */
>>
>> Check at CAN frame reception:
>>
>> if (can_id & FFFFF800 == 0) { /* no EFF / RTR / ERR and max 0x7FF */
>>
>>      if ( bfield[can_id >> 3] & 1 << (can_id & 7) ) {
>>
>>          /* can_id matched */
>>
>>      }
>> }
>>
>> What is your opinion?
>>
>> Does this kind of individual bitfield filter help for your use-cases?
>
> This works for 11bit, but makes 29bit behave differently.
> Therefore, I think it's not such good idea (yet).
I agree. This is a nice approach, but limited to SFF.

I think we "just" need to find a good algorithm to process a set of 
filters. The guys of the IP paket filter doing more complex stuff and 
they need to process much higher datarates then 1MBit ;-)

I will try to understand how the current filter system is implemented, 
maybe I can make more substanial comments on that.

Sebastian
