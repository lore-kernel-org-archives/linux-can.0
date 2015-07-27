From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: State of ISO-TP in SocketCAN?
Date: Mon, 27 Jul 2015 19:40:35 +0200
Message-ID: <55B66D13.2090605@hartkopp.net>
References: <C0D0FD46-6144-4CFF-9730-FC6920E35766@codm.de> <55AFE01E.1080700@hartkopp.net> <1689D99C-35FD-4CC4-ADDB-375F1B6F7ACC@codm.de> <55B1327D.10507@hartkopp.net> <138744C7-2312-4A95-9479-6D465F184F92@codm.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161]:45329 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753029AbbG0Rkk (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 27 Jul 2015 13:40:40 -0400
In-Reply-To: <138744C7-2312-4A95-9479-6D465F184F92@codm.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Tobias Schmitt <tobias.schmitt@codm.de>
Cc: linux-can@vger.kernel.org

On 25.07.2015 17:11, Tobias Schmitt wrote:

>> Whenever you have a transport protocol channel for segmented PDUs you have to provide two CAN-IDs to match FF/CF and FC messages on the 'virtual channel' on the bus.
>>
>> The extended addressing is just some kind of 'extension for the CAN-ID'
>
> Okay, I thought it's purpose is to use it like sender and receiver adresses.
>

Probably if you compare it to sender/receiver addresses inside a VPN tunnel 
(which is defined by the two CAN-IDs).

>> E.g. If you would have a wildcard, to what address should you send the FC then? You would need to implement some connection tracking - even when you are communicating simultaneously to different nodes.
>
> Yes, especially when communication simultaneously. I will try to explain how I implement the ISO-TP extended adressing in our project at the moment (Application Level with can_raw on the Beaglebone Black and AVR-C implementation on AT90CAN). I have to add that we don't use CAN for diagnostics, but for real device-to-device communication on the bus.
>
> We assume there are 3 Clients on the Bus, 1 Master (Beaglebone) and 2 Slaves (AT90CAN). Every device has one unique ID (Master 0, Slaves 0-245, the rest for special purpose).
> can_id = sender_id
> data[0] = receiver_id (extended adressing)
> data[1] ... ISOTP and Data.
>
> For example (I'm not at home so maybe there are a few mistakes with data lengths or IDs, but I think the main point is clear):
> Master (0x00) sends to slave (0x14)
> syntax -> canid - data[0] data[1] ....
>
> Singleframe master to slave:
> 0x00 - 0x01 0x04 0xDE 0xAD 0xBE 0xEF
>
> ISOTP with FF, CF and FC
> <master: send FF to 0x01 with length 12 byte>
> 0x00 - 0x14 0x10 0x0B 0xDE 0xAD 0xBE 0xEF 0xDE
> <slave: FC frame from slave to master>
> 0x14 - 0x00 0x30 0x09 0x00
> <master: CFs... >
> 0x00 - 0x14 0x21 0xAD 0xBE 0xEF 0xDE 0xAD 0xBE
> 0x00 - 0x14 0x22 0xEF
>
> This is how I understood extended adressing.

No this not extended addressing. You are mixing the addressing defined by the 
(outer) CAN-IDs with the (inner) extended addressing (which needs two fixed 
CAN-IDs).

Your addressing scheme is interesting - but unfortunately it has nothing to do 
with ISO-TP addressing ;-)

> On the Linux side I'm implementing a daemon which acts similar to the socketcand and processes isotp on appilcation level and puts the content of the isotp messages on a TCP Port. I have to add, that this "mechanism" of forwarding on a TCP port evolved in my head while I was developing. I didn't know about socketcand at this time.
>
> I think I will finish this daemon in the following week and upload it to github (since it's not critical to our product, my boss is absolutely willing to commit it into OSS community under a free licence - as well as the relevant librarys for at90can devices I wrote).

Very good attitude - you should spend him a beer for that :-)

>> The functional addressing does not need segmentation, so you can create and send functional PDUs by 'handmade' ISO-TP CAN frames via CAN_RAW sockets.
>>
>> When your application needs to 'listen' on several transport channels you may create as much sockets as you need and read from them simultaneously e.g. with the select() syscall.
>>
>> Does that help for your use-case? Can you tell about your use-case?
>
> I must admit that I'm not really sure if I understood everything you wrote.

Forget about it - now that I know your idea it has no value for you.

> So using the socket-level iso-tp implementation with our project (as I explained above) is not possible?

No - unfortunately not.

Even if you would do some hacking to implement your special addressing scheme 
you would need to have n different sockets (== state machines) on each host to 
talk to the n different nodes with segmented PDUs.

And if you have created n sockets anyway you might think about 29bit CAN-IDs 
where you can encode the master/slave IDs into the CAN-IDs, e.g.

0x00001400 tx_id
0x00000014 rx_id

This would work with the iso-tp implementation then.

> The exact usecase is a system for door accesscontrol with iButtons which is expendable over the CAN bus. This bus exists only inside the fusebox / cabinet and handles the communication between the master server and the slave extensions. Since I'm developing with SHA1 iButtons for higher security a raw can message is not enough anymore and we need a more complex protocol, so my first idea was iso-tp.

If you just need an authentication method for your CAN messages there's the 
MaCAN (Message authenticated CAN) project probably something for you:

https://github.com/CTU-IIG/macan

The idea behind MaCAN is some exchange of session keys between the nodes at 
system startup and then communicate in single CAN frames with a 32/24/16 bit MAC.

https://github.com/CTU-IIG/macan/blob/master/doc/macan.pdf

Best regards,
Oliver

