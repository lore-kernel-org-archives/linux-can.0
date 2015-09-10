From: Daniel Squires <dan@engineeredarts.co.uk>
Subject: Re: socket can receive order
Date: Thu, 10 Sep 2015 09:08:30 +0100
Message-ID: <55F13A7E.6020706@engineeredarts.co.uk>
References: <55EEAD8D.3070603@engineeredarts.co.uk> <55EEB217.3080706@pengutronix.de> <55EEBB4E.6080104@engineeredarts.co.uk> <55EEC2BD.6010302@pengutronix.de> <55EECAAE.1020901@grandegger.com> <55F0EB15.30601@optusnet.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from engineeredarts.co.uk ([162.13.42.246]:47752 "EHLO
	mail.engineeredarts.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751242AbbIJIIf (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 10 Sep 2015 04:08:35 -0400
In-Reply-To: <55F0EB15.30601@optusnet.com.au>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: tom_usenet@optusnet.com.au, linux-can@vger.kernel.org



On 10/09/15 03:29, Tom Evans wrote:
> On 08/09/15 21:46, Wolfgang Grandegger wrote:
>>
>> Am 08.09.2015 um 13:13 schrieb Marc Kleine-Budde:
>>> On 09/08/2015 12:41 PM, Daniel Squires wrote:
>>>> On my laptop and Desktop PC I have not seen it happen.
>>> I mean what kind of CAN adapter...
>>
>> "https://github.com/fabiobaltieri/open-usb-can" seems to use a MCP25=
15
>> controller.
>
> http://fabiobaltieri.com/2013/07/23/hacking-into-a-vehicle-can-bus-to=
yothack-and-socketcan/#more-1419=20
>
>
> "my own open hardware USB AVR + MCP2515 interface", "the performances=
=20
> are not that good above 250kbps", "It=E2=80=99s tempting to use an SP=
I=20
> controller (the MCP2515 is very common), but that has terrible=20
> performances on highly loaded fast busses, and you will end up with=20
> problem such as RX buffer underruns and out-of-order frames."
>
> He means "overruns". The MCP2515 doesn't have a FIFO. Messages have t=
o=20
> be read out over a slow SPI bus one bit at a time within one message=20
> time or it overruns. Or two if the BUKT bit is set, but that risks=20
> reading messages in the wrong order.
>
> The design uses an ATMEGA32U2 and an MCP2515. I can't see why it=20
> shouldn't be able to buffer messages from the MCP2515 at relatively=20
> high data rates, if the code is well written. From my experience=20
> though, code for the MCP2515 is seldom "well written". It is too easy=
=20
> to fall into a trap and get the message arrival order wrong.
>
> This is unlikely to be related to the OP's problem, but just somethin=
g=20
> to be aware of.

Yes, I had read that whole article and didn't use the hardware /=20
firmware there for those reasons. I needed 1Mbit also. I am using the=20
STM32F4 Discovery boards with a CAN phy attached. I didn't know where t=
o=20
start with t kernel module which is why i am suing the one from there a=
t=20
present, it would be nice to get a "standardised" usb class kernel=20
module, but i guess that would require input form the USB implementers=20
group.
>
> For anybody still coding and debugging MCP2515 stuff:
>
> http://www.microchip.com/forums/m620741.aspx
>
> > otherwise its prone to loosing TX packets when loaded.
>
> Do you know about having to do something like the following to stop=20
> CAN Transmit Drops? The networking stack defaults to DROPPING CAN=20
> transmit frames before blocking the socket if you don't.
>
>     /bin/echo 256 > /sys/class/net/can0/tx_queue_len
>     ...
>     int sndbuf =3D (250 + 8) * 256;
>     socklen_t socklen =3D sizeof(sndbuf);
>     /* Minimum socket buffer to try and get it blocking */
>     rc =3D setsockopt(pSkt->skt, SOL_SOCKET, SO_SNDBUF,
>                     &sndbuf, sizeof(sndbuf));
>
I hadn't noticed it could be done in that way, had been using ip=20
utility, but was aware of the 10 frames default queue size and that it=20
could be changed. In my very basic OOO test app i'm actually sending=20
packets with incrementing values until there is no space (send returns=20
ENOBUF), then doing the receives and checking the values until there is=
=20
nothing to receive, before continuing to send from the previous failed=20
value.
>
> http://socket-can.996257.n3.nabble.com/Solving-ENOBUFS-returned-by-wr=
ite-td2886.html=20
>
>
> Tom
>
>
>

--=20
Dan Squires

Engineered Arts Ltd.

