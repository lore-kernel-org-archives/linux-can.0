From: Tom Evans <tom_usenet@optusnet.com.au>
Subject: Re: Bad reading from mcp2515 with j1939
Date: Mon, 18 Apr 2016 14:29:43 +1000
Message-ID: <571462B7.8020905@optusnet.com.au>
References: <136B5347-DD98-4021-98C5-2FD18FC925A4@anemomind.com>
 <20160415101957.GA22129@airbook.vandijck-laurijssen.be>
 <4C069C3C-A7B8-4D3D-BA66-0D2140E93996@anemomind.com>
 <57110047.3040305@grandegger.com>
 <86B92DF4-DB93-457E-8BFB-7FA1BBBE2B4D@anemomind.com>
Reply-To: tom_usenet@optusnet.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail110.syd.optusnet.com.au ([211.29.132.97]:53217 "EHLO
	mail110.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751054AbcDRExz (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 18 Apr 2016 00:53:55 -0400
In-Reply-To: <86B92DF4-DB93-457E-8BFB-7FA1BBBE2B4D@anemomind.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Julien Pilet <julien@anemomind.com>, Wolfgang Grandegger <wg@grandegger.com>
Cc: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 16/04/16 02:25, Julien Pilet wrote:
> Hi,
>
> Thanks a lot for your help, I found the error.
 > There was a resistor that was not supposed to be
 > there (120ohms between CANH and CANL).
 > Removing it solved the problem.

Do you mean there was an EXTRA terminating resistor that you removed? The CAN 
bus is specified to have two 120 ohm resistors, normally situated as close to 
the ends of the cable as reasonably possible. Check the diagrams and read the 
"Physical Layer" part of the following for details:

https://en.wikipedia.org/wiki/CAN_bus#Layers

A CAN bus should be able to tolerate three 120 ohm terminators. The On Semi 
AMIS-42770 is specified to work with a minimum termination resistance of 42.5 
ohms. If the bus wiring is high resistance, there are bad connections, or if 
someone has added series resistors or inductors between the transceivers and 
the bus then it might not even work with two terminators. You should check for 
this.

I was very surprised that it was able to receive bad data. There's a 15-bit 
checksum on the data. The only way to have bad data is to have a two-bit or a 
three-bit error that generates the same checksum, or a data bit error and a 
checksum bit error that cancel each other out.

That is extremely unlikely as normally a CAN bus has multiple devices, and 
they're all checking all packets on the wire, all the time. If ANY of them 
detect an error, then they report it back to the wire and that invalidates the 
message, forcing a retransmit.

Do you have only the one transmitter and the one receiver on that bus? If 
there's only the one receiver then it is more likely that a corrupted or noisy 
signal could sneak through bad data. The sensitivity to "every even byte over 
0x80" implies a specific data pattern, stuffing bit and checksum sensitivity.

Do the baud rates match exactly or are they around 1% out? That can cause 
problems related to runs of zeros and stuff bits.

You should monitor TEC and REC if they're available through the interface and 
drivers. It is a boat. What is the common grounding like? You might be getting 
ground shifts between the devices that could be making things worse.

Tom

