From: John Whitmore <arigead@gmail.com>
Subject: Re: j1939 (Higher Layer Protocols)
Date: Mon, 9 Nov 2015 19:48:25 +0000
Message-ID: <20151109194823.GA6539@bamboo.electronicsoup>
References: <20151105180831.GA24951@bamboo.electronicsoup>
 <563BAC5A.8060604@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:32894 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751640AbbKITsc (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 9 Nov 2015 14:48:32 -0500
Received: by wmec201 with SMTP id c201so98586797wme.0
        for <linux-can@vger.kernel.org>; Mon, 09 Nov 2015 11:48:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <563BAC5A.8060604@posteo.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Menschel.P" <menschel.p@posteo.de>
Cc: linux-can@vger.kernel.org

Sorry for the delay been having connectivity issues. Rest inline:

On Thu, Nov 05, 2015 at 08:22:02PM +0100, Menschel.P wrote:
> Hello John,
> 
> if it's just about the standards hierarchy, I can help.
> 
> 1.SAE J1939 is on top. Truck and Construction Equipment usage, although
> US Trucks are mainly J1587 (RS485) with J1708 protocol.
> 1.1 SAEJ1939 defines its own transport protocol to transmit a PGN longer
> than 8Bytes.
> 1.2 Additionally ISO15765 aka "KWP2000 over CAN" defines another
> transport protocol closely linked to KWP2000(ISO 14230) or the newer
> UDS(ISO14229).
> It is basically a wrapper for half-duplex serial communication over CAN.

"Half duplex serial" you could say is all anything built on CAN. Either way
it's not related to j1939 so it doesn't confuse me. I have my own
implementation and it's not interfering with anything.

> 
> 2.NMEA2000 is the marine adaption of J1939, agriculture equipment often
> uses NMEA2000 GPS devices.
> 2.1 NMEA2000 FAST Packet is another transport protocol for >8Byte
> messages. I believe that's what you encountered on the boat. I don't
> know the details.
> 
> 3.ISOBUS(ISO 11783) is the agriculture adaption of J1939
> 3.1 Since the devices of the agriculture equipment can be used in
> multiple combinations, ISOBUS has mechanisms to register new devices to
> the CAN bus and so on. AFAIK there is no additional transport protocol.
> 

So leaving ISO15765 to one side the other 3 are closely related. Does this
mean that a Linux implementation of j1939 could be used for my NEMA2000
requirements? 

To be honest I think it's easier for me to look at the ISO-11783 spec and
reverse engineer the NEMA2000 bits I need. I looked at buying the NEMA2000
specs but you have to buy them all in a job lot for a lot of money. Can't
really afford that unfortunately.

Maybe I could jsut Linux J1939 but that might depend on subtle differences in
Transport protocol.

> Regards,
> Patrick
> 
> 
> Am 05.11.2015 um 19:08 schrieb John Whitmore:
> > Newbie here so this could go to kernel newbies mailing list but it is Can
> > Related so here goes.
> >
> > I'm coming at this from the restricted bubble of microcontrollers, but just so
> > you know what that produced...
> >
> > I have a low level library of code which handles all Can frames (I keep
> > wanting to say Layer 2 but it's probably not) on my single Can
> > Interface. Basically it is a dispatcher which handles all the frames. So the
> > main loop of my embedded microcontroller reads a frame and dispatches it.
> >
> > "Application" code then just registers a handler something like
> >
> > register_handler(filter, handler_function)
> >
> > It's fairly basic but it works for me. I'm working on my own networks so don't
> > have to worry about the rest of the world. And I was only using 8 Byte
> > messages. All my different nodes are basically the low level dispatcher which
> > is alway the same and specific handler registrations.
> >
> > I then started using longer messages (I keep wanting to say Layer 3 but it's
> > probably not) and I got lost in a world of F'n standards. I had thought that
> > j1939 was for lorries in the US or something. I Ended up going with ISO-15765
> > to send longer messages. Because of the way I did my frames I ended up doing
> > the same with this protocol:
> >
> > register_iso15765_handler(filter, iso15765_handler_function)
> >
> > I have to enable a switch at build time and if ISO-15765 is enabled a frame
> > handler is registered:
> >
> > register_handler(iso15765_frame_filter, iso15765_dispatch_function)
> >
> > The iso15765 dispatcher now just receives all frames which is assembles into
> > messages and dispatches them to interested parties.
> > That all worked for what I was trying to do which was reflash units across the
> > CanBus network. As a result of that application my Messages are Flash Row
> > sized.
> >
> > As I could now send long messages with ISO-15765 I had a dedicated unit on my
> > Can Bus network which acted as a "logger" for the whole bus. Any node that had
> > something to log just sent an ISO-15765 message.
> >
> > We're now getting to Linux as the RaspberryPi came along. I had a CanBus
> > logger using ISO-15765 but the unit was a microcontroller which just fired it
> > over RS232 to a minicom log running on a laptop. The RaspberryPi had a File
> > System!!! 
> >
> > Because I already had a logger which basically was a call to:
> >
> > register_iso15765_handler(filter, iso15765_handler_function)
> >
> > I used SocketCan in RAW mode to grab all frames and ported my frame
> > dispatcher. So my ISO-15765 dispatcher which simply registered a frame handler
> > is the same code on microcontroller and Linux (RPi) And my CanBus Network
> > Logger is similar code as well. In the case of RPi it writes the logging
> > messages to the File System, not to RS232.
> >
> >
> > I was happy with Can Frames and ISO-15765 when somebody asked me to do some
> > work on a boat. That's NMEA2000 and found that that is based on ISO-11783. Man
> > there are too many protocols! ISO-11783 don't encode the length of the message
> > :-( And it has a function based addressing scheme :-( AND an extended 29 Bit
> > Can Frame can ONLY be either ISO-15765 or ISO-11783 :-(
> >
> > I can't remember the CAN ID pattern but there are two bits in the extended can
> > frame which dictate either ISO-15765 or ISO-11783.
> >
> > Given the path I've taken I've sort of implemented ISO-11783 the same
> > way as I have ISO-15765. So now my microcontroller "Applications" can:
> >
> > register_handler(iso15765_filter, handler_function)
> > register_iso15765_handler(iso15765_filter, iso15765_handler_function)
> > register_iso11783_handler(iso11783_filter, iso11783_handler_function)
> >
> > Only standard 11 bit can ID frames can use the first registration but all my
> > nodes use Standard frames for sending data around the network. 8 Bytes is huge
> > in my microcontroller world.
> >
> > I'm not very well versed in Linux but what I've done seems wrong in this
> > environment. I mean if I was running my Can Bus Logger and another higher
> > layer application I'd have two SocketCan connections with 2 Can Frame
> > dispatchers and 2 ISO-15765 dispatchers and 2 ISO-11783 dispatchers. Obviously
> > totally wrong.
> >
> > The advantage from my end is that I can run the same code on microcontrollers
> > as RPi. So even if it's wrong it sort of works for me.
> >
> >
> > The only reason I wrote all this is because of the recent discussion on
> > J1939. I've never read that standard but my understanding is that I can't use
> > that for NMEA2000 data on a boat as NMEA defines their own PGN codes and
> > messages. I'm looking at them in the canboat project on github.
> >
> > I should actually look at the Linux-j1939 API and work through that with a cup
> > of tea. I've only really looked at http://elinux.org/J1939 and given my
> > limited and restricted background it feels wrong:
> >
> > ip link set can0 j1939 on
> >
> > Obviously my arch is wrong in Linux but a Can Bus is a transport network. Same
> > as TCP/IP it can transport anything all at the same time. (magic)
> >
> > I should duck my head back down ;-)
> >
> >
> > John
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-can" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 


