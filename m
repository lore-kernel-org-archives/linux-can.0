From: Tom Evans <tom_usenet@optusnet.com.au>
Subject: Re: socket can receive order
Date: Thu, 10 Sep 2015 12:29:41 +1000
Message-ID: <55F0EB15.30601@optusnet.com.au>
References: <55EEAD8D.3070603@engineeredarts.co.uk>
 <55EEB217.3080706@pengutronix.de> <55EEBB4E.6080104@engineeredarts.co.uk>
 <55EEC2BD.6010302@pengutronix.de> <55EECAAE.1020901@grandegger.com>
Reply-To: tom_usenet@optusnet.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail107.syd.optusnet.com.au ([211.29.132.53]:41797 "EHLO
	mail107.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752307AbbIJC3p (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 9 Sep 2015 22:29:45 -0400
In-Reply-To: <55EECAAE.1020901@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Daniel Squires <dan@engineeredarts.co.uk>, linux-can@vger.kernel.org

On 08/09/15 21:46, Wolfgang Grandegger wrote:
>
> Am 08.09.2015 um 13:13 schrieb Marc Kleine-Budde:
>> On 09/08/2015 12:41 PM, Daniel Squires wrote:
>>> On my laptop and Desktop PC I have not seen it happen.
>> I mean what kind of CAN adapter...
>
> "https://github.com/fabiobaltieri/open-usb-can" seems to use a MCP251=
5
> controller.

http://fabiobaltieri.com/2013/07/23/hacking-into-a-vehicle-can-bus-toyo=
thack-and-socketcan/#more-1419

"my own open hardware USB AVR + MCP2515 interface", "the performances a=
re not=20
that good above 250kbps", "It=E2=80=99s tempting to use an SPI controll=
er (the MCP2515=20
is very common), but that has terrible performances on highly loaded fa=
st=20
busses, and you will end up with problem such as RX buffer underruns an=
d=20
out-of-order frames."

He means "overruns". The MCP2515 doesn't have a FIFO. Messages have to =
be read=20
out over a slow SPI bus one bit at a time within one message time or it=
=20
overruns. Or two if the BUKT bit is set, but that risks reading message=
s in=20
the wrong order.

The design uses an ATMEGA32U2 and an MCP2515. I can't see why it should=
n't be=20
able to buffer messages from the MCP2515 at relatively high data rates,=
 if the=20
code is well written. From my experience though, code for the MCP2515 i=
s=20
seldom "well written". It is too easy to fall into a trap and get the m=
essage=20
arrival order wrong.

This is unlikely to be related to the OP's problem, but just something =
to be=20
aware of.

=46or anybody still coding and debugging MCP2515 stuff:

http://www.microchip.com/forums/m620741.aspx

 > otherwise its prone to loosing TX packets when loaded.

Do you know about having to do something like the following to stop CAN=
=20
Transmit Drops? The networking stack defaults to DROPPING CAN transmit =
frames=20
before blocking the socket if you don't.

     /bin/echo 256 > /sys/class/net/can0/tx_queue_len
     ...
     int sndbuf =3D (250 + 8) * 256;
     socklen_t socklen =3D sizeof(sndbuf);
     /* Minimum socket buffer to try and get it blocking */
     rc =3D setsockopt(pSkt->skt, SOL_SOCKET, SO_SNDBUF,
                     &sndbuf, sizeof(sndbuf));


http://socket-can.996257.n3.nabble.com/Solving-ENOBUFS-returned-by-writ=
e-td2886.html

Tom



