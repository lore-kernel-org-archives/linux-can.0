From: John Whitmore <arigead@gmail.com>
Subject: j1939 (Higher Layer Protocols)
Date: Thu, 5 Nov 2015 18:08:33 +0000
Message-ID: <20151105180831.GA24951@bamboo.electronicsoup>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:38450 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932067AbbKESIh (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 5 Nov 2015 13:08:37 -0500
Received: by wmeg8 with SMTP id g8so20785456wme.1
        for <linux-can@vger.kernel.org>; Thu, 05 Nov 2015 10:08:36 -0800 (PST)
Received: from bamboo.electronicsoup (firewall.itsligo.ie. [193.1.112.11])
        by smtp.gmail.com with ESMTPSA id kd8sm8183819wjc.27.2015.11.05.10.08.34
        for <linux-can@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Nov 2015 10:08:35 -0800 (PST)
Content-Disposition: inline
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Newbie here so this could go to kernel newbies mailing list but it is Can
Related so here goes.

I'm coming at this from the restricted bubble of microcontrollers, but just so
you know what that produced...

I have a low level library of code which handles all Can frames (I keep
wanting to say Layer 2 but it's probably not) on my single Can
Interface. Basically it is a dispatcher which handles all the frames. So the
main loop of my embedded microcontroller reads a frame and dispatches it.

"Application" code then just registers a handler something like

register_handler(filter, handler_function)

It's fairly basic but it works for me. I'm working on my own networks so don't
have to worry about the rest of the world. And I was only using 8 Byte
messages. All my different nodes are basically the low level dispatcher which
is alway the same and specific handler registrations.

I then started using longer messages (I keep wanting to say Layer 3 but it's
probably not) and I got lost in a world of F'n standards. I had thought that
j1939 was for lorries in the US or something. I Ended up going with ISO-15765
to send longer messages. Because of the way I did my frames I ended up doing
the same with this protocol:

register_iso15765_handler(filter, iso15765_handler_function)

I have to enable a switch at build time and if ISO-15765 is enabled a frame
handler is registered:

register_handler(iso15765_frame_filter, iso15765_dispatch_function)

The iso15765 dispatcher now just receives all frames which is assembles into
messages and dispatches them to interested parties.
That all worked for what I was trying to do which was reflash units across the
CanBus network. As a result of that application my Messages are Flash Row
sized.

As I could now send long messages with ISO-15765 I had a dedicated unit on my
Can Bus network which acted as a "logger" for the whole bus. Any node that had
something to log just sent an ISO-15765 message.

We're now getting to Linux as the RaspberryPi came along. I had a CanBus
logger using ISO-15765 but the unit was a microcontroller which just fired it
over RS232 to a minicom log running on a laptop. The RaspberryPi had a File
System!!! 

Because I already had a logger which basically was a call to:

register_iso15765_handler(filter, iso15765_handler_function)

I used SocketCan in RAW mode to grab all frames and ported my frame
dispatcher. So my ISO-15765 dispatcher which simply registered a frame handler
is the same code on microcontroller and Linux (RPi) And my CanBus Network
Logger is similar code as well. In the case of RPi it writes the logging
messages to the File System, not to RS232.


I was happy with Can Frames and ISO-15765 when somebody asked me to do some
work on a boat. That's NMEA2000 and found that that is based on ISO-11783. Man
there are too many protocols! ISO-11783 don't encode the length of the message
:-( And it has a function based addressing scheme :-( AND an extended 29 Bit
Can Frame can ONLY be either ISO-15765 or ISO-11783 :-(

I can't remember the CAN ID pattern but there are two bits in the extended can
frame which dictate either ISO-15765 or ISO-11783.

Given the path I've taken I've sort of implemented ISO-11783 the same
way as I have ISO-15765. So now my microcontroller "Applications" can:

register_handler(iso15765_filter, handler_function)
register_iso15765_handler(iso15765_filter, iso15765_handler_function)
register_iso11783_handler(iso11783_filter, iso11783_handler_function)

Only standard 11 bit can ID frames can use the first registration but all my
nodes use Standard frames for sending data around the network. 8 Bytes is huge
in my microcontroller world.

I'm not very well versed in Linux but what I've done seems wrong in this
environment. I mean if I was running my Can Bus Logger and another higher
layer application I'd have two SocketCan connections with 2 Can Frame
dispatchers and 2 ISO-15765 dispatchers and 2 ISO-11783 dispatchers. Obviously
totally wrong.

The advantage from my end is that I can run the same code on microcontrollers
as RPi. So even if it's wrong it sort of works for me.


The only reason I wrote all this is because of the recent discussion on
J1939. I've never read that standard but my understanding is that I can't use
that for NMEA2000 data on a boat as NMEA defines their own PGN codes and
messages. I'm looking at them in the canboat project on github.

I should actually look at the Linux-j1939 API and work through that with a cup
of tea. I've only really looked at http://elinux.org/J1939 and given my
limited and restricted background it feels wrong:

ip link set can0 j1939 on

Obviously my arch is wrong in Linux but a Can Bus is a transport network. Same
as TCP/IP it can transport anything all at the same time. (magic)

I should duck my head back down ;-)


John
