From: Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
Subject: Re: ems_usb: endianess warning
Date: Wed, 25 Mar 2015 11:17:41 +0100
Message-ID: <55128B45.7020906@ems-wuensche.com>
References: <55044620.60903@pengutronix.de> <5511A6B5.2010507@ems-wuensche.com> <55127313.6090500@pengutronix.de> <55127566.8050504@pengutronix.de> <551280A9.8000206@ems-wuensche.com> <55128215.5040300@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.ems-wuensche.com ([85.214.92.62]:37137 "EHLO
	mail.ems-wuensche.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752021AbbCYKRv (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 25 Mar 2015 06:17:51 -0400
In-Reply-To: <55128215.5040300@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Sebastian Haas <haas@ems-wuensche.com>, Sebastian Haas <dev@sebastianhaas.info>

Am 25.03.2015 um 10:38 schrieb Marc Kleine-Budde:
> On 03/25/2015 10:32 AM, Gerhard Uttenthaler wrote:
>>> In the driver there's timestamp, which endianess is corret here?
>>
>> The device is LE and transmits/receives everything as LE, hence also
>> the timestamp.
> 
> Thanks, I've created a patch, can I have your Acked-by.
> 
> Marc
> 
Yes, sure!

Is this OK or do you need a patch? Sorry for this, maybe silly, question, but this formalism is new
for me.

Gerhard
-- 
EMS Dr. Thomas Wuensche e.K.
Sonnenhang 3
85304 Ilmmuenster
HRA Neuburg a.d. Donau, HR-Nr. 70.106

Phone: +49-8441-490260
Fax  : +49-8441-81860
http://www.ems-wuensche.com
