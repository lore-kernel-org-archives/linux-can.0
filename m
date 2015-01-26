From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: [PATCH 7/7 v9] can/peak_usb: add support for PEAK new CANFD USB
 adapters
Date: Mon, 26 Jan 2015 16:42:27 +0100
Message-ID: <54C66063.9050500@peak-system.com>
References: <1422009085-11858-1-git-send-email-s.grosjean@peak-system.com>
 <1422009085-11858-8-git-send-email-s.grosjean@peak-system.com>
 <54C64633.9080204@pengutronix.de> <54C65912.5020309@peak-system.com>
 <54C659C0.4040207@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:56357 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752698AbbAZPmc (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 26 Jan 2015 10:42:32 -0500
In-Reply-To: <54C659C0.4040207@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>


Le 26/01/2015 16:14, Marc Kleine-Budde a =C3=A9crit :
> On 01/26/2015 04:11 PM, Stephane Grosjean wrote:
>> Hi Mark,
>>
>> Well, the ISO/non-ISO feature is not available for all USB devices a=
nd
>> is currently always under development.
>> So, we think that it's a bit early to add it in the peak_usb driver.
> Which mode do the controller support then?
>
> Marc
>
Current versions of the fw run in non-ISO mode.

St=C3=A9phane
--
PEAK-System Technik GmbH
Sitz der Gesellschaft Darmstadt
Handelsregister Darmstadt HRB 9183=20
Geschaeftsfuehrung: Alexander Gach, Uwe Wilhelm
--
