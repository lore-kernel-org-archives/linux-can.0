From: Stefano Babic <sbabic@denx.de>
Subject: Re: [PATCH v5 1/2] Add documentation for SPI to CAN driver
Date: Thu, 30 Oct 2014 17:21:24 +0100
Message-ID: <54526584.3060300@denx.de>
References: <1406565510-10783-1-git-send-email-sbabic@denx.de> <1406565510-10783-2-git-send-email-sbabic@denx.de> <54514F2C.10108@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:43423 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758162AbaJ3QVc (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 30 Oct 2014 12:21:32 -0400
In-Reply-To: <54514F2C.10108@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Stefano Babic <sbabic@denx.de>, linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>

Hi Oliver,

On 29/10/2014 21:33, Oliver Hartkopp wrote:
> Hi Stefano,
> 
> sorry that I did not find some time to review your driver again :-(

Do not worry, I understand ;-)

> 
> I found some small issues:
> 
> On 28.07.2014 18:38, Stefano Babic wrote:
>> Signed-off-by: Stefano Babic <sbabic@denx.de>
> 
> 
>> +The CFG_MSG_GET is sent at the start up to query the CAN controller
>> about its
>> +internal timing, making them available to the netlink interface. CAN
>> drivers
>> +have usually fest values for can_bittiming_const.
> 
> fest -> fixed

ooppps...wrong language, I fix it !

> 
>> In case of a remote
>> +CAN controller driven via SPI, the Main Controller cannot know the
>> timing
>> +and must ask them to the CAN controller before instantiating a CAN
>> device.
>> +For this reason, the message is sent only once in the probe() entry
>> point.
>> +
>> +The REQ_DATA is sent only by the Main Controller when the Main
>> Controller
>> +signals it has packets to be transfered, but the Main Controller has
>> nothing
>> +to sent.
> 
> ?? Didn't understand this - really ;-)

Well, I read the phrase again and I confess I cannot understand it
myself :-D

I try to rephrase it:

The REQ_DATA is a replacement for the SEND_DATA message. It is sent by
the Main Controller when the Slave Controller has signalled in a
previous frame that it has packets to be transfered, but the Main
Controller has nothing to sent.


> 
> 
>> +8.6 Format of Get Configuration Message
>> +----------------------------------------
>> +
>> +Format of the frame sent by Main Controller:
>> +  _____,________
>> + |     |        ,'''''''''|'''''''''|
>> + |ID=6 | LEN=3  | channel |CHECKSUM |
>> + |_____L________|_________|_________|
>> +
>> +Answer from CAN Controller:
>> +  _____,________
>> + |     |        ,''''''''''''''''''''|''''''''''|'''''''''|'''''''''|..
>> + |ID=6 | LEN=25 | channel |tseg1_min |tseg2_max |tseg2_min|        
>> |CHECKSUM
>> + |_____L________|_________|__________|__________|_________|_________..
>> +
>> +    Offset
>> +    0    0x06 (CFG_MSG_GET)
>> +    1-2    25
>> +    3    channel number
>> +        0xFF = CFG
>> +        0..n = CAN controller CAN channel
>> +    5    tseg1_min
>> +    6    tseg1_max
>> +    7    tseg2_min
>> +    8    tseg2_max
>> +    9    sjw_max
>> +    10-13    brp_min
>> +    14-17    brp_max
>> +    18-21    brp_inc
>> +    22    ctrlmode
> 
> Why is ctrlmode not 32 bit?
> 
>> +    23-27    clock
>> +    28-29    Checksum
> 

I admit this is a limitation on the Slave Controller. I was asked to not
send a configuration frame bigger as 32 bytes, and I have tried to save
space in some ways. Indeed, only some bits in the ctrlmode are used.

Anyway, I was unsure if I can reduce the size for the brp_* fields.
Using 32bit for brp_min looks like excessive, and I could drop its size
instead of ctrlmode. Do you think I can use 8bit values for all brp_*
fields ?

> Some more stuff in the other patch.

I check it, thanks for review !

Best regards,
Stefano

-- 
=====================================================================
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-53 Fax: +49-8142-66989-80 Email: sbabic@denx.de
=====================================================================
