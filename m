From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Can bus shield set up
Date: Mon, 4 Apr 2016 12:22:23 +0200
Message-ID: <5702405F.7010003@hartkopp.net>
References: <EF5F25C2-BEAD-4379-83FC-DF0C656930C5@me.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:60783 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753293AbcDDKWg (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 4 Apr 2016 06:22:36 -0400
In-Reply-To: <EF5F25C2-BEAD-4379-83FC-DF0C656930C5@me.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Kyle Crenshaw <kyle.crenshaw@me.com>, linux-can@vger.kernel.org

Hello Kyle,

I assume you won't have much fun with these parts:

The CAN bus shield has a SPI connected CAN controller MCP2515 which 
needs to be connected to a SPI capable CPU board (like the RasPi).

The pl2303 just makes a serial interface (no SPI).
The SLCAN protocol is 'more' high level than the SPI.

I assume the serial pins on the shield only connect the RasPi board.

Regards,
Oliver

On 04/04/2016 08:00 AM, Kyle Crenshaw wrote:
>
> I have a canbus shield from elecfreaks.com and a pl2303 rs232 to usb cable hardware , and can-utils software installed.
> I love would like to read the canbus data coming in through the shield by way of usb end of the cable.
>
> Do I set this up with slcan as a can device (sudo ip link add dev slcan0 type can), ( slcand.....), or (slcan_attach...), or by another method I'm not aware of?
>
> I'm running fedora 23 if it matters...
>
> Thanks in advance.--
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
