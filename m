From: Sebastian Haas <dev@sebastianhaas.info>
Subject: Re: Bus-simulation with SocketCAN
Date: Sat, 14 Jan 2012 10:45:37 +0100
Message-ID: <4F114EC1.1050705@sebastianhaas.info>
References: <4F0B6B35.20104@sebastianhaas.info> <4F0C1304.4060309@hartkopp.net> <4F0CA98E.2050400@sebastianhaas.info> <CAEuXk93BiNr816GocOHX8DS6g=2Lsyd4NPbbH1Hw0Gyc5RbAgA@mail.gmail.com> <4F108ED0.3080105@sebastianhaas.info> <000901ccd237$aae943f0$00bbcbd0$@wilhelm@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtprelay01.ispgateway.de ([80.67.18.43]:54995 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753272Ab2ANJpd (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 14 Jan 2012 04:45:33 -0500
In-Reply-To: <000901ccd237$aae943f0$00bbcbd0$@wilhelm@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Uwe Wilhelm <u.wilhelm@peak-system.com>
Cc: 'Jan-Niklas Meier' <dschanoeh@googlemail.com>, 'Oliver Hartkopp' <socketcan@hartkopp.net>, linux-can@vger.kernel.org, s.grosjean@peak-system.com

Hello Uwe,

would be great if could provide us example .sym files which utilize the=
=20
whole feature set of the SYM file format.

Specifications or example codes are also very much appreciated. ;-)

Thanks for your support.

Cheers,
  Sebastian

Am 13.01.2012 22:09, schrieb Uwe Wilhelm:
> Dear Sebastian,
> if you need any help with the SYM File Format, please let us know.
>
> Best Regards
>
>   Uwe Wilhelm
>   PEAK-System
>   Sales&  Support
>
> -----Urspr=FCngliche Nachricht-----
> Von: linux-can-owner@vger.kernel.org
> [mailto:linux-can-owner@vger.kernel.org] Im Auftrag von Sebastian Haa=
s
> Gesendet: Freitag, 13. Januar 2012 21:07
> An: Jan-Niklas Meier
> Cc: Oliver Hartkopp; linux-can@vger.kernel.org; s.grosjean@peak-syste=
m.com
> Betreff: Re: Bus-simulation with SocketCAN
>
> Hello together,
>
> Am 11.01.2012 09:38, schrieb Jan-Niklas Meier:
>> 2012/1/10 Sebastian Haas<dev@sebastianhaas.info>:
>>>> Implementing a restbus functionality in JAVA based on the Kajak li=
brary
> is
>>>> very easy - when  you are a JAVA developer ;-)
>>>>
>>>> I like your approach to get a restbus simulation in C.
>>>
>>> Well the simulation is written in Javascript, which is even easier =
than C
> or
>>> Java. I want it to be easy to use. The only dependency is NodeJS an=
d you
> can
>>> write and run simulation and test cases from commandline within few
> minutes.
>>
>> I like the idea of using Javascript and especially NodeJS for restbu=
s
>> simulation. At the weekend I will try to set it up at home and play
>> around a little bit :).
> Sounds good. I hope you like it and we can work together on it.
>
>>>> I wonder, if it makes sense for your project to adopt the XML-base=
d KCD
>>>> format for CAN signal descriptions:
>>>
>>> I had a look at the spec, KCD looks pretty good, I think I will use=
 it to
>>> replace the JSON description.
>>
>> \o/ Yay! That's a good idea.
> Yes KCD looks quite complete to describe a whole CAN network include =
the
> communicate. But I'm not yet sure how to extend it for specific featu=
res
> like other protocols.
>
> The basic idea was to have a NodeJS instance for each CAN node to
> simulate. Basically the API allows also to simulate many nodes within
> the same NodeJS instance. But I think it is easier for an developer t=
o
> develop and test CAN nodes in different instances.
>
>>>> There's also a dbc input converter on the run to create KCDs:
>>>> https://github.com/dschanoeh/CANBabel
>>>
>>> Thats create, I was afraid I need to implement the converter myself=
=2E ;-)
> I
>>> hope they will extend to parse .sym files from Peak as well.
>>
>> We mostly have .dbc files we need to convert. Support for different
>> formats (and possibly even conversion in both ways) is planned. Do y=
ou
>> use PEAK .sym-files and could you provide some example files and hel=
p
>> finding bugs in a .sym-Parser?
> No I do not have any PEAK files, but I wonder @Stephane may help us.
>
>>> Do you know about BUSMASTER (https://github.com/rbei-etas/busmaster=
). If
> it
>>> weren't Windows (R) only it would be an interesting solution.
>>>
>>> Oliver, what must restcan provide to be useable for you in your dai=
ly
> work?
>>> Or what do you expect from such a tool?
>>
>> How lightweight is NodeJS? I would find this useful for quick and
>> dirty hacks in embedded units. Could memory (Flash and RAM) be a
>> problem on such devices?
> This thought came also in my mind. I wonder on which type of machines
> (available RAM) do you want run it?
>
> NodeJS just relies on STL and PThread. But I'm afraid STL is quite bi=
g
> ;-) ... Heap usage looks quite good IMHO. If I let signal_tx.js runni=
ng
> the Gnome System monitor reports 2.3MB memory usage. If you also take
> shared libaries into account the footprint explodes up to 64MB. But I
> wonder if it is possible to compile NodeJS/V8 against a more memory
> sensible version of the STL.
>
> Cheers,
>    Sebastian
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> --
> PEAK-System Technik GmbH, Otto-Roehm-Strasse 69, D-64293 Darmstadt
> Geschaeftsleitung: A.Gach/U.Wilhelm, HRB 9183 Darmstadt, Ust.IdNr.:DE=
 202 220 078
> St.Nr.:007/241/13586 FA Darmstadt, WEE-Reg.-Nr.: DE39305391
> Tel.:+49 (0)6151 8173-20 - Fax:+49 (0)6151 8173-29
> E-mail: info@peak-system.com - http://www.peak-system.com
