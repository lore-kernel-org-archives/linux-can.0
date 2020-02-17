From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: canfd through slcan via SocketCAN
Date: Mon, 17 Feb 2020 21:16:49 +0100
Message-ID: <ca7db9dc-991e-e2f7-a3a7-dc13a0880581@hartkopp.net>
References: <B1BB0B55-5478-4C06-AAC2-B27AB986755B@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.20]:24317 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729334AbgBQUQv (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 17 Feb 2020 15:16:51 -0500
In-Reply-To: <B1BB0B55-5478-4C06-AAC2-B27AB986755B@gmail.com>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Chris Morgan <chmorgan@gmail.com>, linux-can@vger.kernel.org

Hi Chris,

On 16/02/2020 14.43, Chris Morgan wrote:

> I’m looking at options to add canfd support to embedded processors via serial using slcan. I’d like the devices to be available via socketcan. Looking at the slcan driver it looks like the MTU is something around 30 bytes and there isn’t any mention of canfd in the driver or in the userspace utilities. Am I missing something with this support? If slcan doesn’t support canfd yet is anyone working to add any?

The slcan driver implements the SLCAN aka Lawicel protocol, originally 
provided by http://www.can232.com/

See documentation at:
http://www.can232.com/docs/can232_v3.pdf

Other low cost serial CAN adapters adopted this simple protocol, see 
this overview:

https://github.com/linux-can/can-misc/blob/master/docs/SLCAN-API.pdf

By today there is no CAN FD capable CAN interface using the SLCAN 
protocol on the market!!

You would need to set a second bitrate (data bitrate) and you would need 
a separated data frame identifier for CAN FD frames.

Today:

t/T -> Classic CAN data frame
r/R -> Classic CAN rtr frame (not in CAN FD)

According to the above documents we would been able to use:

d/D -> CAN FD data frame (with BRS/ESI flags!)
k/K -> set FD data bitrates (analogue to s/S)

The biggest problem with defining these values/characters and adding 
them to the slcan driver in the Linux kernel, is that WE DO NOT KNOW 
whether future serial CAN FD interfaces will follow our suggestion.

Usually you have a hardware providing an API/protocol and THEN the 
driver developers write the driver - and not the other way around ;-)

Regards,
Oliver
