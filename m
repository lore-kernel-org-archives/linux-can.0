From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: [PATCH 7/7 v8] can/peak_usb: add support for PEAK new CANFD USB
 adapters
Date: Thu, 22 Jan 2015 16:40:41 +0100
Message-ID: <54C119F9.7030006@peak-system.com>
References: <1421940266-6088-1-git-send-email-s.grosjean@peak-system.com>
 <1421940266-6088-8-git-send-email-s.grosjean@peak-system.com>
 <54C11839.7060802@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:43788 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660AbbAVPkt (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 22 Jan 2015 10:40:49 -0500
In-Reply-To: <54C11839.7060802@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>


Le 22/01/2015 16:33, Marc Kleine-Budde a =C3=A9crit :
> On 01/22/2015 04:24 PM, Stephane Grosjean wrote:
>> Add support for the following new PEAK-System technik CANFD USB adap=
ters:
>>
>> PCAN-USB FD             single CANFD channel USB adapter
>> PCAN-USB Pro FD         dual CANFD channels USB adapter
>>
>> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>> ---
>>   drivers/net/can/usb/Kconfig                  |   14 +-
>>   drivers/net/can/usb/peak_usb/Makefile        |    2 +-
>>   drivers/net/can/usb/peak_usb/pcan_ucan.h     |  222 ++++++
> Please merge ucan.h into pcan_usb_fd.c, which is the one and only use=
r
> of it.
>
> Marc
>

Well, we already have discussed about that, remember: uCAN interface is=
=20
to be also used with some other new CANFD equipments...

St=C3=A9phane
--
PEAK-System Technik GmbH
Sitz der Gesellschaft Darmstadt
Handelsregister Darmstadt HRB 9183=20
Geschaeftsfuehrung: Alexander Gach, Uwe Wilhelm
--
