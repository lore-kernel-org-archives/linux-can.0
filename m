From: Paul Bongaerts <pauluzs@gmail.com>
Subject: slcand multiple interfaces on single serial interface
Date: Tue, 8 Nov 2016 19:17:07 +0100
Message-ID: <CAGJdXcGu0CftG8wz10_0N5r6xfPeL_SZ71gTR8x=UXqJ+ox1iw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-yw0-f181.google.com ([209.85.161.181]:33668 "EHLO
        mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932258AbcKHSRJ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 8 Nov 2016 13:17:09 -0500
Received: by mail-yw0-f181.google.com with SMTP id r204so188669360ywb.0
        for <linux-can@vger.kernel.org>; Tue, 08 Nov 2016 10:17:08 -0800 (PST)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi my name is Paul, 37, dutch mechanical engineer new to mailing lists
and no programmer.

After looking into linux-can i would like setup 2 mcp2515 controllers
on one serial interface.

I'm using an ATMEGA 328 based arduino with 2 mcp2515 controllers on
isobus (2 250kbbs can interfaces)

For this i found :

The latest mcp_library:
https://github.com/coryjfowler/MCP_CAN_lib

Also i found two ways to use this with the slcand driver
The arduino-canbus-monitor
https://github.com/latonita/arduino-canbus-monitor
And https://github.com/kahiroka/slcanuino/blob/master/slcan.ino

The commands used in the driver
http://www.can232.com/can232/can232_v3.pdf

What i cant figure out is how to do use enumeration to specify which
can controller is used on the serial bus.

There is a serial option
N[CR] which will return the serial. maybe this could be set to ie CAN0 and CAN1
So
Tiiiiiiiildd...[CR]
Could maybe changed into
Tiiiiiiiildd...Nx[CR] to send on CANx

this way it might be possible bind linux CAN0 and CAN1 interfaces to
CAN0 and CAN1 on the arduino.

Who can help me out or point in the correct direction?

Br Paul
