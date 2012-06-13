From: Keith Jones <keith.rjones@yahoo.com>
Subject: Re: flexcan_poll_error_state(struct net_device *dev, u32 reg_esr)
Date: Wed, 13 Jun 2012 12:35:05 -0700 (PDT)
Message-ID: <1339616105.48707.YahooMailNeo@web140804.mail.bf1.yahoo.com>
References: <1338849280.43608.YahooMailNeo@web140802.mail.bf1.yahoo.com> <1338849547.86575.YahooMailNeo@web140805.mail.bf1.yahoo.com> <1338852261.93934.YahooMailNeo@web140802.mail.bf1.yahoo.com> <4FCDB93D.5030007@pengutronix.de> <1339086557.44691.YahooMailNeo@web140804.mail.bf1.yahoo.com> <4FD4DD58.3070302@pengutronix.de>
Reply-To: Keith Jones <keith.rjones@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from nm14.bullet.mail.bf1.yahoo.com ([98.139.212.173]:31008 "HELO
	nm14.bullet.mail.bf1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752321Ab2FMTfG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 13 Jun 2012 15:35:06 -0400
In-Reply-To: <4FD4DD58.3070302@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>



On Sunday, June 10, 2012 10:46 AM, Marc Kleine-Budde wrote:

> Port the 3.4 flexcan driver to you 2.6.35 Kernel.

Okay I copied into my 2.6.34 kernel the following with minimal mods des=
cribed below:=20

drivers/net/can/flexcan.c - used module_init(flexcan_init) and module_e=
xit(flexcan_exit) from 2.6.35
drivers/net/can/dev.c
drivers/net/can/Kconfig=20
drivers/net/can/Makefile - commented out c_can, cc770, and softing for =
now
include/linux/can/platform/flexcan.h
drivers/net/can
include/linux/clk.h


I compiled, booted, and up'd=A0 can0 using:

ip link set can0 type can bitrate 250000

Attached a terminated DB9 (120ohm resister across pins 2 and 7) to imx_=
ard board. On a remote terminated device I sent J1939/Nmea2000 messages=
 at 5 hertz.

When sniffing the bus=A0 I again observed "ErrorFrame" messages with Co=
de : Stuff Error.
On the ard board, all I observe is interrupts on can0 and one or two Rx=
 packets.
can state: ERROR-WARNING
When I down the ard board can0 interface no error packets are sniffed o=
n bus and J1939 signals start
When I up the ard board can0 interface error packets are sniffed=A0 and=
 J1939 signals stop

I am running at 250000 bitrate.

Using flexcan driver from 2.6.35 kernel. The bitrate cannot be set dyna=
mically using iproute tools. In addition, the BSP requires a ENGR001696=
03-MX53-ARD-FlexCAN-Set-lp-apm patch for proper clock source.=A0 Attemp=
ting to set the bitrate produces a "RTNETLINK answers: Operation not su=
pported" message. I am able to send and receive packets by adding patch=
 and hard coding the bitrate.

Using flexcan driver from 2.6.35. I am able to set any bitrate, but I g=
et lots of interrupts with no packets received or sent. Note: I did not=
 use patch for this test.

What is the major difference between 2.3.35 (which sort-of works) and 3=
=2E4 which produces error frames? I would like to use the latest kernel=
 driver if I could better understand the issues I am seeing on my demo =
ard board. Are you aware of flexcan success with 3.4 kernel on imx536?=A0=
 Why is the driver sending error frames and not passing packets up-stre=
am?

thanks

-keith
Hemisphere GPS
