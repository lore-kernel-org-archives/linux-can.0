From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] candump: add option to ignore ENOBUFS
Date: Fri, 10 Jan 2014 23:02:15 +0100
Message-ID: <52D06DE7.3010002@hartkopp.net>
References: <1351244569-11398-1-git-send-email-yegorslists@googlemail.com> <508A5C05.6050803@pengutronix.de> <508D8F53.1050005@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163]:60833 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751986AbaAJWCU (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 10 Jan 2014 17:02:20 -0500
In-Reply-To: <508D8F53.1050005@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: yegorslists@googlemail.com
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org, Michal Sojka <sojkam1@fel.cvut.cz>

Hi Yegor,

the question about a blocking write was still not addressed :-(

Btw. the routing in userspace became obsolete with can-gw which does the
routing in kernel space.

See can-utils 

$> cangw -?

Usage: cangw [options]

Commands:  -A (add a new rule)
           -D (delete a rule)
           -F (flush / delete all rules)
           -L (list all rules)
Mandatory: -s <src_dev>  (source netdevice)
           -d <dst_dev>  (destination netdevice)
Options:   -t (preserve src_dev rx timestamp)
           -e (echo sent frames - recommended on vcanx)
           -i (allow to route to incoming interface)
           -l <hops> (limit the number of frame hops / routings)
           -f <filter> (set CAN filter)
           -m <mod> (set frame modifications)
           -x <from_idx>:<to_idx>:<result_idx>:<init_xor_val> (XOR checksum)
           -c <from>:<to>:<result>:<init_val>:<xor_val>:<crctab[256]> (CRC8 cs)
           -p <profile>:[<profile_data>] (CRC8 checksum profile & parameters)

Values are given and expected in hexadecimal values. Leading 0s can be omitted.

<filter> is a <value><mask> CAN identifier filter
   <can_id>:<can_mask> (matches when <received_can_id> & mask == can_id & mask)
   <can_id>~<can_mask> (matches when <received_can_id> & mask != can_id & mask)

<mod> is a CAN frame modification instruction consisting of
<instruction>:<can_frame-elements>:<can_id>.<can_dlc>.<can_data>
 - <instruction> is one of 'AND' 'OR' 'XOR' 'SET'
 - <can_frame-elements> is _one_ or _more_ of 'I'dentifier 'L'ength 'D'ata
 - <can_id> is an u32 value containing the CAN Identifier
 - <can_dlc> is an u8 value containing the data length code (0 .. 8)
 - <can_data> is always eight(!) u8 values containing the CAN frames data
The max. four modifications are performed in the order AND -> OR -> XOR -> SET

Example:
cangw -A -s can0 -d vcan3 -e -f 123:C00007FF -m SET:IL:333.4.1122334455667788

Supported CRC 8 profiles:
Profile '1' (1U8)       - add one additional u8 value
Profile '2' (16U8)      - add u8 value from table[16] indexed by (data[1] & 0xF)
Profile '3' (SFFID_XOR) - add u8 value (can_id & 0xFF) ^ (can_id >> 8 & 0xFF)

$>

Does that fit your needs?
You can also create these routing jobs with netlink.

Regards,
Oliver


On 28.10.2012 21:02, Oliver Hartkopp wrote:
> On 26.10.2012 11:46, Marc Kleine-Budde wrote:
> 
>> On 10/26/2012 11:42 AM, yegorslists@googlemail.com wrote:
>>> From: Yegor Yefremov <yegorslists@googlemail.com>
>>>
>>> -f option replicated -i option from cangen and allows to
>>> ignore ENOBUFS error in bridge mode
>>
>> Better not ignore, but handle the error. If socket would support, wait
>> with select/poll that the socket get writable and try again. For now
>> sleep and try again. (or fix the poll/select bug in the kernel).
> 
> 
> ACK.
> 
> IIRC this was a problem of socket write queue length that are too long to
> handle short MTUs like we have with CAN frames.
> Therefore the socket itself does not stop the traffic.
> 
> Definitely something to be fixed ... i'll take a look into the mails from
> Michal Sojka.
> 
> Regards,
> Oliver
> 
> 
