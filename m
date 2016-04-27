From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: USB2CAN adapters
Date: Wed, 27 Apr 2016 18:24:44 +0200
Message-ID: <5720E7CC.2040508@hartkopp.net>
References: <C08ECF0F-123A-4B78-8367-E60824D4B5C2@gmail.com>
 <571F9201.2090704@hartkopp.net>
 <1299B9FC-3973-470A-9051-2394C7B4A6B2@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161]:47914 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752458AbcD0QZA (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 27 Apr 2016 12:25:00 -0400
In-Reply-To: <1299B9FC-3973-470A-9051-2394C7B4A6B2@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: kay Cee <unee0x@gmail.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 04/27/2016 05:02 AM, kay Cee wrote:
> You're right, I should've sent more specific info.
>
> I have A beaglebone black and a usbcan adapter ------->>>>>
> http://m.aliexpress.com/item-desc/1443071907.html
>
> And I'm sure if I should be using the slcan protocol to make it work or if i can
> Set it up as a regular can device even though it connects to a USB port?
>

There are numerous chinese USB2CAN adapters you can find with entering 
'usb can adapter' at Ebay, e.g. this one:

http://www.ebay.de/itm/USB-CAN-USB-to-CAN-BUS-Converter-Adapter-USB-Cable-support-win7-System-/361538969224

All these adapters come with some WinXP or Win7 drivers, libraries and 
applications that usually do not tell anything about the protocol on the 
serial/USB link.

Checking the example above the driver.rar package contained a PDF with

USB (Serial port) to CAN protocol defines

Serial port 1228800bps
8 data bit
1 stop bit
No parity

Default baud rate of CAN:250kbsp

Send and receive data packet format

No.	Definition	Remark
0	Packet header	0xaa
1	Packet header	0x55
2	Type		0x01- Transmitting and receiving data
3	Frame type	0x01- Standard frame,0x02- Extended frame
4	Frame format	0x01-ata frame,0x02- Remote Frame
5	Frame ID data 1	1~8bit
6	Frame ID data 2	9~16bit
7	Frame ID data 3	17~24bit
8	Frame ID data 4	25~32bit
9	Length	To send or receive data length of CAN bus(0~8)
10	Data 1	CAN send or receive data 1
11	Data 2	CAN send or receive data 2
12	Data 3	CAN send or receive data 3
13	Data 4	CAN send or receive data 4
14	Data 5	CAN send or receive data 5
15	Data 6	CAN send or receive data 6
16	Data 7	CAN send or receive data 7
17	Data 8	CAN send or receive data 8
18	Reserve	0
19	Check	Red part of the data accumulation and checksum

So this is far away from slcan and we don't know details about the 
checksum either.

Oliver



