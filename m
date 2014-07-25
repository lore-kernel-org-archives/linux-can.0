From: Ssagarr Patil <hugarsagar@outlook.com>
Subject: RE: C_CAN: can frame drops
Date: Fri, 25 Jul 2014 13:43:47 +0530
Message-ID: <BAY176-W4D41B1290DE5D3B2BD6D0D3FC0@phx.gbl>
References: <BAY176-W240BDB3FFF425370BF5B47D3FE0@phx.gbl>,<53D204A4.1060502@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from bay004-omc4s17.hotmail.com ([65.54.190.219]:60595 "EHLO
	BAY004-OMC4S17.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757022AbaGYINr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 25 Jul 2014 04:13:47 -0400
In-Reply-To: <53D204A4.1060502@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Marc,

>>
>> I am using the c_can driver for latest kernel and using the latest c=
anutils to dump to a file.
>> My can bus is set at a rate of 1Mb (receiving 7000fps bus load of 80=
%).
>>
>> When I use the candump tool to dump can frames I get following messa=
ge,
>>
>> 'DROPCOUNT: dropped 2223 CAN frames on 'any' socket (total drops 162=
9092)'
>
> These are the CAN frames dropped by the socket, this means as Oliver
> pointed out, that the candump fails to read the CAN frames fast enoug=
h
> from the socket. How do you connect to the linux box with the c_can?
> Where are the CAN frames printed to?
>
Agreed this is dropped by the socket, so for this to solve I increased =
the socket size
(with -r option of candump to 111173056) after doing this I see that th=
ere is frame drop in
the driver ie I see this function c_can_handle_lost_msg_obj() being cal=
led frequently in which
can frame is overwritten.

I have a can frame generator which I have connected to the EVM, the EVM=
 is recieving the
frames and just dumping it on stdout going ahead I need to log the canf=
rames to SD card.
=A0
> Dropped CAN frames by the hardware should be counted in the rx droppe=
d
> in ifconfig.

Yes I can even see this too.

Thanks,
--Sagar
 		 	   		  