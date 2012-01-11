From: Jan-Niklas Meier <dschanoeh@googlemail.com>
Subject: Re: Bus-simulation with SocketCAN
Date: Wed, 11 Jan 2012 09:38:26 +0100
Message-ID: <CAEuXk93BiNr816GocOHX8DS6g=2Lsyd4NPbbH1Hw0Gyc5RbAgA@mail.gmail.com>
References: <4F0B6B35.20104@sebastianhaas.info>
	<4F0C1304.4060309@hartkopp.net>
	<4F0CA98E.2050400@sebastianhaas.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:63917 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754749Ab2AKIi1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 11 Jan 2012 03:38:27 -0500
Received: by ggdk6 with SMTP id k6so196198ggd.19
        for <linux-can@vger.kernel.org>; Wed, 11 Jan 2012 00:38:26 -0800 (PST)
In-Reply-To: <4F0CA98E.2050400@sebastianhaas.info>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Sebastian Haas <dev@sebastianhaas.info>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, socketcan-users@lists.berlios.de, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi!

2012/1/10 Sebastian Haas <dev@sebastianhaas.info>:

> That looks quite interesting. The approach is different than mine, as=
 the
> logic in restcan is at the server side and the client (not yet availa=
ble) is
> an optional visualization/control component.
>
> It is quite difficult to find active open source projects which are C=
AN
> related. I hope to find some help to implement the visualization for
> restcan. Too bad Kayak does the signal processing on its own.

I agree that the approaches are quite different and also we are trying
to cover different use cases with our projects. With Kayak I tried to
provide a free CAN bus analysis solution. The TCP/IP abstraction is a
nice feature which enables you to do things like remote analysis and
to connect from multiple machines at once.
Kayak is not - and will probably never be - a very good tool for
restbus simulation. In principle it is possible but Kayak is not
intended for this.

>> Implementing a restbus functionality in JAVA based on the Kajak libr=
ary is
>> very easy - when =A0you are a JAVA developer ;-)
>>
>> I like your approach to get a restbus simulation in C.
>
> Well the simulation is written in Javascript, which is even easier th=
an C or
> Java. I want it to be easy to use. The only dependency is NodeJS and =
you can
> write and run simulation and test cases from commandline within few m=
inutes.

I like the idea of using Javascript and especially NodeJS for restbus
simulation. At the weekend I will try to set it up at home and play
around a little bit :).

>> I wonder, if it makes sense for your project to adopt the XML-based =
KCD
>> format for CAN signal descriptions:
>
> I had a look at the spec, KCD looks pretty good, I think I will use i=
t to
> replace the JSON description.

\o/ Yay! That's a good idea.

>> There's also a dbc input converter on the run to create KCDs:
>> https://github.com/dschanoeh/CANBabel
>
> Thats create, I was afraid I need to implement the converter myself. =
;-) I
> hope they will extend to parse .sym files from Peak as well.

We mostly have .dbc files we need to convert. Support for different
formats (and possibly even conversion in both ways) is planned. Do you
use PEAK .sym-files and could you provide some example files and help
finding bugs in a .sym-Parser?

> Do you know about BUSMASTER (https://github.com/rbei-etas/busmaster).=
 If it
> weren't Windows (R) only it would be an interesting solution.
>
> Oliver, what must restcan provide to be useable for you in your daily=
 work?
> Or what do you expect from such a tool?

How lightweight is NodeJS? I would find this useful for quick and
dirty hacks in embedded units. Could memory (Flash and RAM) be a
problem on such devices?

Greetings,
Jan
