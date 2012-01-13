From: Sebastian Haas <dev@sebastianhaas.info>
Subject: Re: Bus-simulation with SocketCAN
Date: Fri, 13 Jan 2012 21:06:40 +0100
Message-ID: <4F108ED0.3080105@sebastianhaas.info>
References: <4F0B6B35.20104@sebastianhaas.info> <4F0C1304.4060309@hartkopp.net> <4F0CA98E.2050400@sebastianhaas.info> <CAEuXk93BiNr816GocOHX8DS6g=2Lsyd4NPbbH1Hw0Gyc5RbAgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtprelay05.ispgateway.de ([80.67.31.94]:49853 "EHLO
	smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932724Ab2AMUGe (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 13 Jan 2012 15:06:34 -0500
In-Reply-To: <CAEuXk93BiNr816GocOHX8DS6g=2Lsyd4NPbbH1Hw0Gyc5RbAgA@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Jan-Niklas Meier <dschanoeh@googlemail.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "s.grosjean@peak-system.com" <s.grosjean@peak-system.com>

Hello together,

Am 11.01.2012 09:38, schrieb Jan-Niklas Meier:
> 2012/1/10 Sebastian Haas<dev@sebastianhaas.info>:
>>> Implementing a restbus functionality in JAVA based on the Kajak library is
>>> very easy - when  you are a JAVA developer ;-)
>>>
>>> I like your approach to get a restbus simulation in C.
>>
>> Well the simulation is written in Javascript, which is even easier than C or
>> Java. I want it to be easy to use. The only dependency is NodeJS and you can
>> write and run simulation and test cases from commandline within few minutes.
>
> I like the idea of using Javascript and especially NodeJS for restbus
> simulation. At the weekend I will try to set it up at home and play
> around a little bit :).
Sounds good. I hope you like it and we can work together on it.

>>> I wonder, if it makes sense for your project to adopt the XML-based KCD
>>> format for CAN signal descriptions:
>>
>> I had a look at the spec, KCD looks pretty good, I think I will use it to
>> replace the JSON description.
>
> \o/ Yay! That's a good idea.
Yes KCD looks quite complete to describe a whole CAN network include the 
communicate. But I'm not yet sure how to extend it for specific features 
like other protocols.

The basic idea was to have a NodeJS instance for each CAN node to 
simulate. Basically the API allows also to simulate many nodes within 
the same NodeJS instance. But I think it is easier for an developer to 
develop and test CAN nodes in different instances.

>>> There's also a dbc input converter on the run to create KCDs:
>>> https://github.com/dschanoeh/CANBabel
>>
>> Thats create, I was afraid I need to implement the converter myself. ;-) I
>> hope they will extend to parse .sym files from Peak as well.
>
> We mostly have .dbc files we need to convert. Support for different
> formats (and possibly even conversion in both ways) is planned. Do you
> use PEAK .sym-files and could you provide some example files and help
> finding bugs in a .sym-Parser?
No I do not have any PEAK files, but I wonder @Stephane may help us.

>> Do you know about BUSMASTER (https://github.com/rbei-etas/busmaster). If it
>> weren't Windows (R) only it would be an interesting solution.
>>
>> Oliver, what must restcan provide to be useable for you in your daily work?
>> Or what do you expect from such a tool?
>
> How lightweight is NodeJS? I would find this useful for quick and
> dirty hacks in embedded units. Could memory (Flash and RAM) be a
> problem on such devices?
This thought came also in my mind. I wonder on which type of machines 
(available RAM) do you want run it?

NodeJS just relies on STL and PThread. But I'm afraid STL is quite big 
;-) ... Heap usage looks quite good IMHO. If I let signal_tx.js running 
the Gnome System monitor reports 2.3MB memory usage. If you also take 
shared libaries into account the footprint explodes up to 64MB. But I 
wonder if it is possible to compile NodeJS/V8 against a more memory 
sensible version of the STL.

Cheers,
  Sebastian
