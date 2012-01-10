From: Sebastian Haas <dev@sebastianhaas.info>
Subject: Re: Bus-simulation with SocketCAN
Date: Tue, 10 Jan 2012 22:11:42 +0100
Message-ID: <4F0CA98E.2050400@sebastianhaas.info>
References: <4F0B6B35.20104@sebastianhaas.info> <4F0C1304.4060309@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtprelay02.ispgateway.de ([80.67.31.25]:55495 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751280Ab2AJVLn (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 10 Jan 2012 16:11:43 -0500
In-Reply-To: <4F0C1304.4060309@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: socketcan-users@lists.berlios.de, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Jan-Niklas Meier <dschanoeh@googlemail.com>

Hi

Am 10.01.2012 11:29, schrieb Oliver Hartkopp:
> Hello Sebastian,
>
> On 09.01.2012 23:33, Sebastian Haas wrote:
>
>> just in case someone is interested in an easy to way to simulate CAN nodes or
>> to test ECUs via CAN. I want to inform you that my recently started project
>> restcan [3] reached a first milestone. Look at [1] to know what restcan is.
>>
>> The milestone includes the following features:
>> - support of SocketCANs' RAW channels incl. Rx filters
>> - support of a rudimentary JSON-based message database format
>
>
> Do you know the Kayak project from Jan-Niklas Meier?
>
> Kajak is a JAVA based frontend and library, see:
>
> http://kayak.2codeornot2code.org/
>
> http://kayak.2codeornot2code.org/tutorial.html
>
> And on github: https://github.com/dschanoeh/Kayak
That looks quite interesting. The approach is different than mine, as 
the logic in restcan is at the server side and the client (not yet 
available) is an optional visualization/control component.

It is quite difficult to find active open source projects which are CAN 
related. I hope to find some help to implement the visualization for 
restcan. Too bad Kayak does the signal processing on its own.

> Implementing a restbus functionality in JAVA based on the Kajak library is
> very easy - when  you are a JAVA developer ;-)
>
> I like your approach to get a restbus simulation in C.
Well the simulation is written in Javascript, which is even easier than 
C or Java. I want it to be easy to use. The only dependency is NodeJS 
and you can write and run simulation and test cases from commandline 
within few minutes.

> But checking your JSON description for CAN signals i stumbled about the
> 'intel' and 'motorola' tags which stand for 'little' and 'big' endian.
Yeah, you are right. I will improve it.

> I wonder, if it makes sense for your project to adopt the XML-based KCD
> format for CAN signal descriptions:
I had a look at the spec, KCD looks pretty good, I think I will use it 
to replace the JSON description.

> https://github.com/dschanoeh/Kayak/blob/ee6b459bddd1831ae99c1afcde01f315e4b454b4/Kayak-kcd/src/test/resources/can_definition_sample.kcd
>
> Here is the XML schema definition:
>
> https://github.com/dschanoeh/Kayak/blob/master/Kayak-kcd/src/main/resources/com/github/kayak/canio/kcd/schema/Definition.xsd
>
> Maybe you can build your JSON description with an XSLT process from the well
> defined KCD description.
>
> There's also a dbc input converter on the run to create KCDs:
> https://github.com/dschanoeh/CANBabel
Thats create, I was afraid I need to implement the converter myself. ;-) 
I hope they will extend to parse .sym files from Peak as well.

Do you know about BUSMASTER (https://github.com/rbei-etas/busmaster). If 
it weren't Windows (R) only it would be an interesting solution.

Oliver, what must restcan provide to be useable for you in your daily 
work? Or what do you expect from such a tool?

Cheers,
  Sebastian
