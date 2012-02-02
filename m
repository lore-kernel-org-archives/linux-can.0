From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: [PATCH 1/2] can/sja1000: Add PEAK-System PCIe/PCIeC and miniPCI
 boards
Date: Thu, 02 Feb 2012 17:33:03 +0100
Message-ID: <4F2ABABF.4020009@peak-system.com>
References: <1328015960-14744-1-git-send-email-s.grosjean@peak-system.com>
 <1328015960-14744-2-git-send-email-s.grosjean@peak-system.com>
 <4F27EBC5.3060805@pengutronix.de> <4F280245.60809@peak-system.com>
 <4F2805D8.7090401@grandegger.com>
Reply-To: s.grosjean@peak-system.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:33599 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755115Ab2BBQdN (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 2 Feb 2012 11:33:13 -0500
In-Reply-To: <4F2805D8.7090401@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can Mailing List <linux-can@vger.kernel.org>

Hi,

I've got one question about some new patch(es) I'd like to post in the=20
drivers/net/can/sja1000 subdir too, about a pcmcia driver.
According to which commit should I create this new patch?
I mean, I recently posted a patch to change the above Kconfig=20
description. Will the new patch's Kconfig include these modifications o=
r=20
should I wait for some ack or else?..

Regards,

St=E9phane

Le 31/01/2012 16:16, Wolfgang Grandegger a =E9crit :
> On 01/31/2012 04:01 PM, Stephane Grosjean wrote:
>> Hi Marc,
>>
>> What do you mean please? You want me to post 4 patches? One for each=
 new
>> board, plus one for the channels list management? For 2 of the 3 boa=
rds,
>> this is as simple as adding a line into the device ids table, except=
ing
>> the ExpressCard for which I added the management of the funky leds.
>> Thanks for any clarification.
> I think he wants two separate patches, instead a series of patches. O=
ne
> patch for peak_pci and another for peak_pcmcia. Which does make sense=
 as
> they do not belong together.
>
> Wolfgang.
--
PEAK-System Technik GmbH, Otto-Roehm-Strasse 69, D-64293 Darmstadt=20
Geschaeftsleitung: A.Gach/U.Wilhelm,St.Nr.:007/241/13586 FA Darmstadt=20
HRB-9183 Darmstadt, Ust.IdNr.:DE 202220078, WEE-Reg.-Nr.: DE39305391=20
Tel.+49 (0)6151-817320 / Fax:+49 (0)6151-817329, info@peak-system.com
