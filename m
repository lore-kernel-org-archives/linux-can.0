From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: [PATCH 1/2] can/sja1000: Add PEAK-System PCIe/PCIeC and miniPCI
 boards
Date: Tue, 31 Jan 2012 16:01:25 +0100
Message-ID: <4F280245.60809@peak-system.com>
References: <1328015960-14744-1-git-send-email-s.grosjean@peak-system.com>
 <1328015960-14744-2-git-send-email-s.grosjean@peak-system.com>
 <4F27EBC5.3060805@pengutronix.de>
Reply-To: s.grosjean@peak-system.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:46448 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754656Ab2AaPBd (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 31 Jan 2012 10:01:33 -0500
In-Reply-To: <4F27EBC5.3060805@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can Mailing List <linux-can@vger.kernel.org>

Hi Marc,

What do you mean please? You want me to post 4 patches? One for each ne=
w=20
board, plus one for the channels list management? For 2 of the 3 boards=
,=20
this is as simple as adding a line into the device ids table, excepting=
=20
the ExpressCard for which I added the management of the funky leds.
Thanks for any clarification.

St=E9phane


Le 31/01/2012 14:25, Marc Kleine-Budde a =E9crit :
> On 01/31/2012 02:19 PM, Stephane Grosjean wrote:
>> This patch adds the support of some new PEAK-System Technik sja1000 =
boards
>> (http://www.peak-system.com):
>>
>> PCAN-PCI Express (1 or 2 channels)
>> PCAN-ExpressCard (1 or 2 channels)
>> PCAN-miniPCI (1 or 2 channels)
>>
>> All of these boards are compliant with CAN specifications 2.0A (11-b=
it ID) and
>> 2.0B (29-bit ID).
>>
>> This patch also fixes the management of the channels list.
> Without looking further at the patch, please make it a seperate patch=
=2E A
> detailed review will follow.
>
>
> Marc
>
--
PEAK-System Technik GmbH, Otto-Roehm-Strasse 69, D-64293 Darmstadt=20
Geschaeftsleitung: A.Gach/U.Wilhelm,St.Nr.:007/241/13586 FA Darmstadt=20
HRB-9183 Darmstadt, Ust.IdNr.:DE 202220078, WEE-Reg.-Nr.: DE39305391=20
Tel.+49 (0)6151-817320 / Fax:+49 (0)6151-817329, info@peak-system.com
