From: Rein Appeldoorn <reinappeldoorn@gmail.com>
Subject: Re: SocketCAN support for a Serial-CAN controller
Date: Mon, 25 Apr 2016 09:26:01 +0200
Message-ID: <CAPO0vcsCE1P56MtDw7B3jnp4cFVBd6zCBpmUGHDW30hWmc2Z+w@mail.gmail.com>
References: <CAPO0vcvuOaGxcCA-722c60o4-k-6somqCD1nuaaV6tWiPkoiTw@mail.gmail.com>
 <CAPO0vcvCBixyQn76ywVQ6GbNbHmB7sH7FqYB9t33qL72pdQDcw@mail.gmail.com> <571B7E9D.7090308@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-lb0-f195.google.com ([209.85.217.195]:33347 "EHLO
	mail-lb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751834AbcDYH0d (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 25 Apr 2016 03:26:33 -0400
Received: by mail-lb0-f195.google.com with SMTP id qf3so1559221lbb.0
        for <linux-can@vger.kernel.org>; Mon, 25 Apr 2016 00:26:32 -0700 (PDT)
In-Reply-To: <571B7E9D.7090308@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org

Hi Oliver,

Thanks for the feedback. I think it is best we go for a PCI SJ1000
controller then. Do you perhaps have any recommendations on this? I
was thinking about the PEAK can pci controller:
http://www.peak-system.com/PCAN-miniPCIe.285.0.html

Thanks,

-Rein
-Rein


On Sat, Apr 23, 2016 at 3:54 PM, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> Hello Rein,
>
> On 04/22/2016 01:17 PM, Rein Appeldoorn wrote:
>
>> Up until now, I've been working with SocketCAN via CANUSB adapters
>> from Lawycel (http://www.can232.com/?page_id=16). However, now we
>> received a new platform with another serial-can controller from
>> axiomtek
>> (http://www.axiomtek.com/Default.aspx?MenuId=Products&FunctionId=ProductView&ItemId=8270).
>>
>> I am able to communicate with the CAN controller via serial and
>> receive CAN frames. However, using slcand to create a socketcan
>> interface does not work. As I see here
>> https://github.com/linux-can/can-utils/blob/master/slcand.c , the
>> slcand program sends specific commands to the serial bus and then
>> creates a bridge between the socket and serial. However, the commands
>> are different for my CAN controller.
>
>
> Yes. That's pretty bad to reinvent the wheel by creating 'just another' CAN
> ASCII protocol :-(
>
>> Can somebody give me some pointers how to get SocketCAN to work with
>> an arbitrary serial-can controller?
>
>
> The slcan driver supports the standard SLCAN protocols as you know from
> Lawicel:
>
> https://github.com/linux-can/can-misc/blob/master/docs/SLCAN-API.pdf
>
>> I'm am very new to these low level Linux things so I really would
>> appreciate your help / corrections. Thanks in advance,
>
>
> You would need to extend the slcan.c driver and the slcan tools from the
> can-utils to cope with the Axiomtek protocol.
>
> Alternatively you can write a user space application that talks to the
> Axiomtek device and send the CAN frames to a virtual CAN (e.g. vcan0) so
> that you can use the can-utils on top of that virtual CAN.
>
> Just a different idea: As you obviously have a full-size mini PCI-Express
> module - why don't you use a proper CAN PCIe interface with a PCI-connected
> SJA1000 controller which is already supported by Linux?
>
> All this serial line encapsulation stuff does not support the really good
> (configuration) things and error handling from SocketCAN.
>
> Regards,
> Oliver
>
> ps. Maybe Axiomtek can also provide a SLCAN compatible firmware ...
