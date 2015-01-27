From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: [PATCH 7/7 v9] can/peak_usb: add support for PEAK new CANFD USB
 adapters
Date: Tue, 27 Jan 2015 14:16:44 +0100
Message-ID: <54C78FBC.1010205@peak-system.com>
References: <1422009085-11858-1-git-send-email-s.grosjean@peak-system.com>
 <1422009085-11858-8-git-send-email-s.grosjean@peak-system.com>
 <54C64633.9080204@pengutronix.de> <54C65912.5020309@peak-system.com>
 <54C659C0.4040207@pengutronix.de> <54C66063.9050500@peak-system.com>
 <54C6628D.7010902@pengutronix.de> <54C6ABE1.8000504@hartkopp.net>
 <54C6ACBD.2020806@pengutronix.de> <54C74589.9050603@hartkopp.net>
 <54C746AE.60801@pengutronix.de> <54C78C6E.3070705@peak-system.com>
 <54C78D8C.30107@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:35320 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754656AbbA0NQt (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 27 Jan 2015 08:16:49 -0500
In-Reply-To: <54C78D8C.30107@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org


Le 27/01/2015 14:07, Marc Kleine-Budde a =C3=A9crit :
> On 01/27/2015 02:02 PM, Stephane Grosjean wrote:
>> But putting "const" here leads to several other changes in
>> pcan_usb_core.h and pcan_usb_core.c (as well as in older pcan_usb.c =
and
>> pcan_usb_pro.c files, where same struct peak_adapter static objects =
are
>> used to define the corresponding USB adapter).
>>
>> Do you need another patch which does this, once for all?
> Yes, make a patch that converts the existing driver...

What do you mean with "the existing driver" please?

> btw while there
> you can convert static struct peak_usb_adapter not to be NULL termina=
ted
> but work with ARRAY_SIZE().
Are u actually talking about "peak_usb_adapters_list" ?

> Marc
>

St=C3=A9phane

--
PEAK-System Technik GmbH
Sitz der Gesellschaft Darmstadt
Handelsregister Darmstadt HRB 9183=20
Geschaeftsfuehrung: Alexander Gach, Uwe Wilhelm
--
