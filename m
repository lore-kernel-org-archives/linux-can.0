From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: [PATCH 7/7 v9] can/peak_usb: add support for PEAK new CANFD USB
 adapters
Date: Mon, 26 Jan 2015 16:11:14 +0100
Message-ID: <54C65912.5020309@peak-system.com>
References: <1422009085-11858-1-git-send-email-s.grosjean@peak-system.com>
 <1422009085-11858-8-git-send-email-s.grosjean@peak-system.com>
 <54C64633.9080204@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:41131 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755896AbbAZPLS (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 26 Jan 2015 10:11:18 -0500
In-Reply-To: <54C64633.9080204@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

Hi Mark,

Well, the ISO/non-ISO feature is not available for all USB devices and=20
is currently always under development.
So, we think that it's a bit early to add it in the peak_usb driver.

Regards,

St=C3=A9phane

Le 26/01/2015 14:50, Marc Kleine-Budde a =C3=A9crit :
> On 01/23/2015 11:31 AM, Stephane Grosjean wrote:
>> Add support for the following new PEAK-System technik CANFD USB adap=
ters:
>>
>> PCAN-USB FD             single CANFD channel USB adapter
>> PCAN-USB Pro FD         dual CANFD channels USB adapter
>>
>> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>> Acked-by: Andri Yngvason <andri.yngvason@marel.com>
> What was the outcome of the CANFD ISO/non-ISO discussion?
>
> Marc
>

--
PEAK-System Technik GmbH
Sitz der Gesellschaft Darmstadt
Handelsregister Darmstadt HRB 9183=20
Geschaeftsfuehrung: Alexander Gach, Uwe Wilhelm
--
