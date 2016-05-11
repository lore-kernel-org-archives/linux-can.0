From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: CAN libpcap capture endianess
Date: Wed, 11 May 2016 09:40:41 +0200
Message-ID: <5732E1F9.1060908@hartkopp.net>
References: <1378920814-sup-4559@pruts.nl> <1462908218-sup-6526@pruts.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.160]:49967 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750954AbcEKHkv (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 11 May 2016 03:40:51 -0400
In-Reply-To: <1462908218-sup-6526@pruts.nl>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ico Doornekamp <ico@pruts.nl>, linux-can <linux-can@vger.kernel.org>



On 05/10/2016 09:25 PM, Ico Doornekamp wrote:
> Sorry to resurrect this three your old thread, but it seems that the
> issue stil exists, and the source of the problem does not seem to lie in
> wireshark, but somewhere in the can-raw handling.
>
> There still seems to be an endianess problem with raw socket access to slcan
> devices. The original message from sep 2013 is pasted below this mail.
>
> I have found a simple way to reproduce, this is what I do:
>
> - setup a vcan device 'vcan0'
>
>    modprobe vcan
>    ip link add dev vcan0 type vcan
>    ip link set vcan0 up
>
> - setup a slcan device 'slcan0'. You do not need an actual slcan
>    interface, it is enough to slattach to any serial device
>
>    slcan_attach -s5 /dev/ttyUSB0
>    slcand -o -c -f -s5 ttyUSB0
>    ifconfig slcan0 up
>
> - send a CAN frame on vcan0 and observe in wireshark:
>
>    $ cansend vcan0 '123#00000000'
>
>    1 0.000000 -> CAN 12 STD: 0x00000123 00 00 00 00
>
>
> - send a CAN frame on slcan0 and observe in wireshark:
>
>   $ cansend slcan0 '123#00000000'
>
>   1 0.000000000 -> CAN 16 ERR: 0x03010000 00 00 00 00
>
>
> The problem resides in the endianess of the CAN ID that is decoded. On vcan0
> the proper address is seen (0x00000123), but on slcan0 the address is read in
> the wrong order (0x03010000).
>
> I have verified that the CAN message on the bus on slcan0 is actually
> sent with ID 0x123. Messages received from other devices are also shown
> with wrong endianess.

Hello Ico,

usually the CAN subsystem has no problems with host/network byte order:
The struct can_frame contains the CAN ID which is set into the CAN 
controller registers inside the CAN driver.

As wireshark uses the PF_PACKET socket to read the CAN frames it might 
make assumptions about the byte order of read elements.

Can you check the output from tst-packet on vcan0 / slcan0:

	./tst-packet -i vcan0

from

	https://github.com/linux-can/can-tests

Regards,
Oliver

>
>
> * On 2013-09-11 19:42:43 +0200, Ico wrote:
>
>> Recently I tried the CANopen module in wireshark to sniff on my slcan
>> interface, but the dissector seemed to mix up the endianess of the
>> capture. The source of the dissector seems to assume the CANopen data is
>> encoded in big endian, altough afaik CANopen uses little endian for its
>> data.
>>
>> I contacted Yegor Yefremov, the contributor of the CANopen dissector,
>> who is now just confused as I am: he made some captures on his own
>> setup, on which the endianess is indeed different then from mine.
>>
>> We both run on x86, so host endianess does not seem to be part of the
>> problem.
>>
>> Hereby I attach two capture files, one made on my setup, and one made by
>> Yegor. Can oneone check which one has the proper endianess, and maybe
>> take a look at the current CANopen dissector in wireshark to see if the
>> implementation is ok?
>>
>> Thank you,
>>
>> Ico
>>
>> attached:
>>
>> 1. capture-ico.pcap: CAN-232 interface, slcan, x86_64
>> 2. capture-yegor.pcap: VScom USB-CAN interface, slcal, x86
>>
>
