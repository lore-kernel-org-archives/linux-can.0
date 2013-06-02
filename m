From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: RFC SFF bitfield filter - was Re: RFC: (optional) software filtering
 in candump
Date: Sun, 02 Jun 2013 11:59:14 +0200
Message-ID: <51AB1772.2000608@hartkopp.net>
References: <51A66B55.6080506@sebastianhaas.info> <51A6DC6A.7020609@hartkopp.net> <51A70F0E.1010902@sebastianhaas.info> <51A71298.1070202@volkswagen.de> <51A71696.8030609@sebastianhaas.info> <20130530101719.GB427@vandijck-laurijssen.be> <51A740E7.3020400@volkswagen.de> <20130530123526.GC427@vandijck-laurijssen.be> <51A77250.8070907@sebastianhaas.info> <51AA01F0.8020308@hartkopp.net> <51AA3ED6.9010806@sebastianhaas.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:57391 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751385Ab3FBJ7R (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 2 Jun 2013 05:59:17 -0400
In-Reply-To: <51AA3ED6.9010806@sebastianhaas.info>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Sebastian Haas <dev@sebastianhaas.info>
Cc: Kurt Van Dijck <kurt.van.dijck@eia.be>, Sandro Anders | CarMediaLab <sandro.anders@carmedialab.de>, linux-can Mailing List <linux-can@vger.kernel.org>


> Am 01.06.2013 16:15, schrieb Oliver Hartkopp:

>> The idea is to introduce a new socket option CAN_RAW_FILTER_UNIQUE for the
>> RAW socket, that catches and omits duplicate frames when it's enabled.
>> This is a per-socket option and is active for all configured filters applied
>> to this socket.
>>
>> It's a relatively small and clear change and it fixes your "bug".
>>
>> Here's the output of candump with and without the 'unique' option when
>> invoking "cansend vcan0 1FF#" in another terminal:
>>
>> $ ./candump vcan0,100~7FF,101~7FF
>>    vcan0  1FF   [0]
>>    vcan0  1FF   [0]
>>
>> $ ./candump vcan0,100~7FF,101~7FF,U
>>    vcan0  1FF   [0]
>>
>> I hope this fit your needs ?! :-)
> Yes it does. It may not be a "clean" solution, but it fixes the issue.
> 

Yes. It is a bit of a fix that handles overlapping filters but is does not
provide a logical AND operation on a bigger number of inverted filters.

E.g. i wanted to remove some single SFF CAN IDs in the 3xx and 5xx range,
which lead to something like this:

candump vcan0,100~C0000100,500:C0000500,333:C00007FF, ...

100~C0000100 -> NOT 1XX 3XX 5XX 7XX SFF frames
500:C0000500 -> add 5XX 7XX again
333:C00007FF, ... -> add single IDs in the 1XX 3XX range

It was a mess. The current filters are not optimized for complex requirements.

Even if it only would be usable for the SFF CAN IDs 0 .. 2048, i wonder if it
would help to configure a 2048 bit bitfield for a 'really individual' filter.

The CAN_RAW socket would get a new sockopt which sets a 128 byte array
(2048/8) to specify for each single CAN ID if it can pass the filter:

u8 bfield[128] /* 2048 bit */

Check at CAN frame reception:

if (can_id & FFFFF800 == 0) { /* no EFF / RTR / ERR and max 0x7FF */

    if ( bfield[can_id >> 3] & 1 << (can_id & 7) ) {

        /* can_id matched */

    }
}

What is your opinion?

Does this kind of individual bitfield filter help for your use-cases?

Regards,
Oliver


