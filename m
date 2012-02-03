From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: [PATCH v4.3] peak_pci: add support for PEAK-System
 PCIe/PCIeC/miniPCI cards
Date: Fri, 03 Feb 2012 12:34:22 +0100
Message-ID: <4F2BC63E.2040406@peak-system.com>
References: <1328188792-2982-1-git-send-email-s.grosjean@peak-system.com>
 <4F2ACFE9.3080602@hartkopp.net> <4F2B16F9.8020903@hartkopp.net>
 <4F2BB498.60606@grandegger.com> <4F2BBA8C.3020501@peak-system.com>
 <4F2BBE24.5090601@grandegger.com>
Reply-To: Stephane Grosjean <s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:59670 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751307Ab2BCLec (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 3 Feb 2012 06:34:32 -0500
In-Reply-To: <4F2BBE24.5090601@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Le 03/02/2012 11:59, Wolfgang Grandegger a =E9crit :
>
> Well, that is even more confusing. What happens if there is no LED
> support. If the LEDs are not blinking or illuminated users might thin=
k
> the card is not working. I would go for CAN_PEAK_PCIEC config enablin=
g
> the support for the PCIEC *explicitly*. I mean, no support for the PC=
IEC
> if CAN_PEAK_PCIEC is not enabled. You may want to use the select tric=
k
> if you prefer on that config. What do the others think?

Ok this argument is valid. Back to Oliver proposal.
The main reason why I generally prefer the "select" way is that the=20
"depends on" hides the menu item/choice text to the user.

St=E9phane
--
PEAK-System Technik GmbH, Otto-Roehm-Strasse 69, D-64293 Darmstadt=20
Geschaeftsleitung: A.Gach/U.Wilhelm,St.Nr.:007/241/13586 FA Darmstadt=20
HRB-9183 Darmstadt, Ust.IdNr.:DE 202220078, WEE-Reg.-Nr.: DE39305391=20
Tel.+49 (0)6151-817320 / Fax:+49 (0)6151-817329, info@peak-system.com
