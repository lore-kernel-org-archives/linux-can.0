From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: [PATCH] pcan_usb: fix wrong memcpy() bytes length
Date: Thu, 08 Aug 2013 15:45:55 +0200
Message-ID: <5203A113.9080207@peak-system.com>
References: <1375951951-18507-1-git-send-email-s.grosjean@peak-system.com>
 <52036B60.7090701@pengutronix.de>
Reply-To: Stephane Grosjean <s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:43119 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933145Ab3HHN6Y (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 8 Aug 2013 09:58:24 -0400
In-Reply-To: <52036B60.7090701@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>

Hi Marc,

I'm afraid I don't understand your remark/question below. Can you pleas=
e=20
be more precise?

Regards,

St=C3=A9phane

Le 08/08/2013 11:56, Marc Kleine-Budde a =C3=A9crit :
> On 08/08/2013 10:52 AM, Stephane Grosjean wrote:
>> Fix possibly wrong memcpy() bytes length since some CAN records rece=
ived from
>> PCAN-USB could define a DLC field in range [9..15].
>> In that case, the real DLC value MUST be used to move forward the re=
cord pointer
>> but, only 8 bytes max. MUST be copied into the data field of the str=
uct
>> can_frame object of the skb given to the network core.
>>
>> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
> Looks like a candidate for stable, doesn't it?
>
> Marc
>

--
PEAK-System Technik GmbH, Otto-Roehm-Strasse 69, D-64293 Darmstadt=20
Geschaeftsleitung: A.Gach/U.Wilhelm,St.Nr.:007/241/13586 FA Darmstadt=20
HRB-9183 Darmstadt, Ust.IdNr.:DE 202220078, WEE-Reg.-Nr.: DE39305391=20
Tel.+49 (0)6151-817320 / Fax:+49 (0)6151-817329, info@peak-system.com
