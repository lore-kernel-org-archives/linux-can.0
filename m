From: John Whitmore <arigead@gmail.com>
Subject: Re: j1939 (Higher Layer Protocols)
Date: Sun, 15 Nov 2015 21:59:20 +0000
Message-ID: <20151115215919.GA8018@BSA-cub>
References: <20151105180831.GA24951@bamboo.electronicsoup>
 <563BAC5A.8060604@posteo.de>
 <20151109194823.GA6539@bamboo.electronicsoup>
 <20151110105257.GA10664@airbook.eia.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:34321 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751184AbbKOV7X (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 15 Nov 2015 16:59:23 -0500
Received: by wmvv187 with SMTP id v187so150335473wmv.1
        for <linux-can@vger.kernel.org>; Sun, 15 Nov 2015 13:59:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20151110105257.GA10664@airbook.eia.lan>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Menschel.P" <menschel.p@posteo.de>, linux-can@vger.kernel.org

Again inline ...

On Tue, Nov 10, 2015 at 11:52:57AM +0100, Kurt Van Dijck wrote:
> My contribution inline ...
> 
> > > 
> > > 1.SAE J1939 is on top. Truck and Construction Equipment usage, although
> > > US Trucks are mainly J1587 (RS485) with J1708 protocol.
> > > 1.1 SAEJ1939 defines its own transport protocol to transmit a PGN longer
> > > than 8Bytes.
> > > 1.2 Additionally ISO15765 aka "KWP2000 over CAN" defines another
> > > transport protocol closely linked to KWP2000(ISO 14230) or the newer
> > > UDS(ISO14229).
> > > It is basically a wrapper for half-duplex serial communication over CAN.
> > 
> > "Half duplex serial" you could say is all anything built on CAN. Either way
> > it's not related to j1939 so it doesn't confuse me. I have my own
> > implementation and it's not interfering with anything.
> > 
> > > 
> > > 2.NMEA2000 is the marine adaption of J1939, agriculture equipment often
> > > uses NMEA2000 GPS devices.
> > > 2.1 NMEA2000 FAST Packet is another transport protocol for >8Byte
> > > messages. I believe that's what you encountered on the boat. I don't
> > > know the details.
> > > 
> > > 3.ISOBUS(ISO 11783) is the agriculture adaption of J1939
> > > 3.1 Since the devices of the agriculture equipment can be used in
> > > multiple combinations, ISOBUS has mechanisms to register new devices to
> > > the CAN bus and so on. AFAIK there is no additional transport protocol.
> > > 
> 
> SAE-J1939's transport protocol has been extended by ISO 11783 to support
> even bigger packets. This is (both) supported by can-j1939.
> 
> SAE-j1939-81 defined dynamic addressing, which is heavily used in
> ISO-11783 busses, and I image NMEA2000 will use the same thing when
> needed. This is supported by can-j1939.
> 
> NMEA2000's fast-packet, as wel as the KWP2000-over-CAN transport are
> transport mechanisms that are defined on a per-PGN basis.  can-j1939 has
> _no_ support for this, i.e. as long as you deliver 8byte pieces to the
> kernel, it will work as expected. This means that these transport
> mechanisms must be implemented (as for now) in userspace.
> As long as the same PGN/SA is not sent from different sockets, no
> multiuser problems would occur.
> 
> You may already have guessed that I never needed to sent the same PGN/SA
> from different sockets yet.
> 
> > 
> > So leaving ISO15765 to one side the other 3 are closely related. Does this
> > mean that a Linux implementation of j1939 could be used for my NEMA2000
> > requirements? 
> 
> I guess so.
> 
> > 
> > To be honest I think it's easier for me to look at the ISO-11783 spec and
> > reverse engineer the NEMA2000 bits I need. I looked at buying the NEMA2000
> > specs but you have to buy them all in a job lot for a lot of money. Can't
> > really afford that unfortunately.
> 
> The fast-packet thing is really simple, works without flow control.
> No worth buying that spec for the transport layers.
> 
> You may still need the application level parts, as this is clearly
> userspace stuff.
> 
> > 
> > Maybe I could jsut Linux J1939 but that might depend on subtle differences in
> > Transport protocol.
> 
> 
> Which subtle differences you refer to?
> I read SAE-J1939 and ISO11783, and I found no differences.
> Can you give an example?
> 
> Kurt

Sorry for the delay in responding been distracted. I've never read SAE-J1939
but only ISO11783 I should have made it clearer when I said "might". I 
was meaning that there might be differences between the two I don't know.

I sort of assumed when they took SAE-J1939 to create ISO11783 that they had a
good reason (Apart from selling another standard) for creating a new standard.
