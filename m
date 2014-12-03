From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: [PATCH 2/3] can/peak_usb: CAN-FD: add new adapters specific files
Date: Wed, 03 Dec 2014 10:38:41 +0100
Message-ID: <547EDA21.6030802@peak-system.com>
References: <5477A5A3.9070107@pengutronix.de>
 <547DBAEC.6010903@pengutronix.de> <547DD608.5090403@peak-system.com>
 <547DD81B.9000403@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:34199 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752506AbaLCJir (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 3 Dec 2014 04:38:47 -0500
In-Reply-To: <547DD81B.9000403@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

Hi Marc,

Le 02/12/2014 16:17, Marc Kleine-Budde a =C3=A9crit :
> On 12/02/2014 04:08 PM, Stephane Grosjean wrote:
>>>>    drivers/net/can/usb/peak_usb/pcan_ucan.h   | 208 +++++++
>>>>    drivers/net/can/usb/peak_usb/pcan_usb_fd.c | 955
>>>> +++++++++++++++++++++++++++++
>>>>    drivers/net/can/usb/peak_usb/pcan_usb_fd.h | 108 ++++
>>> Please don't create a header file, if it's only included once. Plea=
se
>>> merge into the correct .c file.
>> Ok. So I merge both header files into the .c file. There will be onl=
y a
>> single (and big) pcan_usb_fd.c file.
> Yes, we only want code in header files that's used in more than one .=
c file.

Is this rule quite recent? I mean, the current version of peak_usb=20
contains "pcan_usb_pro.h" which is included only by "pcan_usb_pro.c"?

Moreover, "pcan_ucan.h" defines some data structures that might be used=
=20
by some other new "non USB" PEAK -FD devices (peak_pci, for example).
So, how to manage to avoid to have to define several times the same dat=
a=20
structures and constants, please?

St=C3=A9phane
--
PEAK-System Technik GmbH
Sitz der Gesellschaft Darmstadt
Handelsregister Darmstadt HRB 9183=20
Geschaeftsfuehrung: Alexander Gach, Uwe Wilhelm
--
