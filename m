From: "Gerhard Bertelsmann" <info@gerhard-bertelsmann.de>
Subject: Re: Linux board with 10 CANs
Date: Mon, 18 May 2015 11:40:11 +0200 (CEST)
Message-ID: <45240.212.149.48.43.1431942011.squirrel@webmail.rdts.de>
References: <5555A6A3.7090206@orange.fr> <55560FA4.4090300@optusnet.com.au>
    <5559AFF6.3040509@orange.fr>
Reply-To: info@gerhard-bertelsmann.de
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.rdts.de ([195.243.153.28]:56670 "EHLO mail.rdts.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753389AbbERJt5 (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 18 May 2015 05:49:57 -0400
In-Reply-To: <5559AFF6.3040509@orange.fr>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?utf-8?B?RnJhbsOnb2lzIEJlYXVsaWVy?= <fbeaulier@orange.fr>
Cc: Tom Evans <tom_usenet@optusnet.com.au>, linux-can@vger.kernel.org

Hi Francois,
Am Mo, 18.05.2015, 11:25, schrieb Fran=C3=A7ois Beaulier:
> Hi Tom,
>
> Freescale MPC574X chips are MCUs, you can't run Linux on them.
> Vybrid SOCs have 2 CANs max.
> I know the MCP2515 may work in some situation but it depends on kerne=
l
> latency and that is very unpredictable.
> What is helping in QSPI ? the main problem beeing latency between MCP
> irq and effective SPI transfer ?

Yes, latency is the main problem with the MCP2515 connected via SPI.
But I have no doubt that it would be possible using a BeagleBone Black
with it's two integrated PRUs (2x200 MHz MCUs). If you connect 4 MCP251=
5
to each PRU they could be served even at 1MBit @ full speed. With
the already 2 integrated CAN controller you can easily have 10 CANs.

The only concern that I have is the latency/overhead of the SocketCAN
API with 10 CANs at high packet rates on 1 GHz ARM ...

Regards

Gerd

