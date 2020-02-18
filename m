From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: canfd through slcan via SocketCAN
Date: Tue, 18 Feb 2020 08:11:16 +0100
Message-ID: <4ba5c9cc-fbef-1e31-2fd2-51dd50029ac5@hartkopp.net>
References: <B1BB0B55-5478-4C06-AAC2-B27AB986755B@gmail.com>
 <ca7db9dc-991e-e2f7-a3a7-dc13a0880581@hartkopp.net>
 <81FEDC66-54A7-4B53-911E-80122446A453@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.216]:27437 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbgBRHLZ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 18 Feb 2020 02:11:25 -0500
In-Reply-To: <81FEDC66-54A7-4B53-911E-80122446A453@gmail.com>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Chris Morgan <chmorgan@gmail.com>
Cc: linux-can@vger.kernel.org



On 18/02/2020 01.01, Chris Morgan wrote:
> HI Oliver.
> 
>> On Feb 17, 2020, at 3:16 PM, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>>
>> Hi Chris,
>>
>> On 16/02/2020 14.43, Chris Morgan wrote:
>>
>>> I’m looking at options to add canfd support to embedded processors via serial using slcan. I’d like the devices to be available via socketcan. Looking at the slcan driver it looks like the MTU is something around 30 bytes and there isn’t any mention of canfd in the driver or in the userspace utilities. Am I missing something with this support? If slcan doesn’t support canfd yet is anyone working to add any?
>>
>> The slcan driver implements the SLCAN aka Lawicel protocol, originally provided by http://www.can232.com/
>>
>> See documentation at:
>> http://www.can232.com/docs/can232_v3.pdf
>>
> 
> This is super helpful, thanks for the pointer there. I didn’t realize so many letters were already in use but it looks like there are some openings in the protocol.
> 
> 
>> Other low cost serial CAN adapters adopted this simple protocol, see this overview:
>>
>> https://github.com/linux-can/can-misc/blob/master/docs/SLCAN-API.pdf
>>
>> By today there is no CAN FD capable CAN interface using the SLCAN protocol on the market!!
>>
>> You would need to set a second bitrate (data bitrate) and you would need a separated data frame identifier for CAN FD frames.
>>
>> Today:
>>
>> t/T -> Classic CAN data frame
>> r/R -> Classic CAN rtr frame (not in CAN FD)
>>
>> According to the above documents we would been able to use:
>>
>> d/D -> CAN FD data frame (with BRS/ESI flags!)
>> k/K -> set FD data bitrates (analogue to s/S)
>>
>> The biggest problem with defining these values/characters and adding them to the slcan driver in the Linux kernel, is that WE DO NOT KNOW whether future serial CAN FD interfaces will follow our suggestion.
>>
>> Usually you have a hardware providing an API/protocol and THEN the driver developers write the driver - and not the other way around ;-)
>>
> 
> Heh. I can appreciate that.
> 
> I’m working with a MT7688 platform that only supports half duplex spi and looking for a low cost canfd solution for that platform. I’m not sure exactly if that prevents me from using an existing MCP251x driver or not but I’ve heard this is the case. There is also a software spi driver, spi-gpio-custom in openwrt that is an option.
> 
> The idea with slcan would be to use a SAM21 microcontroller with dual canfd controllers to provide canfd functionality, implementing the slcan client in the SAM21 firmware.
> 
> I’m still not sure what the best approach might be. I am hesitating to use a usb based adapter but that’s another option as well.

IMO the SLCAN protocol is a simple but not that reliable, efficient and 
fast protocol.

I would not recommend to take it as a basis for a new design. Therefore 
I would either try to make the SPI working or to go with an USB 
solution, which handles CAN frames directly (meaning without a SLCAN 
protocol).

Regards,
Oliver
