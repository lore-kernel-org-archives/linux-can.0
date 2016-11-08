From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: slcand multiple interfaces on single serial interface
Date: Tue, 8 Nov 2016 21:08:20 +0100
Message-ID: <d3eb4ca8-f2f0-72dd-16eb-f500b4fa433f@hartkopp.net>
References: <CAGJdXcGu0CftG8wz10_0N5r6xfPeL_SZ71gTR8x=UXqJ+ox1iw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:30491 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753306AbcKHUI3 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 8 Nov 2016 15:08:29 -0500
In-Reply-To: <CAGJdXcGu0CftG8wz10_0N5r6xfPeL_SZ71gTR8x=UXqJ+ox1iw@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Paul Bongaerts <pauluzs@gmail.com>, linux-can@vger.kernel.org

Hi Paul,

On 11/08/2016 07:17 PM, Paul Bongaerts wrote:
> After looking into linux-can i would like setup 2 mcp2515 controllers
> on one serial interface.

(..)

> What i cant figure out is how to do use enumeration to specify which
> can controller is used on the serial bus.
>
> There is a serial option
> N[CR] which will return the serial. maybe this could be set to ie CAN0 and CAN1
> So
> Tiiiiiiiildd...[CR]
> Could maybe changed into
> Tiiiiiiiildd...Nx[CR] to send on CANx
>
> this way it might be possible bind linux CAN0 and CAN1 interfaces to
> CAN0 and CAN1 on the arduino.
>
> Who can help me out or point in the correct direction?

The slcan driver sets the so called 'serial line discipline' of an 
existing serial 'tty' to be used with a special protocol.

E.g. for serial line IP (SLIP) an encapsulation for IP frames over 
serial is enabled and a new netdevice is created.

SLCAN does the same for CAN and creates a CAN network interface.

Your idea to *change* the SLCAN protocol to support more than one CAN 
interface at a time would therefore lead to an extended slcan.c driver.

This extended slcan.c driver would need to create multiple CAN network 
interfaces (e.g. 4) for a single serial tty and we would need to define 
a new 'line discipline' value (different from N_SLCAN).

I would start to copy/paste the slcan.c driver to a slcanx.c and 
implement the N_SLCANX protocol as suggested by you.

Btw. when creating the SLCANX protocol I would put the interface 
instance directly after the command:

 > So
 > Tiiiiiiiildd...[CR]
 > Could maybe changed into
 > Tiiiiiiiildd...Nx[CR] to send on CANx

Would better look like

Txiiiiiiiildd...[CR]

Regards,
Oliver
